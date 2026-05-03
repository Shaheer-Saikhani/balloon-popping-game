[org 0x0100]
jmp start


; ELEMENTS FOR STARTING SCREEN
title_s:	db 'TYPING BALLOON', 0					; Title String
titleLength_s:	dw 14
play_s:	db 'PRESS [P] TO PLAY', 0				; Play String
playlength_s:	dw 17
difficulty_s:	db 'PRESS [D] FOR DIFFICULTY', 0	; Difficulty String
difficultylength_s: dw 25
leaderboard_s: db 'PRESS [L] FOR LEADERBOARD', 0	; leaderboard String
leaderboardlength_s: dw 26
select_s:	db '>', 0								; Select String
selectlength_s:	dw 1
quit_s:	db 'PRESS [Q] TO QUIT', 0				; Quit String
quitlength_s:	dw 17
;============================================================================================================================================================================

;ELEMENTS FOR DIFFICULTY SCREEN
title_d:	db 'DIFFICULTY', 0					; Title String
titleLength_d:	dw 10
easytext_d:	db 'PRESS [E] FOR EASY', 0				; Play String
easytextlength_d:	dw 18
mediumtext_d:	db 'PRESS [M] FOR MEDIUM', 0	; Difficulty String
mediumtextlength_d: dw 20
hardtext_d:	db 'PRESS [H] FOR HARD', 0
hardtextlength_d:	dw 19
select_d:	db '>', 0								; Select String
selectlength_d:	dw 1
;============================================================================================================================================================================

;ELEMENTS FOR GAMEPLAY SCREEN
title_g:	db 'TYPING BALLOON', 0						; Title String
titleLength_g:	dw 14
score_g:	db 'SCORE: 155', 0							; Score String
scoreLength_g:	dw 11
timer_g:	db 'TIMER:   s', 0							; Timer String
timerLength_g:	dw 10
level_g:	db 'LEVEL: MEDIUM', 0
levellength_g:	dw 13
pausedtitle_g:	db 'GAME PAUSED!', 0					; Paused String
pausedlength_g:	dw 12
resumetext_g:	db 'PRESS [R] TO RESUME', 0
resumetextlength_g:	dw 19
settingstext_g:	db 'PRESS [S] FOR SETTINGS', 0
settingstextlength_g:	dw 22
quittext_g:	db 'PRESS [Q] TO QUIT', 0
quittextlength_g:	dw 17
select_g:	db '>', 0								    ; Select String
selectlength_g:	dw 1

;============================================================================================================================================================================
; INT for Keyboard
oldisr: dd 0


;=============================================================================================================================================================================
;ELEMENTS FOR OVER SCREEN
gameover_o:	db 'GAME OVER', 0					; Game Over String
overlength_o:	dw 9
score_o:	db 'FINAL SCORE: 155', 0				; Score String
scorelength_o:	dw 16
restart_o:	db 'PRESS [R] TO RESTART', 0		; Restart String
restartlength_o:	dw 20
quit_o:	db 'PRESS [Q] TO QUIT', 0				; Quit String
quitlength_o:	dw 17
mainmenu_o:	db 'PRESS [M] FOR MAIN MENU', 0		; Main Menu String
menulength_o:	dw 23
select_o:	db '>', 0								; Select String
selectlength_o:	dw 1
;==============================================================================================================================================================================


; Start Screen	
start_screen:

		mov ax, 20				; bp + 8 (Column)
		push ax
		mov ax, 0				; bp + 6 (Row)	
		push ax
		mov ax, 40				; bp + 4 (Length)
		push ax
		call drawHorizontalLine	; Draw Top Title Line
		
		mov ax, 20				; bp + 8 (Column)
		push ax
		mov ax, 1				; bp + 6 (Row)	
		push ax
		mov ax, 10				; bp + 4 (Length)
		push ax
		call drawHorizontalLine	; Draw Left Half Middle Title Line
		
		mov ax, 50				; bp + 8 (Column)
		push ax
		mov ax, 1				; bp + 6 (Row)		
		push ax
		mov ax, 10				; bp + 4 (Length)
		push ax
		call drawHorizontalLine	; Draw Right Half Middle Title Line
		
		mov ax, 20				; bp + 8 (Column)
		push ax	
		mov ax, 2				; bp + 6  (Row)	
		push ax
		mov ax, 40				; bp + 4 (Length)
		push ax
		call drawHorizontalLine	; Draw Bottom Title Line
		
		mov ax, 0x000B			; bp + 12 (Colour)
		push ax
		mov ax, 33				; bp + 10 (Column)
		push ax
		mov ax, 1				; bp + 8 (Row)
		push ax
		mov ax, title_s			; bp + 6 (String)
		push ax
		mov ax, [titleLength_s]	; bp + 4 (String Length)
		push ax
		call drawText			; Draw Title Text
		
		mov ax, 25				; bp + 8 (Column)
		push ax
		mov ax, 7				; bp + 6 (Row)		
		push ax
		mov ax, 30				; bp + 4 (Length)
		push ax
		call drawHorizontalLine	; Draw Top Option 1 Line
		
		mov ax, 25				; bp + 8 (Column)
		push ax
		mov ax, 9				; bp + 6 (Row)		
		push ax
		mov ax, 30				; bp + 4 (Length)
		push ax
		call drawHorizontalLine	; Draw Bottom Option 1 Line
		
		mov ax, 0x0089			; bp + 12 (Colour)
		push ax
		mov ax, 32				; bp + 10 (Column)
		push ax
		mov ax, 8				; bp + 8 (Row)
		push ax
		mov ax, play_s			; bp + 6 (String)
		push ax
		mov ax, [playlength_s]	; bp + 4 (String Length)
		push ax
		call drawText			; Draw Option 1 Text
		
		mov ax, 0x0009			; bp + 12 (Colour)
		push ax
		mov ax, 23				; bp + 10 (Column)
		push ax
		mov ax, 8				; bp + 8 (Row)
		push ax
		mov ax, select_s		; bp + 6 (String)
		push ax
		mov ax, [selectlength_s]	; bp + 4 (String Length)
		push ax
		call drawText			; Draw Select Option 1 Text
		
		mov ax, 25					; bp + 8 (Column)
		push ax
		mov ax, 7					; bp + 6 (Row)
		push ax
		mov ax, 3					; bp + 4 (Length)
		push ax
		call drawVerticalLine		; Draw Left Option 1 Border Line
		
		mov ax, 55					; bp + 8 (Column)
		push ax
		mov ax, 7					; bp + 6 (Row)
		push ax
		mov ax, 3					; bp + 4 (Length)
		push ax
		call drawVerticalLine		; Draw Right Option 1 Border Line
		
		mov ax, 25				; bp + 8 (Column)
		push ax
		mov ax, 11				; bp + 6 (Row)		
		push ax
		mov ax, 30				; bp + 4 (Length)
		push ax
		call drawHorizontalLine	; Draw Top Option 2 Line
		
		mov ax, 25				; bp + 8 (Column)
		push ax
		mov ax, 13				; bp + 6 (Row)		
		push ax
		mov ax, 30				; bp + 4 (Length)
		push ax
		call drawHorizontalLine	; Draw Bottom Option 2 Line
		
		mov ax, 0x000C				; bp + 12 (Colour)
		push ax
		mov ax, 28					; bp + 10 (Column)
		push ax
		mov ax, 12					; bp + 8 (Row)
		push ax
		mov ax, difficulty_s			; bp + 6 (String)
		push ax
		mov ax, [difficultylength_s]	; bp + 4 (String Length)
		push ax
		call drawText				; Draw Option 2 Text
		
		mov ax, 25					; bp + 8 (Column)
		push ax
		mov ax, 11					; bp + 6 (Row)
		push ax
		mov ax, 3					; bp + 4 (Length)
		push ax
		call drawVerticalLine		; Draw Left Option 2 Border Line
		
		mov ax, 55					; bp + 8 (Column)
		push ax
		mov ax, 11					; bp + 6 (Row)
		push ax
		mov ax, 3					; bp + 4 (Length)
		push ax
		call drawVerticalLine		; Draw Right Option 2 Border Line
		
		mov ax, 25					; bp + 8 (Column)
		push ax
		mov ax, 15					; bp + 6 (Row)		
		push ax
		mov ax, 30					; bp + 4 (Length)
		push ax
		call drawHorizontalLine		; Draw Top Option 3 Line
		
		mov ax, 25					; bp + 8 (Column)
		push ax
		mov ax, 17					; bp + 6 (Row)		
		push ax
		mov ax, 30					; bp + 4 (Length)
		push ax
		call drawHorizontalLine		; Draw Bottom Option 3 Line
		
		mov ax, 0x000E				; bp + 12 (Colour)
		push ax
		mov ax, 28					; bp + 10 (Column)
		push ax
		mov ax, 16					; bp + 8 (Row)
		push ax
		mov ax, quit_s			; bp + 6 (String)
		push ax
		mov ax, [quitlength_s]	; bp + 4 (String Length)
		push ax
		call drawText				; Draw Option 3 Text
		
		mov ax, 25					; bp + 8 (Column)
		push ax
		mov ax, 15					; bp + 6 (Row)
		push ax
		mov ax, 3					; bp + 4 (Length)
		push ax
		call drawVerticalLine		; Draw Left Option 3 Border Line
		
		mov ax, 55					; bp + 8 (Column)
		push ax
		mov ax, 15					; bp + 6 (Row)
		push ax
		mov ax, 3					; bp + 4 (Length)
		push ax
		call drawVerticalLine		; Draw Right Option 3 Border Line
		
		mov ax, 3 					; bp + 10 (Row)
		push ax
		mov ax, 3					; bp + 8 (Column)
		push ax
		mov ax, 0x6020				; bp + 6 (Colour)
		push ax
	    mov ax,0x6752				; bp + 4 (Letter with Attribute)
		push ax
		call Balloon				; Draw Balloon
		mov bx,5
		
		mov ax,10 					; bp + 10 (Row)
		push ax
		mov ax,15 					; bp + 8 (Column)
		push ax
		mov ax,0x4020				; bp + 6 (Colour)
		push ax
		mov ax,0x4741				; bp + 4 (Letter with Attribute)
		push ax
		call Balloon				; Draw Balloon
		
		mov ax, 17					; bp + 10 (Row)
		push ax
		mov ax, 5					; bp + 8 (Column)
		push ax
		mov ax, 0x2020				; bp + 6 (Colour)
		push ax
	    mov ax,0x2749				; bp + 4 (Letter with Attribute)
		push ax
		call Balloon				; Draw Balloon
			
		mov ax, 20					; bp + 10 (Row)
		push ax
		mov ax, 28					; bp + 8 (Column)
		push ax
		mov ax, 0x1020				; bp + 6 (Colour)
		push ax
	    mov ax,0x1746				; bp + 4 (Letter with Attribute)
		push ax
		call Balloon				; Draw Balloon
		
		mov ax, 19					; bp + 10 (Row)
		push ax
		mov ax, 51					; bp + 8 (Column)
		push ax
		mov ax, 0x6020				; bp + 6 (Colour)
		push ax
	    mov ax,0x6743				; bp + 4 (Letter with Attribute)
		push ax
		call Balloon				; Draw Balloon	
		
		mov ax, 16					; bp + 10 (Row)
		push ax
		mov ax, 65					; bp + 8 (Column)
		push ax
		mov ax, 0x5020				; bp + 6 (Colour)
		push ax
	    mov ax,0x5759				; bp + 4 (Letter with Attribute)
		push ax
		call Balloon				; Draw Balloon
		
		mov ax, 9					; bp + 10 (Row)
		push ax
		mov ax, 75					; bp + 8 (Column)
		push ax
		mov ax, 0x3020				; bp + 6 (Colour)
		push ax
	    mov ax,0x3754				; bp + 4 (Letter with Attribute)
		push ax
		call Balloon				; Draw Balloon
		
		mov ax, 4					; bp + 10 (Row)
		push ax
		mov ax, 60					; bp + 8 (Column)
		push ax
		mov ax, 0x5020				; bp + 6 (Colour)
		push ax
	    mov ax,0x5750				; bp + 4 (Letter with Attribute)
		push ax
		call Balloon				; Draw Balloon		
			
