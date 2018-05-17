;This program allows the user to enter one non-negative integers.
;Then a procedure is called recursively to calculate recursive(n)=5*recursive(n-1)+9
; Wahab Ehsan

INCLUDE io.h								;header file for input/output
.586										;pentium architecture
.MODEL FLAT									;using the flat memory model
.STACK 4096									;establishing 4096 bytes of stack space

.DATA
errlbl			BYTE "ERROR!!", 0					;error label string
errprompt		BYTE "Invalid Number! ", 0			;error message string

prompt			BYTE "Enter non-negative value", 0	;integer prompt
string			BYTE 40 DUP (?)						;string to hold the users input

number1			DWORD ?								;memory location to store the first integer

resultlbl		BYTE "The sum is", 0				;sum label string
result			BYTE 11 DUP (?), 0					;sum message string

.CODE
_MainProc PROC

;prompt the user for the first integer, guarding against negative values
retry1:			input	 prompt, string, 40
				atod	 string
				mov		 number1, eax
				cmp		 number1, 0
				jge		 retry2
				output	 errLbl, errprompt
				jmp		 retry1
retry2:

;place the integer onto the stack and call the procedure
noErr:	
				push	number1
				call	summing
				add		esp, 4
		
;display the results
				dtoa	result, eax
				output	resultlbl, result

;end the program
				mov eax, 0
				ret
			
_MainProc ENDP

;This procedure will accept two integers, and will calculate the sum of
;all integers between the two inclusively
summing PROC
				push ebp				;preserve the old base pointer value
				mov ebp, esp			;establish the new base pointer
				push ebx				;will be using ebx, so preserve its old value
				push ecx

				mov ebx, [ebp+8]		;get the first argument
		



				mov		eax, 0				;start the accumulator at zero
				mov		ecx, 5				;moves 5 into the register for multipication as the formula says
				cmp		ebx, 0				;compares to 0 
				jz		Zero				;if zero then jump to Zero
				sub		ebx, 1				;substract one for recursion
				push	ebx					;pushes ebx into procedure
				call	summing				;calls the method recursive
				add		esp, 4				;moves the pointer for next parameter 
				mul		ecx					;multiplies 5 
				add		eax, 9				;adds 9 at the end as formula says
				jmp		finished			;skips next line becasue for only if value 0
Zero:			mov		eax, 3				;turns output to 3 becasue of formula



finished:
				pop ecx					;restore ecx's old value
				pop ebx					;restore ebx's old value
				pop ebp					;restore ebp's old value

				ret						;return control back to the main procedure
summing ENDP

END										; end of source code