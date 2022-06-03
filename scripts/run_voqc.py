import os
import sys
import time
import numpy as np

# this is a (hacky) wrapper around the OCaml CLI
# we should use VOQC's Python interface instead...
def run_ibm(inf, outf=None):
    
    if not outf:
        outf = "tmp.qasm"
    
    stream = os.popen("dune exec -- ./voqc_cli.exe -i %s -o %s -optimize-nam -optimize-ibm -v" % (inf, outf))
    output = stream.read()

    resDict = {}
    for line in output.split("\n"):
        # Look for original gate counts
        if line.startswith("Original gate counts") or line.startswith("Final gate counts"):
            category = line.split()[0].strip()
            resDict[category] = {}
            gatesStr = line.split("=")[-1]
            # Every element is GATE : count
            gatesInfo = gatesStr.split("{")[-1].split("}")[0].split(",")
            for gateInfo in gatesInfo:
                gate = gateInfo.split(":")[0].strip()
                count = int(gateInfo.split(":")[-1].strip())
                resDict[category][gate] = count
        # Look for time output
        elif line.startswith("Time taken to optimize:"):
            time = float(line.split("Time taken to optimize:")[-1].split("s")[0].strip())

    total_count = resDict["Final"]["Total"]
    two_count = resDict["Final"]["CX"]
    print("\tTotal %d, 2-qubit %d" % (total_count, two_count))

    return("%d,%d,%d,%d" % (resDict["Original"]["CX"], resDict["Original"]["Total"], two_count, total_count), time)

def run_rzq(inf, outf=None):
    
    if not outf:
        outf = "tmp.qasm"
    
    stream = os.popen("dune exec -- ./voqc_cli.exe -i %s -o %s -optimize-nam -v" % (inf, outf))
    output = stream.read()

    resDict = {}
    for line in output.split("\n"):
        # Look for original gate counts
        if line.startswith("Original gate counts") or line.startswith("Final gate counts"):
            category = line.split()[0].strip()
            resDict[category] = {}
            gatesStr = line.split("=")[-1]
            # Every element is GATE : count
            gatesInfo = gatesStr.split("{")[-1].split("}")[0].split(",")
            for gateInfo in gatesInfo:
                gate = gateInfo.split(":")[0].strip()
                count = int(gateInfo.split(":")[-1].strip())
                resDict[category][gate] = count
        # Look for time output
        elif line.startswith("Time taken to optimize:"):
            time = float(line.split("Time taken to optimize:")[-1].split("s")[0].strip())

    total_count = resDict["Final"]["Total"]
    t_count = resDict["Final"]["Rzq"] - resDict["Final"].get("Rzq(Clifford)", 0)
    two_count = resDict["Final"]["CX"]
    print("\tTotal %d, T %d, 2-qubit %d" % (total_count, t_count, two_count))

    return("%d,%d,%d,%d,%d,%d" % (resDict["Original"]["Rzq"], resDict["Original"]["CX"], resDict["Original"]["Total"], t_count, two_count, total_count), time)