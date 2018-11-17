.MODEL SMALL
.STACK 100H
.DATA 
  PROMPT1 DB 'Enter first number : $'
  PROMPT2 DB 'Enter second number : $'
  PROMPTS DB 'Sum = $'
  n_line DB 0DH,0AH,"$"

.CODE
   MAIN PROC
      MOV AX,@DATA
      MOV DS,AX
      
      XOR BX,BX
      MOV CL,4      
      
      LEA DX, PROMPT1
      MOV AH,9
      INT 21H
      
      MOV AH,1
      INT 21h
      
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
              
          LEA DX,PROMPTS
          MOV AH,9
          INT 21h
          
          MOV DH,16
      
      SUM:
          ADD BX,CX
          JC PC1
          MOV CL,4
      
      OUTPUT:
            MOV CH,BH
            SHR CH,CL
            AND CH,0FH 
            CMP CH,10
            ADD CH,'0'
            CMP CH,':'
            JL P1
            ADD CH,7
      P1:
        MOV DL,CH
        MOV AH,2
        INT 21H

        MOV CH,BH
        AND CH,0FH
        CMP CH,10
        ADD CH,'0'
        CMP CH,':'
        JL P2
        ADD CH,7
      P2:
        MOV DL,CH
        MOV AH,2
        INT 21H

        MOV CH,BL
        SHR CH,CL
        AND CH,0FH
        CMP CH,10
        ADD CH,'0'
        CMP CH,':'
        JL P3
        ADD CH,7
      P3:
        MOV DL,CH
        MOV AH,2
        INT 21H

        MOV CH,BL
        AND CH,0FH
        CMP CH,10
        ADD CH,'0'
        CMP CH,':'
        JL P4
        ADD CH,7
      P4:
        MOV DL,CH
        MOV AH,2
        INT 21H

        JMP QUIT
      PC1:
        MOV DL,'1'
        MOV AH,2
        INT 21h
        JMP OUTPUT
        
      QUIT:
        MOV AH,4CH
        INT 21H
        
  MAIN ENDP
END MAIN