;===================================================================================================================================================
; DEFEAT SCREEN FUNCTIONS
printDefeat:	push bp
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
				push di
				mov ax, 0x14DB
				
				; Drawing D
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
				add di, 160
				stosw
				add di, 158
				stosw
				add di, 158
				stosw
				add di, 156
				stosw
				sub di, 4
				stosw
				
				; Drawing E
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
				add di, 152
				stosw
				add di, 158
				stosw
				stosw
				stosw
				stosw
				
				; Drawing F
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
				
				; Drawing E
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
				add di, 152
				stosw
				add di, 158
				stosw
				stosw
				stosw
				stosw
				
				; Drawing A
				pop di
				add di, 12
				push di
				stosw
				stosw
				stosw
				stosw
				add di, 152
				stosw
				add di, 4
				stosw
				add di, 152
				stosw
				stosw
				stosw
				stosw
				add di, 152
				stosw
				add di, 4
				stosw
				add di, 152
				stosw
				add di, 4
				stosw
				
				; Drawing T
				pop di
				add di, 12
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

				pop cx
				pop bx
				pop ax
				pop si
				pop di
				pop es
				pop bp
				ret 4
;===================================================================================================================================================
; Draw Semi Moon Subroutine
drawSemiMoon2: 	push bp
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
				mov ax, 0x7720
				
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
; Defeat Sound Data 
defeat_sound_note: dw 0

defeat_melody_data:
    ; Gentle sad opening (frames 1-5)
    dw 523      ; C5 
    dw 494      ; B4
    dw 440      ; A4
    dw 392      ; G4
    dw 349      ; F4
    
    ; Melancholic descent (frames 6-10)
    dw 330      ; E4
    dw 294      ; D4
    dw 330      ; E4
    dw 349      ; F4
    dw 330      ; E4
    
    ; Sad middle section (frames 11-15)
    dw 294      ; D4
    dw 262      ; C4
    dw 294      ; D4
    dw 330      ; E4
    dw 294      ; D4
    
    ; Acceptance phase (frames 16-18)
    dw 330      ; E4
    dw 349      ; F4
    dw 330      ; E4
    
    ; Final resolution (frames 19-21)
    dw 294      ; D4
    dw 262      ; C4
    dw 220      ; A3

defeat_melody_notes: equ 21
;===================================================================================================================================================
; Play next note in defeat sequence 
defeat_play_next_note:
    push ax
    push bx
    
    mov bx, [defeat_sound_note]
    cmp bx, defeat_melody_notes
    jge .done
    
    ; Play current note
    shl bx, 1
    mov ax, [cs:defeat_melody_data + bx]
    call play_note
    
    ; Move to next note
    inc word [defeat_sound_note]

.done:
    pop bx
    pop ax
    ret
