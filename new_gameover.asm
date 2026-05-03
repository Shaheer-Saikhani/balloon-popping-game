;===================================================================================================================================================
; GAME OVER SCREEN - NEW DESIGN (Fixed Version)
;===================================================================================================================================================

; String definitions (renamed to avoid conflicts)
play_new_o:	db 'RESTART', 0
playlength_new_o: dw 7
difficulty_new_o: db 'MAIN MENU', 0
difficultylength_new_o: dw 9
quit_new_o:	db 'QUIT', 0
quitlength_new_o: dw 4
score_new_o: db 'FINAL SCORE:     ', 0
scorelength_new_o: dw 17

;===================================================================================================================================================
; Helper Functions
;===================================================================================================================================================

; Clear screen with blue background
clrscr3:
    mov ax, 0xb800
    mov es, ax
    mov di, 0
    mov cx, 2000
    mov ax, 0x1020
    cld
    rep stosw
    ret
;===================================================================================================================================================
; Graphics Functions
;===================================================================================================================================================

printMoon2:
    push bp
    mov bp, sp
    push es
    push di
    push ax
    push bx
    push cx

    mov ax, 0xb800
    mov es, ax

    mov ax, [bp + 4]  ; ROW
    mov bx, 80
    mul bx
    add ax, [bp + 6]  ; COLUMN
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
    mov ax, 0x1020
    mov cx, 2
    rep stosw

    add di, 156
    stosw

    add di, 158
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

Mooncloud:
    push bp
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

    mov ax, [bp + 6]  ; ROW
    mov bx, 80
    mul bx
    add ax, [bp + 8]  ; COLUMN
    shl ax, 1
    mov di, ax
    mov cx, [bp + 4]  ; LENGTH
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

blueloop2:
    mov ax, 0x1020
    mov cx, [bp + 4]
    std
    add di, 2
printers:
    stosw
    stosw
    sub di, 4
    sub cx, 2
    cmp cx, 0
    jl printers2
    loop printers

printers2:
    mov ax, [bp + 6]  ; ROW
    mov bx, 80
    mul bx
    add ax, [bp + 8]  ; COLUMN
    shl ax, 1
    mov di, ax
    mov cx, [bp + 4]  ; LENGTH
    mov ax, 0x1020
    cld
    add di, 2

printers2_loop:
    stosw
    stosw
    add di, 4
    sub cx, 2
    cmp cx, 0
    jl printers3
    loop printers2_loop

printers3:
    mov ax, [bp + 6]  ; ROW
    mov bx, 80
    mul bx
    add ax, [bp + 8]  ; COLUMN
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

drawMoonText:
    push bp
    mov bp, sp
    push es
    push ax
    push cx
    push si
    push di

    mov ax, 0xb800
    mov es, ax

    mov ax, [bp + 8]  ; Row
    mov bx, 80
    mul bx
    add ax, [bp + 10]  ; Column
    shl ax, 1
    mov di, ax

    mov si, [bp + 6]  ; String
    mov cx, [bp + 4]  ; Length
    mov ah, [bp + 12]  ; Color

nextchar2:
    mov al, [si]
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

printOver:
    push bp
    mov bp, sp
    push es
    push di
    push ax
    push bx
    push cx

    mov ax, 0xb800
    mov es, ax

    mov ax, [bp + 4]  ; Row
    mov bx, 80
    mul bx
    add ax, [bp + 6]  ; Column
    shl ax, 1
    mov di, ax
    push di
    mov ax, 0x14DB

    ; Letter G
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

    ; Letter A
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

    ; Letter M
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

    ; Letter E
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

    ; Letter O (first)
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

    ; Letter V
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

    ; Letter E (second)
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

    ; Letter R
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

star:
    push bp
    mov bp, sp
    push es
    push di
    push ax
    push bx
    push cx

    mov ax, 0xb800
    mov es, ax

    mov ax, [bp + 4]  ; Row
    mov bx, 80
    mul bx
    add ax, [bp + 6]  ; Column
    shl ax, 1
    mov di, ax
    mov al, 0x2A
    mov ah, [bp + 8]  ; Color

    stosw

    pop cx
    pop bx
    pop ax
    pop di
    pop es
    pop bp
    ret 6

;===================================================================================================================================================
; MAIN GAME OVER SCREEN
;===================================================================================================================================================

