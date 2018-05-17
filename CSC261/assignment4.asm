; Example assembly language program -- adds and subtracts 3 numbers
; Author:  Wahab Ehsan
; Date:    2/11/18

INCLUDE io.h            ; header file for input/output

.586
.MODEL FLAT

.STACK 4096

.DATA
number1		DWORD	?
number2		DWORD   ?
number3		DWORD	?
number4		DWORD	?
number5		DWORD	?
number6		DWORD	?
number7		DWORD	?
number8		DWORD	?
number9		DWORD	?
prompt1		BYTE    "Enter Long jump first attempt", 0
prompt2		BYTE    "Enter Long jump second attempt", 0
prompt3		BYTE	"Enter Long jump third attempt",0
prompt4		BYTE    "Enter High jump first attempt", 0
prompt5		BYTE    "Enter High jump second attempt", 0
prompt6		BYTE	"Enter High jump third attempt",0
prompt7		BYTE    "Enter Shot-put first attempt", 0
prompt8		BYTE    "Enter Shot-put second attempt", 0
prompt9		BYTE	"Enter Shot-put third attempt",0
string		BYTE    40 DUP (?)
resultLbl	BYTE	"The weighted result", 0
resultHj	BYTE	"High jump: "
resulthjs	BYTE	11 DUP (?)
resultLJ	BYTE	13, 10, "Long jump: "
resultljs	BYTE	11 DUP (?)
resultSp	BYTE	13, 10, "Short-put: "
resultsps	BYTE	11 DUP (?)
resultt		BYTE	13, 10, "Total"
sum			DWORD   11 DUP (?), 0

.CODE
_MainProc PROC
        input	prompt1, string, 40		; read ASCII characters
        atod    string					; convert to integer
        mov     number1, eax			; store in memory

        input   prompt2, string, 40     ; repeat for second number
        atod    string
        mov     number2, eax

		input	prompt3, string, 40
		atod	string
		mov		number3, eax

		input	prompt4, string, 40		; read ASCII characters
        atod    string					; convert to integer
        mov     number4, eax			; store in memory

		input	prompt5, string, 40		; read ASCII characters
        atod    string					; convert to integer
        mov     number5, eax			; store in memory

		input	prompt6, string, 40		; read ASCII characters
        atod    string					; convert to integer
        mov     number6, eax			; store in memory

		input	prompt7, string, 40		; read ASCII characters
        atod    string					; convert to integer
        mov     number7, eax			; store in memory

		input	prompt8, string, 40		; read ASCII characters
        atod    string					; convert to integer
        mov     number8, eax			; store in memory

		input	prompt9, string, 40		; read ASCII characters
        atod    string					; convert to integer
        mov     number9, eax			; store in memory
        
		mov		ebx, 3					; for division

        mov     eax, number1			; first number to EAX
        add     eax, number2			; add second number
		add		eax, number3			; add third number to sum
		mov		edx, 0					; for division to work
		div		ebx						; divide by 3 for average
		mov		ecx, 7					; put 7 in memory to ne multiplied
		mul		ecx
		mov		number1, eax			; save the calulation to number1

		mov     eax, number4			; first number to EAX
        add     eax, number5			; add second number
		add		eax, number6			; add third number to sum
		mov		edx, 0					; for division to work
		div		ebx						; divide by 3 for average
		mov		ecx, 4					; puts 4 in register to be multiplied
		mul		ecx
		mov		number4, eax			; save the calulation to number4

		mov     eax, number7			; first number to EAX
        add     eax, number8			; add second number
		add		eax, number9			; add third number to sum
		mov		edx, 0					; for division to work
		div		ebx						; divide by 3 for average
		mov		ecx, 5					; puts 5 in register to be multiplied
		mul		ecx
		mov		number7, eax			; save the calulation to number7


		mov		eax, number1			; save the calculation on number1
		add		eax, number4			; adds num4 to num1 for sum
		add		eax, number7			; adds num7 to num1 for sum
		mov		sum, eax				; save sum to memory

        dtoa	resulthjs, number1			; convert to ASCII characters
		dtoa	resultljs, number4			; convert to ASCII characters
		dtoa	resultsps, number7			; convert to ASCII characters
		dtoa    sum, eax				; convert to ASCII characters
        output  resultLbl, resultHj     ; output label and sum

        mov     eax, 0					; exit with return code 0
        ret
_MainProc ENDP
END										; end of source code

