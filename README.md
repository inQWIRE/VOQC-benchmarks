# VOQC Benchmarking Scripts

This directory contains scripts for evaluating the [VOQC optimizer](https://github.com/inQWIRE/SQIR). In particular, use `run_on_staq_benchmarks.sh` to generate the data from our paper.

We consider the following benchmarks:
* **Nam-benchmarks**: Used to evaluate [an optimizer by Nam et al.](https://arxiv.org/abs/1710.07345); available in Quipper format at [github.com/njross/optimizer](https://github.com/njross/optimizer). We used [PyZX](https://github.com/Quantomatic/pyzx)'s `from_quipper_file` function to convert the circuits to OpenQASM.
* **staq-benchmarks**: Used to evaluate the [Staq compiler](https://arxiv.org/abs/1912.06070); available at [github.com/softwareQinc/staq](https://github.com/softwareQinc/staq/tree/main/examples/staq_paper/benchmarks). We exclude mod_adder_1048576.qasm and cycle_17_3.qasm because they are ill-typed. We exclude gf^X_mult.qasm for X >= 32 and hwbX.qasm for X >= 8 to keep the input circuit sizes under 10^4 gates.

## Setup

In order to run VOQC, you will need a working installation of OCaml and OCaml's package manager [opam](https://opam.ocaml.org/). You can install VOQC with `opam pin voqc https://github.com/inQWIRE/mlvoqc.git#mapping`.

Our other benchmarking scripts depend on PyZX, Qiksit, tket, and Staq, which you can install with `pip install pyzx qiskit pytket git+https://github.com/softwareQinc/staq`. Note that all of these projects require Python 3.