;ELEMENTS FOR GAMEPLAY SCREEN
title_g:	db 'TYPING BALLOON', 0						
titleLength_g:	dw 14
score_g:	db 'SCORE:    ', 0							
scoreLength_g:	dw 11
timer_g:	db 'TIMER:   s', 0							
timerLength_g:	dw 10
level_easy_g:	db 'LEVEL: EASY', 0
levellength_easy_g:	dw 11
level_med_g:	db 'LEVEL: MEDIUM', 0
levellength_med_g:	dw 13
level_hard_g:	db 'LEVEL: HARD', 0
levellength_hard_g:	dw 11
pausedtitle_g:	db 'GAME PAUSED!', 0				
pausedlength_g:	dw 12
resumetext_g:	db 'PRESS [R] TO RESUME', 0
resumetextlength_g:	dw 19
settingstext_g:	db 'PRESS [S] FOR SETTINGS', 0
settingstextlength_g:	dw 22
quittext_g:	db 'PRESS [Q] TO QUIT', 0
quittextlength_g:	dw 17

;===================================================================================================================================================	
; Delay 		
DelayBalloon:
			mov cx, 5		
Delayloop:
			call check_letter_during_game
			call sleep
			loop Delayloop
			ret
	
;===================================================================================================================================================
random_seed: dd 1 	
; Rondom Function(Number and Letter)     
init_random:
			push ax
			push cx
			push dx
			
			mov ah, 0
			int 1Ah            
			
			mov word [random_seed], dx
			mov word [random_seed+2], cx

			cmp word [random_seed], 0
			jne .seed_ok
			cmp word [random_seed+2], 0
			jne .seed_ok
			mov word [random_seed], 1
    
.seed_ok:
			pop dx
			pop cx
			pop ax
			ret

next_random:
			push bx
			push cx
			push dx
			push si
			push di

			mov ax, word [random_seed]     
			mov dx, word [random_seed+2]   

			mov bx, 0x4E6D  
			mov cx, 0x41C6   

			push ax

			mul bx            
			mov di, ax         
			mov si, dx        

			pop ax
			push ax
			mov ax, word [random_seed+2]
			mul bx
			add si, ax

			pop ax
			mul cx
			add si, ax

			mov ax, di
			mov dx, si

			add ax, 0x3039
			adc dx, 0

			mov word [random_seed], ax
			mov word [random_seed+2], dx

			mov ax, dx

			pop di
			pop si
			pop dx
			pop cx
			pop bx
			ret

randomLetter:
			push dx
			push bx
			
			call next_random       
			
			xor dx, dx
			mov bx, 26
			div bx                
			
			mov al, dl
			add al, 'A'            
			
			pop bx
			pop dx
			ret

;====================================================================
; Random Number Generator (column) 
randomNumber:
			push dx
			push bx
			
			call next_random    
			
			xor dx, dx
			mov bx, 64           
			div bx             
			
			mov ax, dx
			add ax, 7            ; base candidate

			; Bounds between 5 and 75
			cmp ax, 5
			jge .no_low_clamp
			mov ax, 5
.no_low_clamp:
			cmp ax, 75
			jle .no_high_clamp
			mov ax, 75
.no_high_clamp:
			; 3-column grid: col = 5 + 3*k
			sub ax, 5
			mov bx, 3
			xor dx, dx
			div bx            ; AX = k, DX = remainder
			mul bx            ; AX = 3*k
			add ax, 5         ; AX = snapped col

			; AX now holds safe column
			pop bx
			pop dx
			ret
;==================================================================================================================================================='
; Clearing the row 
clearRow:
			push bp
			mov bp, sp
			push es
			push di
			push ax
			push bx
			push cx
			
			mov ax, 0xb800
			mov es, ax
			
			mov ax, [bp + 6]				
			mov bx, 80
			mul bx
			add ax, [bp + 8]			
			shl ax, 1
			mov di, ax
			mov cx, [bp + 4]
			
			mov ax, 0x3720
			cld
			
clearLoop:	stosw
			loop clearLoop
			
			pop cx
			pop bx
			pop ax
			pop di
			pop es
			pop bp
			ret 6
;===================================================================================================================================================
; ANIMATED BALLOON CREATION ELEMENTS
temp_final_row: dw 0
temp_final_col: dw 0
temp_current_row: dw 0
temp_color: dw 0
temp_letter: db 0
temp_letter_attr: dw 0
;===================================================================================================================================================
; ANIMATED BALLOON CREATION 
balloon:	push bp
			mov bp, sp
			push es
			push ax
			push bx
			push cx
			push dx
			push si
			push di
			
			mov ax, [bp+10]
			mov [cs:temp_final_row], ax 
			mov ax, [bp+8]
			mov [cs:temp_final_col], ax
			mov ax, [bp+6]
			mov [cs:temp_color], ax
			
			call randomLetter
			mov byte [cs:temp_letter], al
			mov ah, [bp + 5]
			mov [cs:temp_letter_attr], ax

			mov word [cs:temp_current_row], 21
			
.rise_loop:
			mov ax, [cs:temp_current_row]
			cmp ax, [cs:temp_final_row]
			jle .done_rising 
			
			push word [cs:temp_current_row]
			push word [cs:temp_final_col]
			push word [cs:temp_color]
			push word [cs:temp_letter_attr]
			call draw_balloon_frame
			
			call redraw_game_borders
			
			mov cx, 4
.delay:		call sleep
			loop .delay
			
			mov ax, [cs:temp_current_row]
			dec ax 
			cmp ax, [cs:temp_final_row]
			je .skip_clear 
			
			push word [cs:temp_current_row]
			push word [cs:temp_final_col]
			call clear_balloon_frame
			
