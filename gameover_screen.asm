;===================================================================================================================================================
; Text Labels
play_o:	db 'RESTART', 0				; Play String
playlength_o:	dw 7
difficulty_o:	db 'MAIN MENU', 0	; Difficulty String
difficultylength_o: dw 9
quit_o:	db 'QUIT', 0				; Quit String
quitlength_o:	dw 4
score_o:	db 'FINAL SCORE:     ', 0				
scorelength_o:	dw 17
;===================================================================================================================================================
;Clear Screen Subroutine
clrscr3:
        mov ax, 0xb800								
		mov es, ax
		mov di, 0
	    mov cx,2000	
	    mov ax,0x1020
		cld                                   
		rep stosw
		ret			
;===================================================================================================================================================
; Print Moon Subroutine
printMoon2:	push bp	
			mov bp, sp
			push es
			push di
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
			mov ax, 0x7720
			
			mov cx, 7
			rep stosw
			
			add di, 146
			mov cx, 5
			rep stosw
			
			add di, 150
			mov cx, 3
			rep stosw
			
			add di, 154
			mov cx, 5
			rep stosw
			
			add di, 150
			mov cx, 7
			rep stosw
			
			pop di
			mov ax,0x1020
			mov cx, 2
			rep stosw
			
			add di, 156
			stosw
			
			add di, 158
			stosw
			
			add di, 158
			stosw
			
			add di, 158
			mov cx, 2
			rep stosw
			
			pop cx
			pop bx
			pop ax
			pop di
			pop es
			pop bp
			ret 4
;===================================================================================================================================================
; Draw Moon Cloud Subroutine
Mooncloud:		push bp
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
				mov ax, 0x18DB
			
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

blueloop2:	mov ax, 0x1020
			mov cx, [bp + 4]
			std
			add di, 2
printers:	stosw
			stosw
			sub di, 4
			sub cx, 2
			cmp cx, 0
			jl printers2
			loop printers
			
printers2:	
			mov ax, [bp + 6]			; ROW	
			mov bx, 80
			mul bx
			add ax, [bp + 8]			; COLUMN
			shl ax, 1
			mov di, ax
			mov cx, [bp + 4]			; LENGTH
			mov ax, 0x1020
			cld
			add di, 2

printers2_loop:	stosw
				stosw
				add di, 4
				sub cx, 2
				cmp cx, 0
				jl printers3
				loop printers2_loop
			
printers3:	mov ax, [bp + 6]			; ROW	
			mov bx, 80
			mul bx
			add ax, [bp + 8]			; COLUMN
			shl ax, 1
			mov di, ax
			mov ax, 0x1020
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
; Draw Moon Text Subroutine
drawMoonText:	push bp
			mov bp, sp
			push es
			push ax
			push cx
			push si
			push di
			
			mov ax, 0xb800					
			mov es, ax
			
			mov ax, [bp + 8]				
			mov bx, 80
			mul bx
			add ax, [bp + 10]				
			shl ax, 1
			mov di, ax
			
			mov si, [bp + 6]					
			mov cx, [bp + 4]				
			mov ah, [bp + 12]				
				
nextchar2:	mov al, [si]					
			mov [es:di], ax						
			add di, 2
			add si, 1
			loop nextchar2
			
			pop di
			pop si
			pop cx
			pop ax
			pop es
			pop bp
			ret 10
			
