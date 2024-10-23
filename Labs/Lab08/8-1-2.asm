// Variable assignment
mov r0, 15
mov r1, #remain
mov r2, #blank
mov r3, #askNumber

// Procedure
// Display totoal value
ldr r0, .InputNum
str r0, .WriteUnsignedNum
str r1, .WriteString
str r2, .WriteString

// Dispaly how many want to remove
str r3, .WriteString
ldr r4, .InputNum
str r4, .WriteUnsignedNum
str r1, .WriteString
str r2, .WriteString
str r3, .WriteString


halt

remain: .ASCIZ "remaining"
askNumber: .ASCIZ "How many do you want to remove (1-3)?"
blank: .ASCIZ "\n"