ret	
			
;================================================================================================================================================================================	

; Difficulty SCREEN
difficulty_screen:
		
		mov ax, 20				; bp + 8 (Column)
		push ax
		mov ax, 0				; bp + 6 (Row)	
		push ax
		mov ax, 40				; bp + 4 (Length)
		push ax
		call drawHorizontalLine	; Draw Top Title Line
		
		mov ax, 20				; bp + 8 (Column)
		push ax
		mov ax, 1				; bp + 6 (Row)	
		push ax
		mov ax, 10				; bp + 4 (Length)
		push ax
		call drawHorizontalLine	; Draw Left Half Middle Title Line
		
		mov ax, 50				; bp + 8 (Column)
		push ax
		mov ax, 1				; bp + 6 (Row)		
		push ax
		mov ax, 10				; bp + 4 (Length)
		push ax
		call drawHorizontalLine	; Draw Right Half Middle Title Line
		
		mov ax, 20				; bp + 8 (Column)
		push ax	
		mov ax, 2				; bp + 6  (Row)	
		push ax
		mov ax, 40				; bp + 4 (Length)
		push ax
		call drawHorizontalLine	; Draw Bottom Title Line
		
		mov ax, 0x000B			; bp + 12 (Colour)
		push ax
		mov ax, 35				; bp + 10 (Column)
		push ax
		mov ax, 1				; bp + 8 (Row)
		push ax
		mov ax, title_d			; bp + 6 (String)
		push ax
		mov ax, [titleLength_d]	; bp + 4 (String Length)
		push ax
		call drawText			; Draw Title Text
		
		mov ax, 25				; bp + 8 (Column)
		push ax
		mov ax, 7				; bp + 6 (Row)		
		push ax
		mov ax, 30				; bp + 4 (Length)
		push ax
		call drawHorizontalLine	; Draw Top Option 1 Line
		
		mov ax, 25				; bp + 8 (Column)
		push ax
		mov ax, 9				; bp + 6 (Row)		
		push ax
		mov ax, 30				; bp + 4 (Length)
		push ax
		call drawHorizontalLine	; Draw Bottom Option 1 Line
		
		mov ax, 0x0089			; bp + 12 (Colour)
		push ax
		mov ax, 32				; bp + 10 (Column)
		push ax
		mov ax, 8				; bp + 8 (Row)
		push ax
		mov ax, easytext_d			; bp + 6 (String)
		push ax
		mov ax, [easytextlength_d]	; bp + 4 (String Length)
		push ax
		call drawText			; Draw Option 1 Text
		
		mov ax, 0x0009			; bp + 12 (Colour)
		push ax
		mov ax, 23				; bp + 10 (Column)
		push ax
		mov ax, 8				; bp + 8 (Row)
		push ax
		mov ax, select_d			; bp + 6 (String)
		push ax
		mov ax, [selectlength_d]	; bp + 4 (String Length)
		push ax
		call drawText			; Draw Select Option 1 Text
		
		mov ax, 25					; bp + 8 (Column)
		push ax
		mov ax, 7					; bp + 6 (Row)
		push ax
		mov ax, 3					; bp + 4 (Length)
		push ax
		call drawVerticalLine		; Draw Left Option 1 Border Line
		
		mov ax, 55					; bp + 8 (Column)
		push ax
		mov ax, 7					; bp + 6 (Row)
		push ax
		mov ax, 3					; bp + 4 (Length)
		push ax
		call drawVerticalLine		; Draw Right Option 1 Border Line
		
		mov ax, 25				; bp + 8 (Column)
		push ax
		mov ax, 11				; bp + 6 (Row)		
		push ax
		mov ax, 30				; bp + 4 (Length)
		push ax
		call drawHorizontalLine	; Draw Top Option 2 Line
		
		mov ax, 25				; bp + 8 (Column)
		push ax
		mov ax, 13				; bp + 6 (Row)		
		push ax
		mov ax, 30				; bp + 4 (Length)
		push ax
		call drawHorizontalLine	; Draw Bottom Option 2 Line
		
		mov ax, 0x000E				; bp + 12 (Colour)
		push ax
		mov ax, 30					; bp + 10 (Column)
		push ax
		mov ax, 12					; bp + 8 (Row)
		push ax
		mov ax, mediumtext_d			; bp + 6 (String)
		push ax
		mov ax, [mediumtextlength_d]	; bp + 4 (String Length)
		push ax
		call drawText				; Draw Option 2 Text
		
		mov ax, 25					; bp + 8 (Column)
		push ax
		mov ax, 11					; bp + 6 (Row)
		push ax
		mov ax, 3					; bp + 4 (Length)
		push ax
		call drawVerticalLine		; Draw Left Option 2 Border Line
		
		mov ax, 55					; bp + 8 (Column)
		push ax
		mov ax, 11					; bp + 6 (Row)
		push ax
		mov ax, 3					; bp + 4 (Length)
		push ax
		call drawVerticalLine		; Draw Right Option 2 Border Line
		
		mov ax, 25					; bp + 8 (Column)
		push ax
		mov ax, 15					; bp + 6 (Row)		
		push ax
		mov ax, 30					; bp + 4 (Length)
		push ax
		call drawHorizontalLine		; Draw Top Option 3 Line
		
		mov ax, 25					; bp + 8 (Column)
		push ax
		mov ax, 17					; bp + 6 (Row)		
		push ax
		mov ax, 30					; bp + 4 (Length)
		push ax
		call drawHorizontalLine		; Draw Bottom Option 3 Line
		
		mov ax, 0x000C				; bp + 12 (Colour)
		push ax
		mov ax, 32					; bp + 10 (Column)
		push ax
		mov ax, 16					; bp + 8 (Row)
		push ax
		mov ax, hardtext_d			; bp + 6 (String)
		push ax
		mov ax, [hardtextlength_d]	; bp + 4 (String Length)
		push ax
		call drawText				; Draw Option 3 Text
		
		mov ax, 25					; bp + 8 (Column)
		push ax
		mov ax, 15					; bp + 6 (Row)
		push ax
		mov ax, 3					; bp + 4 (Length)
		push ax
		call drawVerticalLine		; Draw Left Option 3 Border Line
		
		mov ax, 55					; bp + 8 (Column)
		push ax
		mov ax, 15					; bp + 6 (Row)
		push ax
		mov ax, 3					; bp + 4 (Length)
		push ax
		call drawVerticalLine		; Draw Right Option 3 Border Line
		
		mov ax, 3 					; bp + 10 (Row)
		push ax
		mov ax, 3					; bp + 8 (Column)
		push ax
		mov ax, 0x6020				; bp + 6 (Colour)
		push ax
	    mov ax,0x6752				; bp + 4 (Letter with Attribute)
		push ax
		call Balloon				; Draw Balloon
		mov bx,5
		
		mov ax,10 					; bp + 10 (Row)
		push ax
		mov ax,15 					; bp + 8 (Column)
		push ax
		mov ax,0x4020				; bp + 6 (Colour)
		push ax
		mov ax,0x4741				; bp + 4 (Letter with Attribute)
		push ax
		call Balloon				; Draw Balloon
		
		mov ax, 17					; bp + 10 (Row)
		push ax
		mov ax, 5					; bp + 8 (Column)
		push ax
		mov ax, 0x2020				; bp + 6 (Colour)
		push ax
	    mov ax,0x2749				; bp + 4 (Letter with Attribute)
		push ax
		call Balloon				; Draw Balloon
			
		mov ax, 20					; bp + 10 (Row)
		push ax
		mov ax, 28					; bp + 8 (Column)
		push ax
		mov ax, 0x1020				; bp + 6 (Colour)
		push ax
	    mov ax,0x1746				; bp + 4 (Letter with Attribute)
		push ax
		call Balloon				; Draw Balloon
		
		mov ax, 19					; bp + 10 (Row)
		push ax
		mov ax, 51					; bp + 8 (Column)
		push ax
		mov ax, 0x6020				; bp + 6 (Colour)
		push ax
	    mov ax,0x6743				; bp + 4 (Letter with Attribute)
		push ax
		call Balloon				; Draw Balloon	
		
		mov ax, 16					; bp + 10 (Row)
		push ax
		mov ax, 65					; bp + 8 (Column)
		push ax
		mov ax, 0x5020				; bp + 6 (Colour)
		push ax
	    mov ax,0x5759				; bp + 4 (Letter with Attribute)
		push ax
		call Balloon				; Draw Balloon
		
		mov ax, 9					; bp + 10 (Row)
		push ax
		mov ax, 75					; bp + 8 (Column)
		push ax
		mov ax, 0x3020				; bp + 6 (Colour)
		push ax
	    mov ax,0x3754				; bp + 4 (Letter with Attribute)
		push ax
		call Balloon				; Draw Balloon
		
		mov ax, 4					; bp + 10 (Row)
		push ax
		mov ax, 60					; bp + 8 (Column)
		push ax
		mov ax, 0x5020				; bp + 6 (Colour)
		push ax
	    mov ax,0x5750				; bp + 4 (Letter with Attribute)
		push ax
		call Balloon				; Draw Balloon
