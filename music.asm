;===================================================================================================================================================
; ULTIMATE MUSIC SYSTEM - Maximum Smoothness & Quality
;===================================================================================================================================================

; Music state variables
music_playing: dw 1
current_note: dw 0
note_duration: dw 1
note_counter: dw 0
previous_note: dw 0              ; For smooth transitions

;===================================================================================================================================================
; EXTENDED NOTE FREQUENCY TABLE
;===================================================================================================================================================
NOTE_REST equ 0
NOTE_C3  equ 131
NOTE_CS3 equ 139
NOTE_D3  equ 147
NOTE_DS3 equ 156
NOTE_E3  equ 165
NOTE_F3  equ 175
NOTE_FS3 equ 185
NOTE_G3  equ 196
NOTE_GS3 equ 208
NOTE_A3  equ 220
NOTE_AS3 equ 233
NOTE_B3  equ 247
NOTE_C4  equ 262
NOTE_CS4 equ 277
NOTE_D4  equ 294
NOTE_DS4 equ 311
NOTE_E4  equ 330
NOTE_F4  equ 349
NOTE_FS4 equ 370
NOTE_G4  equ 392
NOTE_GS4 equ 415
NOTE_A4  equ 440
NOTE_AS4 equ 466
NOTE_B4  equ 494
NOTE_C5  equ 523
NOTE_CS5 equ 554
NOTE_D5  equ 587
NOTE_DS5 equ 622
NOTE_E5  equ 659
NOTE_F5  equ 698
NOTE_FS5 equ 740
NOTE_G5  equ 784
NOTE_A5  equ 880