printOver:	push bp
			mov bp, sp
			push es
			push di
			push ax
			push bx
			push cx
			
			mov ax, 0xb800
			mov es, ax
			
			mov ax, [bp + 4]				
			mov bx, 80
			mul bx
			add ax, [bp + 6]				
			shl ax, 1
			mov di, ax
			push di
			mov ax, 0x14DB
			
			cld
			stosw
			stosw
			stosw
			stosw
			stosw
			add di, 158
			stosw
			sub di, 10
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
			stosw
			sub di, 162
			stosw
			sub di, 4
			stosw
			sub di, 4
			stosw
			
			pop di
			add di, 14
			push di
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
			sub di, 10
			stosw
			sub di, 162
			stosw
			sub di, 162
			stosw
			sub di, 162
			stosw
			add di, 160
			stosw
			stosw
			stosw
			
			pop di
			add di, 14
			push di
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
			stosw
			stosw
			stosw
			add di, 158
			stosw
			add di, 158
			stosw
			sub di, 320
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
			
			pop di
			add di, 18
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
			stosw
			std
			sub di, 322
			stosw
			stosw
			stosw
			stosw
			sub di, 318
			cld
			stosw
			stosw
			stosw
			stosw
			
			pop di
			add di, 24 
			push di
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
			std
			add di, 158
			stosw
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
			pop di
			add di, 14
			push di
			stosw
			add di, 158
			stosw
			add di, 158
			stosw
			add di, 160
			stosw
			add di, 160
			stosw
			sub di, 160
			stosw
			sub di, 160
			stosw
			sub di, 162
			stosw
			sub di, 162
			stosw
			
			pop di
			add di, 14
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
			stosw
			std
			sub di, 322
			stosw
			stosw
			stosw
			stosw
			sub di, 318
			cld
			stosw
			stosw
			stosw
			stosw
			
			pop di
			add di, 14
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
			stosw
			stosw
			stosw
			stosw
			stosw
			add di, 158
			stosw
			std
			add di, 158
			stosw
			stosw
			stosw
			stosw
			cld
			add di, 166
			stosw
			add di, 160
			stosw
			
			pop cx
			pop bx
			pop ax
			pop di
			pop es
			pop bp
			ret 4
;===================================================================================================================================================
; Draw Star Subroutine
star:		push bp
			mov bp, sp
			push es
			push di
			push ax
			push bx
			push cx
			
			mov ax, 0xb800
			mov es, ax
			
			mov ax, [bp + 4]				
			mov bx, 80
			mul bx
			add ax, [bp + 6]				
			shl ax, 1
			mov di, ax
			mov al, 0x2A
			mov ah, [bp + 8]
			
			stosw
			
			pop cx
			pop bx
			pop ax
			pop di
			pop es
			pop bp
			ret 6
