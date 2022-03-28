import pytket
from pytket.qasm import circuit_from_qasm, circuit_to_qasm
from pytket.circuit import OpType
from pytket.passes import SequencePass, RebasePyZX
from pytket.passes import OptimisePhaseGadgets, PauliSimp, FullPeepholeOptimise, RemoveRedundancies
import os
import sys
import time

def run(d,fname):
    
    f = open(fname, "w")
    
    f.write("name,1q,2q,total,time\n")
    
    for fname in os.listdir(d):

        print("Processing %s..." % fname)
        
        circ = circuit_from_qasm(os.path.join(d, fname))

        # Other useful optimizations include OptimisePhaseGadgets and PauliSimp.
        # We exclude them here because they make performance worse on our benchmarks.
        seq_pass=SequencePass([FullPeepholeOptimise(), RemoveRedundancies()])

        start = time.perf_counter()
        seq_pass.apply(circ)
        stop = time.perf_counter()

        total_count = circ.n_gates
        two_count = circ.n_gates_of_type(OpType.CX)
        one_count = total_count - two_count

        # note: could potentially convert to other gate sets here with RebaseCustom

        print("\t Total %d, 1q %d, CNOT %d\n" % (total_count, one_count, two_count))

        f.write("%s,%d,%d,%d,%f\n" % (fname, one_count, two_count, total_count, stop - start))
        
    f.close()

if (len(sys.argv) != 3):
    print("Usage: python run_tket.py <input directory> <output file>")
    exit(-1)

run(sys.argv[1], sys.argv[2])
