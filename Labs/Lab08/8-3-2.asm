mov r0, #15 // Variable assignment
mov r2, #0 // initialize r2 to
mov r1, #computer_select
mov r3, #blank
mov r4, #invlid
mov r5, #remain

select:
    ldr r2, .Random // generate Random Number
    and r2, r2, #0x3 // mask the random number to 0-3

    cmp r2, #3
    bgt invalid_number

    cmp r2, #1
    blt invalid_number

    cmp r0, r2
    blt invalid_number
    sub r0, r0, r2

    str r1, .WriteString
    str r2, .WriteUnsignedNum
    str r3, .WriteString

    str r5, .WriteString
    str r0, .WriteUnsignedNum
    str r3, .WriteString

    cmp r0, #0
    bne select

    b finsh

invalid_number:
    str r4, .WriteString
    str r2, .WriteUnsignedNum
    str r3, .WriteString
    b select

finsh: halt

blank: .ASCIZ "\n"
invlid: .ASCIZ "Invalid Number"
computer_select: .ASCIZ "Computer Select between 1-3: "
remain: .ASCIZ "remaining"