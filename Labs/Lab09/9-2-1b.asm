mov r1, #.PixelScreen
mov r2, #.red
mov r3, #128
loop:
    str r2, [r1+r3]
    add r3, r3, #256
    cmp r3, #3008
    bne loop

halt