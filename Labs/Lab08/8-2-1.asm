// Variable assignment
mov r0, #15
mov r1, #remain
mov r2, #ask_number
mov r3, #blank
mov r4, #0 // For User Input
mov r5, #invlid
mov r6, #finish

// Procedure
// Display totoal value
str r0, .WriteUnsignedNum
str r1, .WriteString
str r3, .WriteString

// Dispaly how many want to remove
remove:
    str r2, .WriteString
    str r3, .WriteString
    ldr r4, .InputNum // User Input

    cmp r4, #3
    bgt invlid_input
    cmp r4, #1
    blt invlid_input

    str r4, .WriteUnsignedNum
    str r3, .WriteString

// Substract total number from user input 
sub r0, r0, r4

cmp r0, #0
beq finish_state

str r0, .WriteUnsignedNum
str r1, .WriteString
str r3, .WriteString

cmp r0, #0
bne remove

invlid_input:
    str r5, .WriteString
    str r3, .WriteString
    b remove

// Optional State
finish_state:
    str r6, .WriteString

halt

remain: .ASCIZ "remaining"
ask_number: .ASCIZ "How many do you want to remove (1-3)?"
blank: .ASCIZ "\n"
invlid: .ASCIZ "Invalid Input"
finish: .ASCIZ "Game Finished"