mov r0, #15
mov r1, #remain
mov r2, #blank
ldr r0, .InputNum
str r0, .WriteUnsignedNum
str r1, .WriteString
str r2, .WriteString

halt

remain: .ASCIZ "remaining"
blank: .ASCIZ "\n"