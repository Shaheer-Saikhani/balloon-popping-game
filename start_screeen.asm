;===================================================================================================================================================
; Text Labels
play_s:	db 'PLAY', 0				; Play String
playlength_s:	dw 4
difficulty_s:	db 'DIFFICULTY', 0	; Difficulty String
difficultylength_s: dw 10
quit_s:	db 'QUIT', 0				; Quit String
quitlength_s:	dw 4
instructions_s: db 'INSTRUCTIONS', 0
instructionslength_s:	dw 12
;===================================================================================================================================================
;Clear Screen Subroutine
clrscr2:
        mov ax, 0xb800								
		mov es, ax
		mov di, 0
	    mov cx,2000	
	    mov ax,0x3020
		cld                                   
		rep stosw
		ret	
;===================================================================================================================================================
; Draw Sun Soubroutine
drawSun:	push bp
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
			mov ax, 0x6620
			mov cx, 10
			
			rep stosw
			
			add di, 140
			mov cx, 10
			rep stosw
			
			add di, 140
			mov cx, 10
			rep stosw
			
			add di, 140
			mov cx, 10
			rep stosw
			
			add di, 140
			mov cx, 10
			rep stosw
			
			pop cx
			pop bx
			pop ax
			pop si
			pop di
			pop es
			pop bp
			ret 4
;===================================================================================================================================================
; Draw Horizontal Sun Ray Subroutine
SunHorizontal:		push bp
					mov bp, sp

					mov ax, 0xb800				
					mov es, ax
					
					mov ax, [bp + 6]			
					mov bx, 80
					mul bx
					add ax, [bp + 8]			
					shl ax, 1
					mov di, ax
					mov cx, [bp + 4]			
		
SunHorizontalLoop:	mov ax, 0x365F
					mov [es:di], ax				
					add di, 6
					loop SunHorizontalLoop
				
					pop bp
					ret 6
;===================================================================================================================================================
; Draw Vertical Sun Ray Subroutine
SunVertical:		push bp
					mov bp, sp

					mov ax, 0xb800			
					mov es, ax
					
					mov ax, [bp + 6]		
					mov bx, 80
					mul bx
					add ax, [bp + 8]		
					shl ax, 1
					mov di, ax
					mov cx, [bp + 4]		
		
SunVerticalLoop:	mov ax, 0x367C
					mov [es:di], ax			
					add di, 160
					loop SunVerticalLoop
				
					pop bp
					ret 6
;===================================================================================================================================================
; Draw Left to Right Slant Sun Ray Subroutine
LRSunSlantLine:
				push bp
				mov  bp, sp
				push es
				push di
				push ax
				push bx
				push cx

				mov  ax, 0xb800
				mov  es, ax

				mov ax, [bp + 6]		
				mov bx, 80
				mul bx
				add ax, [bp + 8]		
				shl ax, 1
				mov di, ax
				mov cx, [bp + 4]

				mov ax, 0x365C
				cld
slantloop:		stosw
				add di, 162
				loop slantloop

				pop  cx
				pop  bx
				pop  ax
				pop  di
				pop  es
				pop  bp
				ret 6
;===================================================================================================================================================
; Draw Right to Left Slant Sun Ray Subroutine
RLSunSlantLine:
				push bp
				mov  bp, sp
				push es
				push di
				push ax
				push bx
				push cx

				mov  ax, 0xb800
				mov  es, ax

				mov ax, [bp + 6]		
				mov bx, 80
				mul bx
				add ax, [bp + 8]		
				shl ax, 1
				mov di, ax
				mov cx, [bp + 4]

				mov ax, 0x362F
				cld
RLslantloop:		stosw
				add di, 154
				loop RLslantloop

				pop  cx
				pop  bx
				pop  ax
				pop  di
				pop  es
				pop  bp
				ret 6
