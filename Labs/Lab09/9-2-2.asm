mov r1, #.PixelScreen
mov r2, #.red
mov r3, #0
mov r4, #0 // row counter
mov r5, #80 // pixel counter

loop:
    b row
update: // row update
    add r4, r4, #1
    cmp r4, #10
    beq finish

    add r3, r3, #176
    mov r5, r3
    add r5, r5, #80
    b loop

row:
    str r2, [r1+r3]
    add r3, r3, #4
    cmp r3, r5
    blt row
    b update



finish:
    halt