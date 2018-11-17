.model small
.stack 100h
.data
  size1 db ?
  arr1 db 20 dup(0)
  newline db 10,13,'$'
  space db ' $'
  msg1 db 10,13,'Enter the size:-  $'
  msg2 db 10,13,'Please Enter the numbers:-  $'
  msg3 db 10,13,'Output After Every Step is:-$'
  small db 0
  index1 dw 0
.code
main proc
  mov ax,@data
  mov ds,ax
  lea dx,msg1
  mov ah,9
  int 21h
  call read
  mov size1,al
  mov cl,size1
  
  
  mov ch,00
  mov si,00
  lea dx,msg2
  mov ah,9
  int 21h
  
  
  
takein:
        lea dx,newline
        mov ah,9
        int 21h
        call read
        mov arr1[si],al
        inc si
        loop takein
        
        
        
  lea dx,msg3
  mov ah,9
  int 21h
  mov ch,size1
  dec ch
  mov si,00
  mov bx,si
loop1:
      mov si,bx
      mov cl,ch
      mov al,arr1[si]
      mov small,al
      mov index1,si
loop2:
      inc si
      cmp al,arr1[si]
      jb loop3
      mov al,arr1[si]
      mov small,al
      mov index1,si
loop3:
       dec cl
       jnz loop2
       mov si,bx
       mov al,arr1[si]
       mov si,index1
       xchg al,arr1[si]
       mov si,bx
       mov arr1[si],al
       inc bx
	call print
       dec ch
       jnz loop1

  mov ah,4ch
  int 21h

main endp

print proc near
  mov cl,size1
  mov si,00
loop4:
        mov ah,00
        mov al,arr1[si]
        call displ
        ;mov ah,00
        ;add ax,'0'
        ;mov dx,ax
        ;mov ah,2
        ;int 21h
        lea dx,space
        mov ah,9
        int 21h
        inc si
        dec cl
        jnz loop4
  lea dx,newline
  mov ah,9
  int 21h
  ret
print endp

read proc
  push bx
  push cx
  mov cx,10
  mov bx,0
readin:
        mov ah,1
        int 21h
        cmp al,'0'
        jb skip1
        cmp al,'9'
        ja skip1
        sub al,'0'
        push ax
        mov ax,bx
        mul cx
        mov bx,ax
        pop ax
        mov ah,00
        add bx,ax
        jmp readin
skip1:
        mov ax,bx
        pop cx
        pop bx
ret
read endp

displ proc
  push dx
  push cx
  push bx
  push ax
  mov cx,0
  mov bx,10
dis1:   mov dx,0
        div bx                       
        push dx
        inc cx                       
        cmp ax,0
        jne dis1
dis2:   pop dx
        add dl,30h
        mov ah,2
        int 21h
        loop dis2
  pop ax
  pop bx
  pop cx
  pop dx
  ret
displ endp

end main
