section .data
m1 db ' Hello I am Samuel ',0xa
len1 equ $-m1
m2 db ' This is my first macro function in assembly ' , 0xa
len2 equ $-m2

%macro write_value 2
mov eax,04
mov ebx,01
mov ecx,%1
mov edx,%2
int 80h
%endmacro

section .data
global _start

_start:
write_value m1,len1
write_value m2,len2

mov eax,01
mov ebx,00
int 80h

