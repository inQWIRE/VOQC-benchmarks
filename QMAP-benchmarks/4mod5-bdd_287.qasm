OPENQASM 2.0;
include "qelib1.inc";
qreg q[16];

x q[4];
x q[6];
cx q[3],q[4];
cx q[1],q[4];
h q[5];
t q[0];
t q[4];
t q[5];
cx q[4],q[0];
cx q[5],q[4];
cx q[0],q[5];
tdg q[4];
cx q[0],q[4];
tdg q[0];
tdg q[4];
t q[5];
cx q[5],q[4];
cx q[0],q[5];
cx q[4],q[0];
h q[5];
h q[6];
t q[0];
t q[4];
t q[6];
cx q[4],q[0];
cx q[6],q[4];
cx q[0],q[6];
tdg q[4];
cx q[0],q[4];
tdg q[0];
tdg q[4];
t q[6];
cx q[6],q[4];
cx q[0],q[6];
cx q[4],q[0];
h q[6];
cx q[4],q[6];
x q[6];
h q[5];
t q[2];
t q[6];
t q[5];
cx q[6],q[2];
cx q[5],q[6];
cx q[2],q[5];
tdg q[6];
cx q[2],q[6];
tdg q[2];
tdg q[6];
t q[5];
cx q[5],q[6];
cx q[2],q[5];
cx q[6],q[2];
h q[5];
h q[6];
t q[2];
t q[5];
t q[6];
cx q[5],q[2];
cx q[6],q[5];
cx q[2],q[6];
tdg q[5];
cx q[2],q[5];
tdg q[2];
tdg q[5];
t q[6];
cx q[6],q[5];
cx q[2],q[6];
cx q[5],q[2];
h q[6];