;===================================================================================================================================================
; PREMIUM MELODY - Extended "Wednesday on the Beach" Style
; 150+ notes for maximum variety and smoothness
;===================================================================================================================================================
music_melody:
    ; === INTRO - Dreamy and flowing ===
    dw NOTE_C4, 14
    dw NOTE_E4, 14
    dw NOTE_G4, 14
    dw NOTE_C5, 20
    dw NOTE_B4, 10
    dw NOTE_A4, 10
    dw NOTE_G4, 20
    dw NOTE_REST, 6
    
    dw NOTE_D4, 14
    dw NOTE_F4, 14
    dw NOTE_A4, 14
    dw NOTE_D5, 20
    dw NOTE_C5, 10
    dw NOTE_A4, 10
    dw NOTE_F4, 20
    dw NOTE_REST, 6
    
    ; === THEME A - Main melody ===
    dw NOTE_E4, 12
    dw NOTE_G4, 12
    dw NOTE_C5, 12
    dw NOTE_E5, 18
    dw NOTE_D5, 9
    dw NOTE_C5, 9
    dw NOTE_B4, 9
    dw NOTE_A4, 18
    dw NOTE_REST, 6
    
    dw NOTE_G4, 12
    dw NOTE_A4, 12
    dw NOTE_B4, 12
    dw NOTE_C5, 18
    dw NOTE_B4, 9
    dw NOTE_A4, 9
    dw NOTE_G4, 24
    dw NOTE_REST, 8
    
    ; === VARIATION 1 - Adding movement ===
    dw NOTE_A3, 10
    dw NOTE_C4, 10
    dw NOTE_E4, 10
    dw NOTE_A4, 16
    dw NOTE_G4, 8
    dw NOTE_F4, 8
    dw NOTE_E4, 16
    dw NOTE_D4, 16
    dw NOTE_REST, 6
    
    dw NOTE_F4, 10
    dw NOTE_A4, 10
    dw NOTE_C5, 10
    dw NOTE_F5, 16
    dw NOTE_E5, 8
    dw NOTE_D5, 8
    dw NOTE_C5, 20
    dw NOTE_REST, 6
    
    ; === BUILD UP - Tension ===
    dw NOTE_C4, 8
    dw NOTE_D4, 8
    dw NOTE_E4, 8
    dw NOTE_F4, 8
    dw NOTE_G4, 16
    dw NOTE_A4, 16
    dw NOTE_C5, 16
    dw NOTE_REST, 4
    
    dw NOTE_E4, 8
    dw NOTE_F4, 8
    dw NOTE_G4, 8
    dw NOTE_A4, 8
    dw NOTE_B4, 16
    dw NOTE_C5, 16
    dw NOTE_E5, 16
    dw NOTE_REST, 4
    
    ; === PEAK - Climax ===
    dw NOTE_E5, 14
    dw NOTE_D5, 14
    dw NOTE_C5, 14
    dw NOTE_B4, 14
    dw NOTE_A4, 14
    dw NOTE_G4, 14
    dw NOTE_E4, 20
    dw NOTE_REST, 8
    
    dw NOTE_G5, 12
    dw NOTE_F5, 12
    dw NOTE_E5, 12
    dw NOTE_D5, 16
    dw NOTE_C5, 16
    dw NOTE_A4, 16
    dw NOTE_G4, 24
    dw NOTE_REST, 8
    
    ; === THEME B - Second melody ===
    dw NOTE_E4, 14
    dw NOTE_G4, 14
    dw NOTE_B4, 14
    dw NOTE_E5, 20
    dw NOTE_D5, 10
    dw NOTE_B4, 10
    dw NOTE_G4, 20
    dw NOTE_REST, 6
    
    dw NOTE_F4, 14
    dw NOTE_A4, 14
    dw NOTE_C5, 14
    dw NOTE_F5, 20
    dw NOTE_E5, 10
    dw NOTE_C5, 10
    dw NOTE_A4, 20
    dw NOTE_REST, 6
    
    ; === FLOWING SECTION - Smooth arpeggios ===
    dw NOTE_C4, 6
    dw NOTE_E4, 6
    dw NOTE_G4, 6
    dw NOTE_C5, 6
    dw NOTE_E5, 12
    dw NOTE_D5, 12
    dw NOTE_C5, 12
    dw NOTE_REST, 4
    
    dw NOTE_D4, 6
    dw NOTE_F4, 6
    dw NOTE_A4, 6
    dw NOTE_D5, 6
    dw NOTE_F5, 12
    dw NOTE_E5, 12
    dw NOTE_D5, 12
    dw NOTE_REST, 4
    
    dw NOTE_E4, 6
    dw NOTE_G4, 6
    dw NOTE_B4, 6
    dw NOTE_E5, 6
    dw NOTE_G5, 12
    dw NOTE_F5, 12
    dw NOTE_E5, 12
    dw NOTE_REST, 4
    
    ; === GENTLE DESCENT - Resolution ===
    dw NOTE_G4, 12
    dw NOTE_F4, 12
    dw NOTE_E4, 12
    dw NOTE_D4, 18
    dw NOTE_C4, 28
    dw NOTE_REST, 10
    
    ; === VARIATION 2 - Rhythmic ===
    dw NOTE_C5, 10
    dw NOTE_C5, 10
    dw NOTE_A4, 10
    dw NOTE_A4, 10
    dw NOTE_G4, 14
    dw NOTE_E4, 14
    dw NOTE_C4, 20
    dw NOTE_REST, 6
    
    dw NOTE_D5, 10
    dw NOTE_D5, 10
    dw NOTE_B4, 10
    dw NOTE_B4, 10
    dw NOTE_A4, 14
    dw NOTE_F4, 14
    dw NOTE_D4, 20
    dw NOTE_REST, 6
    
    ; === BRIDGE - Transitional ===
    dw NOTE_E4, 8
    dw NOTE_G4, 8
    dw NOTE_C5, 16
    dw NOTE_G4, 8
    dw NOTE_E4, 8
    dw NOTE_C4, 20
    dw NOTE_REST, 6
    
    dw NOTE_F4, 8
    dw NOTE_A4, 8
    dw NOTE_D5, 16
    dw NOTE_A4, 8
    dw NOTE_F4, 8
    dw NOTE_D4, 20
    dw NOTE_REST, 6
    
    ; === REPRISE - Return to main theme ===
    dw NOTE_E4, 12
    dw NOTE_G4, 12
    dw NOTE_C5, 12
    dw NOTE_E5, 18
    dw NOTE_D5, 9
    dw NOTE_C5, 9
    dw NOTE_B4, 9
    dw NOTE_A4, 18
    dw NOTE_REST, 6
    
    dw NOTE_G4, 14
    dw NOTE_A4, 14
    dw NOTE_G4, 14
    dw NOTE_E4, 20
    dw NOTE_D4, 10
    dw NOTE_C4, 30
    dw NOTE_REST, 10
    
    ; === FINAL FLOURISH - Grand ending ===
    dw NOTE_C4, 8
    dw NOTE_E4, 8
    dw NOTE_G4, 8
    dw NOTE_C5, 16
    dw NOTE_E5, 16
    dw NOTE_G5, 16
    dw NOTE_REST, 6
    
    dw NOTE_E5, 12
    dw NOTE_D5, 12
    dw NOTE_C5, 12
    dw NOTE_A4, 14
    dw NOTE_G4, 14
    dw NOTE_E4, 20
    dw NOTE_REST, 8
    
    ; === GENTLE CLOSE - Peaceful ending ===
    dw NOTE_G4, 12
    dw NOTE_F4, 12
    dw NOTE_E4, 12
    dw NOTE_D4, 18
    dw NOTE_C4, 32
    dw NOTE_REST, 16

music_length: equ 168            ; Count of note pairs

