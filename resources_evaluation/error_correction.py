#!/usr/bin/env python3
# coding: utf-8
# pylint: disable=C0103, C0144
"""
Tools for describing error correction and cost of logical circuits.

@author: Élie Gouzien
"""
from math import exp, log, floor, ceil

from tools import Params, PhysicalCost


class ErrCorrCode:
    """Abstract class for describing an error correcting code.

    Default implementation assumes same cost for initializing or measuring in
    X or Z basis.
    CZ  is supposed as costly as CNOT.
    """

    def __new__(cls, params: Params, *args, **kwargs):
        """Create new instance, choosing concrete class from params.type."""
        if cls is ErrCorrCode:
            if params.type == '3dcolor':
                return ThreeDGaugeCode(params, *args, **kwargs)
            elif params.type is None:
                return NoCorrCode(params)
            else:
                raise ValueError("'params.type' not valid!")
        return super().__new__(cls)

    def __init__(self, params: Params):
        """Initialize the code parameters."""
        self.params = params
        # Elementary gates cost
        self.gate1 = None
        self.cnot = None
        self.init = None  # initialisation  of one logical qubit
        self.mesure = None  # measurement of one logical qubit
        # Processor properties
        self.correct_time = None  # time for correcting one logical qubit
        self.proc_qubits = None
        # Number of physical qubits per logical qubit
        self.memory_qubits = None
        self.space_modes = None
        self.time_modes = None

    @property
    def and_gate(self):
        """Cost of AND computation in an ancillary qubit."""
        # see arXiv:1805.03662, fig. 4
        # |T> = T |+>, preparing |+> assumed at same cost as |0>
        return self.init + self.gate1*6 + self.cnot*3

    @property
    def deand(self):
        """Cost of AND uncomputation (measurement-based)."""
        # Hadamard gates are merged with preparation/measurements as X and Z
        # basis measurement are assumed to have equal cost (as in CSS codes).
        return self.mesure + 0.5*self.cnot  # CZ assumed as CNOT

    @property
    def and_deand(self):
        """Cost of computing and uncomputing AND."""
        return self.and_gate + self.deand

    @property
    def toffoli(self):
        """Cost of a full Toffoli gate."""
        try:
            return self._toffoli
        except AttributeError:
            # With one ancillary qubit
            return self.and_deand + self.cnot

    @toffoli.setter
    def toffoli(self, value):
        self._toffoli = value

    @toffoli.deleter
    def toffoli(self):
        del self._toffoli

    @property
    def maj(self):
        """Cost of MAJ operation, with ancillary qubit."""
        # See arXiv:quant-ph/0410184 for MAJ and UMA notation
        return self.and_gate + 3*self.cnot

    @property
    def uma(self):
        """Cost of UMA operation, with ancillary qubit."""
        # No parallelization in our architecture
        return 3*self.cnot + self.deand

    def add(self, n=None):
        """Cost of full adder modulo power of two (with ancillary qubits)."""
        if n is None:  # coset representation
            n = self.params.algo.n + self.params.algo.m
        return (n - 2)*(self.maj + self.uma) + 3*self.cnot + self.and_deand

    @property
    def semi_classical_ctrl_maj(self):
        """Cost of MAJ, controlled semi-classical version."""
        return self.and_gate + 3*self.cnot

    @property
    def semi_classical_ctrl_uma(self):
        """Cost of UMA, controlled semi-classical version."""
        return self.deand + 2.5*self.cnot

    def semi_classical_ctrl_add(self, n=None):
        """Cost of controlled semi-classical addition."""
        if n is None:  # coset representation
            n = self.params.algo.n + self.params.algo.m
        return ((n-2)*(self.semi_classical_ctrl_maj
                       + self.semi_classical_ctrl_uma)
                + 2*self.cnot + 0.5*self.and_deand)

    def semi_classical_ctrl_ctrl_add(self, n=None):
        """Cost of doubly controlled semi-classical addition."""
        return self.and_deand + self.semi_classical_ctrl_add(n)

    @property
    def semi_classical_maj(self):
        """Cost of MAJ, semi-classical version."""
        return self.and_gate + 2*self.cnot + self.gate1

    @property
    def semi_classical_maj_dag(self):
        r"""Cost of MAJ^\dagger, semi-classical version."""
        return self.deand + 2*self.cnot + self.gate1

    def semi_classical_comparison(self, n=None):
        """Semi-classical comparison."""
        if n is None:  # coset representation
            n = self.params.algo.n + self.params.algo.m
        return ((n-1)*(self.semi_classical_maj
                       + self.semi_classical_maj_dag)
                + self.cnot)

    def _defaul_lookup_sizes(self):
        """Computes default sizes 'w' et 'n' for table lookup."""
        # total window input size
        w = self.params.algo.we + self.params.algo.wm
        # Numbers read < N : despite coset representation size n OK.
        n = self.params.algo.n
        return w, n

    def lookup(self, w=None, n=None):
        """Cost of table-lookup circuit, address (target) of sizes w (n)."""
        if w is None and n is None:
            w, n = self._defaul_lookup_sizes()
        return (2*self.gate1 + (2**w - 2 + 2**w * n/2)*self.cnot
                + (2**w - 2)*self.and_deand)

    def unary_ununairy(self, size=None):
        """Cost of unary representation computation and uncomputation."""
        # first NOT is not counted as |1> can be directly initialized.
        if size is None:
            size = floor((self.params.algo.we + self.params.algo.wm)/2)
        return self.init + 2*(size-1)*self.cnot + (size-1)*self.and_deand

    def unlookup(self, w=None, n=None):
        """Cost of table-lookup uncomputation."""
        # Hadamard gates are merged with preparation/measurement.
        if w is None and n is None:
            w, n = self._defaul_lookup_sizes()
        return (n*self.mesure
                + self.unary_ununairy(floor(w/2))
                # + 2*floor(w/2)*self.gate1  # CZ same cost as CNOT
                + self.lookup(w=ceil(w/2), n=floor(w/2)))

    def look_unlookup(self, w=None, n=None):
        """Cost of table lookup and unlookup."""
        if w is None and n is None:
            w, n = self._defaul_lookup_sizes()
        return self.lookup(w, n) + self.unlookup(w, n)

    def initialize_coset_reg(self):
        """Coset representation register initialization."""
        # Hadamard gates are merged with preparation/measurement.
        n, m = self.params.algo.n, self.params.algo.m
        return (m*(self.init + self.mesure)
                + m*self.semi_classical_ctrl_add(n+m)
                + 0.5*m*(self.semi_classical_comparison(n+m) + self.gate1))

    def modular_exp_windowed(self):
        """Cost of modular exponentiation, with windowed arithmetics."""
        n, ne, we, wm, m, _, _ = self.params.algo
        nb = 2 * (ne/we) * (n + m)/wm
        classical_error = PhysicalCost(2**(-m), 0)
        return (nb*(self.add() + self.look_unlookup() + classical_error)
                + 2*self.initialize_coset_reg())

    def modular_exp_controlled(self):
        """Cost of modular exponentiation, with controlled arithmetics."""
        n, ne, _, _, m, _, _ = self.params.algo
        nb = 2 * ne * (n + m)
        classical_error = PhysicalCost(2**(-m), 0)
        return (nb*(self.semi_classical_ctrl_ctrl_add() + classical_error)
                + 2 * self.initialize_coset_reg()
                + ne*(n + m)*(2*self.cnot + self.toffoli))

    def modular_exp(self):
        """Modular exponentiation cost, version taken from parameters."""
        if self.params.algo.windowed:
            return self.modular_exp_windowed()
        return self.modular_exp_controlled()

    def temps_inter_lectures(self):
        """Max time between two reading of a given qubit."""
        # Time of one product-addition
        n, _, _, wm, m, _, _ = self.params.algo
        if self.params.algo.windowed:
            nb = (n + m)/wm
            res = nb*(self.add() + self.look_unlookup())
            return res._replace(p=None)
        else:
            nb = n + m
            res = nb*self.semi_classical_ctrl_ctrl_add()
            return res._replace(p=None)


