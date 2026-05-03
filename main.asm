[org 0x0100]

jmp start
;===================================================================================================================================================
; Other balloon and useful labels
score_value: dw 0
balloon_data: times 100 dw 0    
balloon_count: dw 0     
pressed_key: db 0     
skip_first_balloon: dw 0    
victory_col: dw 20
victory_row: dw 20
defeat_col: dw 20     
defeat_row: dw 0
;===================================================================================================================================================
; Labels for Int hook 9
gameplayflag: dw 0
difficultyflag: dw 0
quitflag: dw 0 
main_screen_flag: dw 1
in_pause_menu: dw 0        
in_game_over: dw 0          
letter_pressed: dw 0        
easyflag:   dw 0
mediumflag: dw 0
hardflag:   dw 0
current_difficulty: dw 0 
is_resuming: dw 0
rulesflag: dw 0              ; Flag for rules screen
;===================================================================================================================================================
; Labels for Int 8
tickcount: dw 0
subtick: dw 0
timer_paused: dw 0
saved_tickcount: dw 0
saved_subtick: dw 0
timer_active: dw 0
oldisr8: dd 0
oldkbisr: dd 0
;===================================================================================================================================================
; Save Screen Subroutine (saves the entire gameplay area)
screen_buffer: times 4000 db 0  
saveScreen: 
		pusha
		push ds
		push es

		mov cx, 4000                
		mov ax, 0xb800
		mov ds, ax                 
		push cs
		pop es                      
		mov si, 0                   
		mov di, screen_buffer      
		cld                        
		rep movsb                  
		pop es
		pop ds
		popa
		ret

; Restore Screen Subroutine (restores the entire gameplay area)
restoreScreen: 
		pusha
		push ds
		push es

		mov cx, 4000               
		mov ax, 0xb800
		mov es, ax                  
		push cs
		pop ds                      
		mov si, screen_buffer       
		mov di, 0                   
		cld                        
		rep movsb                  
		pop es
		pop ds
		popa
		ret

;===================================================================================================================================================
; Include screen modules
%include "start_screen.asm"
%include "difficulty_screen.asm"
%include "gameplay_screen.asm"
%include "gameover_screen.asm"
%include "resume_screen.asm" 
%include "common_functions.asm"
%include "music.asm"
%include "victory.asm"
%include "defeat.asm"
%include "rules_screen.asm"    ; Include rules screen module
;===================================================================================================================================================
; Hooking INT 9			

kbisr:
		push ax
		push es
		in al,0x60
		
		cmp word[cs:rulesflag], 3        ; CHECK IF IN RULES SCREEN (displaying)
		je rules_controls
		
		cmp word[cs:rulesflag], 1        ; CHECK IF TRANSITIONING TO RULES
		je rules_controls

		cmp word[cs:in_game_over], 0
		jne gameover_controls

		cmp word[cs:difficultyflag], 3
		je difficulty_controls

		cmp word[cs:main_screen_flag], 0
		je gameplay_controls

startscreen_controls:

		cmp al,0x19 
		jne .check_d
		mov word[cs:gameplayflag],1
		jmp done
	
.check_d:
		cmp al,0x20 
		jne .check_i                      ; Check for 'I' key
		mov word[cs:difficultyflag],1
		jmp done
	
.check_i:                             ; Handle 'I' key for rules
		cmp al,0x17                       ; Scan code for 'I'
		jne .check_q
		mov word[cs:rulesflag],1
		jmp done

.check_q:
		cmp al,0x10
		jne done
		mov word[cs:quitflag],1
		jmp done

rules_controls:                       ; Rules screen controls
		cmp al,0x32                       ; Scan code for 'M'
		jne done
		mov word[cs:rulesflag],2          ; Flag to return to main screen
		jmp done

gameover_controls:
		cmp al,0x13
		jne .go_check_q
		mov word[cs:gameplayflag],2    
		jmp done
	
.go_check_q:
		cmp al,0x10 
		jne .go_check_m
		mov word[cs:quitflag],1
		jmp done
	
.go_check_m:
		cmp al,0x32 
		jne done
		mov word[cs:main_screen_flag],1
		mov word[cs:in_game_over],0
		mov word[cs:gameplayflag],0
		mov word[cs:difficultyflag],2   
		jmp done
	
difficulty_controls:
		cmp al,0x12 
		jne .check_m
		mov word[cs:easyflag],1
		jmp done
	
