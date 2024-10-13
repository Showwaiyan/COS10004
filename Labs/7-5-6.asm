.global _start

_start
    //store 99, 77, 33, 31, 14, 12 to registers
    mov r1, #99
    mov r2, #77
    mov r3, #33
    mov r4, #31
    mov r5, #14
    mov r6, #12

    // all the result store in r7
    // r5 & r6
    // r7 & r1
    // r7 & r2
    // r7 | r4
    // r7 << 1
    // r7 & r3
    and r7, r5, r6
    and r7, r7, r1
    and r7, r7, r2
    orr r7, r7, r4
    lsl r7, r7, #1
    and r7, r7, r3

    // Stop the program
    halt
