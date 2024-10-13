.global _start

_start:
      mov r1, #6        //110
      and r2, r1, #4    //110 & 100 = 100
      orr r3, r2, #7    //100 | 111 = 111
      eor r4, r3, #2    //111 ^ 010 = 101
      lsl r5, r4, #2    //101 << 2 = 10100
      lsr r6, r5, #3    //10100 >> 3 = 10
      halt