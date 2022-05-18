//TEMPJCL   JOB (TSO),
//             'COMPILE CODE',
//             CLASS=A,
//             MSGCLASS=A,
//             MSGLEVEL=(2,1),
//             REGION=0K,
//             USER=IBMUSER,
//             PASSWORD=SYS1
//ASMLKD1 EXEC ASMFCL,
//             PARM.ASM='OBJECT,NODECK,TERM,XREF(SHORT)',
//             PARM.LKED='LET,MAP,XREF,LIST,TEST'
//ASM.SYSLIB  DD   DSN=SYS1.MACLIB,DISP=SHR
//            DD   DSN=SYS1.AMODGEN,DISP=SHR
//            DD   DSN=SYS1.AMACLIB,DISP=SHR
//ASM.SYSTERM DD SYSOUT=*
//ASM.SYSTERM DD SYSOUT=*
//ASM.SYSIN   DD *,DLM=@@
TEMPASM  CSECT
*
* PREFIX TO SIMULATE R15 BRANCH
*
         LR    R15,R15
         LA    R15,16(R15)
         BC    15,0(,R15)
         NOPR  0
EYE4     DC    XL4'CAFEBABE'
         USING *,R12
***********************************************************************
*    INITIALIZATION
***********************************************************************
COPY     LR    R12,R15
         STM   R14,R12,SAVE
***********************************************************************
*    MAINSTREAM OF PROGRAM                                            *
*    YOUR CODE GOES HERE                                              *
***********************************************************************
         WTO   'TEMP'
***********************************************************************
*    END OF PROGRAM
***********************************************************************
ENDPROG  LM    R14,R12,SAVE
         XR    R15,R15
         BR    R14
***********************************************************************
*    DATA
***********************************************************************
SAVE     DS    18F
***********************************************************************
*    DATASETS
***********************************************************************
***********************************************************************
*    MACROS
***********************************************************************
EYE1     DC    XL4'CAFEBABE'
R0       EQU   0
R1       EQU   1
R2       EQU   2
R3       EQU   3
R4       EQU   4
R5       EQU   5
R6       EQU   6
R7       EQU   7
R8       EQU   8
R9       EQU   9
R10      EQU   10
R11      EQU   11
R12      EQU   12
R13      EQU   13
R14      EQU   14
R15      EQU   15
         END   TEMPASM CSECT
@@
//LKED.SYSLMOD  DD DSN=SYS2.LINKLIB(TEMPASM),DISP=SHR
//LKED.SYSPRINT DD   SYSOUT=A
//TEMPASM  EXEC PGM=TEMPASM
//SYSPRINT DD   SYSOUT=A
//STEPLIB  DD   DISP=SHR,DSN=SYS2.LINKLIB
//SYSUDUMP DD   SYSOUT=A

