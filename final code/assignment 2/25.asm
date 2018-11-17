.model small
.stack 100h
.data
m1 db 'Binary$ '
m2 db 'Hexa number$ '
m3 db 'invalid$'

.code
main proc

	mov ax, @data
	mov ds,ax

	clear:
	mov ah,2
	mov dl,0dh
	int 21h
	mov dl,0ah
	int 21h


	mov ah,9
	lea dx,m1
	int 21h

	xor bh,bh
	
	input:
	mov ah,1
	int 21h

	mov ch,al
	
	cmp ch,0dh
	je print

	cmp ch,'0'
	jl exit

	cmp ch,'1'
	jg exit

	and ch,15
	shl bh,1
	or bh,ch

	jmp input
	
	print:
	mov ah,2
	mov dl,0dh
	int 21h
	mov dl,0ah
	int 21h

	mov ah,9
	lea dx,m2
	int 21h

	mov ah,2
	cmp bh,9
	jle number
	
	cmp bh,15
	jle character

	number:
	add bh,48
	mov ah,2
	mov dl,bh
	int 21h
	jmp clear

	character:
	add bh,55
	mov ah,2
	mov dl,bh
	int 21h
	jmp clear

	exit:
	mov ah,2
	mov dl,0dh
	int 21h
	mov dl,0ah
	int 21h

	mov ah,9
	lea dx,m3
	int 21h

	mov ah,4ch
	int 21h
	main endp
end main
