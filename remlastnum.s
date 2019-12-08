    section .text
    global remlastnum

remlastnum:
    push rbp
    mov rbp, rsp

    ;check if first character is '\0'
    mov dl, [rdi]
    cmp dl, 0
    jz end

    
    xor bx, bx  ;clear bx register, will bw used as number found flag
    xor r8, r8  ;clear r8
    xor r9, r9  ;cleaar r9
    mov rsi ,rdi    ;copy of string.begin()
    mov r8b, 1      ;cmov 1
    mov r9b, 0      ;cmov 0

    ;set pointer to last element of string
loop_last:
    inc rdi
    mov dl, [rdi]
    cmp dl, 0
    jnz loop_last

    mov rcx, rdi ;copy of string.end()

    ;set pointers to before first digit of last number (rdi) and first letter of last word (rcx)
loop_1:
    dec rdi
    cmp rdi, rsi
    jl end

    mov dl, [rdi]
    cmp dl, '9'
    jg not_digit
    cmp dl, '0'
    cmovge bx, r8w
    jge loop_1
    
not_digit:
    dec rcx
    cmp bl, 1
    jne loop_1 

    ;copy charcaters
loop_2:
    inc rcx
    inc rdi
loop_2_end:
    mov dl, [rcx]
    mov [rdi], dl
    cmp dl, 0
    jnz loop_2

    mov byte [rdi], 0   ;end string after all characters have been copied
end:
    inc rdi         ;move rdi to first digit     
    cmp bl, 1       ;check if number found  has ended before string begining
    cmove bx, r9w   ;if no end number
    je loop_2_end   ;and copy characters
    
    mov rsp, rbp
    pop rbp
    ret