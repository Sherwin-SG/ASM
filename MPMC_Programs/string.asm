section .data

msg0 db 10,"1.nonoverlap with string"
     db 10,"2.nonoverlap without string"
     db 10,"3.overlap with string"
     db 10,"4.overlap without string"
     db 10,"5.exit"
     db 10,"Enter your choice -> "
len0 equ $-msg0
msg1 db 10,"Source block contents are "
len1 equ $-msg1
msg2 db 10,"Destination block contents are "
len2 equ $-msg2
array db 01h,02h,03h,04h,05h,00h,00h,00h,00h,00h
array2 times 5 db 0
space db 20h
cnt equ 05

section .bss

         dispbuff  resb 4
         var resb 1

%macro display 2		;Macro definition to display
         mov eax,4
         mov ebx,1
         mov ecx,%1
         mov edx,%2
         int 80h

%endmacro

section .code
        global _start
_start:

        display msg0,len0
        mov eax,3		;Assembly definition to input value from keyboard
        mov ebx,0
        mov ecx,var     
        mov edx,2
        int 80h
        cmp byte [var],'5'	;byte of variable "var" is compared to value 5
        je exit			;Jumps to label "exit" is equal

        display msg1,len1
        mov ecx,cnt
        mov esi,array

bk:
        push ecx		;Loads value into ecx .
        mov bl,[esi]		;Moves the value at esi to the lower half of the ebx register
        call display1_proc
        display space,1
        inc esi			;Increments the value of the stack index
        pop ecx			;Places the value at ecx in the register ecx
        loop bk			;bk label is looped upto the end of the array

        display msg2,len2

        cmp byte [var],'1'
        je case1
        cmp byte [var],'2'
        je case2
        cmp byte [var],'3'
        je case3
        cmp byte [var],'4'
        je case4

case1:  

        mov esi,array
        mov edi,array2
        mov ecx,cnt
        cld			;Clear the direction flag if present
        rep movsb		;Repeat while equal and moves the data as bytes
        mov esi,array2
        mov ecx,5
        jmp end			;Unconditional jump to label end 

case2:

        mov esi,array
        mov edi,array2
        mov ecx,cnt

nover:

        mov bl,[esi]			;Value at esi is moved to the lower half of ebx
        mov [edi],bl			;The bl register is placed in the value of edi
        inc esi				;Increment value of esi
        inc edi				;Increment value of edi
        loop nover			;Loop label nover
        mov esi,array2
        mov ecx,5
        jmp end				;jump at the label end

case3:

        mov esi,array+5			;
        mov edi,array+7			;
        mov ecx,cnt
        inc ecx 			;
        std				;
        rep movsb			;Repeat while equal and moves the data as bytes
        mov esi,array			;Moves the array to the register esi
        mov ecx,7
        jmp end 

case4:

        mov esi,array+5
        mov edi,array+7
        mov ecx,cnt
        inc ecx 

overl:

        mov bl,[esi]			;
        mov [edi],bl			;
        dec esi
        dec edi
        loop overl  			;
        mov esi,array
        mov ecx,7
        jmp end

end:

x1:
        push ecx
        mov bl,[esi]			;
        call display1_proc      
        display space,1
        inc esi
        pop ecx				;
        loop x1
        jmp _start			;

exit:

        mov eax,01
        mov ebx,00
        int 80h

display1_proc:

        mov ecx,4
        mov edi,dispbuff        
d1:
        rol bx,4			;
        mov al,bl			;
        and al,07h			;
        cmp al,09
        jbe dskip			;
        add al,07h			;

dskip:

        add al,30h			;
        mov [edi],al
        inc edi
        loop d1				;
        display dispbuff,4
        ret
