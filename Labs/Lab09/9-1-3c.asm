mov r1, #.PixelScreen
mov r2, #.red
mov r3, #128
loop:
    add r4, r1, r3
    str r2, [r4]
    add r3, r3, #256
    cmp r3, #3008
    bne loop

halt