;===================================================================================================================================================
; Game Over Screen Subroutine
over_screen:	call clrscr3

		; Print Moon
		mov ax, 35
		push ax
		mov ax, 1
		push ax
		call printMoon2
		
		; Print Over Heading
		mov ax, 9
		push ax
		mov ax, 7
		push ax
		call printOver
		
		; Draw Moon Clouds
		mov ax, 6		; column
		push ax
		mov ax, 1
		push ax
		mov ax, 13
		push ax
		call Mooncloud
		
		mov ax, 62		; column
		push ax
		mov ax, 1
		push ax
		mov ax, 13
		push ax
		call Mooncloud
		
		; Draw Stars
		mov ax, 0x001E
		push ax
		mov ax, 2
		push ax
		mov ax, 3
		push ax
		call star
		mov ax, 0x0017
		push ax
		mov ax, 2
		push ax
		mov ax, 12
		push ax
		call star
		mov ax, 0x001B
		push ax
		mov ax, 12
		push ax
		mov ax, 0
		push ax
		call star	
		mov ax, 0x0017
		push ax
		mov ax, 21
		push ax
		mov ax, 5
		push ax
		call star
		mov ax, 0x001E
		push ax
		mov ax, 28
		push ax
		mov ax, 3
		push ax
		call star
		mov ax, 0x001B
		push ax
		mov ax, 40
		push ax
		mov ax, 10
		push ax
		call star
		mov ax, 0x001E
		push ax
		mov ax, 45
		push ax
		mov ax, 1
		push ax
		call star
		mov ax, 0x0017
		push ax
		mov ax, 51
		push ax
		mov ax, 5
		push ax
		call star
		mov ax, 0x0013
		push ax
		mov ax, 56
		push ax
		mov ax, 3
		push ax
		call star
		mov ax, 0x001E
		push ax
		mov ax, 74
		push ax
		mov ax, 10
		push ax
		call star
		mov ax, 0x0013
		push ax
		mov ax, 77
		push ax
		mov ax, 1
		push ax
		call star
		mov ax, 0x0017
		push ax
		mov ax, 78
		push ax
		mov ax, 7
		push ax
		call star
		mov ax, 0x001E
		push ax
		mov ax, 2
		push ax
		mov ax, 16
		push ax
		call star
		mov ax, 0x0017
		push ax
		mov ax, 2
		push ax
		mov ax, 23
		push ax
		call star
		mov ax, 0x001B
		push ax
		mov ax, 12
		push ax
		mov ax, 14
		push ax
		call star	
		mov ax, 0x0017
		push ax
		mov ax, 21
		push ax
		mov ax, 16
		push ax
		call star
		mov ax, 0x001E
		push ax
		mov ax, 28
		push ax
		mov ax, 22
		push ax
		call star
		mov ax, 0x001B
		push ax
		mov ax, 40
		push ax
		mov ax, 21
		push ax
		call star
		mov ax, 0x001E
		push ax
		mov ax, 50
		push ax
		mov ax, 20
		push ax
		call star
		mov ax, 0x0017
		push ax
		mov ax, 51
		push ax
		mov ax, 16
		push ax
		call star
		mov ax, 0x0013
		push ax
		mov ax, 56
		push ax
		mov ax, 14
		push ax
		call star
		mov ax, 0x001E
		push ax
		mov ax, 74
		push ax
		mov ax, 21
		push ax
		call star
		mov ax, 0x0013
		push ax
		mov ax, 72
		push ax
		mov ax, 15
		push ax
		call star
		mov ax, 0x0017
		push ax
		mov ax, 78
		push ax
		mov ax, 19
		push ax
		call star
		
		; Draw Play Text
		mov ax, 0x001F			; bp + 12 (Colour)
		push ax
		mov ax, 37				; bp + 10 (Column)
		push ax
		mov ax, 20				; bp + 8 (Row)
		push ax
		mov ax, play_o			; bp + 6 (String)
		push ax
		mov ax, [playlength_o]	; bp + 4 (String Length)
		push ax
		call drawMoonText			; Draw Option 1 Text
		
		; Draw Play Box
		mov ax, 35					; bp + 8 (Column)
		push ax
		mov ax, 19					; bp + 6 (Row)
		push ax
		mov ax, 3					; bp + 4 (Length)
		push ax
		call WhiteVerticalLine		; Draw Right Option 1 Border Line
		
		mov ax, 35				; bp + 8 (Column)
		push ax
		mov ax, 19				; bp + 6 (Row)		
		push ax
		mov ax, 10				; bp + 4 (Length)
		push ax
		call WhiteHorizontalLine	; Draw Top Option 2 Line
		
		mov ax, 45					; bp + 8 (Column)
		push ax
		mov ax, 19					; bp + 6 (Row)
		push ax
		mov ax, 3					; bp + 4 (Length)
		push ax
		call WhiteVerticalLine		; Draw Right Option 1 Border Line
		
		mov ax, 35				; bp + 8 (Column)
		push ax
		mov ax, 21				; bp + 6 (Row)		
		push ax
		mov ax, 10				; bp + 4 (Length)
		push ax
		call WhiteHorizontalLine	; Draw Top Option 2 Line
		
		; Draw Difficulty Text
		mov ax, 0x001F				; bp + 12 (Colour)
		push ax
		mov ax, 7					; bp + 10 (Column)
		push ax
		mov ax, 20					; bp + 8 (Row)
		push ax
		mov ax, difficulty_o			; bp + 6 (String)
		push ax
		mov ax, [difficultylength_o]	; bp + 4 (String Length)
		push ax
		call drawMoonText				; Draw Option 2 Text
		
		; Draw Difficulty Box
		mov ax, 5					; bp + 8 (Column)
		push ax
		mov ax, 19					; bp + 6 (Row)
		push ax
		mov ax, 3					; bp + 4 (Length)
		push ax
		call WhiteVerticalLine		; Draw Right Option 1 Border Line
		
		mov ax, 5				; bp + 8 (Column)
		push ax
		mov ax, 19				; bp + 6 (Row)		
		push ax
		mov ax, 12				; bp + 4 (Length)
		push ax
		call WhiteHorizontalLine	; Draw Top Option 2 Line
		
		mov ax, 17					; bp + 8 (Column)
		push ax
		mov ax, 19					; bp + 6 (Row)
		push ax
		mov ax, 3					; bp + 4 (Length)
		push ax
		call WhiteVerticalLine		; Draw Right Option 1 Border Line
		
		mov ax, 5				; bp + 8 (Column)
		push ax
		mov ax, 21				; bp + 6 (Row)		
		push ax
		mov ax, 12				; bp + 4 (Length)
		push ax
		call WhiteHorizontalLine	; Draw Top Option 2 Line	
		
		; Draw Quit Text
		mov ax, 0x001F				; bp + 12 (Colour)
		push ax
		mov ax, 69					; bp + 10 (Column)
		push ax
		mov ax, 20					; bp + 8 (Row)
		push ax
		mov ax, quit_o			; bp + 6 (String)
		push ax
		mov ax, [quitlength_o]	; bp + 4 (String Length)
		push ax
		call drawMoonText				; Draw Option 3 Text
		
		; Draw Quit Box
		mov ax, 67					; bp + 8 (Column)
		push ax
		mov ax, 19					; bp + 6 (Row)
		push ax
		mov ax, 3					; bp + 4 (Length)
		push ax
		call WhiteVerticalLine		; Draw Right Option 1 Border Line
		
		mov ax, 67				; bp + 8 (Column)
		push ax
		mov ax, 19				; bp + 6 (Row)		
		push ax
		mov ax, 7				; bp + 4 (Length)
		push ax
		call WhiteHorizontalLine	; Draw Top Option 2 Line
		
		mov ax, 74					; bp + 8 (Column)
		push ax
		mov ax, 19					; bp + 6 (Row)
		push ax
		mov ax, 3					; bp + 4 (Length)
		push ax
		call WhiteVerticalLine		; Draw Right Option 1 Border Line
		
		mov ax, 67				; bp + 8 (Column)
		push ax
		mov ax, 21				; bp + 6 (Row)		
		push ax
		mov ax, 7				; bp + 4 (Length)
		push ax
		call WhiteHorizontalLine	; Draw Top Option 2 Line
		
		; Draw Final Score Text
		mov ax, 0x001E				; bp + 12 (Colour)
		push ax
		mov ax, 32					; bp + 10 (Column)
		push ax
		mov ax, 15					; bp + 8 (Row)
		push ax
		mov ax, score_o			; bp + 6 (String)
		push ax
		mov ax, [scorelength_o]	; bp + 4 (String Length)
		push ax
		call drawMoonText				; Draw Option 3 Text
		
		; Print Current Score Value Text
		mov ax, 45
		push ax
		mov ax, 15
		push ax
		mov ax, 0x001E
		push ax
		push word [cs:score_value]
		call printnum
		
		; Draw Final Score Box
		mov ax, 29					; bp + 8 (Column)
		push ax
		mov ax, 13					; bp + 6 (Row)
		push ax
		mov ax, 5					; bp + 4 (Length)
		push ax
		call WhiteVerticalLine		; Draw Right Option 1 Border Line
		
		mov ax, 30				; bp + 8 (Column)
		push ax
		mov ax, 13				; bp + 6 (Row)		
		push ax
		mov ax, 21				; bp + 4 (Length)
		push ax
		call WhiteHorizontalLine	; Draw Top Option 2 Line
		
		mov ax, 51					; bp + 8 (Column)
		push ax
		mov ax, 13					; bp + 6 (Row)
		push ax
		mov ax, 5					; bp + 4 (Length)
		push ax
		call WhiteVerticalLine		; Draw Right Option 1 Border Line
		
		mov ax, 30				; bp + 8 (Column)
		push ax
		mov ax, 17				; bp + 6 (Row)		
		push ax
		mov ax, 21				; bp + 4 (Length)
		push ax
		call WhiteHorizontalLine	; Draw Top Option 2 Line
		ret
;===================================================================================================================================================
