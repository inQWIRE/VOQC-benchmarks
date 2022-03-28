#!/bin/bash

filenames=( $(ls -d staq-benchmarks/*.qasm) )
export TIMEFORMAT="Wallclock time: %R seconds"

printf "Running VOQC with RzQ gate set...\n"
> voqc-rzq.csv
echo "name,Orig. total,Orig. Rzq,Orig. Cliff,Orig. H,Orig. X,Orig. CX,VOQC total,VOQC Rzq,VOQC Cliff,VOQC H,VOQC X,VOQC CX,wallclock time" >> voqc-rzq.csv
for filename in "${filenames[@]}"
do
    program_name=`basename "$filename" .qasm`
    printf "  ${filename}\n"
    (time dune exec -- ./voqc_cli.exe -i ${filename} -o out.qasm -optimize-nam -v) &> ${program_name}.txt
    python parseOutput.py ${program_name}.txt >> voqc-rzq.csv
    rm -f ${program_name}.txt
    rm -f out.qasm
done

printf "Running VOQC with IBM gate set...\n"
> voqc-ibm.csv
echo "name,Orig. total,Orig. 1q,Orig. 2q,VOQC total,VOQC 1q,VOQC 2q,wallclock time" >> voqc-ibm.csv
for filename in "${filenames[@]}"
do
    program_name=`basename "$filename" .qasm`
    printf "  ${filename}\n"
    (time dune exec -- ./voqc_cli.exe -i ${filename} -o out.qasm -optimize-nam -optimize-ibm) &> ${program_name}.txt
    python parseOutput.py ${program_name}.txt >> voqc-ibm.csv
    rm -f ${program_name}.txt
    rm -f out.qasm
done

printf "Running Qiskit\n"
python run_qiskit.py staq-benchmarks qiskit.csv

printf "Running tket\n"
python run_tket.py staq-benchmarks tket.csv

printf "Running Staq\n"
python run_staq.py staq-benchmarks staq.csv

printf "Running PyZX\n"
python run_pyzx.py staq-benchmarks pyzx.csv