.skip_clear:
			; Move up one row
			dec word [cs:temp_current_row]
			
			; Check if we should continue
			cmp word [cs:timer_active], 0
			je .abort_rise
			cmp word [cs:timer_paused], 1
			je .abort_rise
			cmp word [cs:in_pause_menu], 1
			je .abort_rise
			
			jmp .rise_loop

.done_rising:
			; Draw final position
			push word [cs:temp_final_row]
			push word [cs:temp_final_col]
			push word [cs:temp_color]
			push word [cs:temp_letter_attr]
			call draw_balloon_frame
			
			; Redraw borders once more
			call redraw_game_borders
			
			; Save to balloon data array
			mov bx, [cs:balloon_count]
			mov cx, bx
			shl bx, 1
			shl cx, 1
			shl cx, 1
			shl cx, 1
			add bx, cx        ; bx = count*10
			
			mov ax, [cs:temp_final_row]
			mov [cs:balloon_data + bx], ax
			add bx, 2
			
			mov ax, [cs:temp_final_col]
			mov [cs:balloon_data + bx], ax
			add bx, 2
			
			mov al, byte [cs:temp_letter]
			mov [cs:balloon_data + bx], al
			add bx, 2
			
			mov ax, [cs:temp_color]
			mov [cs:balloon_data + bx], ax
			add bx, 2
			
			mov word [cs:balloon_data + bx], 1  ; Active flag
			inc word [cs:balloon_count]

.abort_rise:
			pop di
			pop si
			pop dx
			pop cx
			pop bx
			pop ax
			pop es
			pop bp
			ret 8
;===================================================================================================================================================
; DRAW SINGLE FRAME OF BALLOON
draw_balloon_frame:
			push bp
			mov  bp, sp
			push es
			push di
			push si
			push ax
			push bx
			push cx
			push dx

			mov  ax, 0xb800
			mov  es, ax

			; Calculate starting offset
			mov  al, 80
			mul  byte [bp+10]       ; row
			add  ax, [bp+8]         ; column
			shl  ax, 1
			mov  di, ax             ; top-right corner
			mov  si, ax             ; top-left corner

			; Draw top row
			mov  ax, [bp+6]         ; color
			mov  cx, 2
.row_top:
			mov  [es:di], ax
			add  di, 2
			loop .row_top

			; Draw right column
			mov  cx, 2
.col_right:
			mov  [es:di], ax
			add  di, 160
			loop .col_right

			; Draw left column
			mov  cx, 2
.col_left:
			mov  [es:si], ax
			add  si, 160
			loop .col_left

			; Draw bottom row
			mov  cx, 3
.row_bottom:
			mov  [es:si], ax
			add  si, 2
			loop .row_bottom

			; Move to center for letter
			sub  si, 164
			mov  ax, [bp+4]         ; letter with attribute
			mov  [es:si], ax

			; Move to string position
			add  si, 320
			mov  word [es:si], 0x3FB3       ; vertical string with color

			; Clear left and right of string
			mov  word [es:si-2], 0x3f20     ; left of string: space, no color
			mov  word [es:si+2], 0x3f20     ; right of string: space, no color

			; Move to hook position
			add  si, 160
			mov  word [es:si], 0x3F60       ; hook (dot) with color

			;Clear left and right of hook
			mov  word [es:si-2], 0x3f20     ; left of hook: space, no color
			mov  word [es:si+2], 0x3f20     ; right of hook: space, no color

			; Restore
			pop  dx
			pop  cx
			pop  bx
			pop  ax
			pop  si
			pop  di
			pop  es
			pop  bp
			ret 8

;===================================================================================================================================================
clear_balloon_frame:
			push bp
			mov bp, sp
			push es
			push di
			push ax
			push bx
			push cx
			
			mov ax, 0xb800
			mov es, ax
			
			; Calculate base offset
			mov al, 80
			mul byte [bp+6]       ; row
			add ax, [bp+4]        ; column
			shl ax, 1
			mov di, ax
			
			mov ax, 0x3720  ; blank space
			
			; Clear row 0 (3 chars)
			mov cx, 3
.clear_row0:
			stosw
			loop .clear_row0
			
			; Clear row 1 (3 chars)
			sub di, 6
			add di, 160
			mov cx, 3
.clear_row1:
			stosw
			loop .clear_row1
			
			; Clear row 2 (3 chars)
			sub di, 6
			add di, 160
			mov cx, 3
.clear_row2:
			stosw
			loop .clear_row2
			
			; Clear string (row+3, col+1)
			mov al, 80
			mul byte [bp+6]
			add ax, [bp+4]
			shl ax, 1
			mov di, ax
			add di, 482          ; +3 rows (+480) +1 col (+2)
			mov word [es:di], 0x3720
			
			; Clear dot (row+4, col+1)
			add di, 160
			mov word [es:di], 0x3720
			
			pop cx
			pop bx
			pop ax
			pop di
			pop es
			pop bp
			ret 4

;===================================================================================================================================================
; REDRAW GAME BORDERS
redraw_game_borders:
		push ax
		push bp
		
		; Bottom playfield border
		mov ax, 0
		push ax
		mov ax, 23
		push ax
		mov ax, 80
		push ax
		call WhiteHorizontalLine
		
		; Left outer border
		mov ax, 0
		push ax
		mov ax, 0
		push ax
		mov ax, 25
		push ax
		call WhiteVerticalLine
		
		; Right outer border
		mov ax, 79
		push ax
		mov ax, 0
		push ax
		mov ax, 25
		push ax
		call WhiteVerticalLine
		
		; Bottom outer border
		mov ax, 0				; Start from column 0
		push ax
		mov ax, 24
		push ax
		mov ax, 80				; Full width
		push ax
		call WhiteHorizontalLine
		
		; Top separator (below score/timer/level)
		mov ax, 0
		push ax
		mov ax, 2
		push ax
		mov ax, 80
		push ax
		call WhiteHorizontalLine
		
		pop bp
		pop ax
		ret
