// Convention
// Variable Labes are in camelCase
// Function Labels are in snake_case and start with _
// Branch Labels are in snake_case and without start with _
// Functin arguments are passed in r0, r1, r2, r3
// Matchsticks are stored in r4
// r5 will be used for to indicate the current player, 0 is plyaer and 1 is computer

// Fixed the issue of the game not ending becuase program cannot detect y or n in hex value

// Main Procedure
start:
    bl _initialize_game
    bl _game_start

game_result:
    pop {lr} // Due to it jump from _check_matchsticks, need to pop the lr to be out from _game_start
    cmp r5, #0
    beq player_win

    cmp r5, #1
    beq player_lose

    b game_finish

game_draw:
    mov r0, #draw
    str r0, .WriteString

    b game_finish

game_finish:
    mov r0, #gameResetPrompt
    str r0, .WriteString
    mov r0, #playerChoice
    str r0, .ReadString
    ldrb r0, [r0]
    cmp r0, #121 // y
    beq game_restart
    cmp r0, #89 // Y
    beq game_restart
    cmp r0, #110 // n
    beq game_end
    cmp r0, #78 // N
    beq game_end

game_end:
    halt

game_restart:
    ldr r4, matchsticks
    b _game_start

_initialize_game: // Initialize the game
    push {lr}
    bl _ask_player_name
    bl _ask_matchsticks_number

    // Print the player name
    bl _print_player_name 

    // Print the number of matchsticks
    bl _print_matchsticks_number

    pop {lr}
    ret

_ask_player_name: // Ask the player for their name
    // Print the prompt
    mov r0, #inputNamePrompt
    str r0, .WriteString

    // Get the player name
    mov r0, #playerName
    str r0, .ReadString
    str r0, .WriteString
    push {lr}
    bl _print_newline
    pop {lr}
    ret

_ask_matchsticks_number: // Ask the player for the number of matchsticks
    // Print the prompt
    mov r0, #inputMatchsticksPrompt
    str r0, .WriteString

    // Get the number of matchsticks
    ldr r0, .InputNum
    push {lr, r2, r3}
    mov r2, #10
    mov r3, #100
    bl _is_matchsticks_number_valid
    pop {lr, r2, r3}
    str r0, .WriteUnsignedNum
    str r0, matchsticks
    mov r4, r0
    push {lr}
    bl _print_newline
    pop {lr}
    ret

_print_player_name: // Print the player name
    mov r0, #outputNamePrompt
    str r0, .WriteString
    mov r1, #playerName
    str r1, .WriteString
    mov r0, #newline
    str r0, .WriteString
    ret

_print_matchsticks_number: // Print the number of matchsticks
    mov r0, #outputMatchsticksPrompt
    str r0, .WriteString
    mov r0, r4
    str r0, .WriteUnsignedNum
    push {lr}
    bl _print_newline
    pop {lr}
    ret

_is_matchsticks_number_valid: // Check if the number of matchsticks is valid
    // this will always use r2 and r3 as the range
    cmp r0, r2
    blt invalid_matchstick_input
    cmp r0, r3
    bgt invalid_matchstick_input
    ret

invalid_matchstick_input: // Print an error message for invalid matchsticks input
    mov r1, #invalidInputMessage
    str r1, .WriteString
    push {lr}
    bl _print_newline
    pop {lr}
    pop {lr, r2, r3}
    b _ask_matchsticks_number

_print_remainding_matchsticks: // Print the remaining matchsticks to player
    mov r0, #remainMatchSticksPrompt_1
    str r0, .WriteString
    mov r0, #playerName
    str r0, .WriteString
    mov r0, #remainMatchSticksPrompt_2
    str r0, .WriteString
    mov r0, r4
    str r0, .WriteUnsignedNum
    mov r0, #remainMatchSticksPrompt_3
    str r0, .WriteString
    ret

_ask_number_to_remove_matchsticks:
    // Print the prompt to enter the number of matchsticks to remove
    mov r0, #remainMatchSticksPrompt_1 
    str r0, .WriteString
    mov r0, #playerName
    str r0, .WriteString
    mov r0, #remainMatchSticksPrompt_4
    str r0, .WriteString

    // Get the number of matchsticks to remove
    ldr r0, .InputNum
    push {lr, r2, r3}
    mov r2, #1
    mov r3, #7
    bl _is_user_input_valid
    pop {lr, r2, r3}

    // Print the number of matchsticks removed
    mov r1, #remainMatchSticksPrompt_5
    str r1, .WriteString
    mov r1, r0
    str r1, .WriteUnsignedNum
    push {lr}
    bl _print_newline
    pop {lr}

    // If input is valid, then reduce matchsticks
    push {lr}
    bl _reduce_matchsticks
    pop {lr}
    ret