ret
;================================================================================================================================================================================

; Gameplay Screen 
gameplay_screen:
             
		
		mov ax, 20				; bp + 8 (Column)
		push ax
		mov ax, 0				; bp + 6 (Row)
		push ax
		mov ax, 40				; bp + 4 (Length)
		push ax
		call drawHorizontalLine	; Draw Top Level Line
		
		mov ax, 20				; bp + 8 (Column)
		push ax
		mov ax, 1				; bp + 6 (Row)	
		push ax
		mov ax, 10				; bp + 4 (Length)
		push ax
		call drawHorizontalLine	; Draw Left Half Middle Level Line
		
		mov ax, 50				; bp + 8 (Column)
		push ax
		mov ax, 1				; bp + 6 (Row)		
		push ax
		mov ax, 10				; bp + 4 (Length)	
		push ax
		call drawHorizontalLine	; Draw Right Half Middle Level Line
		
		mov ax, 20				; bp + 8 (Column)
		push ax
		mov ax, 2				; bp + 6 (Row)		
		push ax
		mov ax, 40				; bp + 4 (Length)
		push ax
		call drawHorizontalLine	; Draw Bottom Level Line
		
		mov ax, 0x000B			; bp + 12 (Colour) {Attribute Byte written in lower byte as stored in little endian}
		push ax
		mov ax, 33				; bp + 10 (Column)
		push ax
		mov ax, 1				; bp + 8 (Row)
		push ax
		mov ax, level_g			; bp + 6 (String)
		push ax
		mov ax, [levellength_g]	; bp + 4 (String Length)
		push ax
		call drawText			; Draw Level Text
		
		mov ax, 0x0009			; bp + 12 (Colour)
		push ax
		mov ax, 5				; bp + 10 (Column)
		push ax
		mov ax, 1				; bp + 8 (Row)
		push ax 
		mov ax, score_g			; bp + 6 (String)
		push ax
		mov ax, [scoreLength_g]	; bp + 4 (String Length)
		push ax
		call drawText			; Draw Score Text
		
		mov ax, 1				; bp + 8 (Column)
		push ax
		mov ax, 0				; bp + 6 (Row)	
		push ax
		mov ax, 17				; bp + 4 (Length)
		push ax
		call drawHorizontalLine	; Draw Top Score Line
		
		mov ax, 2				; bp + 8 (Column)
		push ax
		mov ax, 1				; bp + 6 (Row)	
		push ax
		mov ax, 2				; bp + 4 (Length)
		push ax
		call drawHorizontalLine	; Draw Left Half Middle Score Line
		
		mov ax, 16				; bp + 8 (Column)
		push ax
		mov ax, 1				; bp + 6 (Row)	
		push ax
		mov ax, 2				; bp + 4 (Length)
		push ax
		call drawHorizontalLine	; Draw Right Half Middle Score Line
		
		mov ax, 2				; bp + 8 (Column)
		push ax
		mov ax, 2				; bp + 6 (Row)
		push ax
		mov ax, 16				; bp + 4 (Length)
		push ax
		call drawHorizontalLine	; Draw Bottom Score Line
		
		mov ax, 0x0009			; bp + 12 (Colour)
		push ax
		mov ax, 65				; bp + 10 (Column)
		push ax
		mov ax, 1				; bp + 8 (Row)
		push ax
		mov ax, timer_g			; bp + 6 (String)
		push ax
		mov ax, [timerLength_g]	; bp + 4 (String Length)
		push ax
		call drawText			; Draw Timer Text
		
		mov ax, 62				; bp + 8 (Column)
		push ax
		mov ax, 0				; bp + 6 (Row)
		push ax
		mov ax, 17				; bp + 4 (Length)
		push ax
		call drawHorizontalLine	; Draw Top Timer Line
		
		mov ax, 62				; bp + 8 (Column)
		push ax
		mov ax, 1				; bp + 6 (Row)	
		push ax
		mov ax, 2				; bp + 4 (Length)
		push ax
		call drawHorizontalLine	; Draw Left Half Middle Timer Line
		
		mov ax, 76				; bp + 8 (Column)
		push ax
		mov ax, 1				; bp + 6 (Row)	
		push ax
		mov ax, 2				; bp + 4 (Length)
		push ax
		call drawHorizontalLine	; Draw Right Half Middle Timer Line
		
		mov ax, 62				; bp + 8 (Column)
		push ax
		mov ax, 2				; bp + 6 (Row)
		push ax
		mov ax, 16				; bp + 4 (Length)
		push ax
		call drawHorizontalLine	; Draw Bottom Timer Line
		
		mov ax, 0				; bp + 8 (Column)
		push ax
		mov ax, 0				; bp + 6 (Row)	
		push ax
		mov ax, 25				; bp + 4 (Length)
		push ax
		call drawVerticalLine	; Draw Left Outer Border Line
		
		mov ax, 1				; bp + 8 (Column)
		push ax
		mov ax, 24				; bp + 6 (Row)
		push ax
		mov ax, 78				; bp + 4 (Length)
		push ax
		call drawHorizontalLine	; Draw Bottom Outer Border Line
		
		mov ax, 79				; bp + 8 (Column)
		push ax
		mov ax, 0				; bp + 6 (Row)
		push ax
		mov ax, 25				; bp + 4 (Length)
		push ax
		call drawVerticalLine	; Draw Left Outer Border Line
		
		mov ax, 1				; bp + 8 (Column)
		push ax
		mov ax, 2				; bp + 6 (Row)
		push ax
		mov ax, 22				; bp + 4 (Length)
		push ax
		call drawVerticalLine	; Draw Left Inner Border Line
		
		mov ax, 2				; bp + 8 (Column)
		push ax
		mov ax, 23				; bp + 6 (Row)	
		push ax
		mov ax, 76				; bp + 4 (Length)
		push ax
		call drawHorizontalLine	; Draw Bottom Inner Border Line
		
		mov ax, 78				; bp + 8 (Column)
		push ax
		mov ax, 2				; bp + 6 (Row)
		push ax
		mov ax, 22				; bp + 4 (Length)
		push ax
		call drawVerticalLine	; Draw Left Inner Border Line
		
		mov ax,6 				; bp + 10 (Row)
		push ax
		mov ax,17 				; bp + 8 (Column)
		push ax
		mov ax,0x4020			; bp + 6 (Colour)
		push ax
		mov ax,0x4741			; bp + 4 (Letter with Attribute)
		push ax
		call Balloon			; Draw Balloon
		
		mov ax, 10				; bp + 10 (Row)
		push ax
		mov ax, 46				; bp + 8 (Column)
		push ax
		mov ax, 0x2020			; bp + 6 (Colour)
		push ax
	    mov ax,0x2749			; bp + 4 (Letter with Attribute)
		push ax
		call Balloon			; Draw Balloon
		
		mov ax, 14				; bp + 10 (Row)
		push ax
		mov ax, 29				; bp + 8 (Column)
		push ax
		mov ax, 0x1020			; bp + 6 (Colour)
		push ax
	    mov ax,0x1746			; bp + 4 (Letter with Attribute)
		push ax
		call Balloon			; Draw Balloon
		
		mov ax, 18				; bp + 10 (Row)
		push ax
		mov ax, 60				; bp + 8 (Column)
		push ax
		mov ax, 0x6020			; bp + 6 (Colour)
		push ax
	    mov ax,0x6752			; bp + 4 (Letter with Attribute)
		push ax
		call Balloon			; Draw Balloon	
		mov bx,5


