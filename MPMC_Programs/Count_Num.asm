section .data
   	msg1 db 'Program to calculate total positive and negative numbers in an array',10
   	msg1len equ $-msg1
   	
   	msg2 db 'Count of positive numbers : '
   	msg2len equ $-msg2
   	
   	msg3 db 10,'Count of negative numbers : '
   	msg3len equ $-msg3
   	
   	array dw 10,14,-5,-55,23,-77,-7,44,10
   	arrcount equ 9
	
	nwline db 10
	
	pcount db 0
	ncount db 0
	
section .bss
	num resb 2
	
%macro print 2
	mov eax,4
	mov ebx,1
	mov ecx,%1
	mov edx,%2
	int 80h
%endmacro

section .text
	global _start

_start:
	print msg1,msg1len
	
	mov esi,array
	mov ecx,arrcount

up1:
	bt word[esi],15
	jnc pinc
	inc byte[ncount]
	jmp pskip
	
pinc : inc byte[pcount]

pskip: 
	inc esi
	inc esi
	loop up1
	
	print msg2,msg2len
	mov bl,[pcount]
	call disp8num
	
	print msg3,msg3len
	mov bl,[ncount]
	call disp8num
	
	print nwline,1
	
exit:
	mov eax,01
	mov ebx,0
	int 80h
	
disp8num:
	mov ecx,2
	mov edi,num
dup1:
	rol bl,4
	mov al,bl
	and al,0fh
	cmp al,09
	jbe dskip
	add al,07h
dskip:
	add al,30h
	mov [edi],al
	inc edi
	loop dup1
	
	print num,2
	ret
	
	
