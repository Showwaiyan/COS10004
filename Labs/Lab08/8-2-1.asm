// Variable assignment
mov r0, #15
mov r1, #remain
mov r2, #ask_number
mov r3, #blank
mov r4, #0 // For User Input

// Procedure
// Display totoal value
remove:
    str r0, .WriteUnsignedNum
    str r1, .WriteString
    str r3, .WriteString

// Dispaly how many want to remove

    str r2, .WriteString
    str r3, .WriteString
    ldr r4, .InputNum // User Input

// Substract total number from user input 
sub r0, r0, r4
cmp r0, #0
bne remove

halt

remain: .ASCIZ "remaining"
ask_number: .ASCIZ "How many do you want to remove (1-3)?"
blank: .ASCIZ "\n"