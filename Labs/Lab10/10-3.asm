flash_function:
      mov r5, #0
      bl flash_pattern
      cmp r5, r3
      blt rapid_flash
      beq continue
continue:
      mov r7, r4
      bl delay
      halt
drawpixel:
      push {lr,r1,r2}
      mov r1, r0
      str r1, .Pixel13
      str r1, .Pixel14
      str r1, .Pixel15
      str r1, .Pixel16
      str r1, .Pixel17
      str r1, .Pixel45
      str r1, .Pixel46
      str r1, .Pixel47
      str r1, .Pixel48
      str r1, .Pixel49
      mov r2, #1
      bl delay
      pop {lr,r1,r2}
      ret
delay:
      push {r1,r4,r5,r6}
      mov r1, r2
      ldr r4, .Time
time:
      ldr r5, .Time
      sub r6, r5, r4
      cmp r6, r1
      blt time
      pop {r1,r4,r5,r6}
      ret
flash_pattern:
      push {r1,r2}
      mov r1, #message1
      str r1, .WriteString
      ldr r1, .InputNum
      str r1, .WriteUnsignedNum
      mov r2, #message2
      str r2, .WriteString
      ldr r2, .InputNum
      str r2, .WriteUnsignedNum
      mov r3, r1
      mov r4, r2
      pop {r1,r2}
      ret
rapid_flash:
      push {lr, r0}
      mov r0, #.red
      bl drawpixel
      mov r0, #.yellow
      bl drawpixel
      add r5, r5, #1
      pop {lr, r0}
      ret
message1: .asciz "How many flashes do you want: "
message2: .asciz "\n How many delays do you want: "
