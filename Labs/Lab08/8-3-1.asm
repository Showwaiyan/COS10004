mov r2, #0 // initialize r2 to
mov r0, #show_input
mov r1, #blank
mov r3, #invlid

select:
    ldr r2, .Random // generate Random Number
    and r2, r2, #0x3 // mask the random number to 0-3
    cmp r2, #3
    bgt invalid_number
    cmp r2, #1
    blt invalid_number
    str r0, .WriteString
    str r2, .WriteUnsignedNum
    str r1, .WriteString
    b finsh

invalid_number:
    str r3, .WriteString
    str r2, .WriteUnsignedNum
    str r1, .WriteString
    b select

finsh: halt

show_input: .ASCIZ "Random Number: "
blank: .ASCIZ "\n"
invlid: .ASCIZ "Invalid Number"