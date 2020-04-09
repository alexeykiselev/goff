// Code generated by goff (v0.2.0) DO NOT EDIT

#include "textflag.h"

// func MulAssignElement(res,y *Element)
// montgomery multiplication of res by y
// stores the result in res
TEXT ·MulAssignElement(SB), NOSPLIT, $0-16
    
    // dereference our parameters
    MOVQ res+0(FP), R9
    MOVQ y+8(FP), R10
    
    // check if we support adx and mulx
    CMPB ·supportAdx(SB), $1
    JNE no_adx
    
    // the algorithm is described here
    // https://hackmd.io/@zkteam/modular_multiplication
    // however, to benefit from the ADCX and ADOX carry chains
    // we split the inner loops in 2:
    // for i=0 to N-1
    // 		for j=0 to N-1
    // 		    (A,t[j])  := t[j] + a[j]*b[i] + A
    // 		m := t[0]*q'[0] mod W
    // 		C,_ := t[0] + m*q[0]
    // 		for j=1 to N-1
    // 		    (C,t[j-1]) := t[j] + m*q[j] + C
    // 		t[N-1] = C + A
    
    // ---------------------------------------------------------------------------------------------
    // outter loop 0
    
    // clear up the carry flags
    XORQ R11 , R11
    
    // DX = y[0]
    MOVQ 0(R10), DX
    
    // for j=0 to N-1
    //    (A,t[j])  := t[j] + x[j]*y[i] + A
    
    MULXQ 0(R9), CX, BX
    
    MULXQ 8(R9), AX, BP
    ADOXQ AX, BX
    
    MULXQ 16(R9), AX, SI
    ADOXQ AX, BP
    
    MULXQ 24(R9), AX, DI
    ADOXQ AX, SI
    
    MULXQ 32(R9), AX, R8
    ADOXQ AX, DI
    
    MULXQ 40(R9), AX, R11
    ADOXQ AX, R8
    
    // add the last carries to R11
    MOVQ $0, DX
    ADCXQ DX, R11
    ADOXQ DX, R11
    
    // m := t[0]*q'[0] mod W
    MOVQ $0x8508bfffffffffff, DX
    MULXQ CX,R12, DX
    
    // clear the carry flags
    XORQ DX, DX
    
    // C,_ := t[0] + m*q[0]
    MOVQ $0x8508c00000000001, DX
    MULXQ R12, AX, DX
    ADCXQ CX ,AX
    MOVQ DX, CX
    
    // for j=1 to N-1
    //    (C,t[j-1]) := t[j] + m*q[j] + C
    MOVQ $0x170b5d4430000000, DX
    ADCXQ  BX, CX
    MULXQ R12, AX, BX
    ADOXQ AX, CX
    MOVQ $0x1ef3622fba094800, DX
    ADCXQ  BP, BX
    MULXQ R12, AX, BP
    ADOXQ AX, BX
    MOVQ $0x1a22d9f300f5138f, DX
    ADCXQ  SI, BP
    MULXQ R12, AX, SI
    ADOXQ AX, BP
    MOVQ $0xc63b05c06ca1493b, DX
    ADCXQ  DI, SI
    MULXQ R12, AX, DI
    ADOXQ AX, SI
    MOVQ $0x01ae3a4617c510ea, DX
    ADCXQ  R8, DI
    MULXQ R12, AX, R8
    ADOXQ AX, DI
    MOVQ $0, AX
    ADCXQ AX, R8
    ADOXQ R11, R8
    
    // ---------------------------------------------------------------------------------------------
    // outter loop 1
    
    // clear up the carry flags
    XORQ R11 , R11
    
    // DX = y[1]
    MOVQ 8(R10), DX
    
    // for j=0 to N-1
    //    (A,t[j])  := t[j] + x[j]*y[i] + A
    
    MULXQ 0(R9), AX, R11
    ADOXQ AX, CX
    
    ADCXQ R11, BX
    MULXQ 8(R9), AX, R11
    ADOXQ AX, BX
    
    ADCXQ R11, BP
    MULXQ 16(R9), AX, R11
    ADOXQ AX, BP
    
    ADCXQ R11, SI
    MULXQ 24(R9), AX, R11
    ADOXQ AX, SI
    
    ADCXQ R11, DI
    MULXQ 32(R9), AX, R11
    ADOXQ AX, DI
    
    ADCXQ R11, R8
    MULXQ 40(R9), AX, R11
    ADOXQ AX, R8
    
    // add the last carries to R11
    MOVQ $0, DX
    ADCXQ DX, R11
    ADOXQ DX, R11
    
    // m := t[0]*q'[0] mod W
    MOVQ $0x8508bfffffffffff, DX
    MULXQ CX,R12, DX
    
    // clear the carry flags
    XORQ DX, DX
    
    // C,_ := t[0] + m*q[0]
    MOVQ $0x8508c00000000001, DX
    MULXQ R12, AX, DX
    ADCXQ CX ,AX
    MOVQ DX, CX
    
    // for j=1 to N-1
    //    (C,t[j-1]) := t[j] + m*q[j] + C
    MOVQ $0x170b5d4430000000, DX
    ADCXQ  BX, CX
    MULXQ R12, AX, BX
    ADOXQ AX, CX
    MOVQ $0x1ef3622fba094800, DX
    ADCXQ  BP, BX
    MULXQ R12, AX, BP
    ADOXQ AX, BX
    MOVQ $0x1a22d9f300f5138f, DX
    ADCXQ  SI, BP
    MULXQ R12, AX, SI
    ADOXQ AX, BP
    MOVQ $0xc63b05c06ca1493b, DX
    ADCXQ  DI, SI
    MULXQ R12, AX, DI
    ADOXQ AX, SI
    MOVQ $0x01ae3a4617c510ea, DX
    ADCXQ  R8, DI
    MULXQ R12, AX, R8
    ADOXQ AX, DI
    MOVQ $0, AX
    ADCXQ AX, R8
    ADOXQ R11, R8
    
    // ---------------------------------------------------------------------------------------------
    // outter loop 2
    
    // clear up the carry flags
    XORQ R11 , R11
    
    // DX = y[2]
    MOVQ 16(R10), DX
    
    // for j=0 to N-1
    //    (A,t[j])  := t[j] + x[j]*y[i] + A
    
    MULXQ 0(R9), AX, R11
    ADOXQ AX, CX
    
    ADCXQ R11, BX
    MULXQ 8(R9), AX, R11
    ADOXQ AX, BX
    
    ADCXQ R11, BP
    MULXQ 16(R9), AX, R11
    ADOXQ AX, BP
    
    ADCXQ R11, SI
    MULXQ 24(R9), AX, R11
    ADOXQ AX, SI
    
    ADCXQ R11, DI
    MULXQ 32(R9), AX, R11
    ADOXQ AX, DI
    
    ADCXQ R11, R8
    MULXQ 40(R9), AX, R11
    ADOXQ AX, R8
    
    // add the last carries to R11
    MOVQ $0, DX
    ADCXQ DX, R11
    ADOXQ DX, R11
    
    // m := t[0]*q'[0] mod W
    MOVQ $0x8508bfffffffffff, DX
    MULXQ CX,R12, DX
    
    // clear the carry flags
    XORQ DX, DX
    
    // C,_ := t[0] + m*q[0]
    MOVQ $0x8508c00000000001, DX
    MULXQ R12, AX, DX
    ADCXQ CX ,AX
    MOVQ DX, CX
    
    // for j=1 to N-1
    //    (C,t[j-1]) := t[j] + m*q[j] + C
    MOVQ $0x170b5d4430000000, DX
    ADCXQ  BX, CX
    MULXQ R12, AX, BX
    ADOXQ AX, CX
    MOVQ $0x1ef3622fba094800, DX
    ADCXQ  BP, BX
    MULXQ R12, AX, BP
    ADOXQ AX, BX
    MOVQ $0x1a22d9f300f5138f, DX
    ADCXQ  SI, BP
    MULXQ R12, AX, SI
    ADOXQ AX, BP
    MOVQ $0xc63b05c06ca1493b, DX
    ADCXQ  DI, SI
    MULXQ R12, AX, DI
    ADOXQ AX, SI
    MOVQ $0x01ae3a4617c510ea, DX
    ADCXQ  R8, DI
    MULXQ R12, AX, R8
    ADOXQ AX, DI
    MOVQ $0, AX
    ADCXQ AX, R8
    ADOXQ R11, R8
    
    // ---------------------------------------------------------------------------------------------
    // outter loop 3
    
    // clear up the carry flags
    XORQ R11 , R11
    
    // DX = y[3]
    MOVQ 24(R10), DX
    
    // for j=0 to N-1
    //    (A,t[j])  := t[j] + x[j]*y[i] + A
    
    MULXQ 0(R9), AX, R11
    ADOXQ AX, CX
    
    ADCXQ R11, BX
    MULXQ 8(R9), AX, R11
    ADOXQ AX, BX
    
    ADCXQ R11, BP
    MULXQ 16(R9), AX, R11
    ADOXQ AX, BP
    
    ADCXQ R11, SI
    MULXQ 24(R9), AX, R11
    ADOXQ AX, SI
    
    ADCXQ R11, DI
    MULXQ 32(R9), AX, R11
    ADOXQ AX, DI
    
    ADCXQ R11, R8
    MULXQ 40(R9), AX, R11
    ADOXQ AX, R8
    
    // add the last carries to R11
    MOVQ $0, DX
    ADCXQ DX, R11
    ADOXQ DX, R11
    
    // m := t[0]*q'[0] mod W
    MOVQ $0x8508bfffffffffff, DX
    MULXQ CX,R12, DX
    
    // clear the carry flags
    XORQ DX, DX
    
    // C,_ := t[0] + m*q[0]
    MOVQ $0x8508c00000000001, DX
    MULXQ R12, AX, DX
    ADCXQ CX ,AX
    MOVQ DX, CX
    
    // for j=1 to N-1
    //    (C,t[j-1]) := t[j] + m*q[j] + C
    MOVQ $0x170b5d4430000000, DX
    ADCXQ  BX, CX
    MULXQ R12, AX, BX
    ADOXQ AX, CX
    MOVQ $0x1ef3622fba094800, DX
    ADCXQ  BP, BX
    MULXQ R12, AX, BP
    ADOXQ AX, BX
    MOVQ $0x1a22d9f300f5138f, DX
    ADCXQ  SI, BP
    MULXQ R12, AX, SI
    ADOXQ AX, BP
    MOVQ $0xc63b05c06ca1493b, DX
    ADCXQ  DI, SI
    MULXQ R12, AX, DI
    ADOXQ AX, SI
    MOVQ $0x01ae3a4617c510ea, DX
    ADCXQ  R8, DI
    MULXQ R12, AX, R8
    ADOXQ AX, DI
    MOVQ $0, AX
    ADCXQ AX, R8
    ADOXQ R11, R8
    
    // ---------------------------------------------------------------------------------------------
    // outter loop 4
    
    // clear up the carry flags
    XORQ R11 , R11
    
    // DX = y[4]
    MOVQ 32(R10), DX
    
    // for j=0 to N-1
    //    (A,t[j])  := t[j] + x[j]*y[i] + A
    
    MULXQ 0(R9), AX, R11
    ADOXQ AX, CX
    
    ADCXQ R11, BX
    MULXQ 8(R9), AX, R11
    ADOXQ AX, BX
    
    ADCXQ R11, BP
    MULXQ 16(R9), AX, R11
    ADOXQ AX, BP
    
    ADCXQ R11, SI
    MULXQ 24(R9), AX, R11
    ADOXQ AX, SI
    
    ADCXQ R11, DI
    MULXQ 32(R9), AX, R11
    ADOXQ AX, DI
    
    ADCXQ R11, R8
    MULXQ 40(R9), AX, R11
    ADOXQ AX, R8
    
    // add the last carries to R11
    MOVQ $0, DX
    ADCXQ DX, R11
    ADOXQ DX, R11
    
    // m := t[0]*q'[0] mod W
    MOVQ $0x8508bfffffffffff, DX
    MULXQ CX,R12, DX
    
    // clear the carry flags
    XORQ DX, DX
    
    // C,_ := t[0] + m*q[0]
    MOVQ $0x8508c00000000001, DX
    MULXQ R12, AX, DX
    ADCXQ CX ,AX
    MOVQ DX, CX
    
    // for j=1 to N-1
    //    (C,t[j-1]) := t[j] + m*q[j] + C
    MOVQ $0x170b5d4430000000, DX
    ADCXQ  BX, CX
    MULXQ R12, AX, BX
    ADOXQ AX, CX
    MOVQ $0x1ef3622fba094800, DX
    ADCXQ  BP, BX
    MULXQ R12, AX, BP
    ADOXQ AX, BX
    MOVQ $0x1a22d9f300f5138f, DX
    ADCXQ  SI, BP
    MULXQ R12, AX, SI
    ADOXQ AX, BP
    MOVQ $0xc63b05c06ca1493b, DX
    ADCXQ  DI, SI
    MULXQ R12, AX, DI
    ADOXQ AX, SI
    MOVQ $0x01ae3a4617c510ea, DX
    ADCXQ  R8, DI
    MULXQ R12, AX, R8
    ADOXQ AX, DI
    MOVQ $0, AX
    ADCXQ AX, R8
    ADOXQ R11, R8
    
    // ---------------------------------------------------------------------------------------------
    // outter loop 5
    
    // clear up the carry flags
    XORQ R11 , R11
    
    // DX = y[5]
    MOVQ 40(R10), DX
    
    // for j=0 to N-1
    //    (A,t[j])  := t[j] + x[j]*y[i] + A
    
    MULXQ 0(R9), AX, R11
    ADOXQ AX, CX
    
    ADCXQ R11, BX
    MULXQ 8(R9), AX, R11
    ADOXQ AX, BX
    
    ADCXQ R11, BP
    MULXQ 16(R9), AX, R11
    ADOXQ AX, BP
    
    ADCXQ R11, SI
    MULXQ 24(R9), AX, R11
    ADOXQ AX, SI
    
    ADCXQ R11, DI
    MULXQ 32(R9), AX, R11
    ADOXQ AX, DI
    
    ADCXQ R11, R8
    MULXQ 40(R9), AX, R11
    ADOXQ AX, R8
    
    // add the last carries to R11
    MOVQ $0, DX
    ADCXQ DX, R11
    ADOXQ DX, R11
    
    // m := t[0]*q'[0] mod W
    MOVQ $0x8508bfffffffffff, DX
    MULXQ CX,R12, DX
    
    // clear the carry flags
    XORQ DX, DX
    
    // C,_ := t[0] + m*q[0]
    MOVQ $0x8508c00000000001, DX
    MULXQ R12, AX, DX
    ADCXQ CX ,AX
    MOVQ DX, CX
    
    // for j=1 to N-1
    //    (C,t[j-1]) := t[j] + m*q[j] + C
    MOVQ $0x170b5d4430000000, DX
    ADCXQ  BX, CX
    MULXQ R12, AX, BX
    ADOXQ AX, CX
    MOVQ $0x1ef3622fba094800, DX
    ADCXQ  BP, BX
    MULXQ R12, AX, BP
    ADOXQ AX, BX
    MOVQ $0x1a22d9f300f5138f, DX
    ADCXQ  SI, BP
    MULXQ R12, AX, SI
    ADOXQ AX, BP
    MOVQ $0xc63b05c06ca1493b, DX
    ADCXQ  DI, SI
    MULXQ R12, AX, DI
    ADOXQ AX, SI
    MOVQ $0x01ae3a4617c510ea, DX
    ADCXQ  R8, DI
    MULXQ R12, AX, R8
    ADOXQ AX, DI
    MOVQ $0, AX
    ADCXQ AX, R8
    ADOXQ R11, R8
    
    reduce:
    // reduce, constant time version
    // first we copy registers storing t in a separate set of registers
    // as SUBQ modifies the 2nd operand
    MOVQ CX, DX
    MOVQ BX, R10
    MOVQ BP, R11
    MOVQ SI, R12
    MOVQ DI, R13
    MOVQ R8, R14
    MOVQ $0x8508c00000000001, R15
    SUBQ  R15, DX
    MOVQ $0x170b5d4430000000, R15
    SBBQ  R15, R10
    MOVQ $0x1ef3622fba094800, R15
    SBBQ  R15, R11
    MOVQ $0x1a22d9f300f5138f, R15
    SBBQ  R15, R12
    MOVQ $0xc63b05c06ca1493b, R15
    SBBQ  R15, R13
    MOVQ $0x01ae3a4617c510ea, R15
    SBBQ  R15, R14
    JCS t_is_smaller // no borrow, we return t
    
    // borrow is set, we return u
    MOVQ DX, (R9)
    MOVQ R10, 8(R9)
    MOVQ R11, 16(R9)
    MOVQ R12, 24(R9)
    MOVQ R13, 32(R9)
    MOVQ R14, 40(R9)
    RET
    t_is_smaller:
    MOVQ CX, 0(R9)
    MOVQ BX, 8(R9)
    MOVQ BP, 16(R9)
    MOVQ SI, 24(R9)
    MOVQ DI, 32(R9)
    MOVQ R8, 40(R9)
    RET
    
    no_adx:
    
    // ---------------------------------------------------------------------------------------------
    // outter loop 0
    
    // (A,t[0]) := t[0] + x[0]*y[0]
    MOVQ (R9), AX // x[0]
    MOVQ 0(R10), R14
    MULQ R14 // x[0] * y[0]
    MOVQ DX, R11
    MOVQ AX, CX
    
    // m := t[0]*q'[0] mod W
    MOVQ $0x8508bfffffffffff, R12
    IMULQ CX , R12
    
    // C,_ := t[0] + m*q[0]
    MOVQ $0x8508c00000000001, AX
    MULQ R12
    ADDQ CX ,AX
    ADCQ $0, DX
    MOVQ  DX, R13
    
    // for j=1 to N-1
    //    (A,t[j])  := t[j] + x[j]*y[i] + A
    //    (C,t[j-1]) := t[j] + m*q[j] + C
    MOVQ 8(R9), AX
    MULQ R14 // x[1] * y[0]
    MOVQ R11, BX
    ADDQ AX, BX
    ADCQ $0, DX
    MOVQ DX, R11
    
    MOVQ $0x170b5d4430000000, AX
    MULQ R12
    ADDQ  BX, R13
    ADCQ $0, DX
    ADDQ AX, R13
    ADCQ $0, DX
    
    MOVQ R13, CX
    MOVQ DX, R13
    MOVQ 16(R9), AX
    MULQ R14 // x[2] * y[0]
    MOVQ R11, BP
    ADDQ AX, BP
    ADCQ $0, DX
    MOVQ DX, R11
    
    MOVQ $0x1ef3622fba094800, AX
    MULQ R12
    ADDQ  BP, R13
    ADCQ $0, DX
    ADDQ AX, R13
    ADCQ $0, DX
    
    MOVQ R13, BX
    MOVQ DX, R13
    MOVQ 24(R9), AX
    MULQ R14 // x[3] * y[0]
    MOVQ R11, SI
    ADDQ AX, SI
    ADCQ $0, DX
    MOVQ DX, R11
    
    MOVQ $0x1a22d9f300f5138f, AX
    MULQ R12
    ADDQ  SI, R13
    ADCQ $0, DX
    ADDQ AX, R13
    ADCQ $0, DX
    
    MOVQ R13, BP
    MOVQ DX, R13
    MOVQ 32(R9), AX
    MULQ R14 // x[4] * y[0]
    MOVQ R11, DI
    ADDQ AX, DI
    ADCQ $0, DX
    MOVQ DX, R11
    
    MOVQ $0xc63b05c06ca1493b, AX
    MULQ R12
    ADDQ  DI, R13
    ADCQ $0, DX
    ADDQ AX, R13
    ADCQ $0, DX
    
    MOVQ R13, SI
    MOVQ DX, R13
    MOVQ 40(R9), AX
    MULQ R14 // x[5] * y[0]
    MOVQ R11, R8
    ADDQ AX, R8
    ADCQ $0, DX
    MOVQ DX, R11
    
    MOVQ $0x01ae3a4617c510ea, AX
    MULQ R12
    ADDQ  R8, R13
    ADCQ $0, DX
    ADDQ AX, R13
    ADCQ $0, DX
    
    MOVQ R13, DI
    MOVQ DX, R13
    
    ADDQ R13, R11
    MOVQ R11, R8
    
    // ---------------------------------------------------------------------------------------------
    // outter loop 1
    
    // (A,t[0]) := t[0] + x[0]*y[1]
    MOVQ (R9), AX // x[0]
    MOVQ 8(R10), R14
    MULQ R14 // x[0] * y[1]
    ADDQ AX, CX
    ADCQ $0, DX
    MOVQ DX, R11
    
    // m := t[0]*q'[0] mod W
    MOVQ $0x8508bfffffffffff, R12
    IMULQ CX , R12
    
    // C,_ := t[0] + m*q[0]
    MOVQ $0x8508c00000000001, AX
    MULQ R12
    ADDQ CX ,AX
    ADCQ $0, DX
    MOVQ  DX, R13
    
    // for j=1 to N-1
    //    (A,t[j])  := t[j] + x[j]*y[i] + A
    //    (C,t[j-1]) := t[j] + m*q[j] + C
    MOVQ 8(R9), AX
    MULQ R14 // x[1] * y[1]
    ADDQ R11, BX
    ADCQ $0, DX
    ADDQ AX, BX
    ADCQ $0, DX
    MOVQ DX, R11
    
    MOVQ $0x170b5d4430000000, AX
    MULQ R12
    ADDQ  BX, R13
    ADCQ $0, DX
    ADDQ AX, R13
    ADCQ $0, DX
    
    MOVQ R13, CX
    MOVQ DX, R13
    MOVQ 16(R9), AX
    MULQ R14 // x[2] * y[1]
    ADDQ R11, BP
    ADCQ $0, DX
    ADDQ AX, BP
    ADCQ $0, DX
    MOVQ DX, R11
    
    MOVQ $0x1ef3622fba094800, AX
    MULQ R12
    ADDQ  BP, R13
    ADCQ $0, DX
    ADDQ AX, R13
    ADCQ $0, DX
    
    MOVQ R13, BX
    MOVQ DX, R13
    MOVQ 24(R9), AX
    MULQ R14 // x[3] * y[1]
    ADDQ R11, SI
    ADCQ $0, DX
    ADDQ AX, SI
    ADCQ $0, DX
    MOVQ DX, R11
    
    MOVQ $0x1a22d9f300f5138f, AX
    MULQ R12
    ADDQ  SI, R13
    ADCQ $0, DX
    ADDQ AX, R13
    ADCQ $0, DX
    
    MOVQ R13, BP
    MOVQ DX, R13
    MOVQ 32(R9), AX
    MULQ R14 // x[4] * y[1]
    ADDQ R11, DI
    ADCQ $0, DX
    ADDQ AX, DI
    ADCQ $0, DX
    MOVQ DX, R11
    
    MOVQ $0xc63b05c06ca1493b, AX
    MULQ R12
    ADDQ  DI, R13
    ADCQ $0, DX
    ADDQ AX, R13
    ADCQ $0, DX
    
    MOVQ R13, SI
    MOVQ DX, R13
    MOVQ 40(R9), AX
    MULQ R14 // x[5] * y[1]
    ADDQ R11, R8
    ADCQ $0, DX
    ADDQ AX, R8
    ADCQ $0, DX
    MOVQ DX, R11
    
    MOVQ $0x01ae3a4617c510ea, AX
    MULQ R12
    ADDQ  R8, R13
    ADCQ $0, DX
    ADDQ AX, R13
    ADCQ $0, DX
    
    MOVQ R13, DI
    MOVQ DX, R13
    
    ADDQ R13, R11
    MOVQ R11, R8
    
    // ---------------------------------------------------------------------------------------------
    // outter loop 2
    
    // (A,t[0]) := t[0] + x[0]*y[2]
    MOVQ (R9), AX // x[0]
    MOVQ 16(R10), R14
    MULQ R14 // x[0] * y[2]
    ADDQ AX, CX
    ADCQ $0, DX
    MOVQ DX, R11
    
    // m := t[0]*q'[0] mod W
    MOVQ $0x8508bfffffffffff, R12
    IMULQ CX , R12
    
    // C,_ := t[0] + m*q[0]
    MOVQ $0x8508c00000000001, AX
    MULQ R12
    ADDQ CX ,AX
    ADCQ $0, DX
    MOVQ  DX, R13
    
    // for j=1 to N-1
    //    (A,t[j])  := t[j] + x[j]*y[i] + A
    //    (C,t[j-1]) := t[j] + m*q[j] + C
    MOVQ 8(R9), AX
    MULQ R14 // x[1] * y[2]
    ADDQ R11, BX
    ADCQ $0, DX
    ADDQ AX, BX
    ADCQ $0, DX
    MOVQ DX, R11
    
    MOVQ $0x170b5d4430000000, AX
    MULQ R12
    ADDQ  BX, R13
    ADCQ $0, DX
    ADDQ AX, R13
    ADCQ $0, DX
    
    MOVQ R13, CX
    MOVQ DX, R13
    MOVQ 16(R9), AX
    MULQ R14 // x[2] * y[2]
    ADDQ R11, BP
    ADCQ $0, DX
    ADDQ AX, BP
    ADCQ $0, DX
    MOVQ DX, R11
    
    MOVQ $0x1ef3622fba094800, AX
    MULQ R12
    ADDQ  BP, R13
    ADCQ $0, DX
    ADDQ AX, R13
    ADCQ $0, DX
    
    MOVQ R13, BX
    MOVQ DX, R13
    MOVQ 24(R9), AX
    MULQ R14 // x[3] * y[2]
    ADDQ R11, SI
    ADCQ $0, DX
    ADDQ AX, SI
    ADCQ $0, DX
    MOVQ DX, R11
    
    MOVQ $0x1a22d9f300f5138f, AX
    MULQ R12
    ADDQ  SI, R13
    ADCQ $0, DX
    ADDQ AX, R13
    ADCQ $0, DX
    
    MOVQ R13, BP
    MOVQ DX, R13
    MOVQ 32(R9), AX
    MULQ R14 // x[4] * y[2]
    ADDQ R11, DI
    ADCQ $0, DX
    ADDQ AX, DI
    ADCQ $0, DX
    MOVQ DX, R11
    
    MOVQ $0xc63b05c06ca1493b, AX
    MULQ R12
    ADDQ  DI, R13
    ADCQ $0, DX
    ADDQ AX, R13
    ADCQ $0, DX
    
    MOVQ R13, SI
    MOVQ DX, R13
    MOVQ 40(R9), AX
    MULQ R14 // x[5] * y[2]
    ADDQ R11, R8
    ADCQ $0, DX
    ADDQ AX, R8
    ADCQ $0, DX
    MOVQ DX, R11
    
    MOVQ $0x01ae3a4617c510ea, AX
    MULQ R12
    ADDQ  R8, R13
    ADCQ $0, DX
    ADDQ AX, R13
    ADCQ $0, DX
    
    MOVQ R13, DI
    MOVQ DX, R13
    
    ADDQ R13, R11
    MOVQ R11, R8
    
    // ---------------------------------------------------------------------------------------------
    // outter loop 3
    
    // (A,t[0]) := t[0] + x[0]*y[3]
    MOVQ (R9), AX // x[0]
    MOVQ 24(R10), R14
    MULQ R14 // x[0] * y[3]
    ADDQ AX, CX
    ADCQ $0, DX
    MOVQ DX, R11
    
    // m := t[0]*q'[0] mod W
    MOVQ $0x8508bfffffffffff, R12
    IMULQ CX , R12
    
    // C,_ := t[0] + m*q[0]
    MOVQ $0x8508c00000000001, AX
    MULQ R12
    ADDQ CX ,AX
    ADCQ $0, DX
    MOVQ  DX, R13
    
    // for j=1 to N-1
    //    (A,t[j])  := t[j] + x[j]*y[i] + A
    //    (C,t[j-1]) := t[j] + m*q[j] + C
    MOVQ 8(R9), AX
    MULQ R14 // x[1] * y[3]
    ADDQ R11, BX
    ADCQ $0, DX
    ADDQ AX, BX
    ADCQ $0, DX
    MOVQ DX, R11
    
    MOVQ $0x170b5d4430000000, AX
    MULQ R12
    ADDQ  BX, R13
    ADCQ $0, DX
    ADDQ AX, R13
    ADCQ $0, DX
    
    MOVQ R13, CX
    MOVQ DX, R13
    MOVQ 16(R9), AX
    MULQ R14 // x[2] * y[3]
    ADDQ R11, BP
    ADCQ $0, DX
    ADDQ AX, BP
    ADCQ $0, DX
    MOVQ DX, R11
    
    MOVQ $0x1ef3622fba094800, AX
    MULQ R12
    ADDQ  BP, R13
    ADCQ $0, DX
    ADDQ AX, R13
    ADCQ $0, DX
    
    MOVQ R13, BX
    MOVQ DX, R13
    MOVQ 24(R9), AX
    MULQ R14 // x[3] * y[3]
    ADDQ R11, SI
    ADCQ $0, DX
    ADDQ AX, SI
    ADCQ $0, DX
    MOVQ DX, R11
    
    MOVQ $0x1a22d9f300f5138f, AX
    MULQ R12
    ADDQ  SI, R13
    ADCQ $0, DX
    ADDQ AX, R13
    ADCQ $0, DX
    
    MOVQ R13, BP
    MOVQ DX, R13
    MOVQ 32(R9), AX
    MULQ R14 // x[4] * y[3]
    ADDQ R11, DI
    ADCQ $0, DX
    ADDQ AX, DI
    ADCQ $0, DX
    MOVQ DX, R11
    
    MOVQ $0xc63b05c06ca1493b, AX
    MULQ R12
    ADDQ  DI, R13
    ADCQ $0, DX
    ADDQ AX, R13
    ADCQ $0, DX
    
    MOVQ R13, SI
    MOVQ DX, R13
    MOVQ 40(R9), AX
    MULQ R14 // x[5] * y[3]
    ADDQ R11, R8
    ADCQ $0, DX
    ADDQ AX, R8
    ADCQ $0, DX
    MOVQ DX, R11
    
    MOVQ $0x01ae3a4617c510ea, AX
    MULQ R12
    ADDQ  R8, R13
    ADCQ $0, DX
    ADDQ AX, R13
    ADCQ $0, DX
    
    MOVQ R13, DI
    MOVQ DX, R13
    
    ADDQ R13, R11
    MOVQ R11, R8
    
    // ---------------------------------------------------------------------------------------------
    // outter loop 4
    
    // (A,t[0]) := t[0] + x[0]*y[4]
    MOVQ (R9), AX // x[0]
    MOVQ 32(R10), R14
    MULQ R14 // x[0] * y[4]
    ADDQ AX, CX
    ADCQ $0, DX
    MOVQ DX, R11
    
    // m := t[0]*q'[0] mod W
    MOVQ $0x8508bfffffffffff, R12
    IMULQ CX , R12
    
    // C,_ := t[0] + m*q[0]
    MOVQ $0x8508c00000000001, AX
    MULQ R12
    ADDQ CX ,AX
    ADCQ $0, DX
    MOVQ  DX, R13
    
    // for j=1 to N-1
    //    (A,t[j])  := t[j] + x[j]*y[i] + A
    //    (C,t[j-1]) := t[j] + m*q[j] + C
    MOVQ 8(R9), AX
    MULQ R14 // x[1] * y[4]
    ADDQ R11, BX
    ADCQ $0, DX
    ADDQ AX, BX
    ADCQ $0, DX
    MOVQ DX, R11
    
    MOVQ $0x170b5d4430000000, AX
    MULQ R12
    ADDQ  BX, R13
    ADCQ $0, DX
    ADDQ AX, R13
    ADCQ $0, DX
    
    MOVQ R13, CX
    MOVQ DX, R13
    MOVQ 16(R9), AX
    MULQ R14 // x[2] * y[4]
    ADDQ R11, BP
    ADCQ $0, DX
    ADDQ AX, BP
    ADCQ $0, DX
    MOVQ DX, R11
    
    MOVQ $0x1ef3622fba094800, AX
    MULQ R12
    ADDQ  BP, R13
    ADCQ $0, DX
    ADDQ AX, R13
    ADCQ $0, DX
    
    MOVQ R13, BX
    MOVQ DX, R13
    MOVQ 24(R9), AX
    MULQ R14 // x[3] * y[4]
    ADDQ R11, SI
    ADCQ $0, DX
    ADDQ AX, SI
    ADCQ $0, DX
    MOVQ DX, R11
    
    MOVQ $0x1a22d9f300f5138f, AX
    MULQ R12
    ADDQ  SI, R13
    ADCQ $0, DX
    ADDQ AX, R13
    ADCQ $0, DX
    
    MOVQ R13, BP
    MOVQ DX, R13
    MOVQ 32(R9), AX
    MULQ R14 // x[4] * y[4]
    ADDQ R11, DI
    ADCQ $0, DX
    ADDQ AX, DI
    ADCQ $0, DX
    MOVQ DX, R11
    
    MOVQ $0xc63b05c06ca1493b, AX
    MULQ R12
    ADDQ  DI, R13
    ADCQ $0, DX
    ADDQ AX, R13
    ADCQ $0, DX
    
    MOVQ R13, SI
    MOVQ DX, R13
    MOVQ 40(R9), AX
    MULQ R14 // x[5] * y[4]
    ADDQ R11, R8
    ADCQ $0, DX
    ADDQ AX, R8
    ADCQ $0, DX
    MOVQ DX, R11
    
    MOVQ $0x01ae3a4617c510ea, AX
    MULQ R12
    ADDQ  R8, R13
    ADCQ $0, DX
    ADDQ AX, R13
    ADCQ $0, DX
    
    MOVQ R13, DI
    MOVQ DX, R13
    
    ADDQ R13, R11
    MOVQ R11, R8
    
    // ---------------------------------------------------------------------------------------------
    // outter loop 5
    
    // (A,t[0]) := t[0] + x[0]*y[5]
    MOVQ (R9), AX // x[0]
    MOVQ 40(R10), R14
    MULQ R14 // x[0] * y[5]
    ADDQ AX, CX
    ADCQ $0, DX
    MOVQ DX, R11
    
    // m := t[0]*q'[0] mod W
    MOVQ $0x8508bfffffffffff, R12
    IMULQ CX , R12
    
    // C,_ := t[0] + m*q[0]
    MOVQ $0x8508c00000000001, AX
    MULQ R12
    ADDQ CX ,AX
    ADCQ $0, DX
    MOVQ  DX, R13
    
    // for j=1 to N-1
    //    (A,t[j])  := t[j] + x[j]*y[i] + A
    //    (C,t[j-1]) := t[j] + m*q[j] + C
    MOVQ 8(R9), AX
    MULQ R14 // x[1] * y[5]
    ADDQ R11, BX
    ADCQ $0, DX
    ADDQ AX, BX
    ADCQ $0, DX
    MOVQ DX, R11
    
    MOVQ $0x170b5d4430000000, AX
    MULQ R12
    ADDQ  BX, R13
    ADCQ $0, DX
    ADDQ AX, R13
    ADCQ $0, DX
    
    MOVQ R13, CX
    MOVQ DX, R13
    MOVQ 16(R9), AX
    MULQ R14 // x[2] * y[5]
    ADDQ R11, BP
    ADCQ $0, DX
    ADDQ AX, BP
    ADCQ $0, DX
    MOVQ DX, R11
    
    MOVQ $0x1ef3622fba094800, AX
    MULQ R12
    ADDQ  BP, R13
    ADCQ $0, DX
    ADDQ AX, R13
    ADCQ $0, DX
    
    MOVQ R13, BX
    MOVQ DX, R13
    MOVQ 24(R9), AX
    MULQ R14 // x[3] * y[5]
    ADDQ R11, SI
    ADCQ $0, DX
    ADDQ AX, SI
    ADCQ $0, DX
    MOVQ DX, R11
    
    MOVQ $0x1a22d9f300f5138f, AX
    MULQ R12
    ADDQ  SI, R13
    ADCQ $0, DX
    ADDQ AX, R13
    ADCQ $0, DX
    
    MOVQ R13, BP
    MOVQ DX, R13
    MOVQ 32(R9), AX
    MULQ R14 // x[4] * y[5]
    ADDQ R11, DI
    ADCQ $0, DX
    ADDQ AX, DI
    ADCQ $0, DX
    MOVQ DX, R11
    
    MOVQ $0xc63b05c06ca1493b, AX
    MULQ R12
    ADDQ  DI, R13
    ADCQ $0, DX
    ADDQ AX, R13
    ADCQ $0, DX
    
    MOVQ R13, SI
    MOVQ DX, R13
    MOVQ 40(R9), AX
    MULQ R14 // x[5] * y[5]
    ADDQ R11, R8
    ADCQ $0, DX
    ADDQ AX, R8
    ADCQ $0, DX
    MOVQ DX, R11
    
    MOVQ $0x01ae3a4617c510ea, AX
    MULQ R12
    ADDQ  R8, R13
    ADCQ $0, DX
    ADDQ AX, R13
    ADCQ $0, DX
    
    MOVQ R13, DI
    MOVQ DX, R13
    
    ADDQ R13, R11
    MOVQ R11, R8
    
    JMP reduce