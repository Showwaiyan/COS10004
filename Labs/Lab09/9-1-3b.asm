mov r1, #.PixelScreen
mov r2, #.red
mov r3, #256

loop:
    add r4, r1, r3
    str r2, [r4]
    add r3, r3, #4
    cmp r3, #512   
    blt loop

halt