ret
;================================================================================================================================================================================


; Resume Screen			
resume_screen:		
            call clrscr	
			mov ax, 20					; bp + 8 (Column)
			push ax
			mov ax, 0					; bp + 6 (Row)
			push ax
			mov ax, 40					; bp + 4 (Length)
			push ax
			call drawHorizontalLine		; Draw Top Title Line
			
			mov ax, 20					; bp + 8 (Column)
			push ax
			mov ax, 1					; bp + 6 (Row)	
			push ax
			mov ax, 10					; bp + 4 (Length)
			push ax
			call drawHorizontalLine		; Draw Left Half Middle Title Line
			
			mov ax, 50					; bp + 8 (Column)
			push ax
			mov ax, 1					; bp + 6 (Row)		
			push ax
			mov ax, 10					; bp + 4 (Length)	
			push ax
			call drawHorizontalLine		; Draw Right Half Middle Title Line
			
			mov ax, 20					; bp + 8 (Column)
			push ax
			mov ax, 2					; bp + 6 (Row)		
			push ax
			mov ax, 40					; bp + 4 (Length)
			push ax
			call drawHorizontalLine		; Draw Bottom Title Line
			
			mov ax, 0x000B				; bp + 12 (Colour) {Attribute Byte written in lower byte as stored in little endian}
			push ax
			mov ax, 33					; bp + 10 (Column)
			push ax
			mov ax, 1					; bp + 8 (Row)
			push ax
			mov ax, title_g				; bp + 6 (String)
			push ax
			mov ax, [titleLength_g]		; bp + 4 (String Length)
			push ax
			call drawText				; Draw Title Text
			
			mov ax, 0x0009				; bp + 12 (Colour)
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
			
			mov ax, 1					; bp + 8 (Column)
			push ax
			mov ax, 0					; bp + 6 (Row)	
			push ax
			mov ax, 17					; bp + 4 (Length)
			push ax
			call drawHorizontalLine		; Draw Top Score Line
			
			mov ax, 2					; bp + 8 (Column)
			push ax		
			mov ax, 1					; bp + 6 (Row)	
			push ax
			mov ax, 2					; bp + 4 (Length)
			push ax
			call drawHorizontalLine		; Draw Left Half Middle Score Line
			
			mov ax, 16					; bp + 8 (Column)
			push ax
			mov ax, 1					; bp + 6 (Row)	
			push ax
			mov ax, 2					; bp + 4 (Length)
			push ax
			call drawHorizontalLine		; Draw Right Half Middle Score Line
			
			mov ax, 2					; bp + 8 (Column)
			push ax
			mov ax, 2					; bp + 6 (Row)
			push ax
			mov ax, 16					; bp + 4 (Length)
			push ax
			call drawHorizontalLine		; Draw Bottom Score Line
			
			mov ax, 0x0009				; bp + 12 (Colour)
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
			
			mov ax, 62					; bp + 8 (Column)
			push ax
			mov ax, 0					; bp + 6 (Row)
			push ax
			mov ax, 17					; bp + 4 (Length)
			push ax
			call drawHorizontalLine		; Draw Top Timer Line
			
			mov ax, 62					; bp + 8 (Column)
			push ax
			mov ax, 1					; bp + 6 (Row)	
			push ax
			mov ax, 2					; bp + 4 (Length)
			push ax
			call drawHorizontalLine		; Draw Left Half Middle Timer Line
			
			mov ax, 76					; bp + 8 (Column)
			push ax
			mov ax, 1					; bp + 6 (Row)	
			push ax
			mov ax, 2					; bp + 4 (Length)
			push ax
			call drawHorizontalLine		; Draw Right Half Middle Timer Line
			
			mov ax, 62					; bp + 8 (Column)
			push ax
			mov ax, 2					; bp + 6 (Row)
			push ax
			mov ax, 16					; bp + 4 (Length)
			push ax
			call drawHorizontalLine		; Draw Bottom Timer Line
			
			mov ax, 0					; bp + 8 (Column)
			push ax
			mov ax, 0					; bp + 6 (Row)	
			push ax
			mov ax, 25					; bp + 4 (Length)
			push ax
			call drawVerticalLine		; Draw Left Outer Border Line
			
			mov ax, 1					; bp + 8 (Column)
			push ax
			mov ax, 24					; bp + 6 (Row)
			push ax
			mov ax, 78					; bp + 4 (Length)
			push ax
			call drawHorizontalLine		; Draw Bottom Outer Border Line
			
			mov ax, 79					; bp + 8 (Column)
			push ax
			mov ax, 0					; bp + 6 (Row)
			push ax
			mov ax, 25					; bp + 4 (Length)
			push ax
			call drawVerticalLine		; Draw Left Outer Border Line
			
			mov ax, 1					; bp + 8 (Column)
			push ax
			mov ax, 2					; bp + 6 (Row)
			push ax
			mov ax, 22					; bp + 4 (Length)
			push ax
			call drawVerticalLine		; Draw Left Inner Border Line
			
			mov ax, 2					; bp + 8 (Column)
			push ax
			mov ax, 23					; bp + 6 (Row)	
			push ax
			mov ax, 76					; bp + 4 (Length)
			push ax
			call drawHorizontalLine		; Draw Bottom Inner Border Line
			
			mov ax, 78					; bp + 8 (Column)
			push ax
			mov ax, 2					; bp + 6 (Row)
			push ax
			mov ax, 22					; bp + 4 (Length)
			push ax
			call drawVerticalLine		; Draw Left Inner Border Line
			
			mov ax, 0x000E				; bp + 12 (Colour)
			push ax
			mov ax, 34					; bp + 10 (Column)
			push ax
			mov ax, 6					; bp + 8 (Row)
			push ax
			mov ax, pausedtitle_g			; bp + 6 (String)
			push ax
			mov ax, [pausedlength_g]		; bp + 4 (String Length)
			push ax
			call drawText				; Draw Game Paused Text
			
			mov ax, 25					; bp + 8 (Column)
			push ax
			mov ax, 10					; bp + 6 (Row)	
			push ax
			mov ax, 30					; bp + 4 (Length)
			push ax
			call drawHorizontalLine		; Draw Top Option 1 Line
			
			mov ax, 25					; bp + 8 (Column)
			push ax
			mov ax, 12					; bp + 6 (Row)	
			push ax
			mov ax, 30					; bp + 4 (Length)
			push ax
			call drawHorizontalLine		; Draw Bottom Option 1 Line
			
			mov ax, 0x008A				; bp + 12 (Colour)
			push ax
			mov ax, 30					; bp + 10 (Column)
			push ax
			mov ax, 11					; bp + 8 (Row)
			push ax
			mov ax, resumetext_g			; bp + 6 (String)
			push ax
			mov ax, [resumetextlength_g]	; bp + 4 (String Length)
			push ax
			call drawText				; Draw Option 1 Text
			
			mov ax, 0x000A				; bp + 12 (Colour)
			push ax
			mov ax, 22					; bp + 10 (Column)
			push ax
			mov ax, 11					; bp + 8 (Row)
			push ax
			mov ax, select_g				; bp + 6 (String)
			push ax
			mov ax, [selectlength_g]		; bp + 4 (String Length)
			push ax
			call drawText				; Draw Select Option 1 Text
			
			mov ax, 24					; bp + 8 (Column)
			push ax
			mov ax, 10					; bp + 6 (Row)	
			push ax
			mov ax, 3					; bp + 4 (Length)
			push ax
			call drawVerticalLine		; Draw Left Option 1 Border Line
			
			mov ax, 55					; bp + 8 (Column)
			push ax
			mov ax, 10					; bp + 6 (Row)	
			push ax
			mov ax, 3					; bp + 4 (Length)
			push ax
			call drawVerticalLine		; Draw Right Option 1 Border Line
			
			mov ax, 25					; bp + 8 (Column)
			push ax
			mov ax, 14					; bp + 6 (Row)	
			push ax
			mov ax, 30					; bp + 4 (Length)
			push ax
			call drawHorizontalLine		; Draw Top Option 2 Line
			
			mov ax, 25					; bp + 8 (Column)
			push ax
			mov ax, 16					; bp + 6 (Row)
			push ax
			mov ax, 30					; bp + 4 (Length)
			push ax
			call drawHorizontalLine		; Draw Bottom Option 2 Line
			
			mov ax, 0x000D				; bp + 12 (Colour)
			push ax
			mov ax, 29					; bp + 10 (Column)
			push ax
			mov ax, 15					; bp + 8 (Row)
			push ax
			mov ax, settingstext_g		; bp + 6 (String)
			push ax
			mov ax, [settingstextlength_g]	; bp + 4 (String Length)
			push ax
			call drawText				; Draw Option 2 Text
			
			mov ax, 24					; bp + 8 (Column)
			push ax
			mov ax, 14					; bp + 6 (Row)
			push ax
			mov ax, 3					; bp + 4 (Length)
			push ax
			call drawVerticalLine		; Draw Left Option 2 Border Line
			
			mov ax, 55					; bp + 8 (Column)
			push ax
			mov ax, 14					; bp + 6 (Row)	
			push ax
			mov ax, 3					; bp + 4 (Length)
			push ax
			call drawVerticalLine		; Draw Right Option 2 Border Line
			
			mov ax, 25					; bp + 8 (Column)
			push ax
			mov ax, 18					; bp + 6 (Row)	
			push ax
			mov ax, 30					; bp + 4 (Length)
			push ax
			call drawHorizontalLine		; Draw Top Option 3 Line
			
			mov ax, 25					; bp + 8 (Column)
			push ax
			mov ax, 20					; bp + 6 (Row)	
			push ax
			mov ax, 30					; bp + 4 (Length)
			push ax
			call drawHorizontalLine		; Draw Bottom Option 3 Line
			
			mov ax, 0x000C				; bp + 12 (Colour)
			push ax
			mov ax, 31					; bp + 10 (Column)
			push ax
			mov ax, 19					; bp + 8 (Row)
			push ax
			mov ax, quittext_g			; bp + 6 (String)
			push ax
			mov ax, [quittextlength_g]	; bp + 4 (String Length)
			push ax
			call drawText				; Draw Option 3 Text
			
			mov ax, 24					; bp + 8 (Column)
			push ax
			mov ax, 18					; bp + 6 (Row)
			push ax
			mov ax, 3					; bp + 4 (Length)
			push ax
			call drawVerticalLine		; Draw Left Option 3 Border Line
			
			mov ax, 55					; bp + 8 (Column)
			push ax
			mov ax, 18					; bp + 6 (Row)
			push ax
			mov ax, 3					; bp + 4 (Length)
			push ax
			call drawVerticalLine		; Draw Right Option 3 Border Line
			
			ret
