.global _start

_start:
    //Store 12, 11, 7, 5, 3, 2 to registers
    mov r1, #12
    mov r2, #11
    mov r3, #7
    mov r4, #5
    mov r5, #3
    mov r6, #2

    // all the result store in r7
    // r6 << 5 
    // r7 | r2
    // r7 ^ r4
    // r7 ^ r5
    //r7 | r3
    //r7 | r1
    lsl r7, r6, #5
    orr r7, r7, r2
    eor r7, r7, r4
    eor r7, r7, r5
    orr r7, r7, r3
    orr r7, r7, r1

    // Stop the program
    halt