_is_user_input_valid: // Check if the number of matchsticks to remove is valid
    // this will always use r2 and r3 as the range
    cmp r0, r2
    blt invalid_uer_input
    cmp r0, r3
    bgt invalid_uer_input
    cmp r0, r4
    bgt invalid_uer_input
    ret

invalid_uer_input: // Print an error message for invalid user input
    mov r1, #invalidInputMessage
    str r1, .WriteString
    push {lr}
    bl _print_newline
    pop {lr}
    pop {lr, r2, r3}
    b _ask_number_to_remove_matchsticks

_reduce_matchsticks: // Reduce the number of matchsticks
    // this will always r0 as the current player input
    sub r4, r4, r0
    ret

_game_start:
    push {lr}
    bl _user_turn
    bl _check_matchsticks

    bl _computer_turn
    bl _check_matchsticks
    pop {lr}
    
    b _game_start

_user_turn:
    mov r5, #0 // indicate the current player is user
    push {lr}
    bl _print_remainding_matchsticks
    bl _ask_number_to_remove_matchsticks
    pop {lr}
    ret

_computer_turn:
    mov r5, #1 // indicate the current player is computer
    push {lr}
    bl _generate_random_number
    mov r1, #computerChoicePrompt
    str r1, .WriteString
    mov r1, r0
    str r1, .WriteUnsignedNum
    push {lr}
    bl _print_newline
    pop {lr}
    bl _reduce_matchsticks
    pop {lr}
    ret

_generate_random_number:
    // Random number will use r0
    ldr r0, .Random
    and r0, r0, #0x7 // mask the random number to 0-7
    b is_computer_input_valid
    ret

is_computer_input_valid:
    // this will always use r2 and r3 as the range
    mov r2, #1
    mov r3, #7

    cmp r0, r2
    blt _generate_random_number
    cmp r0, r3
    bgt _generate_random_number
    cmp r0, r4
    bgt _generate_random_number
    ret

_check_matchsticks:
    cmp r4, #1
    beq game_result
    cmp r4, #0
    beq game_result 
    ret

player_win:
    mov r0, #remainMatchSticksPrompt_1
    str r0, .WriteString
    mov r0, #playerName
    str r0, .WriteString
    mov r0, #playerWin
    str r0, .WriteString
    b game_finish

player_lose:
    mov r0, #remainMatchSticksPrompt_1
    str r0, .WriteString
    mov r0, #playerName
    str r0, .WriteString
    mov r0, #playerLose
    str r0, .WriteString
    b game_finish

_print_newline:
    push {r0}
    mov r0, #newline
    str r0, .WriteString
    pop {r0}
    ret

.align 256

newline: .asciz "\n"

// label for the name
inputNamePrompt: .asciz "Please enter your name: "
outputNamePrompt: .asciz "\nPlayer 1 is "
playerName: .block 128

// label for matchsticks
inputMatchsticksPrompt: .asciz "\nHow many matchsticks (10-100)?\n"
outputMatchsticksPrompt: .asciz "Matchsticks: "
matchsticks: .word 0

// label for erro message
invalidInputMessage: .asciz "\nInvalid input. Please enter a valid range number.\n"

// label for remaining matchsticks prompt
remainMatchSticksPrompt_1: .asciz "\nPlayer "
remainMatchSticksPrompt_2: .asciz ", there are "
remainMatchSticksPrompt_3: .asciz " matchsticks remaining.\n"
remainMatchSticksPrompt_4: .asciz ",how many do you want to remove (1-7)?\n"
remainMatchSticksPrompt_5: .asciz "Player has removed "

// label for computer random number
computerChoicePrompt: .asciz "\nComputer has removed "

// label for Game End
playerWin: .asciz " ,YOU WIN!\n"
playerLose: .asciz " ,YOU LOSE!\n"
draw: .asciz "It's a draw!\n"

// label for Game reset 
gameResetPrompt: .asciz "Play again (y/n)\n"
playerChoice: .block 1