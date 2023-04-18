section .data
name db "Hello, This is my first program ",50 ;Defines the variable name 
name_len equ $-name

section .bss

section .text
global _start

_start:
mov rax,01
mov rdi,01
mov rsi,name
mov rdx,name_len
syscall; Calls interrupt

mov rax,60
mov rdi,00
syscall; Completes execution of the program