;================================================================================================================================================================================
			
; Over SCREEN
over_screen:
		mov ax, 20					; bp + 8 (Column)
		push ax
		mov ax, 1					; bp + 6 (Row)
		push ax
		mov ax, 40					; bp + 4 (Length)
		push ax
		call drawHorizontalLine		; Draw Top Title Line
		
		mov ax, 20					; bp + 8 (Column)
		push ax
		mov ax, 2					; bp + 6 (Row) 	
		push ax
		mov ax, 10					; bp + 4 (Length)
		push ax
		call drawHorizontalLine		; Draw Left Half Middle Title Line
		
		mov ax, 50					; bp + 8 (Column)
		push ax
		mov ax, 2					; bp + 6 (Row)	
		push ax 
		mov ax, 10					; bp + 4 (Length)
		push ax
		call drawHorizontalLine		; Draw Right Half Middle Title Line
		
		mov ax, 20					; bp + 8 (Column)
		push ax
		mov ax, 3					; bp + 6 (Row)	
		push ax
		mov ax, 10					; bp + 4 (Length)
		push ax
		call drawHorizontalLine		; Draw Left Half Middle Title Line
		
		mov ax, 50					; bp + 8 (Column)
		push ax
		mov ax, 3					; bp + 6 (Row)	
		push ax
		mov ax, 10					; bp + 4 (Length)
		push ax
		call drawHorizontalLine		; Draw Right Half Middle Title Line
		
		mov ax, 20					; bp + 8 (Column)
		push ax
		mov ax, 4					; bp + 6 (Row)	
		push ax
		mov ax, 10					; bp + 4 (Length)
		push ax
		call drawHorizontalLine		; Draw Left Half Middle Title Line
		
		mov ax, 50					; bp + 8 (Column)
		push ax
		mov ax, 4					; bp + 6 (Row)	
		push ax
		mov ax, 10					; bp + 4 (Length)
		push ax
		call drawHorizontalLine		; Draw Right Half Middle Title Line
		
		mov ax, 20					; bp + 8 (Column)
		push ax
		mov ax, 5					; bp + 6 (Row)	
		push ax
		mov ax, 40					; bp + 4 (Length)
		push ax
		call drawHorizontalLine		; Draw Bottom Title Line
		
		mov ax, 0x0004				; bp + 12 (Colour)
		push ax
		mov ax, 35					; bp + 10 (Column)
		push ax
		mov ax, 3					; bp + 8 (Row)
		push ax
		mov ax, gameover_o		; bp + 6 (String)
		push ax
		mov ax, [overlength_o]		; bp + 4 (String Length)
		push ax
		call drawText				; Draw Game Over Text
		
		mov ax, 22					; bp + 8 (Column)
		push ax
		mov ax, 8					; bp + 6 (Row)	
		push ax
		mov ax, 36					; bp + 4 (Length)
		push ax
		call drawHorizontalLine		; Draw Top Score Line
		
		mov ax, 22					; bp + 8 (Column)
		push ax
		mov ax, 10					; bp + 6 (Row)	
		push ax
		mov ax, 36					; bp + 4 (Length)
		push ax
		call drawHorizontalLine		; Draw Bottom Score Line
		
		mov ax, 0x000E				; bp + 12 (Colour)
		push ax
		mov ax, 32					; bp + 10 (Column)
		push ax
		mov ax, 9					; bp + 8 (Row)
		push ax
		mov ax, score_o				; bp + 6 (String)
		push ax
		mov ax, [scorelength_o]		; bp + 4 (String Length)
		push ax
		call drawText				; Draw Score Text
		
		mov ax, 25					; bp + 8 (Column)
		push ax
		mov ax, 13					; bp + 6 (Row)	
		push ax
		mov ax, 30					; bp + 4 (Length)
		push ax
		call drawHorizontalLine		; Draw Top Option 1 Line
		
		mov ax, 25					; bp + 8 (Column)
		push ax
		mov ax, 15					; bp + 6 (Row)	
		push ax
		mov ax, 30					; bp + 4 (Length)
		push ax
		call drawHorizontalLine		; Draw Bottom Option 1 Line
		
		mov ax, 0x0089				; bp + 12 (Colour)
		push ax
		mov ax, 30					; bp + 10 (Column)
		push ax
		mov ax, 14					; bp + 8 (Row)
		push ax
		mov ax, restart_o				; bp + 6 (String)
		push ax
		mov ax, [restartlength_o]		; bp + 4 (String Length)
		push ax
		call drawText				; Draw Option 1 Text
		
		mov ax, 0x0009			; bp + 12 (Colour)
		push ax
		mov ax, 22				; bp + 10 (Column)
		push ax
		mov ax, 14				; bp + 8 (Row)
		push ax
		mov ax, select_o			; bp + 6 (String)
		push ax
		mov ax, [selectlength_o]	; bp + 4 (String Length)
		push ax
		call drawText			; Draw Select Option 1 Text
		
		mov ax, 24					; bp + 8 (Column)
		push ax
		mov ax, 13					; bp + 6 (Row)	
		push ax
		mov ax, 3					; bp + 4 (Length)
		push ax
		call drawVerticalLine		; Draw Left Option 1 Border Line
		
		mov ax, 55					; bp + 8 (Column)
		push ax
		mov ax, 13					; bp + 6 (Row)	
		push ax
		mov ax, 3					; bp + 4 (Length)
		push ax
		call drawVerticalLine		; Draw Right Option 1 Border Line
		
		mov ax, 25					; bp + 8 (Column)
		push ax
		mov ax, 17					; bp + 6 (Row)	
		push ax
		mov ax, 30					; bp + 4 (Length)
		push ax
		call drawHorizontalLine		; Draw Top Option 2 Line
		
		mov ax, 25					; bp + 8 (Column)
		push ax
		mov ax, 19					; bp + 6 (Row)
		push ax
		mov ax, 30					; bp + 4 (Length)
		push ax
		call drawHorizontalLine		; Draw Bottom Option 2 Line
		
		mov ax, 0x000C				; bp + 12 (Colour)
		push ax
		mov ax, 31					; bp + 10 (Column)
		push ax
		mov ax, 18					; bp + 8 (Row)
		push ax
		mov ax, quit_o				; bp + 6 (String)
		push ax
		mov ax, [quitlength_o]		; bp + 4 (String Length)
		push ax
		call drawText				; Draw Option 2 Text
		
		mov ax, 24					; bp + 8 (Column)
		push ax
		mov ax, 17					; bp + 6 (Row)
		push ax
		mov ax, 3					; bp + 4 (Length)
		push ax
		call drawVerticalLine		; Draw Left Option 2 Border Line
		
		mov ax, 55					; bp + 8 (Column)
		push ax
		mov ax, 17					; bp + 6 (Row)	
		push ax
		mov ax, 3					; bp + 4 (Length)
		push ax
		call drawVerticalLine		; Draw Right Option 2 Border Line
		
		mov ax, 25					; bp + 8 (Column)
		push ax
		mov ax, 21					; bp + 6 (Row)	
		push ax
		mov ax, 30					; bp + 4 (Length)
		push ax
		call drawHorizontalLine		; Draw Top Option 3 Line
		
		mov ax, 25					; bp + 8 xedexrfxsedfxrde(Column)
		push ax
		mov ax, 23					; bp + 6 (Row)	
		push ax
		mov ax, 30					; bp + 4 (Length)
		push ax
		call drawHorizontalLine		; Draw Bottom Option 3 Line
		
		mov ax, 0x000B				; bp + 12 (Colour)
		push ax
		mov ax, 28					; bp + 10 (Column)
		push ax
		mov ax, 22					; bp + 8 (Row)
		push ax
		mov ax, mainmenu_o			; bp + 6 (String)
		push ax
		mov ax, [menulength_o]		; bp + 4 (String Length)
		push ax
		call drawText				; Draw Option 3 Text
		
		mov ax, 24					; bp + 8 (Column)
		push ax
		mov ax, 21					; bp + 6 (Row)
		push ax
		mov ax, 3					; bp + 4 (Length)
		push ax
		call drawVerticalLine		; Draw Left Option 3 Border Line
		
		mov ax, 55					; bp + 8 (Column)
		push ax
		mov ax, 21					; bp + 6 (Row)
		push ax
		mov ax, 3					; bp + 4 (Length)
		push ax
		call drawVerticalLine		; Draw Right Option 3 Border Line

