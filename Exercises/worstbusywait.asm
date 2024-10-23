mov r0, #.red
mov r1, #.white
mov r2, #5000000
flash: 
    mov r3, r2
    str r0, .Pixel367
timer1:
    sub r3, r3, #1
    cmp r3, #0
    bne timer1
    mov r3, r2
    str r1, .Pixel367
timer2:
    sub r3, r3, #1
    cmp r3, #0
    bne timer2
    b flash