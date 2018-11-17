.model small
.stack 100h
.data
size1 db ?
ip db ?   
newline db 10,13,'$'
space db ' $'
arr1 db 20 dup(0)
msg1 db 10,13,'Enter the size : $'
msg2 db 10,13,'Enter array element: $'
msg3 db 10,13,'Enter searching element: $'
msg4 db 10,13,'index is:$'

.code
main proc
   mov ax,@data
   mov ds,ax
   
   
   lea dx,msg1
   mov ah,09
   int 21h            ;read size
   call read 
   mov size1,al
   
   lea dx,msg2
   mov ah,09
   int 21h
   mov si,00
   mov cl,size1
   mov ch,00 
   
   takein:
   call read
   mov arr1[si],al
   inc si 
   
    lea dx,newline  ;newline
   mov ah,09h
   int 21h
   
   loop takein
   
   
   lea dx,msg3
   mov ah,09h
   int 21h
   call read       ;read no to search
   mov ip,al
   
   mov si,00
   mov cl,size1
   mov ch,00
   
   lp:
   mov bl,ip
   cmp bl,arr1[si]
   jne l2 
   lea dx,msg4 
   mov ah,09
   int 21h
                         ;searching
   
   mov dx,si
   add dx,30h
   inc dx
   mov ah,2
   int 21h
   l2:
   
   inc si
   loop lp
   
   
   mov ah,4ch        
   int 21h
   main endp
   
   
   
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
end main
