# VOQC Benchmarks

This directory contains the benchmarks used to evaluate the [VOQC optimizer](https://github.com/inQWIRE/SQIR). We include the scripts we used to generate data for our papers in the `scripts/` directory. These are primarily for our own use, but they may be helpful if you are looking for examples of how to run different quantum compilers.

We consider the following benchmarks:
* **Nam-benchmarks**: Used to evaluate [an optimizer by Nam et al.](https://arxiv.org/abs/1710.07345); available in Quipper format at [github.com/njross/optimizer](https://github.com/njross/optimizer). We used [PyZX](https://github.com/Quantomatic/pyzx)'s `from_quipper_file` function to convert the circuits to OpenQASM.
* **staq-benchmarks**: Used to evaluate the [Staq compiler](https://arxiv.org/abs/1912.06070); available at [github.com/softwareQinc/staq](https://github.com/softwareQinc/staq/tree/main/examples/staq_paper/benchmarks). We exclude circuits with more than 10^4 gates.
* **QMAP-benchmarks**: The example suite from the [MQT QMAP project](https://github.com/cda-tum/qmap). We exclude circuits with more than 10^4 gates.

## Setup

In order to run VOQC, you will need a working installation of OCaml and OCaml's package manager [opam](https://opam.ocaml.org/). You can install VOQC with `opam install voqc`.

Our other benchmarking scripts depend on PyZX, Qiksit, tket, and Staq, which you can install with `pip install pyzx qiskit pytket git+https://github.com/softwareQinc/staq`. Note that all of these projects require Python 3.