;===================================================================================================================================================
; Scrolling for easy level
scrollup_easy:
			push bp
			mov bp, sp
			push es
			push ds
			push si
			push di
			push ax
			push bx
			push cx
			push dx
			
			mov ax, 0xb800
			mov es, ax
			mov ds, ax
			mov bx, 4				
			push bx		
    
scroll_row_easy:
			cmp word [cs:timer_active], 0
			je exit_easy
			cmp word [cs:timer_paused], 1
            je exit_easy
            cmp word [cs:in_pause_menu], 1
            je exit_easy

			pop bx					
			push bx			
			mov ax, 80
			mul byte [bp + 4]
			add ax, 5
			shl ax, 1
			mov si, ax			
			
			mov ax, [bp + 4]
			dec ax					
			mov bx, 80
			mul bx
			add ax, 5
			shl ax, 1
			mov di, ax			
			mov dx, 18		
    
copyloop_easy:   
			mov cx, 71				
			cld
			rep movsw					
			add di, 18					
			add si, 18					
			dec dx		
			jnz copyloop_easy
			
			mov ax, 22
			mov bx, 80
			mul bx
			add ax, 5
			shl ax, 1
			mov di, ax					
		
			mov cx, 70					
			mov ax, 0x3720
			rep stosw					
			call update_balloon_positions
  ; Repaint all active balloon frames to keep visuals intact
            call redraw_active_balloons
		
			pop bx							
			dec bx							
			push bx							
			mov cx, 20        	
			
DelayScroll_easy:
            cmp word [cs:timer_active], 0
            je exit_easy
            cmp word [cs:timer_paused], 1
            je exit_easy
            cmp word [cs:in_pause_menu], 1
            je exit_easy
			    
			call check_letter_during_game
            call sleep
            loop DelayScroll_easy
		
			cmp bx, 0						
			jnz scroll_row_easy
		
exit_easy:	
			pop bx
			pop dx
			pop cx
			pop bx
			pop ax
			pop di
			pop si
			pop ds
			pop es
			pop bp
			ret 2
;===================================================================================================================================================
; Scrolling for Medium level
scrollup_medium:
            push bp
            mov bp, sp
            push es
            push ds
            push si
            push di
            push ax
            push bx
            push cx
            push dx

            mov ax, 0xb800
            mov es, ax
            mov ds, ax
            mov bx, 4
            push bx

scroll_row_medium:
            cmp word [cs:timer_active], 0
            je exit_medium
            cmp word [cs:timer_paused], 1
            je exit_medium
            cmp word [cs:in_pause_menu], 1
            je exit_medium

            pop bx
            push bx
            mov ax, 80
            mul byte [bp + 4]
            add ax, 5
            shl ax, 1
            mov si, ax

            mov ax, [bp + 4]
            dec ax
            mov bx, 80
            mul bx
            add ax, 5
            shl ax, 1
            mov di, ax
            mov dx, 18

copyloop_medium:
            mov cx, 71
            cld
            rep movsw
            add di, 18
            add si, 18
            dec dx
            jnz copyloop_medium

            mov ax, 22
            mov bx, 80
            mul bx
            add ax, 5
            shl ax, 1
            mov di, ax

            mov cx, 70
            mov ax, 0x3720
            rep stosw

			call update_balloon_positions
			; Repaint all active balloon frames to keep visuals intact
            call redraw_active_balloons
            pop bx
            dec bx
            push bx
			mov cx, 12
			
DelayScroll_medium:
            cmp word [cs:timer_active], 0
            je exit_medium
            cmp word [cs:timer_paused], 1
            je exit_medium
            cmp word [cs:in_pause_menu], 1
            je exit_medium
			call check_letter_during_game
            call sleep
            loop DelayScroll_medium
            cmp bx, 0
            jnz scroll_row_medium

exit_medium:
            pop bx
            pop dx
            pop cx
            pop bx
            pop ax
            pop di
            pop si
            pop ds
            pop es
            pop bp
            ret 2
;===================================================================================================================================================
; Scrolling for Hard Level	
scrollup_hard:
            push bp
            mov bp, sp
            push es
            push ds
            push si
            push di
            push ax
            push bx
            push cx
            push dx

            mov ax, 0xb800
            mov es, ax
            mov ds, ax
            mov bx, 4
            push bx

scroll_row_hard:
            cmp word [cs:timer_active], 0
            je exit_hard
            cmp word [cs:timer_paused], 1
            je exit_hard
            cmp word [cs:in_pause_menu], 1
            je exit_hard

            pop bx
            push bx
            mov ax, 80
            mul byte [bp + 4]
            add ax, 5
            shl ax, 1
            mov si, ax

            mov ax, [bp + 4]
            dec ax
            mov bx, 80
            mul bx
            add ax, 5
            shl ax, 1
            mov di, ax
            mov dx, 18

copyloop_hard:
            mov cx, 71
            cld
            rep movsw
            add di, 18
            add si, 18
            dec dx
            jnz copyloop_hard

            mov ax, 22
            mov bx, 80
            mul bx
            add ax, 5
            shl ax, 1
            mov di, ax

            mov cx, 70
            mov ax, 0x3720
            rep stosw
			call update_balloon_positions
			
			  ; Repaint all active balloon frames to keep visuals intact
            call redraw_active_balloons
            pop bx
            dec bx
            push bx
			mov cx, 5
			
