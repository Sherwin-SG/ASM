section .data
m1 db 'Enter a 2 digit number' , 0Ah
len1 equ $-m1
m2 db 'You have entered ', 0Ah
len2 equ $-m2

section .bss
buff resb 2

section .text
global _start

_start:
mov eax,04
mov ebx,01
mov ecx,m1
mov edx,len1
int 80h

mov eax,03
mov ebx,00
mov ecx,buff
mov edx,08
int 80h

mov eax,04
mov ebx,01
mov ecx,m2
mov edx,len2
int 80h

mov eax,04
mov ebx,01
mov ecx,buff
mov edx,8
int 80h

mov eax,01
mov ebx,00
int 80h
