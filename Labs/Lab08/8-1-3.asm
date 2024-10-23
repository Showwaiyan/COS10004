// Variable assignment
mov r0, #15
mov r1, #remain
mov r2, #blank
mov r3, #ask_number

// Procedure
// Display totoal value
str r0, .WriteUnsignedNum
str r1, .WriteString
str r2, .WriteString

// Dispaly how many want to remove
str r3, .WriteString
str r2, .WriteString
ldr r4, .InputNum
str r4, .WriteUnsignedNum
str r2, .WriteString

// Substract total number from user input 
sub r0, r0, r4

str r0, .WriteUnsignedNum
str r1, .WriteString
str r2, .WriteString

halt

remain: .ASCIZ "remaining"
ask_number: .ASCIZ "How many do you want to remove (1-3)?"
blank: .ASCIZ "\n"