.check_m:
		cmp al,0x32
		jne .check_h
		mov word[cs:mediumflag],1
		jmp done
	
.check_h:
		cmp al,0x23 
		jne done
		mov word[cs:hardflag],1
		jmp done

gameplay_controls:
		cmp word[cs:in_pause_menu], 1
		je pause_menu_controls

		cmp al,0x01 
		jne check_letters

		call saveScreen          
		mov word[cs:timer_paused],1
		mov word[cs:in_pause_menu],1

		mov ax,[cs:tickcount]
		mov [cs:saved_tickcount],ax
		mov ax,[cs:subtick]
		mov [cs:saved_subtick],ax
		mov word[cs:gameplayflag],3
		jmp done

check_letters:
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
		cmp word [cs:timer_active], 1
		jne done
		cmp word [cs:timer_paused], 1
		je  done
		cmp word [cs:in_pause_menu], 1
		je  done
		cmp word [cs:in_game_over], 0
		jne done

		mov [cs:pressed_key], al        
		mov word [cs:letter_pressed], 1  
		jmp done

pause_menu_controls:
		cmp al,0x13 
		jne .pm_check_m
		mov word[cs:gameplayflag],4
		jmp done
	
.pm_check_m:
		cmp al,0x32 
		jne .pm_check_q
		mov word[cs:main_screen_flag],1
		mov word[cs:in_pause_menu],0
		mov word[cs:timer_active],0
		mov word[cs:difficultyflag],2
		jmp done
	
.pm_check_q:
		cmp al,0x10 
		jne done
		mov word[cs:quitflag],1
		jmp done

done:
		pop es
		pop ax
		jmp far[cs:oldkbisr]
	
;===================================================================================================================================================		
; Hooking the INT 8         
timerclock:
		push ax
		push bx	
		call update_music 

		cmp word [cs:timer_active], 0
		je .chain_old

		cmp word [cs:timer_paused], 1
		je .chain_old

		inc word [cs:subtick]
		mov ax, [cs:subtick]
		cmp ax, 21
		jne .display
		mov word [cs:subtick], 0
		inc word [cs:tickcount]

.display:
		push ax
		mov ax, 72         
		push ax
		mov ax, 1         
		push ax
		mov ax, 0x003F    
		push ax
		push word [cs:tickcount]
		call printnum_timer
		pop ax

		cmp word [cs:tickcount], 10
		jae .stop_timer
		jmp .chain_old

.stop_timer:
		mov word [cs:timer_active], 0
		mov word [cs:in_game_over], 1   
		mov word [cs:in_pause_menu], 0
		mov word [cs:main_screen_flag], 0

.chain_old:
		pop bx
		pop ax
		jmp far [cs:oldisr8]
;===================================================================================================================================================	
; PROGRAM ENTRY POINT
start:
		call init_random    
		call clrscr
		call start_screen
		call start_music 
		
		mov ax, 0
		mov es, ax
		mov ax, [es:8*4]
		mov word [oldisr8], ax
		mov ax, [es:8*4+2]
		mov word [oldisr8+2], ax
		cli
		mov word [es:8*4], timerclock
		mov [es:8*4+2], cs
		sti
		
		mov ax, 0
		mov es, ax
		mov ax, [es:9*4]
		mov word [oldkbisr], ax
		mov ax, [es:9*4+2]
		mov word [oldkbisr+2], ax
		mov ax, [es:9*4]
		cli
		mov word [es:9*4], kbisr
		mov [es:9*4+2], cs
		sti

; MAIN LOOP
mainLoop:
		cmp word[rulesflag], 1            ; Check if should show rules
		je show_rules
		
		cmp word[rulesflag], 3            ; Check if rules are being displayed
		je show_rules

		cmp word[rulesflag], 2            ; Check if returning from rules
		je return_from_rules

		cmp word[in_game_over], 1
		je show_game_over

		cmp word[main_screen_flag],0
		je check_gameplay_state

		cmp word[difficultyflag], 2
		je return_to_main

		cmp word[difficultyflag],1
		je show_difficulty
		
		cmp word[easyflag],1
		je start_gameplay_easy
		
		cmp word[mediumflag],1
		je start_gameplay_medium
		
		cmp word[hardflag],1
		je start_gameplay_hard

		cmp word[gameplayflag],1
		je start_gameplay

		cmp word[quitflag],1
		je do_quit

		jmp mainLoop
	
