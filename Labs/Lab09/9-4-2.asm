mov r0, #arrayData
mov r1, #0 // array index
mov r2, #0 // for array last index (currently 0)
ldr r9, arrayLength

mov r8 ,#0 // last index loop counter
last_index:
    add r2, r2, #4
    add r8, r8, #1
    cmp r8, r9
    bne last_index

    sub r2, r2, #4 // last index = arrayLength - 1

reverse:
    cmp r1, r2
    bgt finish

    // r3 and r4 are temporary registers for swapping value
    ldr r3, [r0+r1] // r3 = arrayData[i]
    ldr r4, [r0+r2] // r4 = arrayData[arrayLength - 1 - i]

    // swap the value
    str r4, [r0+r1]
    str r3, [r0+r2]

    add r1, r1, #4 // array index increasement
    sub r2, r2, #4 // array index decreasement
    b reverse

finish:
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