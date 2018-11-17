.MODEL SMALL
.STACK 100H

.DATA
	PROMPT1 DB 'Enter first number : $'
	PROMPT2 DB 'Enter second number : $'
	PROMPTY DB 'Second is smaller$'
	PROMPTN DB 'Second is not smaller$'
	n_line DB 0DH,0AH,"$"

.CODE
	MAIN PROC
		MOV AX,@DATA
		MOV DS,AX

		LEA DX, PROMPT1
		MOV AH,9
		INT 21H

		XOR BX,BX
		MOV CL,4

		MOV AH,1
		INT 21H

		INPUT1:
			CMP AL,0DH
			JE LINE1

			CMP AL,39h
			JG LETTER1

			AND AL,0FH
			JMP SHIFT1

		LETTER1:
			SUB AL,37H

		SHIFT1:
			SHL BX,CL
			OR  BL,AL

			INT 21h
			JMP INPUT1
		LINE1:
			LEA DX, PROMPT2
			MOV AH,9
			INT 21H

			XOR DX,DX		

		MOV AH,1
		INT 21h

		INPUT2:
			CMP AL,0DH
			JE LINE2

			CMP AL,39h
			JG LETTER2

			AND AL,0FH
			JMP SHIFT2

		LETTER2:
			SUB AL,37H

		SHIFT2:
			SHL DX,CL
			OR  DL,AL

			INT 21h
			JMP INPUT2
		LINE2:
			MOV CX,DX
			MOV DH,16

		CMP CX,BX
		JL DISPY

		LEA DX,PROMPTN
		MOV AH,9
		INT 21h
		JMP QUIT

		DISPY:
			LEA DX,PROMPTY
			MOV AH,9
			INT 21h

		QUIT:
			MOV AH,4CH
			INT 21H
	MAIN ENDP
END MAIN