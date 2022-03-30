import pyzx as zx
import os
import sys
import time

def run(d, fname):
    
    f = open(fname, "w")
        
    f.write("name,T,2q,total,time\n")
    
    for fname in os.listdir(d):

        print("Processing %s..." % fname)
        
        circ = zx.Circuit.load(os.path.join(d, fname)).to_basic_gates()

        start = time.perf_counter()
        g = circ.to_graph()
        zx.full_reduce(g)
        g.normalize()
        opt_circ1 = zx.extract_circuit(g).to_basic_gates()
        opt_circ2 = zx.full_optimize(opt_circ1)
        stop = time.perf_counter()
        
        total_count = len(opt_circ2.gates)
        two_count = opt_circ2.twoqubitcount()
        t_count = zx.tcount(opt_circ2)

        print("\t Total %d, T %d, 2-qubit %d\n" % (total_count, t_count, two_count))

        f.write("%s,%d,%d,%d,%f\n" % (fname, t_count, two_count, total_count, stop - start))

    f.close()

if (len(sys.argv) != 3):
    print("Usage: python run_pyzx.py <input directory> <output file>")
    exit(-1)

run(sys.argv[1], sys.argv[2])