; HANDLERS
show_rules:                           ; Show rules screen
		cmp word[rulesflag], 1            ; Only draw if flag is exactly 1
		jne .skip_draw
		call clrscr
		call rules_screen                 ; Call your rules screen function
		mov word[rulesflag], 3            ; Set to 3 to indicate screen is drawn
.skip_draw:
		jmp mainLoop

return_from_rules:                    ; Return to main screen from rules
		call clrscr
		call start_screen
		mov word[rulesflag], 0            ; Reset rules flag
		jmp mainLoop

show_game_over:
		call clrscr
		
		; Determine victory score based on difficulty
		mov ax, [score_value]
		mov bx, [current_difficulty]
		
		cmp bx, 1                    ; Easy level
		je .check_easy
		cmp bx, 2                    ; Medium level
		je .check_medium
		cmp bx, 3                    ; Hard level
		je .check_hard
		jmp .show_defeat             ; Default to defeat if difficulty unknown

.check_easy:
		cmp ax, 10                  ; Easy requires score >= 150
		jge .show_victory_screen
		jmp .show_defeat

.check_medium:
		cmp ax, 300                  ; Medium requires score >= 300
		jge .show_victory_screen
		jmp .show_defeat

.check_hard:
		cmp ax, 500                  ; Hard requires score >= 500
		jge .show_victory_screen
		jmp .show_defeat

.show_defeat:
		; Score below victory score - Show DEFEAT animation FIRST
		call defeat_animation_sequence
		
		; THEN show normal game over screen
		call clrscr
		call over_screen
		mov word[in_game_over], 2
		jmp mainLoop

.show_victory_screen:
		; Score meets threshold - Show victory animation FIRST
		call victory_animation_sequence
		
		; THEN show normal game over screen
		call clrscr
		call over_screen
		
		; Victory sound already played during animation
		mov word[in_game_over], 2
		jmp mainLoop

return_to_main:
		call clrscr
		call start_screen
		call start_music          
		mov word[difficultyflag], 0
		mov word[in_game_over], 0
		mov word[in_pause_menu], 0
		mov word[gameplayflag], 0
		mov word[timer_active], 0
		jmp mainLoop

show_difficulty:
		call clrscr
		call difficulty_screen
		mov word[difficultyflag], 3      
		mov word[main_screen_flag], 1    
		jmp mainLoop

start_gameplay:
		call clrscr
		mov word[timer_active], 1
		mov word[timer_paused], 0
		mov word[tickcount], 0
		mov word[subtick], 0
		mov word[gameplayflag], 0
		mov word[main_screen_flag], 0
		mov word[in_pause_menu], 0
		mov word[in_game_over], 0
		mov word[current_difficulty], 1          
		mov word[score_value], 0
		call gameplay_screen_display
		
		mov ax, 12
		push ax
		mov ax, 1
		push ax
		mov ax, 0x003F
		push ax
		push word [score_value]
		call printnum

		call Generate_Balloons_Easy
		jmp mainLoop
		
start_gameplay_easy:
		call clrscr
		mov word[balloon_count], 0     
		mov word[timer_active], 1
		mov word[timer_paused], 0
		mov word[tickcount], 0
		mov word[subtick], 0
		mov word[gameplayflag], 0
		mov word[main_screen_flag], 0
		mov word[in_pause_menu], 0
		mov word[in_game_over], 0
		mov word[easyflag], 0
		mov word[difficultyflag], 0
		mov word[current_difficulty], 1        
		mov word[score_value], 0
		call gameplay_screen_display
		
		mov ax, 12
		push ax
		mov ax, 1
		push ax
		mov ax, 0x003F
		push ax
		push word [score_value]
		call printnum
		
		call Generate_Balloons_Easy
		jmp mainLoop

start_gameplay_medium:
		call clrscr
		mov word[balloon_count], 0      
		mov word[timer_active], 1
		mov word[timer_paused], 0
		mov word[tickcount], 0
		mov word[subtick], 0
		mov word[gameplayflag], 0
		mov word[main_screen_flag], 0
		mov word[in_pause_menu], 0
		mov word[in_game_over], 0
		mov word[mediumflag], 0
		mov word[difficultyflag], 0
		mov word[current_difficulty], 2          
		mov word[score_value], 0
		call gameplay_screen_display
		
		mov ax, 12
		push ax
		mov ax, 1
		push ax
		mov ax, 0x003F
		push ax
		push word [score_value]
		call printnum

		call Generate_Balloons_Medium
		jmp mainLoop
	
