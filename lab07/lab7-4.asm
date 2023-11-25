%include 'in_out.asm'
SECTION .data
msg1 DB 'Введите x: ', 0h
msg2 DB 'Введите a: ', 0h
msg3 DB 'Результат: ', 0h

SECTION .bss
x resb 11
a resb 11
res resb 12

SECTION .text
global _start
_start:
; ---------- Вывод сообщения 'Введите x: ' и ввод 'x' с клавиатуры
mov eax, msg1
call sprint
mov ecx, x
mov edx, 10
call sread

; ---------- Вывод сообщения 'Введите а: ' и ввод 'а' с клавиатуры
mov eax, msg2
call sprint
mov ecx, a
mov edx, 10
call sread

mov eax, x
call atoi ; Вызов подпрограммы перевода символа в число
mov [x], eax ; запись преобразованного числа в 'x'
mov eax, a
call atoi ; Вызов подпрограммы перевода символа в число
mov [a], eax ; запись преобразованного числа в 'a'

; ---------- Сравниваем 'x' и 'a' (как числа)
mov eax, [x]
mov ecx, [a]
cmp eax, ecx ; Сравниваем 'a' и 'x'
jg _label1 ; если 'a>x', то переход на метку '_label1'
mov ebx, 15
mov eax, ebx ; иначе 'eax = 15'
mov [res], eax ; 'res = 15'
jmp _end

; ---------- Вычисление выражения '2*(x - a)'
_label1:
mov ebx, 2
sub eax, ecx ; 'eax = eax + ecx = x - a' 
mul ebx ; 'eax = ebx*eax = 2*(x-a)'
mov [res], eax ; 'res = 2*(x-a)'
jmp _end

; ---------- Вывод результата
_end:
mov eax, msg3
call sprint ; Вывод сообщения 'Результат: '
mov eax, [res]
call iprintLF ; Вывод
call quit ; Вызов подпрограммы завершения