DelayScroll_hard:
            cmp word [cs:timer_active], 0
            je exit_hard
            cmp word [cs:timer_paused], 1
            je exit_hard
            cmp word [cs:in_pause_menu], 1
            je exit_hard
			call check_letter_during_game
            call sleep
            loop DelayScroll_hard

            cmp bx, 0
            jnz scroll_row_hard

exit_hard:
            pop bx
            pop dx
            pop cx
            pop bx
            pop ax
            pop di
            pop si
            pop ds
            pop es
            pop bp
            ret 2

;===================================================================================================================================================
; Updating the position of the Ballon
update_balloon_positions:
			push ax
			push bx
			push cx
			push si
			xor si, si

.update_loop:
			cmp si, [cs:balloon_count]
			jge .done
			mov bx, si
			mov cx, si
			shl bx, 1
			shl cx, 1
			shl cx, 1
			shl cx,1
			add bx, cx   
			
			cmp word [cs:balloon_data + bx + 8], 0
			je .next        
			dec word [cs:balloon_data + bx]
			cmp word [cs:balloon_data + bx], 4
			jge .next     
			mov word [cs:balloon_data + bx + 8], 0

.next:
			inc si
			jmp .update_loop

.done:
			call cleanup_balloons             
			pop si
			pop cx
			pop bx
			pop ax
			ret
;===================================================================================================================================================
; Gameplay Screen Display
gameplay_screen_display:
			; LEFT OUTER BORDER (Full height)
			mov ax, 0				; Column
			push ax
			mov ax, 0				; Row
			push ax
			mov ax, 25				; Length (full screen height)
			push ax
			call WhiteVerticalLine
			
			; RIGHT OUTER BORDER (Full height)
			mov ax, 79				; Column
			push ax
			mov ax, 0				; Row
			push ax
			mov ax, 25				; Length (full screen height)
			push ax
			call WhiteVerticalLine
			
			; BOTTOM OUTER BORDER
			mov ax, 0				; Column (start from 0, not 1)
			push ax
			mov ax, 24				; Row
			push ax
			mov ax, 80				; Length (full width)
			push ax
			call WhiteHorizontalLine
			
			; TOP BORDER (separator line below top bars)
			mov ax, 0				; Column
			push ax
			mov ax, 2				; Row
			push ax
			mov ax, 80				; Length
			push ax
			call WhiteHorizontalLine

			; SCORE SECTION
			
			; Score top border
			mov ax, 0				; Column
			push ax
			mov ax, 0				; Row
			push ax
			mov ax, 18				; Length (matches resume screen)
			push ax
			call WhiteHorizontalLine
			
			; Score right separator
			mov ax, 16				; Column (matches resume screen)
			push ax
			mov ax, 1				; Row
			push ax
			mov ax, 2				; Length
			push ax
			call WhiteHorizontalLine
			
			; Score text
			mov ax, 0x003F			; Color (cyan, matches resume)
			push ax
			mov ax, 5				; Column (matches resume)
			push ax
			mov ax, 1				; Row
			push ax 
			mov ax, score_g			; String
			push ax
			mov ax, [scoreLength_g]	; String Length
			push ax
			call drawText
			
			; Score value
			mov ax, 12				; Column
			push ax
			mov ax, 1				; Row
			push ax
			mov ax, 0x003F			; Color
			push ax
			push word [cs:score_value]
			call printnum
			
			; LEVEL SECTION 
			
			; Level top border
			mov ax, 28				; Column (matches resume)
			push ax
			mov ax, 0				; Row
			push ax
			mov ax, 22				; Length (matches resume)
			push ax
			call WhiteHorizontalLine
			
			; Level left border
			mov ax, 28				; Column
			push ax
			mov ax, 0				; Row
			push ax
			mov ax, 2				; Length
			push ax
			call WhiteVerticalLine
			
			; Level right border
			mov ax, 50				; Column (matches resume)
			push ax
			mov ax, 0				; Row
			push ax
			mov ax, 2				; Length
			push ax
			call WhiteVerticalLine
			
			; Level text
			mov ax, 0x003F			; Color (cyan, matches resume)
			push ax
			mov ax, 34				; Column (centered in level box)
			push ax
			mov ax, 1				; Row
			push ax
			
			; Check difficulty and draw appropriate text
			mov bx, [cs:current_difficulty]
			cmp bx, 2
			je .lvl_medium
			cmp bx, 3
			je .lvl_hard
			
			; Easy level
			mov ax, level_easy_g
			push ax
			mov ax, [levellength_easy_g]
			push ax
			jmp .draw_level
		
.lvl_medium:
			mov ax, level_med_g
			push ax
			mov ax, [levellength_med_g]
			push ax
			jmp .draw_level
		
.lvl_hard:
			mov ax, level_hard_g
			push ax
			mov ax, [levellength_hard_g]
			push ax
		
.draw_level:
			call drawText
		
			; TIMER SECTION 
			
			; Timer top border
			mov ax, 62				; Column (matches resume)
			push ax
			mov ax, 0				; Row
			push ax
			mov ax, 17				; Length (matches resume)
			push ax
			call WhiteHorizontalLine
			
			; Timer left separator
			mov ax, 62				; Column
			push ax
			mov ax, 1				; Row
			push ax
			mov ax, 2				; Length
			push ax
			call WhiteHorizontalLine
			
			; Timer text
			mov ax, 0x003F			; Color (cyan, matches resume)
			push ax
			mov ax, 65				; Column (matches resume)
			push ax
			mov ax, 1				; Row
			push ax
			mov ax, timer_g			; String
			push ax
			mov ax, [timerLength_g]	; String Length
			push ax
			call drawText
			
			ret
