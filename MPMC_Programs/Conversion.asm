section .data
men db 10,13,"------NUMBER CONVERSIONS--------"
db 10,13,"1.FOR HEXADECMAL TO BCD"
db 10,13,"2.BCD TO HEXADECIMAL"
db 10,13,"3.EXIT"
db 10,13,"ENTER YOUR CHOICE:"
men_len equ $-men
msg1 db "ENTER A HEX CHOICE:"
msg1_len equ $-msg1
msg2 db "THE EQUIVALENT BCD NUMBER IS:"
msg2_len equ $-msg2
msg3 db "ENTER A 5 DIGIT BCD NUMBER:"
msg3_len equ $-msg3
msg4 db "THE EQUIVALENT HEX NUMBER IS:"
msg4_len equ $-msg4
newline db 10,13,""
thank db 10,13,"THANKYOU!!"
thank_len equ $-thank
err db 10,13,"INVALID INPUT!!"
errlen equ $-err

section .bss
num resb 6
res resb 5
opt resb 2

%macro print 2
mov eax,4
mov ebx,1
mov ecx,%1
mov edx,%2
int 80h
%endmacro

%macro read 2
mov eax,3
mov ebx,0
mov ecx,%1
mov edx,%2
int 80h
%endmacro


section .text

global _start
_start:

	menu:print newline,1
	print men,men_len
	read opt,2
	cmp byte[opt],'1'
	je HTB
	cmp byte[opt],'2'
	je BTH
	cmp byte[opt],'3'
	je finish
	print err,errlen
	jmp men
	
	

HTB:
	print newline,1
	print msg1,msg1_len
	read num,5
	call convert
	mov ax,bx
	mov bx,10
	mov ecx,00
	
up1:
	mov edx,00
	div bx
	push edx
	inc ecx
	cmp ax,0
	jne up1
	mov edi,res
	
up2:
	pop edx
	add dl,30h
	mov [edi],dl
	inc edi
	loop up2
	print msg2,msg2_len
	print res,5
	jmp menu	
	
	
	BTH: 	
		print newline,1
		print msg3,msg3_len
		read num,6
		mov esi,num
		mov edi,0
		mov ecx,5
		xor eax,eax
		mov ebx,10
		
Y: 	xor edx,edx
	mul ebx
	mov dl,[esi]
	sub dl,30h
	add eax,edx
	inc esi
	dec ecx
	jnz Y
	push eax
	print msg4,msg4_len
	pop eax
	mov ebx,eax
	call display1
	jmp menu
	
	
	
	finish: print thank,thank_len
		print newline,1
		
		mov eax,1
		mov ebx,0
		int 80h
		
convert: mov bx,00
	mov esi,num
	mov ecx,4
	
back1: rol ebx,4
	mov al,[esi]
	cmp al,39h
	jbe X
	sub al,07h
	
X: sub al,30h
	add bl,al
	inc esi
	loop back1
	
ret

display1: mov ecx,8
	mov edi,res
	
back2: rol ebx,04
	mov al,bl
	and al,0fh
	cmp al,09h
	jbe x
	add al,07h
	x: add al,30h
	mov [edi],al
	inc edi
	loop back2
	print res+4,4
	ret
	
