// Convention
// Variable Labes are in camelCase
// Function Labels are in snake_case and start with _
// Branch Labels are in snake_case and without start with _
// Functin arguments are passed in r0, r1, r2, r3
// Matchsticks are stored in r4

// Main Procedure
start:
    bl _initialize_game
    b game_start
game_end:
    mov r0, #gameOverMessage
    str r0, .WriteString
    halt


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
    sub r4, r4, r0
    ret

game_start:
    bl _print_remainding_matchsticks
    bl _ask_number_to_remove_matchsticks
    bl _check_matchsticks

_check_matchsticks:
    cmp r4, #0
    beq game_end
    b game_start

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

// label for erro message
invalidInputMessage: .asciz "\nInvalid input. Please enter a valid range number.\n"

// label for remaining matchsticks prompt
remainMatchSticksPrompt_1: .asciz "\nPlayer "
remainMatchSticksPrompt_2: .asciz ", there are "
remainMatchSticksPrompt_3: .asciz " matchsticks remaining.\n"
remainMatchSticksPrompt_4: .asciz ",how many do you want to remove (1-7)?\n"

// label for Game Over
gameOverMessage: .asciz "\nGame Over\n"