ret
;================================================================================================================================================================================


; Termination for Timer
termination2:
call clrscr
call over_screen
jmp termination
;================================================================================================================================================================================


; Printing the Number
printnum:
			push bp 
			mov bp,sp
			push es
			push ax
			push bx
			push cs
			push dx
			push di
			
			mov ax,0xb800
			mov es,ax
			mov ax,[bp+4]
			mov bx,10
			mov cx,0
			
			
nextdigit:
			mov dx,0
			div bx
			add dl,0x30
			push dx
			inc cx
			cmp ax,0
			
			jnz nextdigit
			
			push ax
			mov al,80
			mul byte[bp+8]
			add ax,[bp+10]
			shl ax,1
			mov di,ax
			pop ax
			
nextpos:
			pop dx
			mov dh,[bp+6]
			mov [es:di],dx
			add di,2
			loop nextpos

			pop di
			pop dx
			pop cx
			pop bx
			pop ax
			pop es
			pop bp
			ret 8
;===================================================================================================================================================================================			
	

; Sleep and Delay
sleep:	push cx				; Sleep Subroutine
		mov cx, 0xFFFF
		
delay:	loop delay			; Delay Loop
		pop cx
		ret
;===================================================================================================================================================================================
	
; Clear Entire Screen Subroutine	
clrscr:
        mov ax, 0xb800							; Set es to video memory		
		mov es, ax
		mov di, 0
	    mov cx,2000	
	    mov ax,0x0020
		cld                                     ; Repeat loop if not
		rep stosw
		ret										; Return
