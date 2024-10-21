ldr r1, .InputNum
ldr r2, .InputNum
ldr r3, .InputNum
cmp r1, r2
bgt first_greater
str r2, max
cmp r2, r3
bgt second_greater
str r3, max
b stop
first_greater:
    str r1, max
second_greater:
    str r2, max
stop: halt
max: .word 0