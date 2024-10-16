.global _start

_start
    //Two's complement program
    mov r0, #6 //110
    mvn r1, r0 //001
    add r1, r1, #1//010
    halt