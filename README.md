# VOQC Benchmarks

This directory contains the benchmarks used to evaluate the [VOQC optimizer](https://github.com/inQWIRE/SQIR). These benchmarks were taken from https://github.com/njross/optimizer and converted to OpenQASM using [PyZX](https://github.com/Quantomatic/pyzx)'s `from_quipper_file` function. 

These benchmarks were previously used to evaluate [an optimizer by Nam et al.](https://arxiv.org/abs/1710.07345). We have made a few modifications. In particular, some programs in the QFT_and_Adders directory originally contained ancilla initialization and termination; PyZX removes these during conversion to OpenQASM. PyZX also converts z-axis rotation angles to the form 'x * pi' by rounding. For the PF benchmarks, we translate these rz gates to our rzq gates in the parser; for the QFT programs we have translated the rz gates to rzq gates in advance. Finally, the gf2^X family of circuits and csum_mux_9 have been lightly edited to remove redundant H gates that caused inconsistencies in the original gate counts.
