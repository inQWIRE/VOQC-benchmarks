OPENQASM 2.0;
include "qelib1.inc";
qreg q[48];
ccx q[15], q[17], q[32];
ccx q[14], q[18], q[32];
ccx q[13], q[19], q[32];
ccx q[12], q[20], q[32];
ccx q[11], q[21], q[32];
ccx q[10], q[22], q[32];
ccx q[9], q[23], q[32];
ccx q[8], q[24], q[32];
ccx q[7], q[25], q[32];
ccx q[6], q[26], q[32];
ccx q[5], q[27], q[32];
ccx q[4], q[28], q[32];
ccx q[3], q[29], q[32];
ccx q[2], q[30], q[32];
ccx q[1], q[31], q[32];
ccx q[15], q[18], q[33];
ccx q[14], q[19], q[33];
ccx q[13], q[20], q[33];
ccx q[12], q[21], q[33];
ccx q[11], q[22], q[33];
ccx q[10], q[23], q[33];
ccx q[9], q[24], q[33];
ccx q[8], q[25], q[33];
ccx q[7], q[26], q[33];
ccx q[6], q[27], q[33];
ccx q[5], q[28], q[33];
ccx q[4], q[29], q[33];
ccx q[3], q[30], q[33];
ccx q[2], q[31], q[33];
ccx q[15], q[19], q[34];
ccx q[14], q[20], q[34];
ccx q[13], q[21], q[34];
ccx q[12], q[22], q[34];
ccx q[11], q[23], q[34];
ccx q[10], q[24], q[34];
ccx q[9], q[25], q[34];
ccx q[8], q[26], q[34];
ccx q[7], q[27], q[34];
ccx q[6], q[28], q[34];
ccx q[5], q[29], q[34];
ccx q[4], q[30], q[34];
ccx q[3], q[31], q[34];
ccx q[15], q[20], q[35];
ccx q[14], q[21], q[35];
ccx q[13], q[22], q[35];
ccx q[12], q[23], q[35];
ccx q[11], q[24], q[35];
ccx q[10], q[25], q[35];
ccx q[9], q[26], q[35];
ccx q[8], q[27], q[35];
ccx q[7], q[28], q[35];
ccx q[6], q[29], q[35];
ccx q[5], q[30], q[35];
ccx q[4], q[31], q[35];
ccx q[15], q[21], q[36];
ccx q[14], q[22], q[36];
ccx q[13], q[23], q[36];
ccx q[12], q[24], q[36];
ccx q[11], q[25], q[36];
ccx q[10], q[26], q[36];
ccx q[9], q[27], q[36];
ccx q[8], q[28], q[36];
ccx q[7], q[29], q[36];
ccx q[6], q[30], q[36];
ccx q[5], q[31], q[36];
ccx q[15], q[22], q[37];
ccx q[14], q[23], q[37];
ccx q[13], q[24], q[37];
ccx q[12], q[25], q[37];
ccx q[11], q[26], q[37];
ccx q[10], q[27], q[37];
ccx q[9], q[28], q[37];
ccx q[8], q[29], q[37];
ccx q[7], q[30], q[37];
ccx q[6], q[31], q[37];
ccx q[15], q[23], q[38];
ccx q[14], q[24], q[38];
ccx q[13], q[25], q[38];
ccx q[12], q[26], q[38];
ccx q[11], q[27], q[38];
ccx q[10], q[28], q[38];
ccx q[9], q[29], q[38];
ccx q[8], q[30], q[38];
ccx q[7], q[31], q[38];
ccx q[15], q[24], q[39];
ccx q[14], q[25], q[39];
ccx q[13], q[26], q[39];
ccx q[12], q[27], q[39];
ccx q[11], q[28], q[39];
ccx q[10], q[29], q[39];
ccx q[9], q[30], q[39];
ccx q[8], q[31], q[39];
ccx q[15], q[25], q[40];
ccx q[14], q[26], q[40];
ccx q[13], q[27], q[40];
ccx q[12], q[28], q[40];
ccx q[11], q[29], q[40];
ccx q[10], q[30], q[40];
ccx q[9], q[31], q[40];
ccx q[15], q[26], q[41];
ccx q[14], q[27], q[41];
ccx q[13], q[28], q[41];
ccx q[12], q[29], q[41];
ccx q[11], q[30], q[41];
ccx q[10], q[31], q[41];
ccx q[15], q[27], q[42];
ccx q[14], q[28], q[42];
ccx q[13], q[29], q[42];
ccx q[12], q[30], q[42];
ccx q[11], q[31], q[42];
ccx q[15], q[28], q[43];
ccx q[14], q[29], q[43];
ccx q[13], q[30], q[43];
ccx q[12], q[31], q[43];
ccx q[15], q[29], q[44];
ccx q[14], q[30], q[44];
ccx q[13], q[31], q[44];
ccx q[15], q[30], q[45];
ccx q[14], q[31], q[45];
ccx q[15], q[31], q[46];
cx q[46], q[35];
cx q[46], q[33];
cx q[46], q[32];
cx q[45], q[34];
cx q[45], q[32];
cx q[45], q[47];
cx q[44], q[33];
cx q[44], q[47];
cx q[44], q[46];
cx q[43], q[32];
cx q[43], q[46];
cx q[43], q[45];
cx q[42], q[47];
cx q[42], q[45];
cx q[42], q[44];
cx q[41], q[46];
cx q[41], q[44];
cx q[41], q[43];
cx q[40], q[45];
cx q[40], q[43];
cx q[40], q[42];
cx q[39], q[44];
cx q[39], q[42];
cx q[39], q[41];
cx q[38], q[43];
cx q[38], q[41];
cx q[38], q[40];
cx q[37], q[42];
cx q[37], q[40];
cx q[37], q[39];
cx q[36], q[41];
cx q[36], q[39];
cx q[36], q[38];
cx q[35], q[40];
cx q[35], q[38];
cx q[35], q[37];
cx q[34], q[39];
cx q[34], q[37];
cx q[34], q[36];
cx q[33], q[38];
cx q[33], q[36];
cx q[33], q[35];
cx q[32], q[37];
cx q[32], q[35];
cx q[32], q[34];
ccx q[15], q[16], q[47];
ccx q[14], q[17], q[47];
ccx q[13], q[18], q[47];
ccx q[12], q[19], q[47];
ccx q[11], q[20], q[47];
ccx q[10], q[21], q[47];
ccx q[9], q[22], q[47];
ccx q[8], q[23], q[47];
ccx q[7], q[24], q[47];
ccx q[6], q[25], q[47];
ccx q[5], q[26], q[47];
ccx q[4], q[27], q[47];
ccx q[3], q[28], q[47];
ccx q[2], q[29], q[47];
ccx q[1], q[30], q[47];
ccx q[0], q[31], q[47];
ccx q[14], q[16], q[46];
ccx q[13], q[17], q[46];
ccx q[12], q[18], q[46];
ccx q[11], q[19], q[46];
ccx q[10], q[20], q[46];
ccx q[9], q[21], q[46];
ccx q[8], q[22], q[46];
ccx q[7], q[23], q[46];
ccx q[6], q[24], q[46];
ccx q[5], q[25], q[46];
ccx q[4], q[26], q[46];
ccx q[3], q[27], q[46];
ccx q[2], q[28], q[46];
ccx q[1], q[29], q[46];
ccx q[0], q[30], q[46];
ccx q[13], q[16], q[45];
ccx q[12], q[17], q[45];
ccx q[11], q[18], q[45];
ccx q[10], q[19], q[45];
ccx q[9], q[20], q[45];
ccx q[8], q[21], q[45];
ccx q[7], q[22], q[45];
ccx q[6], q[23], q[45];
ccx q[5], q[24], q[45];
ccx q[4], q[25], q[45];
ccx q[3], q[26], q[45];
ccx q[2], q[27], q[45];
ccx q[1], q[28], q[45];
ccx q[0], q[29], q[45];
ccx q[12], q[16], q[44];
ccx q[11], q[17], q[44];
ccx q[10], q[18], q[44];
ccx q[9], q[19], q[44];
ccx q[8], q[20], q[44];
ccx q[7], q[21], q[44];
ccx q[6], q[22], q[44];
ccx q[5], q[23], q[44];
ccx q[4], q[24], q[44];
ccx q[3], q[25], q[44];
ccx q[2], q[26], q[44];
ccx q[1], q[27], q[44];
ccx q[0], q[28], q[44];
ccx q[11], q[16], q[43];
ccx q[10], q[17], q[43];
ccx q[9], q[18], q[43];
ccx q[8], q[19], q[43];
ccx q[7], q[20], q[43];
ccx q[6], q[21], q[43];
ccx q[5], q[22], q[43];
ccx q[4], q[23], q[43];
ccx q[3], q[24], q[43];
ccx q[2], q[25], q[43];
ccx q[1], q[26], q[43];
ccx q[0], q[27], q[43];
ccx q[10], q[16], q[42];
ccx q[9], q[17], q[42];
ccx q[8], q[18], q[42];
ccx q[7], q[19], q[42];
ccx q[6], q[20], q[42];
ccx q[5], q[21], q[42];
ccx q[4], q[22], q[42];
ccx q[3], q[23], q[42];
ccx q[2], q[24], q[42];
ccx q[1], q[25], q[42];
ccx q[0], q[26], q[42];
ccx q[9], q[16], q[41];
ccx q[8], q[17], q[41];
ccx q[7], q[18], q[41];
ccx q[6], q[19], q[41];
ccx q[5], q[20], q[41];
ccx q[4], q[21], q[41];
ccx q[3], q[22], q[41];
ccx q[2], q[23], q[41];
ccx q[1], q[24], q[41];
ccx q[0], q[25], q[41];
ccx q[8], q[16], q[40];
ccx q[7], q[17], q[40];
ccx q[6], q[18], q[40];
ccx q[5], q[19], q[40];
ccx q[4], q[20], q[40];
ccx q[3], q[21], q[40];
ccx q[2], q[22], q[40];
ccx q[1], q[23], q[40];
ccx q[0], q[24], q[40];
ccx q[7], q[16], q[39];
ccx q[6], q[17], q[39];
ccx q[5], q[18], q[39];
ccx q[4], q[19], q[39];
ccx q[3], q[20], q[39];
ccx q[2], q[21], q[39];
ccx q[1], q[22], q[39];
ccx q[0], q[23], q[39];
ccx q[6], q[16], q[38];
ccx q[5], q[17], q[38];
ccx q[4], q[18], q[38];
ccx q[3], q[19], q[38];
ccx q[2], q[20], q[38];
ccx q[1], q[21], q[38];
ccx q[0], q[22], q[38];
ccx q[5], q[16], q[37];
ccx q[4], q[17], q[37];
ccx q[3], q[18], q[37];
ccx q[2], q[19], q[37];
ccx q[1], q[20], q[37];
ccx q[0], q[21], q[37];
ccx q[4], q[16], q[36];
ccx q[3], q[17], q[36];
ccx q[2], q[18], q[36];
ccx q[1], q[19], q[36];
ccx q[0], q[20], q[36];
ccx q[3], q[16], q[35];
ccx q[2], q[17], q[35];
ccx q[1], q[18], q[35];
ccx q[0], q[19], q[35];
ccx q[2], q[16], q[34];
ccx q[1], q[17], q[34];
ccx q[0], q[18], q[34];
ccx q[1], q[16], q[33];
ccx q[0], q[17], q[33];
ccx q[0], q[16], q[32];
