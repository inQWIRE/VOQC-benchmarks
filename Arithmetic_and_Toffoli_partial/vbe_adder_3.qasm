OPENQASM 2.0;
include "qelib1.inc";
qreg q[10];
ccx q[1], q[2], q[3];
cx q[1], q[2];
ccx q[0], q[2], q[3];
ccx q[4], q[5], q[6];
cx q[4], q[5];
ccx q[3], q[5], q[6];
ccx q[7], q[8], q[9];
cx q[7], q[8];
ccx q[6], q[8], q[9];
cx q[6], q[8];
ccx q[3], q[5], q[6];
cx q[4], q[5];
ccx q[4], q[5], q[6];
cx q[3], q[5];
cx q[4], q[5];
ccx q[0], q[2], q[3];
cx q[1], q[2];
ccx q[1], q[2], q[3];
cx q[0], q[2];
cx q[1], q[2];