;====================================================================================================================================================================================


; Draw Horizontal Line Subroutine
drawHorizontalLine:	push bp
					mov bp, sp

					mov ax, 0xb800				; Load Video Memory
					mov es, ax
					
					mov ax, [bp + 6]			; Row
					mov bx, 80
					mul bx
					add ax, [bp + 8]			; Column
					shl ax, 1
					mov di, ax
					mov cx, [bp + 4]			; Length
		
HorizontalLineLoop:	mov ax, 0x0F3A				
					mov [es:di], ax				; Print ':'	
					add di, 2
					loop HorizontalLineLoop
				
					pop bp
					ret 6

; Draw Vertical Line Subroutine					
drawVerticalLine:	push bp
					mov bp, sp

					mov ax, 0xb800				; Load Video Memory
					mov es, ax
					
					mov ax, [bp + 6]			; Row
					mov bx, 80
					mul bx
					add ax, [bp + 8]			; Column
					shl ax, 1
					mov di, ax
					mov cx, [bp + 4]			; Length
		
VerticalLineLoop:	mov ax, 0x0F3A	
					mov [es:di], ax				; Print ':'
					add di, 160
					loop VerticalLineLoop
				
					pop bp
					ret 6
;====================================================================================================================================================================================


; Draw Text Subroutine
drawText:	push bp
			mov bp, sp
			push es
			push ax
			push cx
			push si
			push di
			
			mov ax, 0xb800						; Load Video Memory
			mov es, ax
			
			mov ax, [bp + 8]					; Row
			mov bx, 80
			mul bx
			add ax, [bp + 10]					; Column
			shl ax, 1
			mov di, ax
			
			mov si, [bp + 6]					; Point si to string
			mov cx, [bp + 4]					; String Length
			mov ah, [bp + 12]					; Load Attribute byte
				
nextchar:	mov al, [si]						; Load character into al
			mov [es:di], ax						; Print character
			add di, 2
			add si, 1
			loop nextchar
			
			pop di
			pop si
			pop cx
			pop ax
			pop es
			pop bp
			ret 10
;====================================================================================================================================================================================	
	
	
; Draw Balloon Subroutine
Balloon:	push bp
			mov bp, sp
			
			mov ax, 0xb800						; Load Video Memory	
			mov es, ax
			
			mov al, 80
			mul byte [bp+10]					; Row
			add ax, [bp+8]						; Column
			shl ax, 1
			mov di, ax
			mov si, ax
			mov ax, [bp+6]						; Load Balloon Colour
			mov cx, 2 ;3x3
		
row1:		mov [es:di], ax						; Print First Horizontal Row
			add di, 2
			loop row1
			mov cx, 2
	
col3:   	mov [es:di], ax						; Print Third Vertical Column	
			add di, 160
			loop col3
			mov cx, 2
			
col1:		mov [es:si], ax						; Print First Vertical Column
			add si, 160
			loop col1
			mov cx, 3
		
row3:		mov [es:si], ax						; Print Third Horizontal Row
			add si, 2	
			loop row3		

		    sub si, 164
			mov ax, [bp+4]
			mov word [es:si], ax ; 0x0FC5	; Print Letter in Balloon		
			
			
			add si, 320
			mov word[es:si], 0x0Fb3			; Print Balloon String End
			add si, 160
			mov word[es:si], 0x0F60         ; Print Dot

stop:		pop bp
			ret	8
;===================================================================================================================================================
; Labels for Int hook 9
gameplayflag: dw 0
difficultyflag: dw 0
quitflag: dw 0
main_screen_flag: dw 1
in_pause_menu: dw 0         ; 0=gameplay, 1=pause menu
in_game_over: dw 0          ; 0=not in game over, 1=in game over screen
letter_pressed: dw 0        ; Flag for any letter A-Z pressed

;=====================================================================================================================================================================================	
; Labels for Int 8
tickcount: dw 0
subtick: dw 0
timer_paused: dw 0
saved_tickcount: dw 0
saved_subtick: dw 0
timer_active: dw 0
oldisr8: dd 0

;=======================================================================================================================================================================================
; Hooking INT 9			
; --- INT 9 keyboard ISR gate: treat any non-zero as "in game over" ---
kbisr:
    push ax
    push es
    in al,0x60

    ; Check if in game over screen (non-zero)
    cmp word[cs:in_game_over], 0
    jne gameover_controls

    ; If not in game over, check if not in main screen -> gameplay
    cmp word[cs:main_screen_flag], 0
    je gameplay_controls

startscreen_controls:
    ; Only P, D, Q are accepted on start screen
    cmp al,0x19 ; P
    jne .check_d
    mov word[cs:gameplayflag],1
    jmp done
.check_d:
    cmp al,0x20 ; D
    jne .check_q
    mov word[cs:difficultyflag],1
    jmp done
.check_q:
    cmp al,0x10 ; Q
    jne done
    mov word[cs:quitflag],1
    jmp done

gameover_controls:
    ; Only R, M, Q are accepted on game over screen
    cmp al,0x13 ; R
    jne .go_check_q
    mov word[cs:gameplayflag],2    ; restart request
    jmp done
.go_check_q:
    cmp al,0x10 ; Q
    jne .go_check_m
    mov word[cs:quitflag],1
    jmp done
.go_check_m:
    cmp al,0x32 ; M
    jne done
    mov word[cs:main_screen_flag],1
    mov word[cs:in_game_over],0
    mov word[cs:gameplayflag],0
    mov word[cs:timer_active],0
    mov word[cs:difficultyflag],2    ; return to main
    jmp done