;===================================================================================================================================================		
; Checking the Letter of Balloon during the game		
check_letter_during_game:
			push ax
			push bx
			push cx
			push dx
			push si
		
			cmp word [cs:letter_pressed], 0
			je .no_letter
			
			mov word [cs:letter_pressed], 0
			
			mov al, [cs:pressed_key]
			call scancode_to_letter
			
			cmp al, 0
			je .no_letter
			xor si, si
    
.search:
			cmp si, [cs:balloon_count]
			jge .no_letter
			
			mov bx, si
			mov cx, si
			shl bx, 1         ; bx = si * 2
			shl cx, 1
			shl cx, 1
			shl cx, 1         ; cx = si * 8
			add bx, cx        ; bx = si*10 âœ“
			
			cmp word [cs:balloon_data + bx + 8], 0
			je .next
			
			mov ah, byte [cs:balloon_data + bx + 4]
			cmp al, ah
			je .match
    
.next:
			inc si
			jmp .search

.match:
			; Double-check balloon is still active 
			cmp word [cs:balloon_data + bx + 8], 0
			je .next                              ; Already popped, skip it
			
			mov word [cs:balloon_data + bx + 8], 0
			
			call sound_balloon_pop
			push word [cs:balloon_data + bx + 2]   
			push word [cs:balloon_data + bx]     
			call Pop

			call redraw_active_balloons
			mov ax, [cs:score_value]
			add ax, 10
			mov [cs:score_value], ax
			
			push word 12
			push word 1
			push word 0x003F
			push word [cs:score_value]
			call printnum
			
			jmp .no_letter                        ; Exit immediately after first match
	
.no_letter:
			pop si
			pop dx
			pop cx
			pop bx
			pop ax
			ret
;===================================================================================================================================================
; Generating the Balloons for Easy Level
Generate_Balloons_Easy: 
gen_loop_easy:
			cmp word [cs:timer_active], 0
			je .done_easy
			cmp word [cs:timer_paused], 1
			je .done_easy
			cmp word [cs:in_pause_menu], 1
			je .done_easy
			
			cmp word [cs:skip_first_balloon], 1
			je .skip_to_scroll_easy

			; --- redraw level text ---
			mov ax, 30
			push ax
			mov ax, 1
			push ax
			mov ax, 20
			push ax
			call clearRow
			
			mov ax, 0x003F
			push ax
			mov ax, 34
			push ax
			mov ax, 1
			push ax
			mov ax, level_easy_g
			push ax
			mov ax, [levellength_easy_g]
			push ax
			call drawText

		; Spawn First Balloon
.get_col_easy1:
			call randomNumber
			mov bx, ax
			push 18                ; row
			push bx                ; col
			call can_place_balloon
			cmp ax, 1
			jne .get_col_easy1

			push 18                ; final row
			push bx                ; safe col
			mov ax, 0x4020         ; RED balloon body
			push ax
			mov ax, 0x4F00         ; WHITE letter on red
			push ax
			call balloon

			mov cx, 20
.balloon_gen_delay:
			call check_letter_during_game
			call sleep
			loop .balloon_gen_delay

.skip_to_scroll_easy:
			mov word [cs:skip_first_balloon], 0
			call check_letter_during_game

			cmp word [cs:timer_active], 0
			je .done_easy
			cmp word [cs:timer_paused], 1
			je .done_easy
			cmp word [cs:in_pause_menu], 1
			je .done_easy

			mov ax, 5
			push ax
			call scrollup_easy
			call check_letter_during_game

        ; Spawn Second Balloon
.get_col_easy2:
        call randomNumber
        mov bx, ax
        push 18
        push bx
        call can_place_balloon
        cmp ax, 1
        jne .get_col_easy2

        push 18
        push bx
        mov ax, 0x2020         ; GREEN balloon body
        push ax
        mov ax, 0x2F00         ; BLACK letter on green (will be set by randomLetter)
        push ax
        call balloon

        call check_letter_during_game
        mov ax, 5
        push ax
        call scrollup_easy

        ; Spawn Third Balloon
.get_col_easy3:
        call randomNumber
        mov bx, ax
        push 18
        push bx
        call can_place_balloon
        cmp ax, 1
        jne .get_col_easy3

        push 18
        push bx
        mov ax, 0x1020         ; BLUE balloon body
        push ax
        mov ax, 0x1F00         ; WHITE letter on blue
        push ax
        call balloon

        call check_letter_during_game
        mov ax, 5
        push ax
        call scrollup_easy

         ; Spawn Fourth Balloon
.get_col_easy4:
        call randomNumber
        mov bx, ax
        push 18
        push bx
        call can_place_balloon
        cmp ax, 1
        jne .get_col_easy4

        push 18
        push bx
        mov ax, 0x5020         ; MAGENTA balloon body
        push ax
        mov ax, 0x5F00         ; WHITE letter on magenta
        push ax
        call balloon

        call check_letter_during_game
        mov ax, 5
        push ax
        call scrollup_easy

        jmp gen_loop_easy

.done_easy:
        ret
;===================================================================================================================================================
; Generating the Balloons for Medium Level 
Generate_Balloons_Medium:   
gen_loop_medium:
        cmp word [cs:timer_active], 0
        je .done_medium
        cmp word [cs:timer_paused], 1
        je .done_medium
        cmp word [cs:in_pause_menu], 1
        je .done_medium

         ; Spawn First Balloon
