;Write and test a program to Convert a Binary digit to Decimal and vice versa
include mtab.asm

.model small
.stack 100h

.data
	iprompt1 db "Enter binary number: $"
	iprompt2 db "Enter hexadecimal number: $"

	oprompt1 db "Equivalent hexadecimal number: $"
	oprompt2 db "Equivalent binary number: $"

.code

    printm macro mess
	    lea dx,mess
	    mov ah,09h
	    int 21h
    endm

    new_line macro
	    mov ah,02h
	    mov dl,0dh
	    int 21h
	    mov dl,0ah
	    int 21h
    endm

    bin_input macro
		local skip,input
		; output: bx
		

		xor bx,bx

		mov ah,01h
		int 21h

		cmp al,0dh
		je skip

		input:
			xor ah,ah
			sub ax,'0'
			shl bx,1
			or bx,ax

			; take input
			mov ah,01h
			int 21h

			cmp al,0dh
			jne input

		skip:

	endm

	; macro to take binary output
	bin_output macro
		local output,display_loop
		; input: bx
		
		mov ah,02h
		mov cx,0

		output:
			mov dx,bx
			and dx,01h
			add dx,'0'
			push dx
			inc cx
			shr bx,1

		jnz output

		mov cx,cx
		display_loop:
			pop dx
			int 21h
		loop display_loop

	endm

	;macro for hex input
	hex_input macro
		local skip,input,letter,shift
		; output: bx
		

		xor bx,bx

		mov ah,01h
		int 21h

		cmp al,0dh
		je skip

		input:
			xor ah,ah
			cmp ax,'A'
			jge letter
			sub ax,'0'
			jmp shift
			letter:
				sub ax,55
			shift:	
				shl bx,1
				shl bx,1
				shl bx,1
				shl bx,1

			or bx,ax

			; take input
			mov ah,01h
			int 21h

			cmp al,0dh
			jne input

		skip:


	endm

	;macro for hex_output
	hex_output macro
		local output,display_loop,letter,line
		; input: bx
		
		mov ah,02h
		mov cx,0

		output:
			mov dx,bx
			and dx,0fh
			cmp dx,10
			jge letter
			add dx,'0'
			jmp line
		letter:
				add dx,55
		line:
			push dx
			inc cx

			shr bx,1
			shr bx,1
			shr bx,1
			shr bx,1

		jnz output

		mov cx,cx
		display_loop:
			pop dx
			int 21h
		loop display_loop
	endm

	main proc
		mov ax,@data
		mov ds,ax

		;******************** BINARY TO HEXADECIMAL *******************
		;input
		printm iprompt1

		bin_input	; binary number in bx
		
		;output
		new_line
		printm oprompt1
 		hex_output
 		;***********************************************************

 		;******************** HEXADECIMAL TO BINARY *******************
		;input
		new_line
		printm iprompt2

		hex_input	; binary number in bx
		
		;output
		new_line
		printm oprompt2
 		bin_output
 		;***********************************************************

		exitp

	main endp
end main