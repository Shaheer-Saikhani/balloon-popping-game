;===================================================================================================================================================
line1:  db '* Welcome to Typing Balloons!',0
len1:   dw 29
line2:  db '* Your mission: pop balloons by',0
len2:   dw 31
line2.1:	db 'typing the letter inside them.', 0
len2.1:	dw 31
line3:  db '* Each correct pop is worth 10 points',0
len3:   dw 38
line4:  db '* The clock is ticking ... you have',0
len4:   dw 35
line4.1:	db '120 seconds total.', 0
len4.1:	dw 18
line4.2: db '* Choose your challenge wisely!',0
len4.2:  dw 30
line5:  db '* Victory for chosen difficulty:',0
len5:   dw 33
line6:  db '- Easy Mode: 150 points to win',0
len6:   dw 31
line7:  db '- Medium Mode: 300 points to win',0
len7:   dw 33
line8:  db '- Hard Mode: 500 points to win',0
len8:   dw 31
line9:  db '* Type fast, stay sharp, and watch',0
len9:   dw 34
line9.1:	db 'the balloons fly!', 0
len9.1:	dw 17
line10: db '* Press ESC during gameplay to pause',0
len10:  dw 37
line11: db '* Can you beat the timer and claim',0
len11:  dw 35
line11.1:	db 'the high score?', 0
len11.1:	dw 15
line11.2: db '* Balloons wont wait - keep typing',0
len11.2:  dw 34
line11.3:	db 'as fast as you can!', 0
len11.3:	dw 19
line12: db '* Good luck and lets get popping!',0
len12:  dw 33
menus_r: db 'MAIN  MENU'
menulen_r: dw 10
;===================================================================================================================================================
; Draw Rules Heading Subroutine
drawRules:	push bp	
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
			mov ax, 0x3EDB
			
			; Drawing R
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
			cld
			pop di
			add di, 160
			stosw
			add di, 158
			stosw
			add di, 158
			stosw
			add di, 158
			stosw
			add di, 6
			stosw
			sub di, 164
			stosw
			
			; Drawing U
			pop di
			add di, 20
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
			sub di, 162
			stosw
			sub di, 162
			stosw
			sub di, 162
			stosw
			sub di, 162
			stosw
			
			; Drawing L
			pop di
			add di, 20
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
			
			; Drawing E
			pop di
			add di, 20
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
			
			; Drawing S
			pop di
			add di, 20
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
			add di, 158
			stosw
			add di, 158
			std
			stosw
			stosw
			stosw
			stosw
			stosw

			pop cx
			pop bx
			pop ax
			pop di
			pop es
			pop bp
			ret 4
