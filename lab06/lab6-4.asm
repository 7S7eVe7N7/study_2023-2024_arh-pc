%include 'in_out.asm' ; подключение внешнего файла
SECTION .data
msg: DB 'Введите значение x: ', 0
rem: DB 'Результат: ',0
SECTION .bss
x: RESB 80 ; Переменная, значение которой запрашивается у пользователя
SECTION .text
GLOBAL _start
_start:

; ---- Вычисление выражения (9x - 8)/8
mov eax,msg ;
call sprint ;
mov ecx, x ;
mov edx, 80 ;
call sread ;
mov eax,x  ; вызов подпрограммы преобразования
call atoi ;
mov ebx,9 ; EBX=9
mul ebx ; EAX=EAX*EBX
sub eax,8 ; EAX=EAX-8
xor edx,edx ; 
mov ebx,8 ; EBX=8
div ebx ; EAX=EAX/8
mov edi,eax ; запись результата вычисления в 'edi'

; ---- Вывод результата на экран

mov eax,rem   ; вызов подпрограммы печати
call sprint   ; сообщения 'Результат: '
mov eax,edi   ; вызов подпрограммы печати значения
call iprintLF   ; из 'edi' в виде символов
call quit     ; вызов подпрограммы завершения