;===================================================================================================================================================
; Draw Cloud Subroutine
cloud:			push bp
				mov bp, sp
				push es
				push di
				push si
				push ax
				push bx
				push cx
				
				mov ax, 0xb800
				mov es, ax
				xor di, di
				
				mov ax, [bp + 6]			; ROW	
				mov bx, 80
				mul bx
				add ax, [bp + 8]			; COLUMN
				shl ax, 1
				mov di, ax
				mov cx, [bp + 4]			; LENGTH
				mov ax, 0x3FDB
			
				cld
				rep stosw
				
				add di, 158
				mov cx, [bp + 4]
				std
				rep stosw
				
				add di, 162
				mov cx, [bp + 4]
				cld
				rep stosw
				
				add di, 158
				mov cx, [bp + 4]
				std
				rep stosw
				
				add di, 162
				mov cx, [bp + 4]
				cld
				rep stosw
				push di

blueloop:	mov ax, 0x3020
			mov cx, [bp + 4]
			std
			add di, 2
printer:	stosw
			stosw
			sub di, 4
			sub cx, 2
			cmp cx, 0
			jl printer2
			loop printer
			
			printer2:	
			mov ax, [bp + 6]			; ROW	
			mov bx, 80
			mul bx
			add ax, [bp + 8]			; COLUMN
			shl ax, 1
			mov di, ax
			mov cx, [bp + 4]			; LENGTH
			mov ax, 0x3020
			cld
			add di, 2

printer2_loop:	stosw
				stosw
				add di, 4
				sub cx, 2
				cmp cx, 0
				jl printer3
				loop printer2_loop
			
printer3:	mov ax, [bp + 6]			; ROW	
			mov bx, 80
			mul bx
			add ax, [bp + 8]			; COLUMN
			shl ax, 1
			mov di, ax
			mov ax, 0x3020
			add di, 320
			cld
			stosw
			stosw
			
			pop di
			sub di, 322
			std
			stosw
			stosw

		pop cx
		pop bx
		pop ax
		pop si
		pop di
		pop es
		pop bp
		ret 6
;===================================================================================================================================================
; Print Typing Balloons Heading
printTitle:	push bp	
			mov bp, sp
			push es
			push di
			push ax
			push bx
			push cx
			
			mov ax, 0xb800
			mov es, ax
			
			mov ax, [bp + 4]			; ROW	
			mov bx, 80
			mul bx
			add ax, [bp + 6]			; COLUMN
			shl ax, 1
			mov di, ax
			push di
			
			; Draw T
			mov cx, 5
			mov ax, 0x3EDB
			cld
printT:		stosw
			loop printT
			
			add di, 154
			mov cx, 4
printT_Ver:	stosw
			add di, 158
			loop printT_Ver
			
			; Draw Y
			pop di
			add di, 12
			push di
printY:		stosw
			add di, 2
			stosw
			add di, 156
			stosw
			add di, 158
			stosw
			add di, 158
			stosw
			add di, 158
			stosw
			
			; Draw P
			pop di
			add di, 8
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
			
			; Draw I
			pop di
			push di
			add di, 2
			stosw
			stosw
			add di, 158
			stosw
			add di, 156
			stosw
			stosw
			
			; Draw N
			pop di
			add di, 8
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
			
			; Draw G
			pop di
			add di, 4
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
			pop di
			add di, 2
			push di
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
			
			; Draw B
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
			std
			sub di, 162
			stosw
			stosw
			
			; Draw A
			pop di
			cld
			add di, 26
			push di
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
			std
			sub di, 2
			stosw
			stosw
			stosw
			stosw
			sub di, 158
			stosw
			sub di, 158
			stosw
			sub di, 158
			stosw
			cld
			add di, 164
			stosw
			stosw
			stosw
			
			; Draw L
			pop di
			add di, 10
			push di
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
			add di, 2
			stosw
			sub di, 162
			stosw
			sub di, 162
			std
			stosw
			stosw
			cld
			sub di, 156
			stosw
			
			; Draw L
			pop di
			add di, 8
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
			
			; Draw O
			pop di
			add di, 8
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
			
			; Draw O
			pop di
			add di, 8
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
			sub di, 162
			stosw
			sub di, 162
			stosw
			sub di, 162
			stosw
			sub di, 162
			stosw
			sub di, 4
			stosw
			
			; Draw N
			pop di
			add di, 8
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
			sub di, 162
			stosw
			sub di, 162
			stosw
			sub di, 162
			stosw
			sub di, 162
			stosw
			sub di, 4
			stosw
			
			; Draw S
			pop di
			add di, 8
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
			pop di
			push di
			add di, 2
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
			pop di
			add di, 8
			push di
			stosw
			stosw
			stosw
			add di, 154
			stosw
			add di, 158
			stosw
			stosw
			stosw
			add di, 158
			stosw
			add di, 158
			stosw
			std
			sub di, 4
			stosw
			stosw
			
			pop di
			pop cx
			pop bx
			pop ax
			pop di
			pop es
			pop bp
			ret 4
