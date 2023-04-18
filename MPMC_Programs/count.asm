%macro scall 4
        mov eax,%1
        mov ebx,%2 
        mov ecx,%3
        mov edx,%4
        int 80h
%endmacro
section .data
        arr dd -18888888h,18888888h,-22222222h,11111111h
        n equ 4
        pmsg db 10d,13d,"The Count of Positive No: ",10d,13d
        plen equ $-pmsg
        nmsg db 10d,13d,"The Count of Negative No: ",10d,13d
        nlen equ $-nmsg
        nwline db 10d,13d
section .bss
        pcnt resq 1
        ncnt resq 1
        char_answer resb 8
 
section .text
        global _start
        _start:
                mov esi,arr
                mov edi,n
                mov ebx,0
                mov ecx,0
 
        up:    
                mov eax,[esi]
                cmp eax,00000000h 	;Value of 1st element of the array is compared with a 0
                js negative		;If the sign of the number is negative, control is taken to label "negative"
 
        positive:       inc ebx		;Positive label increments the value of ebx
                           jmp next	;Unconditional jump to label next for instruction execution 
        negative:       inc ecx
 
        next:    add esi,4		;At every 4 bytes, the next value in the array is present
                  dec edi		;Value of the array count 
                  jnz up		;If value of edi is zero, control is taken to label up
                mov [pcnt],ebx		;Value of ebx is moved to the variable value at pcnt 
                mov [ncnt],ecx		;Value of ecx is moved to the variable value at ncnt
                scall 4,1,pmsg,plen
                mov eax,[pcnt]		;Value at pcnt is moved to register eax
                call display
                scall 4,1,nmsg,nlen
                mov eax,[ncnt]		;Value at ncnt is moved to register eax
                call display
                scall 4,1,nwline,1
                mov eax,1		;Exit code for the program
                mov ebx,0
                int 80h
 
 
;display procedure for 32bit        
display:
        mov esi,char_answer+7
        mov ecx,8
 
        cnt:    mov edx,0
                mov ebx,16h
                div ebx			;Divides the value in ebx 
                cmp dl,09h		;Compares the value of dl with 09h
                jbe add30		;Jumps to add30 label is value of dl is below or equal to 09h
                add dl,07h		;If not then we add 07h to dl
        add30:    add dl,30h		;Here value of 30h is added to dl		
                mov [esi],dl		;dl is moved to the value at esi register
                dec esi			;Esi is decremented
                dec ecx			;Ecx is decremented
                jnz cnt			;If count is not zero go back to cnt label 
        scall 4,1,char_answer,8
ret
