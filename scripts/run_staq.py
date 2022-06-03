import pystaq
import os
import sys
import time
import math

def sum_vals(d):
    sum = 0
    for k in d.keys():
        sum += d[k]
    return sum

def close(x, y):
    return math.isclose(x, y, abs_tol=1e-06) # hacky

def sum_t_vals(d):
    sum = 0
    for k in d.keys():
        if k == "x" or k == "h" or k == "s" or k == "cx" or k == "z": 
            pass
        elif k.startswith("u1"):
            angle = float(k[3:-1])
            x = angle / math.pi
            while x > 2: # staq sometimes outputs angles greater than 2pi
                x -= 2
            if close(x, 1/4) or close(x, 3/4) or close(x, 5/4) or close(x, 7/4):
                sum += d[k]
        else:
            sum += d[k]
    return sum

def run(inf, outf=None):

    qasm_f = open(inf, "r")
    circ = pystaq.parse_str(qasm_f.read())
    qasm_f.close()
    pystaq.inline(circ) # convert CCX to 1- and 2-qubit gates

    start = time.perf_counter()
    pystaq.simplify(circ)
    pystaq.rotation_fold(circ)
    pystaq.simplify(circ)
    pystaq.cnot_resynth(circ)
    pystaq.simplify(circ)
    stop = time.perf_counter()

    res = circ.get_resources().split("\n")[1:] # skip the first line
    counts = {}
    for line in res:
        if len(line) > 0:
            line = line.split(":")
            counts[line[0].strip()] = int(line[1])
    counts.pop("depth")
    counts.pop("qubits")

    total_count = sum_vals(counts)
    two_count = counts["cx"]
    t_count = sum_t_vals(counts)

    if outf:
        original_stdout = sys.stdout
        with open(outf, 'w') as f:
            sys.stdout = f
            print(circ)
            sys.stdout = original_stdout

    print("\tTotal %d, T %d, 2-qubit %d" % (total_count, t_count, two_count))

    return ("%d,%d,%d" % (t_count, two_count, total_count), stop - start)