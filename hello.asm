; Hello World CPC Machine Code Example
; (c) Dave Moore 2023

; Compile with ../rasm_linux64 -eo ./hello.asm

print_char equ #BB5A 		; Firmware Call to Print a Character

org #8000					; Destination

begin_code					; **********************************

ld hl, message				; Address of string to print
call print_string 			; Print to screen
call print_new_line			; Add CR/LF
ret							; Quit

message: db 'Hello World!', #ff

; Print a string terminated by #ff
print_string:
	ld a, (hl)				
	cp #ff
	ret z
	inc hl
	call print_char
	jr print_string

; PRint CR/LF
print_new_line:
	ld a, #0d				; Carriage return
	call print_char
	ld a, #0a				; Line Feed
	call print_char
	ret

end_code					; **********************************

; RASM directive to save this as "hello.bin" in a dsk file
SAVE 'hello.bin', begin_code, end_code - begin_code, DSK, 'hello.dsk'