.get_col_med1:
        call randomNumber
        mov bx, ax
        push 18                ; row
        push bx                ; col
        call can_place_balloon
        cmp ax, 1
        jne .get_col_med1

        push 18
        push bx
        mov ax, 0x6020         ; YELLOW balloon body
        push ax
        mov ax, 0x6F00         ; BLACK letter on yellow
        push ax
        call balloon

        call check_letter_during_game
        mov ax, 5
        push ax
        call scrollup_medium

         ; Spawn Second Balloon
.get_col_med2:
        call randomNumber
        mov bx, ax
        push 18
        push bx
        call can_place_balloon
        cmp ax, 1
        jne .get_col_med2

        push 18
        push bx
        mov ax, 0x4020         ; RED balloon body
        push ax
        mov ax, 0x4F00         ; WHITE letter on red
        push ax
        call balloon

        call check_letter_during_game
        mov ax, 5
        push ax
        call scrollup_medium

         ; Spawn Third Balloon
.get_col_med3:
        call randomNumber
        mov bx, ax
        push 18
        push bx
        call can_place_balloon
        cmp ax, 1
        jne .get_col_med3

        push 18
        push bx
        mov ax, 0x1020         ; BLUE balloon body
        push ax
        mov ax, 0x1F00         ; WHITE letter on blue
        push ax
        call balloon

        call check_letter_during_game
        mov ax, 5
        push ax
        call scrollup_medium

         ; Spawn Fourth Balloon
.get_col_med4:
        call randomNumber
        mov bx, ax
        push 18
        push bx
        call can_place_balloon
        cmp ax, 1
        jne .get_col_med4

        push 18
        push bx
        mov ax, 0x5020         ; MAGENTA balloon body
        push ax
        mov ax, 0x5F00         ; WHITE letter on magenta
        push ax
        call balloon

        call check_letter_during_game
        mov ax, 5
        push ax
        call scrollup_medium

        jmp gen_loop_medium

.done_medium:
        ret
;===================================================================================================================================================
; Generating the Balloons for Hard Level 
Generate_Balloons_Hard:   
gen_loop_hard:
        cmp word [cs:timer_active], 0
        je .done_hard
        cmp word [cs:timer_paused], 1
        je .done_hard
        cmp word [cs:in_pause_menu], 1
        je .done_hard

         ; Spawn First Balloon
.get_col_hard1:
        call randomNumber
        mov bx, ax
        push 18                ; row
        push bx                ; col
        call can_place_balloon
        cmp ax, 1
        jne .get_col_hard1

        push 18
        push bx
        mov ax, 0x2020         ; GREEN balloon body
        push ax
        mov ax, 0x2F00         ; BLACK letter on green
        push ax
        call balloon

        call check_letter_during_game
        mov ax, 5
        push ax
        call scrollup_hard

         ; Spawn Second Balloon
.get_col_hard2:
        call randomNumber
        mov bx, ax
        push 18
        push bx
        call can_place_balloon
        cmp ax, 1
        jne .get_col_hard2

        push 18
        push bx
        mov ax, 0x4020         ; RED balloon body
        push ax
        mov ax, 0x4F00         ; WHITE letter on red
        push ax
        call balloon

        call check_letter_during_game
        mov ax, 5
        push ax
        call scrollup_hard

         ; Spawn Third Balloon
.get_col_hard3:
        call randomNumber
        mov bx, ax
        push 18
        push bx
        call can_place_balloon
        cmp ax, 1
        jne .get_col_hard3

        push 18
        push bx
        mov ax, 0x1020         ; BLUE balloon body
        push ax
        mov ax, 0x1F00         ; WHITE letter on blue
        push ax
        call balloon

        call check_letter_during_game
        mov ax, 5
        push ax
        call scrollup_hard

         ; Spawn Fourth Balloon
.get_col_hard4:
        call randomNumber
        mov bx, ax
        push 18
        push bx
        call can_place_balloon
        cmp ax, 1
        jne .get_col_hard4

        push 18
        push bx
        mov ax, 0x6020         ;  YELLOW balloon body
        push ax
        mov ax, 0x6F00         ; BLACK letter on yellow
        push ax
        call balloon

        call check_letter_during_game
        mov ax, 5
        push ax
        call scrollup_hard

        jmp gen_loop_hard

.done_hard:
        ret
;===================================================================================================================================================
; Clearing the Balloons (Popping)
clearBalloon:
        push bp
        mov bp, sp
        push es
        push di
        push ax
        push bx
        push cx

        mov ax, 0xb800
        mov es, ax

        mov al, 80
        mul byte [bp+4]          ; row
        add ax, [bp+6]           ; column
        shl ax, 1
        mov di, ax               ; DI = base offset

        mov ax, 0x3720           ; blank space
        cld
        mov cx, 3
.clear_row0:
        stosw
        loop .clear_row0
        sub di, 6          
        add di, 160            
        mov cx, 3
.clear_row1:
        stosw
        loop .clear_row1
        sub di, 6
        add di, 160
        mov cx, 3
.clear_row2:
        stosw
        loop .clear_row2

        mov al, 80
        mul byte [bp+4]          ; row
        add ax, [bp+6]           ; column
        shl ax, 1
        mov di, ax               ; Fresh base offset
        
        add di, 480              ; row+3 = +3*160 = +480
        add di, 2                ; col+1 = +2 bytes
        mov word [es:di], 0x3720 ; Clear string character

        ; Clear the dot at row+4, col+1
        add di, 160              ; Down one more row
        mov word [es:di], 0x3720 ; Clear dot character

        pop cx
        pop bx
        pop ax
        pop di
        pop es
        pop bp
        ret 4
