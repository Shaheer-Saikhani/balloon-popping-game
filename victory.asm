;===================================================================================================================================================
; Print Victory Heading Subroutine
printVictory:	push bp
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
				mov ax, 0x1EDB
				
				; Drawing V
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
				
				; Drawing I
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
				
				; Drawing C
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
				
				; Drawing T
				pop di
				add di, 12
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
				
				; Drawing O
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
				std
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
				sub di, 158
				stosw
				
				; Drawing R
				pop di
				cld
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
				cld
				stosw
				add di, 162
				stosw
				add di, 160
				stosw
				
				; Drawing Y
				pop di
				add di, 14
				push di
				stosw
				add di, 160
				stosw
				add di, 160
				stosw
				add di, 158
				stosw
				add di, 158
				stosw
				pop di
				add di, 8
				stosw
				add di, 156
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
; Draw Half Moon Subroutine
drawSemiMoon: 	push bp
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
; Victory Sound Data
victory_sound_note: dw 0

victory_melody_data:
    ; Gentle opening (frames 1-5)
    dw 523      ; C5
    dw 587      ; D5
    dw 659      ; E5
    dw 698      ; F5
    dw 784      ; G5
    
    ; Peaceful peak (frames 6-9)
    dw 880      ; A5
    dw 784      ; G5
    dw 698      ; F5
    dw 659      ; E5
    
    ; Soothing middle section (frames 10-14)
    dw 587      ; D5
    dw 523      ; C5
    dw 587      ; D5
    dw 659      ; E5
    dw 698      ; F5
    
    ; Uplifting resolution (frames 15-18)
    dw 784      ; G5
    dw 659      ; E5
    dw 698      ; F5
    dw 784      ; G5
    
    ; Graceful finale (frames 19-21)
    dw 880      ; A5
    dw 784      ; G5
    dw 523      ; C5 

victory_melody_notes: equ 21
;===================================================================================================================================================
; Play next note in victory sequence
victory_play_next_note:
    push ax
    push bx
    
    mov bx, [victory_sound_note]
    cmp bx, victory_melody_notes
    jge .done
    
    ; Play current note
    shl bx, 1
    mov ax, [cs:victory_melody_data + bx]
    call play_note
    
    ; Move to next note
    inc word [victory_sound_note]

.done:
    pop bx
    pop ax
    ret
;===================================================================================================================================================
; Play final triumphant note
victory_play_final_note:
    push ax
    ;Play the next note from sequence
    call victory_play_next_note
    pop ax
    ret
