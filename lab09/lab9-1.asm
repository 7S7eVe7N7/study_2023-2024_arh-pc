%include 'in_out.asm'
SECTION .data
msg: DB 'Введите x: ',0
result: DB '2(3x - 1) + 7=',0
SECTION .bss
x: RESB 80
res: RESB 80
SECTION .text
global _start
_start:
;------------------------------------------
; Основная программа
;------------------------------------------
mov eax, msg
call sprint

mov ecx, x
mov edx, 80
call sread

mov eax,x
call atoi

call _calcul ; Вызов подпрограммы _calcul

mov eax,result
call sprint
mov eax,[res]
call iprintLF

call quit
;------------------------------------------
; Подпрограмма вычисления
; выражения "2x+7"
;------------------------------------------
_calcul:
mov ebx,eax
call _subcalcul
mov ebx,2
mul ebx
add eax,7
mov [res],eax

ret

;------------------------------------------
; Подпрограмма вычисления
; выражения "3x-1"
;------------------------------------------
_subcalcul:
mov ebx,3
mul ebx ; EAX = EAX*EBX = 3*x
sub eax,1 ; EAX = EAX - 1 = 3*x - 1

ret ; выход из подпрограммы
