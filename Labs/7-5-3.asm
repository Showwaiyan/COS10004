.global _start

_start:
    //Storing number to register
    mov r1, #300
    mov r2, #21
    mov r3, #5
    mov r4, #64
    mov r5, #92
    mov r6, #18

    //Computing
    //By using equation of
    // (((((300-18)-64)+92)-21)+5)
    sub r7, r1, r6 //282
    sub r7, r7, r4 //218
    add r7, r7, r5 //310
    sub r7, r7, r2 //289
    add r7, r7, r3 //294

    // Stop the program
    halt
