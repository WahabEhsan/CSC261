; Array Demo Program
; Create a 15 integer array using user input
; Allow user to enter a value and count number of 
; Print the array
; sort the array
; attempt on print even
; Author:  Spring 2018 CSC 261 Class

INCLUDE io.h            ; header file for input/output

.586
.MODEL FLAT

.STACK 4096

.DATA
prompt			BYTE		"Enter number",0
string			BYTE		40 DUP (?)
array			DWORD		20 DUP (?)
errlbl			BYTE		"Error", 0
errMsg			BYTE		"Invalid Number", 0
shownum1		BYTE		"The numbers entered are", 0 
shownum2		BYTE		"The even numbers are", 0

numbers			BYTE		15 DUP(11 DUP (?), 10), 0 
numbers2		BYTE		15 DUP(11 DUP (?), 10), 0 


searchPrompt	BYTE		"Enter number to search", 0
occlbl			BYTE		"The number of occurrences is", 0
occ				BYTE		11 DUP (?), 0

.CODE
_MainProc PROC

			mov		ecx, 15						; Set the counter to loop 15 times
			lea		esi, array					; Load the address at the beginning of the array

			jmp		getNum						; Jumps error message for first run
reprompt:	output	errlbl, errMsg				; Error Message
getNum:		input	prompt, string, 40			; Ask for the number
			atod	string						; Convert to DWORD
			cmp		eax, 10						; Checks if greater then 10
			jg		reprompt					; If greater then reprompts
			cmp		eax, -10					; Checks if less then -10
			jl		reprompt					; If lesser then reprompts
			mov		[esi], eax					; Put DWORD into the array
			add		esi, 4						; Position array pointer to next integer location
			loop	getNum						; Start the loop

			; Prints array
			mov		ecx, 15						; makes loop go 15 times
			lea		esi, array					; Load the address at the beginning of the array
			lea		edi, numbers				; Load the address at the beginning of the numbers
printl:		dtoa	[edi], [esi]				; converts numbers to ascii and loads in to different register
			add		esi, 4						; increments by 4 to get next value
			add		edi, 12						; incremants by 11 plus 1 for the formatting
			loop	printl						; loops around		
			output	shownum1, numbers			; prints array

			; Attempt on Bubble sort
			mov		ebx, 0
outerlp:	mov		ecx, 14						; runs 15-1 becasue of last element
			lea		esi, array					; loads address to the begining
sortl:		mov		eax, [esi]					; moves current value to a register
			mov		edx, [esi+4]				; moves the value next the current index into a register 
			cmp		eax, edx					; compares the two values	
			jg		greater						; if greater then it goes to label greater
			xchg	eax, edx					; Swap values
			mov		[esi], eax					; moves value back into array
			mov		[esi+4], edx				; moves value back into array
greater:	add		esi, 4						; contunies to go around next index
			loop	sortl						; loops around
			inc		ebx							; increments ebx for outer loop
			cmp		ebx, 15						; checks if counter 15
			jne		outerlp						; if not 15 then goes back to outerloop

			; Printing after sorting
			mov		ecx, 15						; Runs 15 times
			mov		numbers, 0					; erases all from numbers	
			lea		esi, array					; goes tot the begining of array
			lea		edi, numbers				; goes to begining of string
printl2:	dtoa	[edi], [esi]				; converts double to ascii into string
			add		esi, 4						; goes to next value
			add		edi, 12						; goes to next avilible spot for next integer
			loop	printl2						; loops around
			output	shownum1, numbers			; prints the numbers
			
			; Sepreating even numbers
			mov		ecx, 15						; runs 15 times
			lea		esi, array					; goes to begining of array
			lea		edi, numbers2				; goes to beginng og string
			mov		ebx, 2						; moves 2 in ebx
evennum:	mov		eax, [esi]					; moves the values to the acumalator 
			cdq									; Preparing for sign division
			idiv	ebx							; divides by 2 to check even
			cmp		edx, 0						; checks if remainder is zero	
			jne		notEven						; if not zero then goes to notEven
			dtoa	[edi], [esi]				; else inserts esi to edi as ascii
			add		edi, 12						; goes to next index
notEven:	add		esi, 4						; moves to next avialabe location
			loop	evennum						; loops around
			output	shownum2, numbers2			; prints the even numbers

			mov     eax, 0						; exit with return code 0
			ret
_MainProc ENDP
END												; end of source code

