;===================================================================================================================================================
; Text Labels
easytext_d:	db 'EASY', 0				
easytextlength_d:	dw 4
mediumtext_d:	db 'MEDIUM', 0	
mediumtextlength_d: dw 6
hardtext_d:	db 'HARD', 0
hardtextlength_d:	dw 4
;===================================================================================================================================================
; Print Difficulty Heading Subroutine
printDiff:	push bp
			mov bp, sp
			push es
			push di
			push si
			push ax
			push bx
			push cx
			
			mov ax, 0xb800
			mov es, ax
			
			mov ax, [bp + 4]		; ROW			
			mov bx, 80
			mul bx
			add ax, [bp + 6]		; COLUMN	
			shl ax, 1
			mov di, ax
			push di
			mov ax, 0x3EDB
			
			; Draw D
			cld
			stosw
			add di, 158
			stosw
			add di, 158
			stosw
			add di, 158
			stosw
			add di, 158
			stosw
			stosw
			stosw
			sub di, 160
			stosw
			sub di, 162
			stosw
			sub di, 162
			stosw
			sub di, 164
			stosw
			sub di, 4
			stosw
			
			; Draw I
			pop di
			add di, 12
			push di
			stosw
			add di, 158
			stosw
			add di, 158
			stosw
			add di, 158
			stosw
			add di, 158
			stosw
			
			; Draw F
			pop di
			add di, 6
			push di
			stosw
			stosw
			stosw
			stosw
			add di, 152
			stosw
			add di, 158
			stosw
			stosw
			stosw
			add di, 154
			stosw
			add di, 158
			stosw
			
			; Draw F
			pop di
			add di, 12
			push di
			stosw
			stosw
			stosw
			stosw
			add di, 152
			stosw
			add di, 158
			stosw
			stosw
			stosw
			add di, 154
			stosw
			add di, 158
			stosw
			
			; Draw I
			pop di
			add di, 12
			push di
			stosw
			add di, 158
			stosw
			add di, 158
			stosw
			add di, 158
			stosw
			add di, 158
			stosw
			
			; Draw C
			pop di
			add di, 6
			push di
			stosw
			stosw
			stosw
			stosw
			add di, 152
			stosw
			add di, 158
			stosw
			add di, 158
			stosw
			add di, 158
			stosw
			stosw
			stosw
			stosw
			
			; Draw U
			pop di
			add di, 12
			push di
			stosw
			add di, 158
			stosw
			add di, 158
			stosw
			add di, 158
			stosw
			add di, 158
			stosw
			stosw
			stosw
			stosw
			sub di, 162
			stosw
			sub di, 162
			stosw
			sub di, 162
			stosw
			sub di, 162
			stosw
			
			; Draw L
			pop di
			add di, 12 
			push di
			stosw
			add di, 158
			stosw
			add di, 158
			stosw
			add di, 158
			stosw
			add di, 158
			stosw
			stosw
			stosw
			stosw
			
			; Draw T
			pop di
			add di, 10
			push di
			stosw
			stosw
			stosw
			stosw
			stosw
			add di, 154
			stosw
			add di, 158
			stosw
			add di, 158
			stosw
			add di, 158
			stosw
			
			; Draw Y
			pop di
			add di, 14
			stosw
			add di, 6
			stosw
			add di, 152
			stosw
			add di, 2
			stosw
			add di, 156
			stosw
			add di, 158
			stosw
			add di, 158
			stosw
			
			pop cx
			pop bx
			pop ax
			pop si
			pop di
			pop es
			pop bp
			ret 4
;===================================================================================================================================================
; Draw Semi Sun Subroutine
drawSemiSun: 	push bp
				mov bp, sp
				push es
				push di
				push si
				push ax
				push bx
				push cx
				
				mov ax, 0xb800
				mov es, ax
				
				mov ax, [bp + 4]		; ROW			
				mov bx, 80
				mul bx
				add ax, [bp + 6]		; COLUMN	
				shl ax, 1
				mov di, ax
				push di
				mov ax, 0x6620
				
				cld
				stosw
				stosw
				stosw
				stosw
				stosw
				stosw
				stosw
				stosw
				
				add di, 158
				stosw
				add di, 158
				stosw
				add di, 158
				stosw
				add di, 158
				stosw
				add di, 158
				stosw
				
				pop di
				add di, 162
				push di
				stosw
				stosw
				stosw
				stosw
				stosw
				stosw
				add di, 158
				stosw
				add di, 158
				stosw
				add di, 158
				stosw

				pop di
				add di, 162
				stosw
				stosw
				stosw
				stosw
				add di, 156
				stosw
				stosw
				
				pop cx
				pop bx
				pop ax
				pop si
				pop di
				pop es
				pop bp
				ret 4
