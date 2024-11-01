mov r0, #reversearray
mov r1, #arrayData
mov r2, #0 // array index
mov r3, #36 // reverse array index
mov r4, #0 // loop counter
ldr r9, arrayLength

reverse:
    ldr r5, [r1+r2]
    str r5, [r0+r3]
    add r2, r2, #4 // array index increasement
    sub r3, r3, #4 // reverse array index decreasement
    add r4, r4, #1 // loop counter increasement
    cmp r4, r9
    blt reverse

halt

.ALIGN 256 
arrayLength: 10
arrayData: 9 
 8
 7
 6
 5
 4
 3
 2
 1
 0
 
 .ALIGN 16
 reversearray: 0 // first intialize the reverse array