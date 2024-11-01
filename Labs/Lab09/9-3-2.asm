mov r1, #arrayData
mov r2, #0 // array index
mov r0, #0 // sum up value
mov r4, #0 // array index counter

sum:
    ldr r3, [r1+r2]
    add r0, r0, r3
    add r2, r2, #4 // array index increasement
    add r4, r4, #1 // array index counter increasement
    cmp r4, #arrayLength
    bne sum

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