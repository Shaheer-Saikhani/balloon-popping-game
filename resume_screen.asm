;===================================================================================================================================================
; Text Labels
mainmenu_r:	db 'MAIN MENU', 0		
menulength_r:	dw 9
resume_r:	db 'RESUME', 0
resumelength_r:	dw 6
quit_r:	db 'QUIT', 0
quitlength_r:	dw 4
;===================================================================================================================================================
; Draw Paused Heading Subroutine
drawPaused:	push bp	
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
			mov ax, 0x3EDB
			
			; Draw G
			cld
			stosw
			stosw
			stosw
			stosw
			stosw
			add di, 150
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
			sub di, 162
			stosw
			stosw
			stosw
			
			; Draw A
			cld
			pop di
			add di, 14
			push di
			stosw
			stosw
			stosw
			stosw
			stosw
			add di, 150
			stosw
			add di, 158
			stosw
			add di, 158
			stosw
			add di, 158
			stosw
			add di, 6
			stosw
			sub di, 162
			stosw
			sub di, 162
			stosw
			sub di, 162
			stosw
			add di, 150
			stosw
			stosw
			stosw
			stosw
			
			; Draw M
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
			push di
			stosw
			stosw
			stosw
			stosw
			add di, 158
			stosw
			add di, 158
			stosw
			pop di
			push di
			add di, 8
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
			
			; Draw E
			pop di
			add di, 18
			push di
			stosw
			stosw
			stosw
			stosw
			stosw
			add di, 150
			stosw
			add di, 158
			stosw
			stosw
			stosw
			stosw
			stosw
			add di, 150
			stosw
			add di, 158
			stosw
			stosw
			stosw
			stosw
			stosw
			
			; Draw P
			pop di
			add di, 22
			push di
			push di
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
			stosw
			cld
			pop di
			stosw
			add di, 158
			stosw
			add di, 158
			stosw
			add di, 158
			stosw
			add di, 158
			stosw
			
			; Draw A
			pop di
			add di, 14
			push di
			stosw
			stosw
			stosw
			stosw
			stosw
			add di, 150
			stosw
			add di, 158
			stosw
			add di, 158
			stosw
			add di, 158
			stosw
			add di, 6
			stosw
			sub di, 162
			stosw
			sub di, 162
			stosw
			sub di, 162
			stosw
			add di, 150
			stosw
			stosw
			stosw
			stosw
			
			; Draw U
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
			sub di, 162
			stosw
			sub di, 162
			stosw
			sub di, 162
			stosw
			sub di, 162
			stosw
			
			; Draw S
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
			stosw
			add di, 158
			stosw
			std
			add di, 158
			stosw
			stosw
			stosw
			stosw
			
			; Draw E
			cld
			pop di
			add di, 12
			push di
			stosw
			stosw
			stosw
			stosw
			stosw
			add di, 150
			stosw
			add di, 158
			stosw
			stosw
			stosw
			stosw
			stosw
			add di, 150
			stosw
			add di, 158
			stosw
			stosw
			stosw
			stosw
			stosw
			
			; Draw D
			pop di
			add di, 14
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
			
			pop cx
			pop bx
			pop ax
			pop di
			pop es
			pop bp
			ret 4