;===================================================================================================================================================
popAnimation:
        push bp
        mov bp, sp
        push es
        push di
        push ax
        push bx
        push cx
        push dx

        mov ax, 0xb800
        mov es, ax

        ; Bounds check: ensure letter position is in playfield
        ; Letter is at (row+1, col+1), check that position instead
        mov ax, [bp+4]           ; row (top-left of balloon)
        add ax, 1                ; row of letter = row+1
        cmp ax, 3                ; Letter must be >= row 3 (playfield starts at row 3)
        jb .done_anim
        cmp ax, 22               ; Letter must be <= row 22
        ja .done_anim
        
        mov ax, [bp+6]           ; column (left of balloon)
        add ax, 1                ; column of letter = col+1
        cmp ax, 6                ; Letter must be >= col 6
        jb .done_anim
        cmp ax, 75               ; Letter must be <= col 75
        ja .done_anim

        ; Calculate base offset for animation (use balloon top-left, not letter position)
        mov al, 80
        mul byte [bp+4]          ; row
        add ax, [bp+6]           ; column
        shl ax, 1
        mov bx, ax               ; Save base in BX

        ; Frame 1: Center + 4 cardinal directions (cross pattern)
        mov ax, 0x6E2A           ; Orange asterisk
        
        ; Center
        mov di, bx
        mov [es:di], ax
        
        ; Right (+2)
        mov di, bx
        add di, 2
        mov [es:di], ax
        
        ; Left (-2)
        mov di, bx
        sub di, 2
        mov [es:di], ax
        
        ; Down (+160)
        mov di, bx
        add di, 160
        mov [es:di], ax
        
        ; Up (-160)
        mov di, bx
        sub di, 160
        mov [es:di], ax

        ; Delay
        mov cx, 3
.f1_pause:
        call sleep
        loop .f1_pause

        ; Frame 2: Add diagonal directions
        mov ax, 0x6E2A           ; Orange asterisk
        
        ; Up-left (-160-2)
        mov di, bx
        sub di, 162
        mov [es:di], ax
        
        ; Up-right (-160+2)
        mov di, bx
        sub di, 158
        mov [es:di], ax
        
        ; Down-left (+160-2)
        mov di, bx
        add di, 158
        mov [es:di], ax
        
        ; Down-right (+160+2)
        mov di, bx
        add di, 162
        mov [es:di], ax

        ; Delay
        mov cx, 3
.f2_pause:
        call sleep
        loop .f2_pause

        ; Clean up all animation marks
        mov ax, 0x3720           ; Blank

        ; Clear center
        mov di, bx
        mov [es:di], ax
        
        ; Clear cardinals
        mov di, bx
        add di, 2
        mov [es:di], ax
        
        mov di, bx
        sub di, 2
        mov [es:di], ax
        
        mov di, bx
        add di, 160
        mov [es:di], ax
        
        mov di, bx
        sub di, 160
        mov [es:di], ax
        
        ; Clear diagonals
        mov di, bx
        sub di, 162
        mov [es:di], ax
        
        mov di, bx
        sub di, 158
        mov [es:di], ax
        
        mov di, bx
        add di, 158
        mov [es:di], ax
        
        mov di, bx
        add di, 162
        mov [es:di], ax

.done_anim:
        pop dx
        pop cx
        pop bx
        pop ax
        pop di
        pop es
        pop bp
        ret 4
;===================================================================================================================================================
Pop:    
        push bp
        mov bp, sp
        push word [bp + 6]    
        push word [bp + 4]       
        call popAnimation

        push word [bp + 6]     
        push word [bp + 4]   
        call clearBalloon

        ; Repair any incidental clears by repainting all active balloons
        call redraw_active_balloons

        pop bp
        ret 4	
;===================================================================================================================================================
; Remove inactive balloons and compact the array
cleanup_balloons:
		push ax
		push bx
		push cx
		push dx
		push si
		push di
		
		xor si, si              ; Read index
		xor di, di              ; Write index

.cleanup_loop:
		cmp si, [cs:balloon_count]
		jge .update_count
		
		; Calculate read offset (si * 10)
		mov bx, si
		mov cx, si
		shl bx, 1
		shl cx, 1
		shl cx, 1
		shl cx, 1
		add bx, cx              ; bx = si * 10
		
		; Check if balloon is active
		push bx
		mov ax, balloon_data
		add bx, ax
		add bx, 8               ; Point to active flag
		mov ax, [cs:bx]
		pop bx
		cmp ax, 0
		je .skip_balloon        ; Inactive, don't copy
		
		; Balloon is active - copy if needed
		cmp si, di
		je .same_position       ; No need to copy to same spot
		
		; Calculate write offset (di * 10)
		push bx
		mov bx, di
		mov cx, di
		shl bx, 1
		shl cx, 1
		shl cx, 1
		shl cx, 1
		add bx, cx              ; bx = di * 10
		mov dx, bx              ; dx = write offset
		pop bx                  ; bx = read offset
		
		; Copy 5 words (10 bytes) using SI as pointer
		push si
		push di
		
		; Set up source pointer
		mov si, balloon_data
		add si, bx              ; si = &balloon_data[read_offset]
		
		; Set up destination pointer
		mov di, balloon_data
		add di, dx              ; di = &balloon_data[write_offset]
		
		; Copy word 0
		mov ax, [cs:si]
		mov [cs:di], ax
		
		; Copy word 1
		mov ax, [cs:si+2]
		mov [cs:di+2], ax
		
		; Copy word 2
		mov ax, [cs:si+4]
		mov [cs:di+4], ax
		
		; Copy word 3
		mov ax, [cs:si+6]
		mov [cs:di+6], ax
		
		; Copy word 4
		mov ax, [cs:si+8]
		mov [cs:di+8], ax
		
		pop di
		pop si
    
