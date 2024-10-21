mov r2, #0
repeat: 
    b user_input
user_input: 
    ldr r1, .InputNum
    b end_state
addition:
    add r2, r2, r1
    b repeat
end_state:
    cmp r1, #0
    beq stop
    b addition
stop: 
    str r2, sum
    halt
sum: .word 0