;===================================================================================================================================================
; Resume Screen	Subroutine		
resume_screen:		
            call clrscr	
			
			; Draw Paused Heading
			mov ax, 5
			push ax
			mov ax, 4
			push ax
			call drawPaused
			
			; Draw Border
			mov ax, 0					; bp + 8 (Column)
			push ax
			mov ax, 0					; bp + 6 (Row)
			push ax
			mov ax, 40					; bp + 4 (Length)
			push ax
			call WhiteVerticalLine		; Draw Top Title Line
			
			mov ax, 79					; bp + 8 (Column)
			push ax
			mov ax, 0					; bp + 6 (Row)
			push ax
			mov ax, 40					; bp + 4 (Length)
			push ax
			call WhiteVerticalLine		; Draw Top Title Line
			
			mov ax, 0					; bp + 8 (Column)
			push ax
			mov ax, 24					; bp + 6 (Row)		
			push ax
			mov ax, 80					; bp + 4 (Length)	
			push ax
			call WhiteHorizontalLine		; Draw Right Half Middle Title Line
			
			mov ax, 0					; bp + 8 (Column)
			push ax
			mov ax, 2					; bp + 6 (Row)		
			push ax
			mov ax, 80					; bp + 4 (Length)
			push ax
			call WhiteHorizontalLine		; Draw Bottom Title Line
			
			; Draw Score Text
			mov ax, 0x003F				; bp + 12 (Colour)
			push ax
			mov ax, 5					; bp + 10 (Column)
			push ax
			mov ax, 1					; bp + 8 (Row)
			push ax 
			mov ax, score_g				; bp + 6 (String)
			push ax
			mov ax, [scoreLength_g]		; bp + 4 (String Length)
			push ax
			call drawText				; Draw Score Text
			
			; Draw Score Value Text
			mov ax, 12
			push ax
			mov ax, 1
			push ax
			mov ax, 0x003F
			push ax
			push word [cs:score_value]
			call printnum
	
			; Draw Score Border
			mov ax, 0					; bp + 8 (Column)
			push ax
			mov ax, 0					; bp + 6 (Row)	
			push ax
			mov ax, 18					; bp + 4 (Length)
			push ax
			call WhiteHorizontalLine		; Draw Top Score Line
			
			mov ax, 16					; bp + 8 (Column)
			push ax
			mov ax, 1					; bp + 6 (Row)	
			push ax
			mov ax, 2					; bp + 4 (Length)
			push ax
			call WhiteHorizontalLine	; Draw Right Half Middle Score Line
			
			; Draw Timer Text
			mov ax, 0x003F				; bp + 12 (Colour)
			push ax
			mov ax, 65					; bp + 10 (Column)
			push ax
			mov ax, 1					; bp + 8 (Row)
			push ax
			mov ax, timer_g				; bp + 6 (String)
			push ax
			mov ax, [timerLength_g]		; bp + 4 (String Length)
			push ax
			call drawText				; Draw Timer Text
			
			; Draw Timer Count Text
			mov ax, 72
			push ax
			mov ax, 1
			push ax
			mov ax, 0x003F
			push ax
			push word [cs:saved_tickcount]
			call printnum

			; Draw Timer Border
			mov ax, 62					; bp + 8 (Column)
			push ax
			mov ax, 0					; bp + 6 (Row)
			push ax
			mov ax, 17					; bp + 4 (Length)
			push ax
			call WhiteHorizontalLine	; Draw Top Timer Line
			
			mov ax, 28					; bp + 8 (Column)
			push ax
			mov ax, 0					; bp + 6 (Row)
			push ax
			mov ax, 22					; bp + 4 (Length)
			push ax
			call WhiteHorizontalLine	; Draw Top level Line
			
			mov ax, 50					; bp + 8 (Column)
			push ax
			mov ax, 0					; bp + 6 (Row)
			push ax
			mov ax, 2					; bp + 4 (Length)
			push ax
			call WhiteVerticalLine		; Draw Right Option 1 Border Line
			
			mov ax, 0
			push ax
			mov ax, 23
			push ax
			mov ax, 80
			push ax
			call WhiteHorizontalLine
			
			mov ax, 28					; bp + 8 (Column)
			push ax
			mov ax, 0					; bp + 6 (Row)
			push ax
			mov ax, 2					; bp + 4 (Length)
			push ax
			call WhiteVerticalLine		; Draw Right Option 1 Border Line
			
			mov ax, 62					; bp + 8 (Column)
			push ax
			mov ax, 1					; bp + 6 (Row)	
			push ax
			mov ax, 2					; bp + 4 (Length)
			push ax
			call WhiteHorizontalLine	; Draw Left Half Middle Timer Line

			; Draw Resume Text
			mov ax, 0x003F			; bp + 12 (Colour)
			push ax
			mov ax, 36				; bp + 10 (Column)
			push ax
			mov ax, 15				; bp + 8 (Row)
			push ax
			mov ax, resume_r			; bp + 6 (String)
			push ax
			mov ax, [resumelength_r]	; bp + 4 (String Length)
			push ax
			call drawText			; Draw Option 1 Text
			
			; Draw Resume Box
			mov ax, 30					; bp + 8 (Column)
			push ax
			mov ax, 14					; bp + 6 (Row)
			push ax
			mov ax, 3					; bp + 4 (Length)
			push ax
			call WhiteVerticalLine		; Draw Right Option 1 Border Line
			
			mov ax, 30				; bp + 8 (Column)
			push ax
			mov ax, 13				; bp + 6 (Row)		
			push ax
			mov ax, 17				; bp + 4 (Length)
			push ax
			call WhiteHorizontalLine	; Draw Top Option 2 Line
			
			mov ax, 47					; bp + 8 (Column)
			push ax
			mov ax, 13					; bp + 6 (Row)
			push ax
			mov ax, 4					; bp + 4 (Length)
			push ax
			call WhiteVerticalLine		; Draw Right Option 1 Border Line
			
			mov ax, 30				; bp + 8 (Column)
			push ax
			mov ax, 17				; bp + 6 (Row)		
			push ax
			mov ax, 18				; bp + 4 (Length)
			push ax
			call WhiteHorizontalLine	; Draw Top Option 2 Line	
			
			; Draw Main Menu Text
			mov ax, 0x003F			; bp + 12 (Colour)
			push ax
			mov ax, 9				; bp + 10 (Column)
			push ax
			mov ax, 15				; bp + 8 (Row)
			push ax
			mov ax, mainmenu_r			; bp + 6 (String)
			push ax
			mov ax, [menulength_r]	; bp + 4 (String Length)
			push ax
			call drawText			; Draw Option 1 Text
			
			; Draw Main Menu Box
			mov ax, 5					; bp + 8 (Column)
			push ax
			mov ax, 14					; bp + 6 (Row)
			push ax
			mov ax, 3					; bp + 4 (Length)
			push ax
			call WhiteVerticalLine		; Draw Right Option 1 Border Line
			
			mov ax, 5				; bp + 8 (Column)
			push ax
			mov ax, 13				; bp + 6 (Row)		
			push ax
			mov ax, 17				; bp + 4 (Length)
			push ax
			call WhiteHorizontalLine	; Draw Top Option 2 Line
			
			mov ax, 22					; bp + 8 (Column)
			push ax
			mov ax, 13					; bp + 6 (Row)
			push ax
			mov ax, 4					; bp + 4 (Length)
			push ax
			call WhiteVerticalLine		; Draw Right Option 1 Border Line
			
			mov ax, 5				; bp + 8 (Column)
			push ax
			mov ax, 17				; bp + 6 (Row)		
			push ax
			mov ax, 18				; bp + 4 (Length)
			push ax
			call WhiteHorizontalLine	; Draw Top Option 2 Line	
			
			; Draw Quit Text
			mov ax, 0x003F				; bp + 12 (Colour)
			push ax
			mov ax, 63					; bp + 10 (Column)
			push ax
			mov ax, 15					; bp + 8 (Row)
			push ax
			mov ax, quit_r			; bp + 6 (String)
			push ax
			mov ax, [quitlength_r]	; bp + 4 (String Length)
			push ax
			call drawText				; Draw Option 3 Text
			
			; Draw Quit Box
			mov ax, 56					; bp + 8 (Column)
			push ax
			mov ax, 14					; bp + 6 (Row)
			push ax
			mov ax, 3					; bp + 4 (Length)
			push ax
			call WhiteVerticalLine		; Draw Right Option 1 Border Line
			
			mov ax, 56				; bp + 8 (Column)
			push ax
			mov ax, 13				; bp + 6 (Row)		
			push ax
			mov ax, 17				; bp + 4 (Length)
			push ax
			call WhiteHorizontalLine	; Draw Top Option 2 Line
			
			mov ax, 73					; bp + 8 (Column)
			push ax
			mov ax, 13					; bp + 6 (Row)
			push ax
			mov ax, 4					; bp + 4 (Length)
			push ax
			call WhiteVerticalLine		; Draw Right Option 1 Border Line
			
			mov ax, 56				; bp + 8 (Column)
			push ax
			mov ax, 17				; bp + 6 (Row)		
			push ax
			mov ax, 18				; bp + 4 (Length)
			push ax
			call WhiteHorizontalLine	; Draw Top Option 2 Line
				
			; Draw Birds
			mov ax, 3
			push ax
			mov ax, 11
			push ax
			call drawBird
			
			mov ax, 9
			push ax
			mov ax, 9
			push ax
			call drawBird
			
			mov ax, 76
			push ax
			mov ax, 11
			push ax
			call drawBird
			
			mov ax, 70
			push ax
			mov ax, 9
			push ax
			call drawBird
			
			mov ax, 42
			push ax
			mov ax, 8
			push ax
			call drawBird
			
			mov ax, 50
			push ax
			mov ax, 10
			push ax
			call drawBird
			
			mov ax, 27
			push ax
			mov ax, 10
			push ax
			call drawBird
			
			mov ax, 34
			push ax
			mov ax, 5
			push ax
			call drawBird

			mov ax, 0x003F          ; colour
			push ax
			mov ax, 34             ; column
			push ax
			mov ax, 1               ; row
			push ax
			
			; Check Selected Difficulty
			mov bx, [cs:current_difficulty]
			cmp bx, 2
			je .lvl_medium
			cmp bx, 3
			je .lvl_hard

			; Print 'LEVEL:EASY'
			mov ax, level_easy_g
			push ax
			mov ax, [levellength_easy_g]
			push ax
			call drawText
			jmp end1
		
.lvl_medium:
			; Print 'LEVEL:MEDIUM'
			mov ax, level_med_g
			push ax
			mov ax, [levellength_med_g]
			push ax
			call drawText
			jmp end1
		
.lvl_hard:
			; Print 'LEVEL:HARD'
			mov ax, level_hard_g
			push ax
			mov ax, [levellength_hard_g]
			push ax
			call drawText
end1:
			ret
;===================================================================================================================================================