import sys

if __name__ == "__main__":
    inFile = sys.argv[1]
    fIn = open(inFile, "r")
    lines = fIn.readlines()
    fIn.close()

    # Keys are "Original" and "Final"
    # Value are dicts mapping gate names to counts
    resDict = {}
    wallClockTime = None
    for line in lines:
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
        elif line.startswith("Wallclock time:"):
            wallClockTime = float(line.split("Wallclock time:")[-1].split("seconds")[0].strip())

    # Print out results. The run_benchmarks script will redirect to the CSV file. 

    if "1q" in resDict["Original"]:
        # use IBM header
        # name,Orig. total,Orig. 1q,Orig. 2q,VOQC total,VOQC 1q,VOQC 2q,wallclock time
        
        name = inFile.split("/")[-1].split(".txt")[0].strip()
        print("%s,%d,%d,%d,%d,%d,%d,%f" %(name, resDict["Original"]["Total"], resDict["Original"]["1q"],\
                                          resDict["Original"]["2q"], resDict["Final"]["Total"],\
                                          resDict["Final"]["1q"], resDict["Final"]["2q"], wallClockTime))

    else:
        # use RzQ header
        # name,Orig. total,Orig. Rzq,Orig. Cliff,Orig. H,Orig. X,Orig. CX,VOQC total,VOQC Rzq,VOQC Cliff,VOQC H,VOQC X,VOQC CX,wallclock time

        if not "Rzq(Clifford)" in resDict["Original"]:
            resDict["Original"]["Rzq(Clifford)"] = 0
        if not "X" in resDict["Original"]:
            resDict["Original"]["X"] = 0
        if not "Rzq(Clifford)" in resDict["Final"]:
            resDict["Final"]["Rzq(Clifford)"] = 0
        if not "X" in resDict["Final"]:
            resDict["Final"]["X"] = 0
        
        name = inFile.split("/")[-1].split(".txt")[0].strip()
        print("%s,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%f" %(name, resDict["Original"]["Total"], resDict["Original"]["Rzq"],\
                                                            resDict["Original"]["Rzq(Clifford)"], resDict["Original"]["H"], \
                                                            resDict["Original"]["X"], resDict["Original"]["CX"],\
                                                            resDict["Final"]["Total"], resDict["Final"]["Rzq"],\
                                                            resDict["Final"]["Rzq(Clifford)"], resDict["Final"]["H"],\
                                                            resDict["Final"]["X"], resDict["Final"]["CX"], wallClockTime))