;===================================================================================================================================================
; Main rules screen function
rules_screen:
    call clrscr				; Call Common Clear Screen Subroutine
    
    ; Draw border
    mov ax, 0				; bp + 8 (Column)
	push ax
	mov ax, 0				; bp + 6 (Row)		
	push ax
	mov ax, 80				; bp + 4 (Length)
	push ax
    call WhiteHorizontalLine
    
    mov ax, 0				; bp + 8 (Column)
	push ax
	mov ax, 24				; bp + 6 (Row)		
	push ax
	mov ax, 80				; bp + 4 (Length)
	push ax
    call WhiteHorizontalLine
    
    mov ax, 0				; bp + 8 (Column)
	push ax
	mov ax, 0				; bp + 6 (Row)		
	push ax
	mov ax, 25				; bp + 4 (Length)
	push ax
    call WhiteVerticalLine
    
    mov ax, 79				; bp + 8 (Column)
	push ax
	mov ax, 0				; bp + 6 (Row)		
	push ax
	mov ax, 25				; bp + 4 (Length)
	push ax
    call WhiteVerticalLine
    
	; Draw Rules Heading
	mov ax, 17
	push ax
	mov ax, 2
	push ax
	call drawRules
	
	; Draw Divider between Rules
	mov ax, 40				; bp + 8 (Column)
	push ax
	mov ax, 9				; bp + 6 (Row)		
	push ax
	mov ax, 10				; bp + 4 (Length)
	push ax
    call WhiteVerticalLine
    
	; Print '* Welcome to Typing Balloons!'
	mov ax, 0x003F				; bp + 12 (Colour)
	push ax
	mov ax, 2					; bp + 10 (Column)
	push ax
	mov ax, 9					; bp + 8 (Row)
	push ax
	mov ax, line1		; bp + 6 (String)
	push ax
	mov ax, [len1]; bp + 4 (String Length)
	push ax
	call drawText				; Draw Option 1 Text
	
	; Print '* Your mission: pop balloons by'
	mov ax, 0x003F				; bp + 12 (Colour)
	push ax
	mov ax, 2					; bp + 10 (Column)
	push ax
	mov ax, 10					; bp + 8 (Row)
	push ax
	mov ax, line2		; bp + 6 (String)
	push ax
	mov ax, [len2]; bp + 4 (String Length)
	push ax
	call drawText				; Draw Option 1 Text
	
	; Print 'typing the letter inside them.'
	mov ax, 0x003F				; bp + 12 (Colour)
	push ax
	mov ax, 4					; bp + 10 (Column)
	push ax
	mov ax, 11					; bp + 8 (Row)
	push ax
	mov ax, line2.1		; bp + 6 (String)
	push ax
	mov ax, [len2.1]; bp + 4 (String Length)
	push ax
	call drawText				; Draw Option 1 Text
	
	; Print '* Each correct pop is worth 10 points'
	mov ax, 0x003F				; bp + 12 (Colour)
	push ax
	mov ax, 2					; bp + 10 (Column)
	push ax
	mov ax, 12					; bp + 8 (Row)
	push ax
	mov ax, line3		; bp + 6 (String)
	push ax
	mov ax, [len3]; bp + 4 (String Length)
	push ax
	call drawText				; Draw Option 1 Text
	
	; Print '* The clock is ticking ... you have'
	mov ax, 0x003F				; bp + 12 (Colour)
	push ax
	mov ax, 2					; bp + 10 (Column)
	push ax
	mov ax, 13					; bp + 8 (Row)
	push ax
	mov ax, line4		; bp + 6 (String)
	push ax
	mov ax, [len4]; bp + 4 (String Length)
	push ax
	call drawText				; Draw Option 1 Text
	
	; Print '120 seconds total.'
	mov ax, 0x003F				; bp + 12 (Colour)
	push ax
	mov ax, 4					; bp + 10 (Column)
	push ax
	mov ax, 14					; bp + 8 (Row)
	push ax
	mov ax, line4.1		; bp + 6 (String)
	push ax
	mov ax, [len4.1]; bp + 4 (String Length)
	push ax
	call drawText				; Draw Option 1 Text
	
	; Print '* Victory for chosen difficulty:'
	mov ax, 0x003F				; bp + 12 (Colour)
	push ax
	mov ax, 2					; bp + 10 (Column)
	push ax
	mov ax, 15					; bp + 8 (Row)
	push ax
	mov ax, line5		; bp + 6 (String)
	push ax
	mov ax, [len5]; bp + 4 (String Length)
	push ax
	call drawText				; Draw Option 1 Text
	
	; Print '- Easy Mode: 150 points to win'
	mov ax, 0x003E				; bp + 12 (Colour)
	push ax
	mov ax, 7					; bp + 10 (Column)
	push ax
	mov ax, 16					; bp + 8 (Row)
	push ax
	mov ax, line6		; bp + 6 (String)
	push ax
	mov ax, [len6]; bp + 4 (String Length)
	push ax
	call drawText				; Draw Option 1 Text
	
	; Print '- Medium Mode: 300 points to win'
	mov ax, 0x003E				; bp + 12 (Colour)
	push ax
	mov ax, 7					; bp + 10 (Column)
	push ax
	mov ax, 17					; bp + 8 (Row)
	push ax
	mov ax, line7		; bp + 6 (String)
	push ax
	mov ax, [len7]; bp + 4 (String Length)
	push ax
	call drawText				; Draw Option 1 Text
	
	; Print '- Hard Mode: 500 points to win'
	mov ax, 0x003E				; bp + 12 (Colour)
	push ax
	mov ax, 7					; bp + 10 (Column)
	push ax
	mov ax, 18					; bp + 8 (Row)
	push ax
	mov ax, line8		; bp + 6 (String)
	push ax
	mov ax, [len8]; bp + 4 (String Length)
	push ax
	call drawText				; Draw Option 1 Text
	
	; Print '* Type fast, stay sharp, and watch'
	mov ax, 0x003F				; bp + 12 (Colour)
	push ax
	mov ax, 42					; bp + 10 (Column)
	push ax
	mov ax, 9					; bp + 8 (Row)
	push ax
	mov ax, line9		; bp + 6 (String)
	push ax
	mov ax, [len9]; bp + 4 (String Length)
	push ax
	call drawText				; Draw Option 1 Text
	
	; Print 'the balloons fly!'
	mov ax, 0x003F				; bp + 12 (Colour)
	push ax
	mov ax, 44					; bp + 10 (Column)
	push ax
	mov ax, 10					; bp + 8 (Row)
	push ax
	mov ax, line9.1		; bp + 6 (String)
	push ax
	mov ax, [len9.1]; bp + 4 (String Length)
	push ax
	call drawText				; Draw Option 1 Text
	
	; Print '* Press ESC during gameplay to pause'
	mov ax, 0x003F				; bp + 12 (Colour)
	push ax
	mov ax, 42					; bp + 10 (Column)
	push ax
	mov ax, 11					; bp + 8 (Row)
	push ax
	mov ax, line10		; bp + 6 (String)
	push ax
	mov ax, [len10]; bp + 4 (String Length)
	push ax
	call drawText				; Draw Option 1 Text
	
	; Print '* Can you beat the timer and claim'
	mov ax, 0x003F				; bp + 12 (Colour)
	push ax
	mov ax, 42					; bp + 10 (Column)
	push ax
	mov ax, 12 					; bp + 8 (Row)
	push ax
	mov ax, line11		; bp + 6 (String)
	push ax
	mov ax, [len11]; bp + 4 (String Length)
	push ax
	call drawText				; Draw Option 1 Text
	
	; Print 'the high score?'
	mov ax, 0x003F				; bp + 12 (Colour)
	push ax
	mov ax, 44					; bp + 10 (Column)
	push ax
	mov ax, 13 					; bp + 8 (Row)
	push ax
	mov ax, line11.1		; bp + 6 (String)
	push ax
	mov ax, [len11.1]; bp + 4 (String Length)
	push ax
	call drawText				; Draw Option 1 Text
	
	; Print '* Balloons wont wait - keep typing'
	mov ax, 0x003F				; bp + 12 (Colour)
	push ax
	mov ax, 42					; bp + 10 (Column)
	push ax
	mov ax, 14 					; bp + 8 (Row)
	push ax
	mov ax, line11.2		; bp + 6 (String)
	push ax
	mov ax, [len11.2]; bp + 4 (String Length)
	push ax
	call drawText				; Draw Option 1 Text
	
	; Print 'as fast as you can!'
	mov ax, 0x003F				; bp + 12 (Colour)
	push ax
	mov ax, 44					; bp + 10 (Column)
	push ax
	mov ax, 15 					; bp + 8 (Row)
	push ax
	mov ax, line11.3		; bp + 6 (String)
	push ax
	mov ax, [len11.3]; bp + 4 (String Length)
	push ax
	call drawText				; Draw Option 1 Text
	
	; Print '* Good luck and lets get popping!'
	mov ax, 0x003F				; bp + 12 (Colour)
	push ax
	mov ax, 42					; bp + 10 (Column)
	push ax
	mov ax, 16					; bp + 8 (Row)
	push ax
	mov ax, line12		; bp + 6 (String)
	push ax
	mov ax, [len12]; bp + 4 (String Length)
	push ax
	call drawText				; Draw Option 1 Text
		
	; Print Main Menu Text
	mov ax, 0x003F				; bp + 12 (Colour)
	push ax
	mov ax, 35					; bp + 10 (Column)
	push ax
	mov ax, 21					; bp + 8 (Row)
	push ax
	mov ax, menus_r		; bp + 6 (String)
	push ax
	mov ax, [menulen_r]; bp + 4 (String Length)
	push ax
	call drawText				; Draw Option 1 Text
	
	; Print Main Menu Border
	mov ax, 33					; bp + 8 (Column)
	push ax
	mov ax, 20					; bp + 6 (Row)
	push ax
	mov ax, 3					; bp + 4 (Length)
	push ax
	call WhiteVerticalLine		; Draw Left Option 2 Border Line
	
	mov ax, 46					; bp + 8 (Column)
	push ax
	mov ax, 20					; bp + 6 (Row)	
	push ax
	mov ax, 3					; bp + 4 (Length)
	push ax
	call WhiteVerticalLine		; Draw Right Option 2 Border Line
	
	mov ax, 33					; bp + 8 (Column)
	push ax
	mov ax, 20					; bp + 6 (Row)	
	push ax
	mov ax, 13					; bp + 4 (Length)
	push ax
	call WhiteHorizontalLine    ; Draw Top Option 3 Line
	
	mov ax, 33					; bp + 8 (Column)
	push ax
	mov ax, 22					; bp + 6 (Row)	
	push ax
	mov ax, 13					; bp + 4 (Length)
	push ax
	call WhiteHorizontalLine		; Draw Bottom Option 3 Line
		
    ret
;===================================================================================================================================================