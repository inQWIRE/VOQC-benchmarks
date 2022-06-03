import pyzx as zx
import os
import sys
import time
import signal
from contextlib import contextmanager

class TimeoutException(Exception): pass

# From https://stackoverflow.com/questions/366682/how-to-limit-execution-time-of-a-function-call
@contextmanager
def time_limit(seconds):
    def signal_handler(signum, frame):
        raise TimeoutException("Timed out!")
    signal.signal(signal.SIGALRM, signal_handler)
    signal.alarm(seconds)
    try:
        yield
    finally:
        signal.alarm(0)

TIMEOUT = 600 # 600s = 10min

def run(inf, outf=None):

    circ = zx.Circuit.load(inf).to_basic_gates()

    start = time.perf_counter()
    g = circ.to_graph()
    zx.full_reduce(g)
    g.normalize()
    opt_circ = zx.extract_circuit(g).to_basic_gates()
    stop = time.perf_counter()
    elapsed = stop - start
    if elapsed < TIMEOUT:
        try: # try to run full_optimize, cancelling after 10 minutes - elapsed
            with time_limit(TIMEOUT - round(elapsed)):
                opt_circ = zx.full_optimize(opt_circ)
                stop = time.perf_counter()
        except TimeoutException:
            print("\tfull_optimize is slow; only running full_reduce")
    else:
        print("\tfull_optimize is slow; only running full_reduce")

    total_count = len(opt_circ.gates)
    two_count = opt_circ.twoqubitcount()
    t_count = zx.tcount(opt_circ)

    if outf:
        f = open(outf, "w")
        f.write(opt_circ.to_qasm())
        f.close()

    print("\tTotal %d, T %d, 2-qubit %d" % (total_count, t_count, two_count))

    return ("%d,%d,%d" % (t_count, two_count, total_count), stop - start)
