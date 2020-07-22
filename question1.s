		AREA Pointers, CODE, READONLY
		ENTRY
	
		ADR	r1, UPC				;	Register R1 points to beginning of UPC string
		MOV r0, #2				;	Initializing R0 to 2 (invalid by default) 
		
loop1	LDRB r2, [r1], #1		;	Load odd byte of UPC in R2
		SUB	r2, r2, #0x30		;	Find the real number in R2
		LDRB r3, [r1], #1		;	Load even byte of UPC in R3
		SUB r3, r3, #0x30		;	Find the real number in R3
		ADD r4, r4, r2			;	Add R2 to R4 (Adding odd digits)
		ADD r5, r5, r3			;	Add R3 to R5 (Adding even digits)
		ADD r6, #1				;	Increment loop counter R6 by 1
		CMP r6, #6				;	Check loop counter (loop until 6)
		BNE loop1
		
		ADD r7, r4, r4, LSL #1	; 	Multiplying odd sum by 3 in R7
		ADD r8, r5, r7			;	Combining odd and even sums in R8 (total sum)
		
loop2	SUBS r8, r8, #10		; 	Subtracting 10 from total sum
		CMP r8, #10				;	Check if number r8 is 10
		BEQ valid				;	If total sum is multiple of 10
		BLT loop1				;	If r8 is Less Than 10 (not multiple) end program
		BGT loop2				;	Loop if r8 is still above 10
		
valid	MOV r0, #1				;	Store 1 in r0 when valid

UPC		DCB "013800150738"		;	UPC string	
		
		END