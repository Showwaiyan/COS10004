flash_function: 
      mov r0, #.red 
      bl drawpixel 
      mov r0, #.yellow 
      bl drawpixel
      b flash_function 
      halt
drawpixel:
      push {lr,r1,r2}
      mov r1,r0
      str r1,.Pixel13
      str r1,.Pixel14
      str r1,.Pixel15
      str r1,.Pixel16
      str r1,.Pixel17
      str r1,.Pixel45
      str r1,.Pixel46
      str r1,.Pixel47
      str r1,.Pixel48
      str r1,.Pixel49
      mov r1,#1
      bl delay
      pop {lr,r1,r2}
delay:
      push {r3,r4,r5,r6,r7}
      mov r3,r2
      ldr r4, .Time
time:
      ldr r5, .Time
      sub r6,r5,r4
      cmp r6,r3
      blt time
      pop {r3,r4,r5,r6,r7}
      ret
