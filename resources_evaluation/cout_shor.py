#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Computes resources for RSA integer factorization with a memory.

@author: Élie Gouzien
"""
from math import ceil, isnan, isinf
from itertools import product

from tools import AlgoOpts, LowLevelOpts, Params, PhysicalCost
from error_correction import ErrCorrCode


# %% Ancillary functions
def logical_qubits(params: Params, verb=True):
    """Logical qubits count.

    It adapts to the type of algorithm (controlled or windowed arithmetics).
    """
    if params.algo.windowed:
        res = 4*params.algo.n + 3*params.algo.m + params.algo.we - 1
    else:
        res = 3*(params.algo.n + params.algo.m) + 1
    if verb:
        print("\tLogical qubits count:", res)
    return res


def qubits_en_memoire(err_corr: ErrCorrCode, verb=True):
    """In memory physical qubit number."""
    return err_corr.memory_qubits*logical_qubits(err_corr.params, verb)


def modes_en_memoire(err_corr: ErrCorrCode):
    """Spatial and temporal modes."""
    return (err_corr.space_modes*logical_qubits(err_corr.params, False),
            err_corr.time_modes)


def correct_all(err_corr: ErrCorrCode):
    """Compute time for error-correcting all the memory."""
    # 2 qubits slices in the processor for parallelization
    return err_corr.correct_time*logical_qubits(err_corr.params, verb=False)/2


def memory_limited_time(err_corr: ErrCorrCode):
    """Cycle-time when limited by memory readout time."""
    # Time to access 1 qubit with 4Γ/10 hypothesis
    speed = 4 * 12e6 / 10  # qubit/s
    return qubits_en_memoire(err_corr, verb=False) / speed


def ne_size(n):
    """Estimates exponent size n_e for some integer to factor size n.

    See A.2.1 of eprint.iacr.org/2017/1122.
    """
    # pylint: disable=C0103
    delta = 20 if n >= 1024 else 0
    m = ceil(n / 2) - 1
    l = m - delta
    n_e = m + 2 * l
    return n_e


# %% Optimization
def iterate(base_params: Params, **kwargs):
    """Generate iterator on all free parameters of the algorithm.

    Possible kwargs: d1s, ds, wes, wms, ms
    """
    # pylint: disable=C0103
    if base_params.type == '3dcolor':
        ranges = dict(d1s=(None,),
                      ds=range(1, 100, 2),
                      wes=range(1, 10),
                      wms=range(1, 10),
                      ms=range(1, 40))
    elif base_params.type is None:
        ranges = dict(d1s=(None,),
                      ds=(None,),
                      wes=range(1, 10),
                      wms=range(1, 10),
                      ms=range(1, 40))
    else:
        raise ValueError("params.type not valid!")
    ranges.update(kwargs)
    for d1, d, we, wm, m in product(ranges['d1s'], ranges['ds'], ranges['wes'],
                                    ranges['wms'], ranges['ms']):
        # we and wm have same role, no need to explore all the parameter space
        if wm is not None and we is not None and wm > we:
            continue
        yield base_params._replace(
            algo=base_params.algo._replace(we=we, wm=wm, m=m),
            low_level=base_params.low_level._replace(d1=d1, d=d))


def metrique(cost: PhysicalCost, qubits, biais=1):
    """Score the quality of resource cost."""
    return cost.exp_t * qubits**biais


def prepare_ressources(params: Params):
    """Prepare cost and qubit count for given parameter set."""
    err_corr = ErrCorrCode(params)
    cost = err_corr.modular_exp()
    qubits = err_corr.proc_qubits
    return cost, qubits


def find_best_params(base_params: Params, biais=1, **kwargs):
    """Find the best parameter set."""
    best = float('inf')
    best_params = None
    for params in iterate(base_params, **kwargs):
        try:
            cost, qubits = prepare_ressources(params)
        except RuntimeError:
            continue
        score = metrique(cost, qubits, biais)
        if score < best:
            best = score
            best_params = params
    if best_params is None:
        raise RuntimeError("Optimization didn't converge. "
                           "No parameter allow to end the computation in "
                           "finite time.")
    return best_params


# %% Table generation
def unit_format(num, unit, unicode=False):
    """Assemble number and unit, eventually converting it into LaTeX."""
    space = chr(8239)
    num = str(round(num)) if not isinf(num) else "∞" if unicode else r"\infty"
    if not unicode:
        unit = {"µs": r"\micro\second",
                "ms": r"\milli\second",
                "s": r"\second",
                "min": r"\minute",
                "hours": "hours",
                "days": "days"}[unit]
    if unicode:
        return num + space + unit
    return rf"\SI{{{num}}}{{{unit}}}"


def format_time(time, unicode=False):
    """Return formatted time, with correct unity."""
    if isnan(time):
        return "nan"
    if time < 1e-3:
        temps, unit = time*1e6, "µs"
    elif time < 1:
        temps, unit = time*1000, "ms"
    elif time < 60:
        temps, unit = time, "s"
    elif time < 3600:
        temps, unit = time/60, "min"
    elif time < 3600*24:
        temps, unit = time/3600, "hours"
    else:
        temps, unit = time/(3600*24), "days"
    return unit_format(temps, unit, unicode)


def entree_tableau(params: Params):
    """One line of the table."""
    err_corr = ErrCorrCode(params)
    cost, qubits = prepare_ressources(params)
    return [params.algo.n, params.algo.ne, params.algo.m, params.algo.we,
            params.algo.wm,
            params.low_level.d, qubits, format_time(cost.exp_t),
            logical_qubits(params, False),
            qubits_en_memoire(err_corr, False),
            *modes_en_memoire(err_corr),
            format_time(correct_all(err_corr))]


def table_shape(largeurs, sep_places, sep="|"):
    """Give the shape of the table (for LaTeX)."""
    liste = [f"S[table-figures-integer={size}]" if size is not None else 'c'
             for size in largeurs]
    for pos in sorted(sep_places, reverse=True):
        liste = liste[:pos] + [sep] + liste[pos:]
    return ''.join(liste)


def print_tableau(err_corr_type='3dcolor', windowed=True):
    r"""Table for article supplemental material.

    To be used with
    \usepackage[table-figures-decimal=0,table-number-alignment=center]{siunitx}
    """
    # Internal parameters
    entetes = ["$n$", '$n_e$', "$m$", "$w_e$", "$w_m$", "$d$",
               r"$n_{\text{qubits}}$", r"$t_{\text{exp}}$",
               "logical qubits", "total modes",
               "spatial modes", "temporal modes",
               "all memory correction"]
    skip_size = (7, 12)
    seps = (2, 6, 8)
    just = 30
    # Data computation
    tableau = []
    for n, biais in zip([6, 829, 2048], [10, 1, 1]):  # pylint:disable=C0103
        base_params = Params(err_corr_type,
                             AlgoOpts(n=n, ne=ne_size(n), windowed=windowed),
                             LowLevelOpts())
        best_params = find_best_params(base_params, biais=biais)
        tableau.append(entree_tableau(best_params))
    # Column width
    sizes = [max(len(str(ligne[col])) for ligne in tableau)
             if col not in skip_size else None for col in range(len(entetes))]
    # Print table
    print(r"\begin{tabular}{" + table_shape(sizes, seps) + "}")
    print("\t" + '&'.join(('{'+x+'}').ljust(just) for x in entetes) + r'\\',
          r"\hline")
    for ligne in tableau:
        print("\t" + '&'.join(str(x).ljust(just) for x in ligne) + r'\\')
    print(r'\end{tabular}')


# %% Executable part
if __name__ == '__main__':
    # Put 'biais' to 10 for the metric to obtain suitable result with n=6.
    # params = Params('3dcolor',
    #                 AlgoOpts(n=6, ne=ne_size(6), windowed=True),
    #                 LowLevelOpts())

    # params = Params('3dcolor',
    #                 AlgoOpts(n=829, ne=ne_size(829), windowed=True),
    #                 LowLevelOpts())

    params = Params('3dcolor',
                    AlgoOpts(n=2048, ne=ne_size(2048), windowed=True),
                    LowLevelOpts())

    # Windowed arithmetics
    print("Windowed arithmetics")
    print("====================")
    best_params = find_best_params(params, biais=1)
    best_err_corr = ErrCorrCode(best_params)
    cost, qubits = prepare_ressources(best_params)
    print("Best cost:", cost, ";",  qubits)
    print("Max time between two reading:", best_err_corr.temps_inter_lectures())
    print("In memory physical qubits:", qubits_en_memoire(best_err_corr))
    print("Full error-correction time:",
          format_time(correct_all(best_err_corr), True))
    print("Time if one spatial mode:", format_time(
        cost.exp_t*memory_limited_time(best_err_corr)/best_params.low_level.tc,
        unicode=True))

    # Controlled arithmetics
    print("\n"*2)
    print("Controlled arithmetics")
    print("======================")
    best_params_ctrl = find_best_params(
        params._replace(algo=params.algo._replace(windowed=False)),
        biais=1, wes=(None,), wms=(None,))
    best_err_corr_ctrl = ErrCorrCode(best_params_ctrl)
    cost_ctrl, qubits_ctrl = prepare_ressources(best_params_ctrl)
    print("Best cost for controlled arithmetics:", cost_ctrl, ";", qubits_ctrl)
    print("In memory physical qubits for controlled arithmetics:",
          qubits_en_memoire(best_err_corr_ctrl))
    print("Max time between two reading:",
          best_err_corr_ctrl.temps_inter_lectures())
    print("Full error-correction time:",
          format_time(correct_all(best_err_corr_ctrl), unicode=True))
    print("Time if one spatial mode:", format_time(
        cost_ctrl.exp_t * memory_limited_time(best_err_corr_ctrl)
        / best_params_ctrl.low_level.tc, unicode=True))

    # Table
    print("\n"*2)
    print("Table")
    print("=====")
    print_tableau()
