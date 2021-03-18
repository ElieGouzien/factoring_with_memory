#!/usr/bin/env python3
# coding: utf-8
"""
Tools for algorithmic resource estimate.

@author: Élie Gouzien
"""
import numbers
from collections import namedtuple
from datetime import timedelta

AlgoOpts = namedtuple('AlgoOpts',
                      'n, ne, we, wm, m, windowed, mesure_based_deand',
                      defaults=(None, None, None, None, None, True, True))
AlgoOpts.__doc__ = """AlgoOpts(n, ne, we, wm, m, windowed, mesure_based_deand)

Parameters:
    n  : number of bits of N
    ne : number of bits of exponent
    we : size of the exponentiation window
    wm : size of the multiplication window
    m  : number of bits added for coset representation
    windowed : use windowed algorithm ? (True or False)
    mesure_based_deand : measurement based AND uncomputation
                        (only for type == '3dcolor', otherwise take the
                         obvious option without considering this parameter)
"""

LowLevelOpts = namedtuple('LowLevelOpts', 'debitage, d1, d, tc, tr, pp',
                          defaults=(2, None, None, 1e-6, 1e-6, 1e-3))
LowLevelOpts.__doc__ = """LowLevelOpts(debitage, d1, d, tc, tr, pp)

Parameters:
    debitage : cut of tetrahedron for '3dcolor' error correction code
               1 is parallel to large tetrahedron face
               2 is as presented in article (orthogonal to two faces)
    d1 : distance of first step of distillation
    d  : main code distance
    tc : cycle time
    tr : reaction time
    pp : error probability on physical gates (inc. identity)
"""

Params = namedtuple('Params', 'type, algo, low_level')
Params.__doc__ = """'Params(type, algo, low_level)'

Parameters:
    type      : type of error correction : '3dcolor' or None
    algo      : algorithm options, type AlgoOpts
    low_level : low level options, type LowLevelOpts
"""


class PhysicalCost(namedtuple('PhysicalCost', ('p', 't'))):
    """Physical cost of some gates: error probability and runtime.

    Attributs
    ---------
        p : error probability.
        t : runtime.

    Methods
    -------
        Has same interface as namedtuple, except for listed operators.

    Operators
    ---------
        a + b : cost of serial execution of a and b.
        k * a : cost of serial execution of a k times (k can be float).
        a | b : cost of parallel execution of a and b.

    """

    def __add__(self, other):
        """Cost of sequential execution of self and other."""
        if not isinstance(other, __class__):
            return NotImplemented
        return __class__(1 - (1 - self.p)*(1 - other.p), self.t + other.t)

    def __mul__(self, other):
        """
        Cost of sequential execution of self other times.

        Other does not need to be integer (as some gates are probabilistically
                                           applied).
        """
        if not isinstance(other, numbers.Real):
            return NotImplemented
        return __class__(1 - (1 - self.p)**other, self.t * other)

    def __rmul__(self, other):
        """Right multiplication."""
        return self * other

    def __sub__(self, other):
        """Subtraction: revert previous of future addition."""
        return self + (-1 * other)

    def __or__(self, other):
        """Cost of parallel execution of self and other."""
        if not isinstance(other, __class__):
            return NotImplemented
        return __class__(1 - (1 - self.p)*(1-other.p), max(self.t, other.t))

    @property
    def exp_t(self):
        """Average runtime (several intents might be required)."""
        if self.p is None:
            return self.t
        if self.p >= 1:
            return float('inf')
        return self.t / (1 - self.p)

    @property
    def exp_t_str(self):
        """Format average runtime."""
        try:
            return timedelta(seconds=self.exp_t)
        except OverflowError:
            if self.exp_t == float('inf'):
                return "∞"
            return str(round(self.exp_t/(3600*24*365.25))) + " years"

    def __str__(self):
        """Readable representation of a PhysicalCost."""
        # pylint: disable=C0103
        try:
            t = timedelta(seconds=self.t)
        except OverflowError:
            if self.t == float('inf'):
                t = "∞"
            else:
                t = str(round(self.t/(3600*24*365.25))) + " years"
        return f"PhysicalCost(p={self.p}, t={t}, exp_t={self.exp_t_str})"
