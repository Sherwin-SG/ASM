section .data
msg db "The sum of the 2 numbers is ", 0xA,0xD
len equ $-msg

section .bss
sum resb 2

section .text

global _start

_start:
mov eax,'3'
sub eax,'0'

mov ebx,'4'
sub ebx,'0'
add eax,ebx
add eax,'0'

mov [sum],eax
mov ecx,msg
mov edx,len
mov eax,4
mov ebx,1
int 80h

mov eax,4
mov ebx,1
mov ecx,sum
mov edx,1
int 80h

mov eax,1
mov ebx,0
int 80h

