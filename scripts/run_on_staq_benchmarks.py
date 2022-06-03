from run_pyzx import run as run_pyzx
from run_qiskit import run as run_qiskit
from run_staq import run as run_staq
from run_tket import run as run_tket
from run_voqc import run_ibm as run_voqc_ibm
from run_voqc import run_rzq as run_voqc_rzq

import sys
import os
import numpy as np

def get_ibm_summary(d, fname):
    f = open(fname, "w")
    f.write("name,Original 2q,Original total,VOQC 2q,VOQC total,Qiskit 2q,Qiskit total,tket 2q,tket total\n")
    
    for fname in os.listdir(d):
        inf = os.path.join(d, fname)
        print("Processing %s..." % fname)
        f.write("%s," % fname.split(".")[0])

        res = run_voqc_ibm(inf)
        f.write("%s," % res[0])
        
        res = run_qiskit(inf)
        f.write("%s," % res[0])

        res = run_tket(inf)
        f.write("%s\n" % res[0])

    f.close()

def get_rzq_summary(d, fname):
    f = open(fname, "w")
    f.write("name,Original T,Original 2q,Original total,VOQC T,VOQC 2q,VOQC total,Staq T,Staq 2q,Staq total,PyZX T,PyZX 2q,PyZX total\n")
    
    for fname in os.listdir(d):
        inf = os.path.join(d, fname)
        print("Processing %s..." % fname)
        f.write("%s," % fname.split(".")[0])

        res = run_voqc_rzq(inf)
        f.write("%s," % res[0])
        
        res = run_staq(inf)
        f.write("%s," % res[0])

        res = run_pyzx(inf)
        f.write("%s\n" % res[0])

    f.close()

def get_median_times(d, fname, num_trials=11):
    f = open(fname, "w")
    f.write("name,VOQC time,Qiskit time,tket time,Staq time,PyZX time\n")
    
    for fname in os.listdir(d):
        inf = os.path.join(d, fname)
        print("Processing %s..." % fname)

        times = []
        for i in range(num_trials):
            res = run_voqc_ibm(inf)
            times.append(res[1])
        voqc_time = np.median(np.array(times))

        times = []
        for i in range(num_trials):
            res = run_qiskit(inf)
            times.append(res[1])
        qiskit_time = np.median(np.array(times))

        times = []
        for i in range(num_trials):
            res = run_tket(inf)
            times.append(res[1])
        tket_time = np.median(np.array(times))

        times = []
        for i in range(num_trials):
            res = run_staq(inf)
            times.append(res[1])
        staq_time = np.median(np.array(times))

        times = []
        for i in range(num_trials):
            res = run_pyzx(inf)
            times.append(res[1])
        pyzx_time = np.median(np.array(times))
        
        f.write("%s,%f,%f,%f,%f,%f\n" % (fname.split(".")[0], voqc_time, qiskit_time, tket_time, staq_time, pyzx_time))
        
    f.close()

# requires that ../staq-benchmarks-results and sub-directories already exist
def write_optimized_files(din, dout):  
    for fname in os.listdir(din):
        print("Processing %s..." % fname.split(".")[0])
        run_voqc_ibm(os.path.join(din, fname), os.path.join(dout, "voqc-ibm", fname))
        run_voqc_rzq(os.path.join(din, fname), os.path.join(dout, "voqc-rzq", fname))
        run_qiskit(os.path.join(din, fname), os.path.join(dout, "qiskit", fname))
        run_tket(os.path.join(din, fname), os.path.join(dout, "tket", fname))
        run_staq(os.path.join(din, fname), os.path.join(dout, "staq", fname))
        run_pyzx(os.path.join(din, fname), os.path.join(dout, "pyzx", fname))

if (len(sys.argv) != 1):
    print("Usage: python run_on_staq_benchmarks.py")
    exit(-1)

get_ibm_summary("../staq-benchmarks", "ibm_summary.csv")
get_rzq_summary("../staq-benchmarks", "rzq_summary.csv")
# get_median_times("../staq-benchmarks", "times.csv")
# write_optimized_files("../staq-benchmarks", "../staq-benchmarks-results")