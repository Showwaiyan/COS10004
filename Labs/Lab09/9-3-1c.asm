mov r2, #arrayData
mov r0, #16 // based on 0 index to 5th = 4*4 bytes = 16
ldr r1, [r1+r2]

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