;===================================================================================================================================================
; Draw Difficulty Screen Subroutine
difficulty_screen:	call clrscr2	
		
		; Draw Clouds
		mov ax, 4		; column
		push ax
		mov ax, 8
		push ax
		mov ax, 13
		push ax
		call cloud
		
		mov ax, 60		; column
		push ax
		mov ax, 8
		push ax
		mov ax, 13
		push ax
		call cloud
		
		; Draw Difficulty Heading
		mov ax, 13
		push ax
		mov ax, 1
		push ax
		call printDiff
		
		; Draw Easy Text
		mov ax, 0x003F			; bp + 12 (Colour)
		push ax
		mov ax, 36				; bp + 10 (Column)
		push ax
		mov ax, 9				; bp + 8 (Row)
		push ax
		mov ax, easytext_d			; bp + 6 (String)
		push ax
		mov ax, [easytextlength_d]	; bp + 4 (String Length)
		push ax
		call drawText			; Draw Option 1 Text
		
		; Draw Easy Border
		mov ax, 29					; bp + 8 (Column)
		push ax
		mov ax, 8					; bp + 6 (Row)
		push ax
		mov ax, 3					; bp + 4 (Length)
		push ax
		call WhiteVerticalLine		; Draw Right Option 1 Border Line
		
		mov ax, 29				; bp + 8 (Column)
		push ax
		mov ax, 7				; bp + 6 (Row)		
		push ax
		mov ax, 17				; bp + 4 (Length)
		push ax
		call WhiteHorizontalLine	; Draw Top Option 2 Line
		
		mov ax, 46					; bp + 8 (Column)
		push ax
		mov ax, 7					; bp + 6 (Row)
		push ax
		mov ax, 4					; bp + 4 (Length)
		push ax
		call WhiteVerticalLine		; Draw Right Option 1 Border Line
		
		mov ax, 29				; bp + 8 (Column)
		push ax
		mov ax, 11				; bp + 6 (Row)		
		push ax
		mov ax, 18				; bp + 4 (Length)
		push ax
		call WhiteHorizontalLine	; Draw Top Option 2 Line
		
		; Draw Medium Text
		mov ax, 0x003F				; bp + 12 (Colour)
		push ax
		mov ax, 35					; bp + 10 (Column)
		push ax
		mov ax, 15					; bp + 8 (Row)
		push ax
		mov ax, mediumtext_d			; bp + 6 (String)
		push ax
		mov ax, [mediumtextlength_d]	; bp + 4 (String Length)
		push ax
		call drawText				; Draw Option 2 Text
		
		; Draw Medium Box
		mov ax, 29					; bp + 8 (Column)
		push ax
		mov ax, 14					; bp + 6 (Row)
		push ax
		mov ax, 3					; bp + 4 (Length)
		push ax
		call WhiteVerticalLine		; Draw Right Option 1 Border Line
		
		mov ax, 29				; bp + 8 (Column)
		push ax
		mov ax, 13				; bp + 6 (Row)		
		push ax
		mov ax, 17				; bp + 4 (Length)
		push ax
		call WhiteHorizontalLine	; Draw Top Option 2 Line
		
		mov ax, 46					; bp + 8 (Column)
		push ax
		mov ax, 13					; bp + 6 (Row)
		push ax
		mov ax, 4					; bp + 4 (Length)
		push ax
		call WhiteVerticalLine		; Draw Right Option 1 Border Line
		
		mov ax, 29				; bp + 8 (Column)
		push ax
		mov ax, 17				; bp + 6 (Row)		
		push ax
		mov ax, 18				; bp + 4 (Length)
		push ax
		call WhiteHorizontalLine	; Draw Top Option 2 Line	
		
		; Draw Hard Text
		mov ax, 0x003F				; bp + 12 (Colour)
		push ax
		mov ax, 36					; bp + 10 (Column)
		push ax
		mov ax, 21					; bp + 8 (Row)
		push ax
		mov ax, hardtext_d			; bp + 6 (String)
		push ax
		mov ax, [hardtextlength_d]	; bp + 4 (String Length)
		push ax
		call drawText				; Draw Option 3 Text
		
		; Draw Hard Box
		mov ax, 29					; bp + 8 (Column)
		push ax
		mov ax, 20					; bp + 6 (Row)
		push ax
		mov ax, 3					; bp + 4 (Length)
		push ax
		call WhiteVerticalLine		; Draw Right Option 1 Border Line
		
		mov ax, 29				; bp + 8 (Column)
		push ax
		mov ax, 19				; bp + 6 (Row)		
		push ax
		mov ax, 17				; bp + 4 (Length)
		push ax
		call WhiteHorizontalLine	; Draw Top Option 2 Line
		
		mov ax, 46					; bp + 8 (Column)
		push ax
		mov ax, 19					; bp + 6 (Row)
		push ax
		mov ax, 4					; bp + 4 (Length)
		push ax
		call WhiteVerticalLine		; Draw Right Option 1 Border Line
		
		mov ax, 29				; bp + 8 (Column)
		push ax
		mov ax, 23				; bp + 6 (Row)		
		push ax
		mov ax, 18				; bp + 4 (Length)
		push ax
		call WhiteHorizontalLine	; Draw Top Option 2 Line
		
		; Draw Balloons
		mov ax, 14 					; bp + 10 (Row)
		push ax
		mov ax, 3					; bp + 8 (Column)
		push ax
		mov ax, 0x6020				; bp + 6 (Colour)
		push ax
	    mov ax,0x6752				; bp + 4 (Letter with Attribute)
		push ax
		call Balloon				; Draw Balloon
		mov bx,5
		
		mov ax, 20 					; bp + 10 (Row)
		push ax
		mov ax, 12 					; bp + 8 (Column)
		push ax
		mov ax,0x4020				; bp + 6 (Colour)
		push ax
		mov ax,0x4741				; bp + 4 (Letter with Attribute)
		push ax
		call Balloon				; Draw Balloon
		
		mov ax, 15					; bp + 10 (Row)
		push ax
		mov ax, 21					; bp + 8 (Column)
		push ax
		mov ax, 0x2020				; bp + 6 (Colour)
		push ax
	    mov ax,0x2749				; bp + 4 (Letter with Attribute)
		push ax
		call Balloon				; Draw Balloon
			
		mov ax, 20					; bp + 10 (Row)
		push ax
		mov ax, 74					; bp + 8 (Column)
		push ax
		mov ax, 0x1020				; bp + 6 (Colour)
		push ax
	    mov ax,0x1746				; bp + 4 (Letter with Attribute)
		push ax
		call Balloon				; Draw Balloon
		
		mov ax, 18					; bp + 10 (Row)
		push ax
		mov ax, 50					; bp + 8 (Column)
		push ax
		mov ax, 0x6020				; bp + 6 (Colour)
		push ax
	    mov ax,0x6743				; bp + 4 (Letter with Attribute)
		push ax
		call Balloon				; Draw Balloon	
		
		mov ax, 14					; bp + 10 (Row)
		push ax
		mov ax, 62					; bp + 8 (Column)
		push ax
		mov ax, 0x5020				; bp + 6 (Colour)
		push ax
	    mov ax,0x5759				; bp + 4 (Letter with Attribute)
		push ax
		call Balloon				; Draw Balloon
		
		; Draw Semi Sun
		mov ax, 72					; bp + 10 (Column)
		push ax
		mov ax, 0					; bp + 8 (Row)
		push ax
		call drawSemiSun
		
		; Draw Sun Horizontal Ray
		mov ax, 67
		push ax
		mov ax, 0
		push ax
		mov ax, 2
		push ax
		call SunHorizontal
		
		; Draw Sun Vertical Ray
		mov ax, 79
		push ax
		mov ax, 7
		push ax
		mov ax, 2
		push ax
		call SunVertical
		
		; Draw Sun Right Left Slant Ray
		mov ax, 72
		push ax
		mov ax, 4
		push ax
		mov ax, 2
		push ax
		call RLSunSlantLine
		
		; Draw Birds
		mov ax, 49
		push ax
		mov ax, 8
		push ax
		call drawBird
		
		mov ax, 55
		push ax
		mov ax, 12
		push ax
		call drawBird
		
		mov ax, 6
		push ax
		mov ax, 3
		push ax
		call drawBird
		
		mov ax, 25
		push ax
		mov ax, 8
		push ax
		call drawBird
		
		mov ax, 20
		push ax
		mov ax, 12
		push ax
		call drawBird
		
		ret
;===================================================================================================================================================