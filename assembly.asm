.MODEL SMALL
.STACK 100h
.DATA
targetChar DB ? 
userGuess DB ?

inputMsg DB 'Guess Capital letter: $'

successMsg DB 10,'Correct Answer You Win', 13, 10,'$'
prevHintMsg DB 10,'Target char is previous', 13, 10,'$'
afterHintMsg DB 10,'Target char is after this letter', 13, 10,'$'
OutOfGuessesMsg DB 10,'Out of guesses! The letter was: ', 13, 10, '$'

.CODE
MAIN PROC
    .startup

    MOV AH, 2Ch

generateChar:
    INT 21H  
    ADD DL, 65 
    CMP DL, 'Z' + 1
    JB storeChar  
    SUB DL, 26      
    JMP generateChar 

storeChar:
    MOV targetChar, DL 
    MOV CX, 03H 

inputLoop:
    LEA DX, inputMsg
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H
    MOV [userGuess], AL

    MOV AL, [userGuess]
    CMP AL, targetChar
    JE success
   
    CMP AL, targetChar
    JB afterHint
    
    LEA DX, prevHintMsg
    JMP displayHint
    
success:
    LEA DX, successMsg
    MOV AH, 09H
    INT 21H
    JMP endProgram 

afterHint:
    LEA DX, afterHintMsg

displayHint:
    MOV AH, 09H
    INT 21H

    LOOP inputLoop
   
    LEA DX, OutOfGuessesMsg
    MOV AH, 09H
    INT 21H
    MOV DL, targetChar 
    MOV AH, 02H
    INT 21H

    JMP endProgram 



endProgram:

    .exit
MAIN ENDP
END MAIN