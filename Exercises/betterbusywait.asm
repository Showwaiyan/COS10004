mov r0, #.red
mov r1, #.white
mov r2, #1

flash:
    str r0, .Pixel367
    ldr r3, .Time 
timer1:
    ldr r4, .Time
    sub r5, r4, r3
    cmp r5, r2
    blt timer1
str r1, .Pixel367
ldr r3, .Time
timer2:
    ldr r4, .Time
    sub r5, r4, r3
    cmp r5, r2
    blt timer2

b flash