start_gameplay_hard:
		call clrscr
		mov word[balloon_count], 0      
		mov word[timer_active], 1
		mov word[timer_paused], 0
		mov word[tickcount], 0
		mov word[subtick], 0
		mov word[gameplayflag], 0
		mov word[main_screen_flag], 0
		mov word[in_pause_menu], 0
		mov word[in_game_over], 0
		mov word[hardflag], 0
		mov word[difficultyflag], 0
		mov word[current_difficulty], 3         
		mov word[score_value], 0
		call gameplay_screen_display
		
		mov ax, 12
		push ax
		mov ax, 1
		push ax
		mov ax, 0x003F
		push ax
		push word [score_value]
		call printnum
		
		call Generate_Balloons_Hard
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
		cmp word[quitflag], 1
		je do_quit
		jmp mainLoop
	
restart_game:
		call clrscr
		call start_music
		mov word[balloon_count], 0   
		mov word[tickcount], 0
		mov word[subtick], 0
		mov word[timer_active], 1
		mov word[timer_paused], 0
		mov word[in_game_over], 0
		mov word[in_pause_menu], 0
		mov word[main_screen_flag], 0
		mov word[gameplayflag], 0
		mov word[score_value], 0
		call gameplay_screen_display

		mov ax, 12        
		push ax
		mov ax, 1       
		push ax
		mov ax, 0x003F   
		push ax
		push word [score_value]
		call printnum

		mov ax, [current_difficulty]
		cmp ax, 1
		je .restart_easy
		cmp ax, 2
		je .restart_medium
		cmp ax, 3
		je .restart_hard
		jmp mainLoop

.restart_easy:
		call Generate_Balloons_Easy
		jmp mainLoop

.restart_medium:
		call Generate_Balloons_Medium
		jmp mainLoop

.restart_hard:
		call Generate_Balloons_Hard
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

		call clrscr
		call restoreScreen     

		mov word[timer_paused], 0
		mov word[in_pause_menu], 0
		mov word[gameplayflag], 0
		mov word[skip_first_balloon], 1
		
		mov ax, 12         
		push ax
		mov ax, 1       
		push ax
		mov ax, 0x003F     
		push ax
		push word [score_value]
		call printnum

		mov ax, 72         
		push ax
		mov ax, 1       
		push ax
		mov ax, 0x003F    
		push ax
		push word [tickcount]
		call printnum
		
		mov ax, [current_difficulty]
		cmp ax, 1
		je .resume_easy
		cmp ax, 2
		je .resume_medium
		cmp ax, 3
		je .resume_hard
		jmp mainLoop

.resume_easy:
		call Generate_Balloons_Easy
		jmp mainLoop

.resume_medium:
		call Generate_Balloons_Medium
		jmp mainLoop

.resume_hard:
		call Generate_Balloons_Hard
		jmp mainLoop
	
handle_letter_press:
		mov word[letter_pressed], 0
		mov al, [pressed_key]
		call scancode_to_letter
		cmp al, 0
		je .done
		xor si, si

.search_loop:
		cmp si, [balloon_count]
		jge .not_found

		mov bx, si
		mov cx, si
		shl bx, 1
		shl cx, 1
		shl cx, 1
		add bx, cx

		cmp word [cs:balloon_data + bx + 8], 0
		je .next_balloon
		mov ah, byte [cs:balloon_data + bx + 4]
		cmp al, ah
		je .found_match

.next_balloon:
		inc si
		jmp .search_loop

.found_match:
		mov word [cs:balloon_data + bx + 8], 0

		; Use Pop (column first, then row)
		push word [cs:balloon_data + bx + 2]   ; column
		push word [cs:balloon_data + bx]       ; row
		call Pop

		; Score update
		mov ax, [cs:score_value]
		add ax, 10
		mov [cs:score_value], ax
		mov ax, 12
		push ax
		mov ax, 1
		push ax
		mov ax, 0x003F
		push ax
		push word [cs:score_value]
		call printnum

.not_found:
.done:
		jmp mainLoop

	
termination:
		; STOP MUSIC FIRST
		call stop_music
	
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

    push ax
    push es
    mov ax, 0
    mov es, ax
    cli
    mov ax, word [oldkbisr]
    mov [es:9*4], ax
    mov ax, word [oldkbisr+2]
    mov [es:9*4+2], ax
    sti
		
		
		pop es
		pop ax

		mov ax, 0x4c00
		int 0x21