;===================================================================================================================================================
; Defeat Animation Sequence
defeat_animation_sequence:
    push ax
    push cx
    push bx
    
    ; Initialize defeat screen position
    mov word [defeat_col], 20
    mov word [defeat_row], 0
    
    ; Initialize sound variables
    mov word [defeat_sound_note], 0
    
    ; Stop background music
    call stop_music
    
    ; ANIMATION LOOP - 21 frames total
    
    ; Frame 1 - Initial position + C5
    call defeat_play_next_note
    call draw_defeat_frame
    call defeat_frame_delay
    
    ; Frame 2 - Move + B4
    add word [defeat_col], 1
    add word [defeat_row], 1
    call defeat_play_next_note
    call draw_defeat_frame
    call defeat_frame_delay
    
    ; Frame 3 - Move + A4
    add word [defeat_col], 1
    add word [defeat_row], 1
    call defeat_play_next_note
    call draw_defeat_frame
    call defeat_frame_delay
    
    ; Frame 4 - Move + G4
    add word [defeat_col], 1
    add word [defeat_row], 1
    call defeat_play_next_note
    call draw_defeat_frame
    call defeat_frame_delay
    
    ; Frame 5 - Move + F4
    add word [defeat_col], 1
    add word [defeat_row], 1
    call defeat_play_next_note
    call draw_defeat_frame
    call defeat_frame_delay
    
    ; Frame 6 - Move + E4
    add word [defeat_col], 1
    add word [defeat_row], 1
    call defeat_play_next_note
    call draw_defeat_frame
    call defeat_frame_delay
    
    ; Frame 7 - Move + D4
    add word [defeat_col], 1
    add word [defeat_row], 1
    call defeat_play_next_note
    call draw_defeat_frame
    call defeat_frame_delay
    
    ; Frame 8 - Move left + E4
    sub word [defeat_col], 1
    add word [defeat_row], 1
    call defeat_play_next_note
    call draw_defeat_frame
    call defeat_frame_delay
    
    ; Frame 9 - Move left + F4
    sub word [defeat_col], 1
    add word [defeat_row], 1
    call defeat_play_next_note
    call draw_defeat_frame
    call defeat_frame_delay
    
    ; Frame 10 - Move left + E4
    sub word [defeat_col], 1
    add word [defeat_row], 1
    call defeat_play_next_note
    call draw_defeat_frame
    call defeat_frame_delay
    
    ; Frame 11 - Move left + D4
    sub word [defeat_col], 1
    add word [defeat_row], 1
    call defeat_play_next_note
    call draw_defeat_frame
    call defeat_frame_delay
    
    ; Frame 12 - Move left + C4
    sub word [defeat_col], 1
    add word [defeat_row], 1
    call defeat_play_next_note
    call draw_defeat_frame
    call defeat_frame_delay
    
    ; Frame 13 - Move left + D4
    sub word [defeat_col], 1
    add word [defeat_row], 1
    call defeat_play_next_note
    call draw_defeat_frame
    call defeat_frame_delay
    
    ; Frame 14 - Move left + E4
    sub word [defeat_col], 1
    add word [defeat_row], 1
    call defeat_play_next_note
    call draw_defeat_frame
    call defeat_frame_delay
    
    ; Frame 15 - Move right + D4
    add word [defeat_col], 1
    add word [defeat_row], 1
    call defeat_play_next_note
    call draw_defeat_frame
    call defeat_frame_delay
    
    ; Frame 16 - Move right + E4
    add word [defeat_col], 1
    add word [defeat_row], 1
    call defeat_play_next_note
    call draw_defeat_frame
    call defeat_frame_delay
    
    ; Frame 17 - Move right + F4
    add word [defeat_col], 1
    add word [defeat_row], 1
    call defeat_play_next_note
    call draw_defeat_frame
    call defeat_frame_delay
    
    ; Frame 18 - Move right + E4
    add word [defeat_col], 1
    add word [defeat_row], 1
    call defeat_play_next_note
    call draw_defeat_frame
    call defeat_frame_delay
    
    ; Frame 19 - Move right + D4
    add word [defeat_col], 1
    add word [defeat_row], 1
    call defeat_play_next_note
    call draw_defeat_frame
    call defeat_frame_delay
    
    ; Frame 20 - Move right + C4
    add word [defeat_col], 1
    add word [defeat_row], 1
    call defeat_play_next_note
    call draw_defeat_frame
    call defeat_frame_delay
    
    ; Frame 21 - Final position + A3
    add word [defeat_col], 1
    add word [defeat_row], 1
    call defeat_play_next_note
    call draw_defeat_frame
    call defeat_frame_delay
    
    ; Hold final sad note longer
    mov cx, 25
.final_wait:
    call sleep
    loop .final_wait
    
    call stop_sound
    
    pop bx
    pop cx
    pop ax
    ret
;===================================================================================================================================================
; Draw single defeat frame
draw_defeat_frame:
    push ax
    
    call clrscr3
    call defeat_background_elements
    
    mov ax, [defeat_col]
    push ax
    mov ax, [defeat_row]
    push ax
    call printDefeat
    
    pop ax
    ret
;===================================================================================================================================================
; Draw background elements (clouds, stars, moon)
defeat_background_elements:
    push ax
    
    ; Draw clouds
    mov ax, 3
    push ax
    mov ax, 1
    push ax
    mov ax, 13
    push ax
    call Mooncloud
    
    mov ax, 64
    push ax
    mov ax, 10
    push ax
    mov ax, 13
    push ax
    call Mooncloud
    
    mov ax, 5
    push ax
    mov ax, 18
    push ax
    mov ax, 13
    push ax
    call Mooncloud
    
    ; Draw stars
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
    
    ; Draw moon
    mov ax, 72
    push ax
    mov ax, 0
    push ax
    call drawSemiMoon2
    
    pop ax
    ret
;===================================================================================================================================================
; Frame Delay
defeat_frame_delay:
    push cx
    mov cx, 5
.delay_loop:
    call sleep
    loop .delay_loop
    pop cx
    ret
;===================================================================================================================================================