over_screen:
    call clrscr3

    ; Draw moon
    mov ax, 35
    push ax
    mov ax, 1
    push ax
    call printMoon2

    ; Draw "GAME OVER" text
    mov ax, 9
    push ax
    mov ax, 7
    push ax
    call printOver

    ; Draw clouds
    mov ax, 6
    push ax
    mov ax, 1
    push ax
    mov ax, 13
    push ax
    call Mooncloud

    mov ax, 62
    push ax
    mov ax, 1
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
    mov ax, 2
    push ax
    mov ax, 12
    push ax
    call star

    mov ax, 0x001E
    push ax
    mov ax, 74
    push ax
    mov ax, 10
    push ax
    call star

    mov ax, 0x0017
    push ax
    mov ax, 21
    push ax
    mov ax, 5
    push ax
    call star

    ; RESTART button
    mov ax, 0x001F
    push ax
    mov ax, 37
    push ax
    mov ax, 20
    push ax
    mov ax, play_new_o
    push ax
    mov ax, [playlength_new_o]
    push ax
    call drawMoonText

    mov ax, 35
    push ax
    mov ax, 19
    push ax
    mov ax, 3
    push ax
    call WhiteVerticalLine

    mov ax, 35
    push ax
    mov ax, 19
    push ax
    mov ax, 10
    push ax
    call WhiteHorizontalLine

    mov ax, 45
    push ax
    mov ax, 19
    push ax
    mov ax, 3
    push ax
    call WhiteVerticalLine

    mov ax, 35
    push ax
    mov ax, 21
    push ax
    mov ax, 10
    push ax
    call WhiteHorizontalLine

    ; MAIN MENU button
    mov ax, 0x001D
    push ax
    mov ax, 7
    push ax
    mov ax, 20
    push ax
    mov ax, difficulty_new_o
    push ax
    mov ax, [difficultylength_new_o]
    push ax
    call drawMoonText

    mov ax, 5
    push ax
    mov ax, 19
    push ax
    mov ax, 3
    push ax
    call WhiteVerticalLine

    mov ax, 5
    push ax
    mov ax, 19
    push ax
    mov ax, 12
    push ax
    call WhiteHorizontalLine

    mov ax, 17
    push ax
    mov ax, 19
    push ax
    mov ax, 3
    push ax
    call WhiteVerticalLine

    mov ax, 5
    push ax
    mov ax, 21
    push ax
    mov ax, 12
    push ax
    call WhiteHorizontalLine

    ; QUIT button
    mov ax, 0x0014
    push ax
    mov ax, 69
    push ax
    mov ax, 20
    push ax
    mov ax, quit_new_o
    push ax
    mov ax, [quitlength_new_o]
    push ax
    call drawMoonText

    mov ax, 67
    push ax
    mov ax, 19
    push ax
    mov ax, 3
    push ax
    call WhiteVerticalLine

    mov ax, 67
    push ax
    mov ax, 19
    push ax
    mov ax, 7
    push ax
    call WhiteHorizontalLine

    mov ax, 74
    push ax
    mov ax, 19
    push ax
    mov ax, 3
    push ax
    call WhiteVerticalLine

    mov ax, 67
    push ax
    mov ax, 21
    push ax
    mov ax, 7
    push ax
    call WhiteHorizontalLine

    ; Score display
    mov ax, 0x001E
    push ax
    mov ax, 32
    push ax
    mov ax, 15
    push ax
    mov ax, score_new_o
    push ax
    mov ax, [scorelength_new_o]
    push ax
    call drawMoonText

    mov ax, 45
    push ax
    mov ax, 15
    push ax
    mov ax, 0x001E
    push ax
    push word [cs:score_value]
    call printnum

    ; Score box
    mov ax, 29
    push ax
    mov ax, 13
    push ax
    mov ax, 5
    push ax
    call WhiteVerticalLine

    mov ax, 30
    push ax
    mov ax, 13
    push ax
    mov ax, 21
    push ax
    call WhiteHorizontalLine

    mov ax, 51
    push ax
    mov ax, 13
    push ax
    mov ax, 5
    push ax
    call WhiteVerticalLine

    mov ax, 30
    push ax
    mov ax, 17
    push ax
    mov ax, 21
    push ax
    call WhiteHorizontalLine

    ret