.same_position:
		inc di                  ; Increment write index

.skip_balloon:
		inc si                  ; Increment read index
		jmp .cleanup_loop

.update_count:
		mov [cs:balloon_count], di
    
		pop di
		pop si
		pop dx
		pop cx
		pop bx
		pop ax
		ret	
;====================================================================
; Check if a balloon can be placed at (row, col) without overlap
can_place_balloon:
		push bp
		mov  bp, sp
		push si
		push bx
		push cx
		push dx
		push di

		mov dx, [bp+4]      ; new balloon row
		mov ax, [bp+6]      ; new balloon col

		xor si, si

.check_loop:
		cmp si, [cs:balloon_count]
		jge .ok

		; compute offset = si * 10
		mov bx, si
		mov cx, si
		shl bx, 1
		shl cx, 1
		shl cx, 1
		shl cx, 1
		add bx, cx

		; Skip inactive balloons
		cmp word [cs:balloon_data + bx + 8], 0
		je .next

		mov cx, [cs:balloon_data + bx]      ; existing row
		mov di, [cs:balloon_data + bx + 2]  ; existing col

		; CHECK 1: Body overlap (3x3) 		
		; Check if rows DON'T overlap
		mov bp, cx
		add bp, 2           ; existing bottom row
		cmp dx, bp
		jg  .check_string   ; New balloon starts below existing - check string
		
		mov bp, dx
		add bp, 2           ; new balloon bottom row
		cmp cx, bp
		jg  .next           ; Existing starts below new - no overlap
		
		; Rows overlap, now check columns
		mov bp, di
		add bp, 2           ; existing right column
		cmp ax, bp
		jg  .next           ; New balloon starts right of existing - safe
		
		mov bp, ax
		add bp, 2           ; new balloon right column
		cmp di, bp
		jg  .next           ; Existing starts right of new - safe
		
		; If we reach here, body overlaps
		jmp .reject

.check_string:
		; CHECK 2: String overlap   
		mov bp, dx
		add bp, 3           ; new string row
		
		; Is string row within existing body rows?
		cmp bp, cx
		jl  .check_hook     ; String above body
		mov di, cx
		add di, 2
		cmp bp, di
		jg  .check_hook     ; String below body
		
		; String row intersects, check column
		mov di, [cs:balloon_data + bx + 2]  ; reload existing col
		mov bp, ax
		add bp, 1           ; new string column
		
		cmp bp, di
		jl  .check_hook     ; String left of body
		mov di, [cs:balloon_data + bx + 2]
		add di, 2
		cmp bp, di
		jg  .check_hook     ; String right of body
		
		; String hits body
		jmp .reject

.check_hook:
		; CHECK 3: Hook overlap
		
		mov bp, dx
		add bp, 4           ; new hook row
		
		mov cx, [cs:balloon_data + bx]      ; reload existing row
		cmp bp, cx
		jl  .next           ; Hook above body
		add cx, 2
		cmp bp, cx
		jg  .next           ; Hook below body
		
		; Hook row intersects, check column
		mov di, [cs:balloon_data + bx + 2]  ; reload existing col
		mov bp, ax
		add bp, 1           ; new hook column
		
		cmp bp, di
		jl  .next           ; Hook left of body
		add di, 2
		cmp bp, di
		jg  .next           ; Hook right of body
		
		; Hook hits body
		jmp .reject

.next:
		inc si
		jmp .check_loop

.ok:
		mov ax, 1
		jmp .ret

.reject:
		mov ax, 0

.ret:
		pop di
		pop dx
		pop cx
		pop bx
		pop si
		pop bp
		ret 4
;====================================================================
; Redraw every active balloon 
redraw_active_balloons:
		push ax
		push bx
		push cx
		push dx
		push si
		push di
		push es

		mov ax, 0xb800
		mov es, ax

		xor si, si
.redraw_loop:
		cmp si, [cs:balloon_count]
		jge .done

		; compute offset = si * 10
		mov bx, si
		mov cx, si
		shl bx, 1
		shl cx, 1
		shl cx, 1
		shl cx, 1
		add bx, cx

		; skip inactive
		cmp word [cs:balloon_data + bx + 8], 0
		je .next

		; row, col, color
		mov dx, [cs:balloon_data + bx]       ; row
		mov di, [cs:balloon_data + bx + 2]   ; col
		mov cx, [cs:balloon_data + bx + 6]   ; color

		; read center (row+1, col+1) from VRAM to preserve letter+attr exactly
		mov ax, dx
		add ax, 1              ; row+1
		mov bl, 80
		mul bl                 ; ax = (row+1)*80
		add ax, di
		add ax, 1              ; col+1
		shl ax, 1              ; byte offset
		push si                ; Save SI before we use it
		mov si, ax
		mov ax, [es:si]        ; ax = letter_with_attribute currently displayed
		pop si                 ; Restore SI

		; draw COMPLETE frame (body + string + hook)
		push dx                ; row
		push di                ; col
		push cx                ; color
		push ax                ; letter_with_attribute from VRAM
		call draw_balloon_frame

.next:
		inc si
		jmp .redraw_loop

.done:
		pop es
		pop di
		pop si
		pop dx
		pop cx
		pop bx
		pop ax
		ret