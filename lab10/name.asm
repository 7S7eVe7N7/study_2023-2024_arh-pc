%include 'in_out.asm'
SECTION .data
filename db 'name.txt', 0h ; Имя файла
msg db 'Как вас зовут?', 0h
msg1 db 'Меня зовут ', 0h
SECTION .bss
name resb 255 ; переменная для вводимой строки
SECTION .text
global _start
_start:

; --- Печать сообщения `msg`
mov eax,msg
call sprintLF

; ---- Запись введеной с клавиатуры строки в `name`
mov ecx, name
mov edx, 255
call sread

; --- Создание файла (`sys_creat`)
mov ecx, 0777o ; установка прав доступа
mov ebx, filename ; имя создаваемого файла
mov eax, 8 ; номер системного вызова `sys_creat`
int 80h ; вызов ядра

; --- Открытие существующего файла (`sys_open`)
mov ecx, 2 ; открываем для записи (2)
mov ebx, filename
mov eax, 5
int 80h

; --- Запись дескриптора файла в `esi`
mov esi, eax

; --- Расчет длины введенной строки
mov eax, msg1 ; в `eax` запишется количество
call slen         ; введенных байтов

; --- Записываем в файл `name` (`sys_write`)
mov edx, eax
mov ecx, msg1
mov ebx, esi
mov eax, 4
int 80h

; --- Расчет длины введенной строки
mov eax, name ; в `eax` запишется количество
call slen         ; введенных байтов

; --- Записываем в файл `name` (`sys_write`)
mov edx, eax
mov ecx, name
mov ebx, esi
mov eax, 4
int 80h

; --- Закрываем файл (`sys_close`)
mov ebx, esi
mov eax, 6
int 80h
call quit