gameplay_controls:
    ; Only ESC and A-Z are accepted in gameplay
    cmp word[cs:in_pause_menu], 1
    je pause_menu_controls

    cmp al,0x01  ; ESC key
    jne check_letters
    mov word[cs:timer_paused],1
    mov word[cs:in_pause_menu],1
    ; Save timer
    mov ax,[cs:tickcount]
    mov [cs:saved_tickcount],ax
    mov ax,[cs:subtick]
    mov [cs:saved_subtick],ax
    mov word[cs:gameplayflag],3
    jmp done

check_letters:
    ; Letters A–Z only
    cmp al,0x1E ; A
    je letter_hit
    cmp al,0x30 ; B
    je letter_hit
    cmp al,0x2E ; C
    je letter_hit
    cmp al,0x20 ; D
    je letter_hit
    cmp al,0x12 ; E
    je letter_hit
    cmp al,0x21 ; F
    je letter_hit
    cmp al,0x22 ; G
    je letter_hit
    cmp al,0x23 ; H
    je letter_hit
    cmp al,0x17 ; I
    je letter_hit
    cmp al,0x24 ; J
    je letter_hit
    cmp al,0x25 ; K
    je letter_hit
    cmp al,0x26 ; L
    je letter_hit
    cmp al,0x32 ; M
    je letter_hit
    cmp al,0x31 ; N
    je letter_hit
    cmp al,0x18 ; O
    je letter_hit
    cmp al,0x19 ; P
    je letter_hit
    cmp al,0x10 ; Q
    je letter_hit
    cmp al,0x13 ; R
    je letter_hit
    cmp al,0x1F ; S
    je letter_hit
    cmp al,0x14 ; T
    je letter_hit
    cmp al,0x16 ; U
    je letter_hit
    cmp al,0x2F ; V
    je letter_hit
    cmp al,0x11 ; W
    je letter_hit
    cmp al,0x2D ; X
    je letter_hit
    cmp al,0x15 ; Y
    je letter_hit
    cmp al,0x2C ; Z
    je letter_hit
    jmp done

letter_hit:
    mov word[cs:letter_pressed],1
    jmp done

pause_menu_controls:
    ; Only R, M, Q in pause menu
    cmp al,0x13 ; R for Resume
    jne .pm_check_m
    mov word[cs:gameplayflag],4
    jmp done
.pm_check_m:
    cmp al,0x32 ; M for Main Menu
    jne .pm_check_q
    mov word[cs:main_screen_flag],1
    mov word[cs:in_pause_menu],0
    mov word[cs:timer_active],0
    mov word[cs:difficultyflag],2
    jmp done
.pm_check_q:
    cmp al,0x10 ; Q for Quit
    jne done
    mov word[cs:quitflag],1
    jmp done

done:
    mov al,0x20
    out 0x20,al
    pop es
    pop ax
    iret


;=======================================================================================================================================================================================
            
; Hooking the INT 8			
; --- INT 8 timer: do NOT change, only ensure in_game_over stays 1 until exit ---
timerclock:
    push ax
    push bx

    cmp word [cs:timer_active], 0
    je .chain_old

    cmp word [cs:timer_paused], 1
    je .chain_old

    inc word [cs:subtick]
    mov ax, [cs:subtick]
    cmp ax, 18
    jne .display
    mov word [cs:subtick], 0
    inc word [cs:tickcount]

.display:
    ; Draw seconds at row=1 col=72
    push ax
    mov ax, 72
    push ax
    mov ax, 1
    push ax
    mov ax, 0x0009
    push ax
    push word [cs:tickcount]
    call printnum
    pop ax

    ; End condition (5 seconds for test)
    cmp word [cs:tickcount], 5
    jae .stop_timer
    jmp .chain_old

.stop_timer:
    mov word [cs:timer_active], 0
    mov word [cs:in_game_over], 1    ; keep 1, not 2
    mov word [cs:in_pause_menu], 0
    mov word [cs:main_screen_flag], 0

.chain_old:
    pop bx
    pop ax
    jmp far [cs:oldisr8]
	
;===================================================================================================================================================================================	

; =========================
; PROGRAM ENTRY POINT
; =========================
start:
    call clrscr
    call start_screen

    ; Save original INT 8
    mov ax, 0
    mov es, ax
    mov ax, [es:8*4]
    mov word [oldisr8], ax
    mov ax, [es:8*4+2]
    mov word [oldisr8+2], ax

    ; Hook INT 8 (timer)
    cli
    mov word [es:8*4], timerclock
    mov [es:8*4+2], cs
    sti

    ; Hook INT 9 (keyboard)
    mov ax, [es:9*4]
    cli
    mov word [es:9*4], kbisr
    mov [es:9*4+2], cs
    sti

; =========================
; MAIN LOOP
; =========================
mainLoop:
    cmp word[in_game_over], 1
    je show_game_over

    cmp word[main_screen_flag],0
    je check_gameplay_state

    cmp word[difficultyflag], 2
    je return_to_main

    cmp word[difficultyflag],1
    je show_difficulty

    cmp word[gameplayflag],1
    je start_gameplay

    cmp word[quitflag],1
    je do_quit

    jmp mainLoop

; =========================
; HANDLERS
; =========================

show_game_over:
    call clrscr
    call over_screen
    mov word[in_game_over], 2   ; mark as shown
    jmp mainLoop

return_to_main:
    call clrscr
    call start_screen
    mov word[difficultyflag], 0
    mov word[in_game_over], 0
    mov word[in_pause_menu], 0
    mov word[gameplayflag], 0
    mov word[timer_active], 0
    jmp mainLoop

show_difficulty:
    call clrscr
    call difficulty_screen
    mov word[difficultyflag],0
    jmp mainLoop

start_gameplay:
    call clrscr
    call gameplay_screen
    mov word[timer_active], 1
    mov word[timer_paused], 0
    mov word[tickcount], 0
    mov word[subtick], 0
    mov word[gameplayflag], 0
    mov word[main_screen_flag], 0
    mov word[in_pause_menu], 0
    mov word[in_game_over], 0
    jmp mainLoop

do_quit:
    call clrscr
    jmp termination

check_gameplay_state:
    cmp word[gameplayflag], 2
    je restart_game
    cmp word[gameplayflag], 3
    je show_pause_menu
    cmp word[gameplayflag], 4
    je resume_from_pause
    cmp word[letter_pressed], 1
    je handle_letter_press
    cmp word[quitflag], 1
    je do_quit
    jmp mainLoop

restart_game:
    call clrscr
    mov word[tickcount], 0
    mov word[subtick], 0
    mov word[timer_active], 1
    mov word[timer_paused], 0
    mov word[in_game_over], 0
    mov word[in_pause_menu], 0
    mov word[main_screen_flag], 0
    mov word[gameplayflag], 0
    call gameplay_screen
    jmp mainLoop

show_pause_menu:
    call clrscr
    call resume_screen
    mov word[gameplayflag], 0
    jmp mainLoop

resume_from_pause:
    mov ax, [saved_tickcount]
    mov [tickcount], ax
    mov ax, [saved_subtick]
    mov [subtick], ax
    mov word[timer_paused], 0
    mov word[in_pause_menu], 0
    mov word[gameplayflag], 0
    call clrscr
    call gameplay_screen
    jmp mainLoop

handle_letter_press:
    call clrscr
    call gameplay_screen
    mov word[letter_pressed], 0
    jmp mainLoop

termination:
    push ax
    push es
    mov ax, 0
    mov es, ax
    cli
    mov ax, word [oldisr8]
    mov [es:8*4], ax
    mov ax, word [oldisr8+2]
    mov [es:8*4+2], ax
    sti
    pop es
    pop ax

    mov ax, 0x4c00
    int 0x21