;===================================================================================================================================================
; Start Screen Subroutine
start_screen:	call clrscr2
		; Draw Sun 
		mov ax, 34
		push ax
		mov ax, 4
		push ax
		call drawSun
		
		; Draw Vertical Sun Rays
		mov ax, 39
		push ax
		mov ax, 1
		push ax
		mov ax, 2
		push ax
		call SunVertical
		
		mov ax, 39
		push ax
		mov ax, 10
		push ax
		mov ax, 2
		push ax
		call SunVertical
		
		; Draw Horizontal Sun Rays
		mov ax, 28
		push ax
		mov ax, 6
		push ax
		mov ax, 2
		push ax
		call SunHorizontal
		
		mov ax, 46
		push ax
		mov ax, 6
		push ax
		mov ax, 2
		push ax
		call SunHorizontal
		
		; Draw Left To Right Slant Rays
		mov ax, 30
		push ax
		mov ax, 2
		push ax
		mov ax, 2
		push ax
		call LRSunSlantLine
		
		mov ax, 45
		push ax
		mov ax, 9
		push ax
		mov ax, 2
		push ax
		call LRSunSlantLine
		
		; Draw Right to Left Slant Rays
		mov ax, 32
		push ax
		mov ax, 9
		push ax
		mov ax, 2
		push ax
		call RLSunSlantLine
		
		mov ax, 47
		push ax
		mov ax, 2
		push ax
		mov ax, 2
		push ax
		call RLSunSlantLine
		
		; Draw Clouds
		mov ax, 6		; column
		push ax
		mov ax, 2
		push ax
		mov ax, 13
		push ax
		call cloud
		
		mov ax, 62		; column
		push ax
		mov ax, 2
		push ax
		mov ax, 13
		push ax
		call cloud
		
		; Print Typing Balloons Heading
		mov ax, 7
		push ax
		mov ax, 13
		push ax
		call printTitle
		
		; Draw Play Text
		mov ax, 0x003F			; bp + 12 (Colour)
		push ax
		mov ax, 4				; bp + 10 (Column)
		push ax
		mov ax, 20				; bp + 8 (Row)
		push ax
		mov ax, play_s			; bp + 6 (String)
		push ax
		mov ax, [playlength_s]	; bp + 4 (String Length)
		push ax
		call drawText			; Draw Option 1 Text
		
		; Draw Play Box
		mov ax, 2					; bp + 8 (Column)
		push ax
		mov ax, 19					; bp + 6 (Row)
		push ax
		mov ax, 3					; bp + 4 (Length)
		push ax
		call WhiteVerticalLine		; Draw Right Option 1 Border Line
		
		mov ax, 2				; bp + 8 (Column)
		push ax
		mov ax, 19				; bp + 6 (Row)		
		push ax
		mov ax, 7				; bp + 4 (Length)
		push ax
		call WhiteHorizontalLine	; Draw Top Option 2 Line
		
		mov ax, 9					; bp + 8 (Column)
		push ax
		mov ax, 19					; bp + 6 (Row)
		push ax
		mov ax, 3					; bp + 4 (Length)
		push ax
		call WhiteVerticalLine		; Draw Right Option 1 Border Line
		
		mov ax, 2				; bp + 8 (Column)
		push ax
		mov ax, 21				; bp + 6 (Row)		
		push ax
		mov ax, 7				; bp + 4 (Length)
		push ax
		call WhiteHorizontalLine	; Draw Top Option 2 Line
		
		; Draw Difficulty Text
		mov ax, 0x003F				; bp + 12 (Colour)
		push ax
		mov ax, 49					; bp + 10 (Column)
		push ax
		mov ax, 20					; bp + 8 (Row)
		push ax
		mov ax, difficulty_s			; bp + 6 (String)
		push ax
		mov ax, [difficultylength_s]	; bp + 4 (String Length)
		push ax
		call drawText				; Draw Option 2 Text
		
		; Draw Difficulty Box
		mov ax, 47					; bp + 8 (Column)
		push ax
		mov ax, 19					; bp + 6 (Row)
		push ax
		mov ax, 3					; bp + 4 (Length)
		push ax
		call WhiteVerticalLine		; Draw Right Option 1 Border Line
		
		mov ax, 47				; bp + 8 (Column)
		push ax
		mov ax, 19				; bp + 6 (Row)		
		push ax
		mov ax, 13				; bp + 4 (Length)
		push ax
		call WhiteHorizontalLine	; Draw Top Option 2 Line
		
		mov ax, 60					; bp + 8 (Column)
		push ax
		mov ax, 19					; bp + 6 (Row)
		push ax
		mov ax, 3					; bp + 4 (Length)
		push ax
		call WhiteVerticalLine		; Draw Right Option 1 Border Line
		
		mov ax, 47				; bp + 8 (Column)
		push ax
		mov ax, 21				; bp + 6 (Row)		
		push ax
		mov ax, 13				; bp + 4 (Length)
		push ax
		call WhiteHorizontalLine	; Draw Top Option 2 Line	
		
		; Draw Quit Text
		mov ax, 0x003F				; bp + 12 (Colour)
		push ax
		mov ax, 73					; bp + 10 (Column)
		push ax
		mov ax, 20					; bp + 8 (Row)
		push ax
		mov ax, quit_s			; bp + 6 (String)
		push ax
		mov ax, [quitlength_s]	; bp + 4 (String Length)
		push ax
		call drawText				; Draw Option 3 Text
		
		; Draw Quit Box
		mov ax, 71					; bp + 8 (Column)
		push ax
		mov ax, 19					; bp + 6 (Row)
		push ax
		mov ax, 3					; bp + 4 (Length)
		push ax
		call WhiteVerticalLine		; Draw Right Option 1 Border Line
		
		mov ax, 71				; bp + 8 (Column)
		push ax
		mov ax, 19				; bp + 6 (Row)		
		push ax
		mov ax, 7				; bp + 4 (Length)
		push ax
		call WhiteHorizontalLine	; Draw Top Option 2 Line
		
		mov ax, 78					; bp + 8 (Column)
		push ax
		mov ax, 19					; bp + 6 (Row)
		push ax
		mov ax, 3					; bp + 4 (Length)
		push ax
		call WhiteVerticalLine		; Draw Right Option 1 Border Line
		
		mov ax, 71				; bp + 8 (Column)
		push ax
		mov ax, 21				; bp + 6 (Row)		
		push ax
		mov ax, 7				; bp + 4 (Length)
		push ax
		call WhiteHorizontalLine	; Draw Top Option 2 Line
		
		; Draw Instructions Text
		mov ax, 0x003F			; bp + 12 (Colour)
		push ax
		mov ax, 22				; bp + 10 (Column)
		push ax
		mov ax, 20				; bp + 8 (Row)
		push ax
		mov ax, instructions_s			; bp + 6 (String)
		push ax
		mov ax, [instructionslength_s]	; bp + 4 (String Length)
		push ax
		call drawText			; Draw Option 1 Text
		
		; Draw Instructions Box
		mov ax, 20					; bp + 8 (Column)
		push ax
		mov ax, 19					; bp + 6 (Row)
		push ax
		mov ax, 3					; bp + 4 (Length)
		push ax
		call WhiteVerticalLine		; Draw Right Option 1 Border Line
		
		mov ax, 20				; bp + 8 (Column)
		push ax
		mov ax, 19				; bp + 6 (Row)		
		push ax
		mov ax, 15				; bp + 4 (Length)
		push ax
		call WhiteHorizontalLine	; Draw Top Option 2 Line
		
		mov ax, 35					; bp + 8 (Column)
		push ax
		mov ax, 19					; bp + 6 (Row)
		push ax
		mov ax, 3					; bp + 4 (Length)
		push ax
		call WhiteVerticalLine		; Draw Right Option 1 Border Line
		
		mov ax, 20				; bp + 8 (Column)
		push ax
		mov ax, 21				; bp + 6 (Row)		
		push ax
		mov ax, 15				; bp + 4 (Length)
		push ax
		call WhiteHorizontalLine	; Draw Top Option 2 Line
		
		; Draw Birds
		mov ax, 2      ; column
		push ax
		mov ax, 11      ; row
		push ax
		call drawBird
		
		mov ax, 6      ; column
		push ax
		mov ax, 8      ; row
		push ax
		call drawBird
		
		mov ax, 14      ; column
		push ax
		mov ax, 10      ; row
		push ax
		call drawBird
		
		mov ax, 25      ; column
		push ax
		mov ax, 8      ; row
		push ax
		call drawBird
		
		mov ax, 22      ; column
		push ax
		mov ax, 11      ; row
		push ax
		call drawBird
		
		mov ax, 54      ; column
		push ax
		mov ax, 11      ; row
		push ax
		call drawBird
		
		mov ax, 58      ; column
		push ax
		mov ax, 8      ; row
		push ax
		call drawBird
		
		mov ax, 67      ; column
		push ax
		mov ax, 9      ; row
		push ax
		call drawBird
		
		mov ax, 78      ; column
		push ax
		mov ax, 8      ; row
		push ax
		call drawBird
		
		mov ax, 74      ; column
		push ax
		mov ax, 11      ; row
		push ax
		call drawBird
		
		; mov ax,8 					; bp + 10 (Row)
		; push ax
		; mov ax,22 					; bp + 8 (Column)
		; push ax
		; mov ax,0x4020				; bp + 6 (Colour)
		; push ax
		; mov ax,0x4741				; bp + 4 (Letter with Attribute)
		; push ax
		; call Balloon				; Draw Balloon
		
		; mov ax, 3					; bp + 10 (Row)
		; push ax
		; mov ax, 55					; bp + 8 (Column)
		; push ax
		; mov ax, 0x2020				; bp + 6 (Colour)
		; push ax
	    ; mov ax,0x2749				; bp + 4 (Letter with Attribute)
		; push ax
		; call Balloon				; Draw Balloon
		
		; mov ax, 9					; bp + 10 (Row)
		; push ax
		; mov ax, 74					; bp + 8 (Column)
		; push ax
		; mov ax, 0x5020				; bp + 6 (Colour)
		; push ax
	    ; mov ax,0x5746				; bp + 4 (Letter with Attribute)
		; push ax
		; call Balloon				; Draw Balloon
		
		; mov ax, 14					; bp + 10 (Row)
		; push ax
		; mov ax, 3					; bp + 8 (Column)
		; push ax
		; mov ax, 0x6020				; bp + 6 (Colour)
		; push ax
	    ; mov ax,0x6743				; bp + 4 (Letter with Attribute)
		; push ax
		; call Balloon				; Draw Balloon
				
		ret
;===================================================================================================================================================