;===================================================================================================================================================
; Victory Animation Sequence - Sound plays IN PARALLEL with animation
victory_animation_sequence:
    push ax
    push cx
    push bx
    
    ; Initialize victory screen position
    mov word [victory_col], 20
    mov word [victory_row], 20
    
    ; Initialize sound variables
    mov word [victory_sound_note], 0
    
    ; Stop background music
    call stop_music
    
    ; ANIMATION LOOP - 21 frames with continuous music 
    
    ; Frame 1 - Initial position + C4
    call victory_play_next_note
    call draw_victory_frame
    call victory_frame_delay
    
    ; Frame 2 - Move + E4
    add word [victory_col], 1
    sub word [victory_row], 1
    call victory_play_next_note
    call draw_victory_frame
    call victory_frame_delay
    
    ; Frame 3 - Move + G4
    add word [victory_col], 1
    sub word [victory_row], 1
    call victory_play_next_note
    call draw_victory_frame
    call victory_frame_delay
    
    ; Frame 4 - Move + C5
    add word [victory_col], 1
    sub word [victory_row], 1
    call victory_play_next_note
    call draw_victory_frame
    call victory_frame_delay
    
    ; Frame 5 - Move + E5
    sub word [victory_col], 1
    sub word [victory_row], 1
    call victory_play_next_note
    call draw_victory_frame
    call victory_frame_delay
    
    ; Frame 6 - Move + G5
    sub word [victory_col], 1
    sub word [victory_row], 1
    call victory_play_next_note
    call draw_victory_frame
    call victory_frame_delay
    
    ; Frame 7 - Move + C6 (peak!)
    sub word [victory_col], 1
    sub word [victory_row], 1
    call victory_play_next_note
    call draw_victory_frame
    call victory_frame_delay
    
    ; Frame 8 - Move + B5
    sub word [victory_col], 1
    sub word [victory_row], 1
    call victory_play_next_note
    call draw_victory_frame
    call victory_frame_delay
    
    ; Frame 9 - Move + A5
    sub word [victory_col], 1
    sub word [victory_row], 1
    call victory_play_next_note
    call draw_victory_frame
    call victory_frame_delay
    
    ; Frame 10 - Move + G5
    sub word [victory_col], 1
    sub word [victory_row], 1
    call victory_play_next_note
    call draw_victory_frame
    call victory_frame_delay
    
    ; Frame 11 - Move + E5
    add word [victory_col], 1
    sub word [victory_row], 1
    call victory_play_next_note
    call draw_victory_frame
    call victory_frame_delay
    
    ; Frame 12 - Move + D5
    add word [victory_col], 1
    sub word [victory_row], 1
    call victory_play_next_note
    call draw_victory_frame
    call victory_frame_delay
    
    ; Frame 13 - Move + C5
    add word [victory_col], 1
    sub word [victory_row], 1
    call victory_play_next_note
    call draw_victory_frame
    call victory_frame_delay
    
    ; Frame 14 - Move + A4
    add word [victory_col], 1
    sub word [victory_row], 1
    call victory_play_next_note
    call draw_victory_frame
    call victory_frame_delay
    
    ; Frame 15 - Move + G4
    add word [victory_col], 1
    sub word [victory_row], 1
    call victory_play_next_note
    call draw_victory_frame
    call victory_frame_delay
    
    ; Frame 16 - Move + C5
    add word [victory_col], 1
    sub word [victory_row], 1
    call victory_play_next_note
    call draw_victory_frame
    call victory_frame_delay
    
    ; Frame 17 - Move + E5
    add word [victory_col], 1
    sub word [victory_row], 1
    call victory_play_next_note
    call draw_victory_frame
    call victory_frame_delay
    
    ; Frame 18 - Move + G5
    add word [victory_col], 1
    sub word [victory_row], 1
    call victory_play_next_note
    call draw_victory_frame
    call victory_frame_delay
    
    ; Frame 19 - Move + C6
    add word [victory_col], 1
    sub word [victory_row], 1
    call victory_play_next_note
    call draw_victory_frame
    call victory_frame_delay
    
    ; Frame 20 - Move + D6
    sub word [victory_col], 1
    sub word [victory_row], 1
    call victory_play_next_note
    call draw_victory_frame
    call victory_frame_delay
    
    ; Frame 21 - Final position + E6 (GRAND FINALE!)
    sub word [victory_col], 1
    sub word [victory_row], 1
    call victory_play_next_note
    call draw_victory_frame
    call victory_frame_delay
    
    ; Hold final note longer
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
; Draw single victory frame
draw_victory_frame:
    push ax
    
    call clrscr3
    call victory_background_elements
    
    mov ax, [victory_col]
    push ax
    mov ax, [victory_row]
    push ax
    call printVictory
    
    pop ax
    ret
;===================================================================================================================================================
; Draw background elements (clouds, stars, moon)
victory_background_elements:
    push ax
    
    ; Draw clouds
    mov ax, 8
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
    mov ax, 28
    push ax
    mov ax, 3
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
    
    mov ax, 0x001B
    push ax
    mov ax, 12
    push ax
    mov ax, 0
    push ax
    call star
    
    mov ax, 0x001E
    push ax
    mov ax, 2
    push ax
    mov ax, 3
    push ax
    call star
    
    mov ax, 0x0017
    push ax
    mov ax, 78
    push ax
    mov ax, 7
    push ax
    call star
    
    mov ax, 0x0013
    push ax
    mov ax, 77
    push ax
    mov ax, 1
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
    mov ax, 7
    push ax
    mov ax, 7
    push ax
    call star
    
    mov ax, 0x001E
    push ax
    mov ax, 70
    push ax
    mov ax, 8
    push ax
    call star
    
    mov ax, 0x0017
    push ax
    mov ax, 21
    push ax
    mov ax, 7
    push ax
    call star
    
    ; Draw moon
    mov ax, 72
    push ax
    mov ax, 0
    push ax
    call drawSemiMoon
    
    pop ax
    ret
;===================================================================================================================================================
; Frame Delay 
victory_frame_delay:
    push cx
    mov cx, 4
.delay_loop:
    call sleep
    loop .delay_loop
    pop cx
    ret
;===================================================================================================================================================
