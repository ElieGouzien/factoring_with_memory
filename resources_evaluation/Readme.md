Code for computations in [arXiv:2103.06159](https://arxiv.org/abs/2103.06159)
=============================================================================


Computation of resources for RSA factorization
----------------------------------------------

Python files for evaluating the cost of RSA factorization with a small processor and a memory.

Manifest:
  * `tools.py` : definition of useful data structures.
  * `error_correction.py` : representation of error correction, and the cost evaluation for circuits.
  * `cout_shor.py` : main file doing the evaluation by optimizing on the parameters.