class ThreeDGaugeCode(ErrCorrCode):
    """3d gauge color codes, with code switching."""

    def __init__(self, params: Params):
        """Create 3d gauge color codes instance."""
        # Start and parameters validation
        super().__init__(params)
        d = params.low_level.d  # pylint: disable=C0103
        debitage = params.low_level.debitage
        if not d % 2 == 1:
            raise ValueError("Distance must be odd.")
        if debitage not in (1, 2):
            raise ValueError("'debitage' takes value '1' or '2'.")

        # Geometrical characteristics
        self.memory_qubits = (d**3 + d)//2
        self.space_modes = ((1 + 3*d**2)//4 if debitage == 1
                            else (3*d**2 + 2*d - 3)//2)
        self.time_modes = 2*d-4 if debitage == 1 else d-2

        # Processor
        # 2 because 2 logical qubits, 2 because ancillary qubits for measurements
        self.proc_qubits = 2*2*self.space_modes

        # Logical gates
        # p_th = 0.0031  # arXiv:1503.08217
        p_th = 0.0075  # arXiv:1708.07131 ; known decoding
        # p_th = 0.019   # arXiv:1708.07131 ; no decoding
        A = 0.033
        α = 0.516
        β = 0.822
        # logical error: arXiv:1503.08217
        err = A * exp(α * log(params.low_level.pp/p_th) * d**β)
        err_2 = 1 - (1 - err)**2
        # 2 factor: one time for gate, one time for stabilizers measurement
        # actual correction delayed to next use and neglected.
        time = 2*params.low_level.tc*self.time_modes
        # T, T^\daggger, H, S, S^\dagger, CNOT and CZ transversal
        self.gate1 = PhysicalCost(err, time)
        self.cnot = PhysicalCost(err_2, time)
        self.init = PhysicalCost(err, time/2)  # 1 pass
        self.mesure = PhysicalCost(err, params.low_level.tr + time/2)
        self.correct_time = time/2

    @property
    def deand(self):
        """AND uncomputation.

        Measurement-based technique is most of the time more efficient.
        """
        if self.params.algo.mesure_based_deand:
            return super().deand
        else:
            # Only gates before last CNOT in Fig.4 of arXiv:1805.03662
            return 5*self.gate1 + 3*self.cnot


class NoCorrCode(ErrCorrCode):
    """No error correction. Toffoli gate assumed elementary."""

    def __init__(self, params: Params):
        """Init no correction instance."""
        super().__init__(params)
        err_2 = 1 - (1 - params.low_level.pp)**2
        err_3 = 1 - (1 - params.low_level.pp)**3
        self.gate1 = PhysicalCost(params.low_level.pp, params.low_level.tc)
        self.cnot = PhysicalCost(err_2, params.low_level.tc)
        self.toffoli = PhysicalCost(err_3, params.low_level.tc)
        self.init = PhysicalCost(params.low_level.pp, params.low_level.tc)
        self.mesure = PhysicalCost(params.low_level.pp, params.low_level.tr)
        self.correct_time = float('nan')
        self.proc_qubits = 3
        self.memory_qubits = 1
        self.space_modes = 1
        self.time_modes = 1

    @property
    def and_gate(self):
        """Cost of AND computation."""
        # Note: no initialisation cost as qubit recycled
        return self.toffoli

    @property
    def deand(self):
        """Cost of AND uncomputation."""
        # Note: no measurement cost as qubit recycled
        return self.toffoli

    @property
    def maj(self):
        """Cost of MAJ operation."""
        # See arXiv:quant-ph/0410184
        return self.toffoli + 2*self.cnot

    @property
    def uma(self):
        """Cost of UMA operation."""
        # No parallelization in our architecture
        return self.toffoli + 2*self.cnot

    def add(self, n=None):
        """Addition cost (with Toffoli gates)."""
        # See arXiv:quant-ph/0410184
        if n is None:  # coset representation
            n = self.params.algo.n + self.params.algo.m
        return (n - 3)*(self.maj + self.uma) + 7*self.cnot + 3*self.toffoli
