section .data
name db "Hello World!!" ,15 ;Defines the variable name 
name_len equ $-name

section .bss


section .text
global _start

_start:
mov eax,04
mov ebx,01
mov ecx,name
mov edx,name_len
int 80h; Calls interrupt

mov eax,01
mov ebx,00
int 80h; Completes execution of the program
