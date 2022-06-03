from qiskit import QuantumCircuit
from qiskit.compiler import transpile
import os
import sys
import time

def sum_vals(d):
    sum = 0
    for k in d.keys():
        sum += d[k]
    return sum

def run(inf, outf=None):

    circ = QuantumCircuit.from_qasm_file(inf)

    start = time.perf_counter()
    new_circ = transpile(circ, basis_gates=['u1', 'u2', 'u3', 'cx'], coupling_map=None, optimization_level=3)
    stop = time.perf_counter()

    total_count = sum_vals(new_circ.count_ops())
    two_count = 0
    for inst, _, _ in new_circ.data:
        if (inst.name == "cx"):
            two_count += 1
    
    if outf:
        new_circ.qasm(filename=outf)

    print("\tTotal %d, 2-qubit %d" % (total_count, two_count))

    return ("%d,%d" % (two_count, total_count), stop - start)
