import pytket
from pytket.qasm import circuit_from_qasm, circuit_to_qasm
from pytket.circuit import OpType
from pytket.passes import SequencePass, RebasePyZX
from pytket.passes import OptimisePhaseGadgets, PauliSimp, FullPeepholeOptimise, RemoveRedundancies
import os
import sys
import time
import numpy as np

def run(inf, outf=None):
    
    circ = circuit_from_qasm(inf)

    # Other useful optimizations include OptimisePhaseGadgets and PauliSimp.
    # We exclude them here because they make performance worse on our benchmarks.
    seq_pass=SequencePass([FullPeepholeOptimise(), RemoveRedundancies()])

    start = time.perf_counter()
    seq_pass.apply(circ)
    stop = time.perf_counter()

    total_count = circ.n_gates
    two_count = circ.n_gates_of_type(OpType.CX)

    # note: could potentially convert to other gate sets here with RebaseCustom

    if outf:
        circuit_to_qasm(circ, outf)

    print("\tTotal %d, 2-qubit %d" % (total_count, two_count))

    return ("%d,%d" % (two_count, total_count), stop - start)