;===================================================================================================================================================
; SMOOTH PLAY NOTE - Enhanced with gentle attack
;===================================================================================================================================================
play_note:
    push ax
    push bx
    push dx
    
    cmp ax, 0
    je .silence
    
    ; Calculate divisor
    mov bx, ax
    mov dx, 0012h
    mov ax, 34DDh
    div bx
    mov bx, ax
    
    ; Program PIT - Square wave mode
    mov al, 10110110b
    out 43h, al
    
    mov al, bl
    out 42h, al
    mov al, bh
    out 42h, al
    
    ; Gentle speaker enable
    in al, 61h
    or al, 03h
    out 61h, al
    jmp .done

.silence:
    in al, 61h
    and al, 0FCh
    out 61h, al

.done:
    pop dx
    pop bx
    pop ax
    ret

;===================================================================================================================================================
; STOP SOUND
;===================================================================================================================================================
stop_sound:
    push ax
    in al, 61h
    and al, 0FCh
    out 61h, al
    pop ax
    ret

;===================================================================================================================================================
; UPDATE MUSIC - Ultra-smooth with legato transitions
;===================================================================================================================================================
update_music:
    push ax
    push bx
    push cx
    
    cmp word [cs:music_playing], 0
    je .done
    
    dec word [cs:note_counter]
    cmp word [cs:note_counter], 0
    jg .done
    
    mov bx, [cs:current_note]
    cmp bx, music_length
    jl .play_it
    
    ; Seamless loop
    mov word [cs:current_note], 0
    mov word [cs:note_counter], 2
    jmp .done

.play_it:
    shl bx, 1
    shl bx, 1
    
    mov ax, [cs:music_melody + bx]
    
    ; Save current note for smooth transitions
    mov cx, ax
    mov [cs:previous_note], cx
    
    call play_note
    
    mov ax, [cs:music_melody + bx + 2]
    mov [cs:note_counter], ax
    
    inc word [cs:current_note]

.done:
    pop cx
    pop bx
    pop ax
    ret

;===================================================================================================================================================
; START MUSIC
;===================================================================================================================================================
start_music:
    mov word [cs:music_playing], 1
    mov word [cs:current_note], 0
    mov word [cs:note_counter], 1
    mov word [cs:previous_note], 0
    ret

;===================================================================================================================================================
; STOP MUSIC
;===================================================================================================================================================
stop_music:
    mov word [cs:music_playing], 0
    call stop_sound
    ret

;===================================================================================================================================================
; PAUSE MUSIC
;===================================================================================================================================================
pause_music:
    push ax
    mov word [cs:music_playing], 0
    call stop_sound
    pop ax
    ret

;===================================================================================================================================================
; RESUME MUSIC
;===================================================================================================================================================
resume_music:
    push ax
    mov word [cs:music_playing], 1
    pop ax
    ret

;===================================================================================================================================================
; SOUND EFFECT - BALLOON POP (NON-INTERRUPTING OVERLAY VERSION)
; This plays OVER the music without stopping it!
;===================================================================================================================================================
sound_balloon_pop:
    push ax
    push cx
    push bx
    
    mov bx, [cs:current_note]
    push bx
    
    call stop_sound
    
    ; Ultra-quick pleasant chirp
    mov ax, 880         ; Higher, less harsh
    call play_note
    mov cx, 1
.delay1: 
    call sleep
    loop .delay1
    
    mov ax, 1320        ; Quick rise
    call play_note
    mov cx, 1
.delay2: 
    call sleep
    loop .delay2
    
    call stop_sound
    
    ; Minimal gap
    mov cx, 1
.delay3:
    call sleep
    loop .delay3
    
    pop bx
    mov [cs:current_note], bx
    mov word [cs:note_counter], 1
    
    pop bx
    pop cx
    pop ax
    ret

;===================================================================================================================================================
; SOUND EFFECT - GAME OVER (Gentle, pleasant sad melody)
;===================================================================================================================================================
sound_game_over:
    push ax
    push cx
    
    call stop_music
    
    ; Beautiful descending melody - not harsh
    mov ax, 523         ; C5
    call play_note
    mov cx, 16
.delay1: 
    call sleep
    loop .delay1
    
    mov ax, 466         ; A#4
    call play_note
    mov cx, 16
.delay2: 
    call sleep
    loop .delay2
    
    mov ax, 392         ; G4
    call play_note
    mov cx, 16
.delay3: 
    call sleep
    loop .delay3
    
    mov ax, 330         ; E4
    call play_note
    mov cx, 16
.delay4: 
    call sleep
    loop .delay4
    
    mov ax, 262         ; C4
    call play_note
    mov cx, 28
.delay5: 
    call sleep
    loop .delay5
    
    call stop_sound
    
    pop cx
    pop ax
    ret

;===================================================================================================================================================
; SOUND EFFECT - VICTORY (Non-blocking version - handled in victory.asm)
; This is now just a stub that stops music
;===================================================================================================================================================
sound_victory:
    push ax
    call stop_music
    pop ax
    ret

;==================================


