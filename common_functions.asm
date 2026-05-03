;====================================================================================================================================================
;Clearing the Screen
clrscr:
        mov ax, 0xb800								
		mov es, ax
		mov di, 0
	    mov cx,2000	
	    mov ax,0x3020
		cld                                   
		rep stosw
		ret			
;===================================================================================================================================================
; Draw Horizontal Line Subroutine
drawHorizontalLine:	push bp
					mov bp, sp

					mov ax, 0xb800				
					mov es, ax
					
					mov ax, [bp + 6]			
					mov bx, 80
					mul bx
					add ax, [bp + 8]			
					shl ax, 1
					mov di, ax
					mov cx, [bp + 4]			
		
HorizontalLineLoop:	mov ax, 0x3F3A				
					mov [es:di], ax				
					add di, 2
					loop HorizontalLineLoop
				
					pop bp
					ret 6
				
drawVerticalLine:	push bp
					mov bp, sp

					mov ax, 0xb800			
					mov es, ax
					
					mov ax, [bp + 6]		
					mov bx, 80
					mul bx
					add ax, [bp + 8]		
					shl ax, 1
					mov di, ax
					mov cx, [bp + 4]		
		
VerticalLineLoop:	mov ax, 0x3F3A
					mov [es:di], ax			
					add di, 160
					loop VerticalLineLoop
				
					pop bp
					ret 6
;===================================================================================================================================================
WhiteHorizontalLine:	push bp
					mov bp, sp

					mov ax, 0xb800				
					mov es, ax
					
					mov ax, [bp + 6]			
					mov bx, 80
					mul bx
					add ax, [bp + 8]			
					shl ax, 1
					mov di, ax
					mov cx, [bp + 4]			
		
WhiteHorizontalLoop:	mov ax, 0x3FDB				
					mov [es:di], ax				
					add di, 2
					loop WhiteHorizontalLoop
				
					pop bp
					ret 6
				
WhiteVerticalLine:	push bp
					mov bp, sp

					mov ax, 0xb800			
					mov es, ax
					
					mov ax, [bp + 6]		
					mov bx, 80
					mul bx
					add ax, [bp + 8]		
					shl ax, 1
					mov di, ax
					mov cx, [bp + 4]		
		
WhiteVerticalLoop:	mov ax, 0x3FDB
					mov [es:di], ax			
					add di, 160
					loop WhiteVerticalLoop
				
					pop bp
					ret 6
;===================================================================================================================================================	
; Draw Text Subroutine
drawText:	push bp
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
				
nextchar:	mov al, [si]					
			mov [es:di], ax						
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
;===================================================================================================================================================	
; Draw Balloon Subroutine
Balloon:	push bp
			mov bp, sp
			
			mov ax, 0xb800					
			mov es, ax
			
			mov al, 80
			mul byte [bp+10]				
			add ax, [bp+8]						
			shl ax, 1
			mov di, ax
			mov si, ax
			mov ax, [bp+6]						
			mov cx, 2 ;3x3
		
row11:		mov [es:di], ax						
			add di, 2
			loop row11
			mov cx, 2
	
col31:   	mov [es:di], ax						
			add di, 160
			loop col31
			mov cx, 2
			
col11:		mov [es:si], ax						
			add si, 160
			loop col11
			mov cx, 3
		
row31:		mov [es:si], ax						
			add si, 2	
			loop row31		

		    sub si, 164
			mov ax, [bp+4]
			mov word [es:si], ax 	
			
			add si, 320
			mov word[es:si], 0x3Fb3			
			add si, 160
			mov word[es:si], 0x3F60        

stop1:		pop bp
			ret	8
;===================================================================================================================================================
; Draw Bird Subroutine
drawBird:
    push bp
    mov bp, sp
    push es
    push di
    push ax
    push bx
    
    mov ax, 0xb800
    mov es, ax
    
    ; Calculate starting position (row, column)
    mov ax, [bp + 4]        ; row
    mov bx, 80
    mul bx
    add ax, [bp + 6]        ; column
    shl ax, 1
    mov di, ax
    
    mov ax, 0x305C
	cld
	stosw
	mov ax, 0x302F
	stosw
	
    pop bx
    pop ax
    pop di
    pop es
    pop bp
    ret 4
;===================================================================================================================================================	
; Printing the Number (Normal)
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
;===================================================================================================================================================				
; Printing the Number (Timer)
printnum_timer: 
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
			
nextdigit_t:
			mov dx,0
			div bx
			add dl,0x30
			push dx
			inc cx
			cmp ax,0
			
			jnz nextdigit_t
			
			push ax
			mov al,80
			mul byte[bp+8]
			add ax,[bp+10]
			shl ax,1
			mov di,ax
			pop ax
			
nextpos_t:
			pop dx
			mov dh,[bp+6]
			mov [es:di],dx
			add di,2
			loop nextpos_t

			pop di
			pop dx
			pop cx
			pop bx
			pop ax
			pop es
			pop bp
			ret 8		
;===================================================================================================================================================				
; Sleep and Delay	
sleep:	push cx				
		mov cx, 0xFFFF
		
delay:	loop delay			
		pop cx
		ret
;===================================================================================================================================================	
scancode_table: db 'ASDFGHJKLQWERTYUIOPZXCVBNM'
; Convert scancode to ASCII letter
scancode_to_letter:
    push bx
  
    cmp al, 0x1E    ; A
    je .is_a
    cmp al, 0x30    ; B
    je .is_b
    cmp al, 0x2E    ; C
    je .is_c
    cmp al, 0x20    ; D
    je .is_d
    cmp al, 0x12    ; E
    je .is_e
    cmp al, 0x21    ; F
    je .is_f
    cmp al, 0x22    ; G
    je .is_g
    cmp al, 0x23    ; H
    je .is_h
    cmp al, 0x17    ; I
    je .is_i
    cmp al, 0x24    ; J
    je .is_j
    cmp al, 0x25    ; K
    je .is_k
    cmp al, 0x26    ; L
    je .is_l
    cmp al, 0x32    ; M
    je .is_m
    cmp al, 0x31    ; N
    je .is_n
    cmp al, 0x18    ; O
    je .is_o
    cmp al, 0x19    ; P
    je .is_p
    cmp al, 0x10    ; Q
    je .is_q
    cmp al, 0x13    ; R
    je .is_r
    cmp al, 0x1F    ; S
    je .is_s
    cmp al, 0x14    ; T
    je .is_t
    cmp al, 0x16    ; U
    je .is_u
    cmp al, 0x2F    ; V
    je .is_v
    cmp al, 0x11    ; W
    je .is_w
    cmp al, 0x2D    ; X
    je .is_x
    cmp al, 0x15    ; Y
    je .is_y
    cmp al, 0x2C    ; Z
    je .is_z
    
    mov al, 0       ; Unknown key
    jmp .done
    
.is_a: mov al, 'A'
    jmp .done
.is_b: mov al, 'B'
    jmp .done
.is_c: mov al, 'C'
    jmp .done
.is_d: mov al, 'D'
    jmp .done
.is_e: mov al, 'E'
    jmp .done
.is_f: mov al, 'F'
    jmp .done
.is_g: mov al, 'G'
    jmp .done
.is_h: mov al, 'H'
    jmp .done
.is_i: mov al, 'I'
    jmp .done
.is_j: mov al, 'J'
    jmp .done
.is_k: mov al, 'K'
    jmp .done
.is_l: mov al, 'L'
    jmp .done
.is_m: mov al, 'M'
    jmp .done
.is_n: mov al, 'N'
    jmp .done
.is_o: mov al, 'O'
    jmp .done
.is_p: mov al, 'P'
    jmp .done
.is_q: mov al, 'Q'
    jmp .done
.is_r: mov al, 'R'
    jmp .done
.is_s: mov al, 'S'
    jmp .done
.is_t: mov al, 'T'
    jmp .done
.is_u: mov al, 'U'
    jmp .done
.is_v: mov al, 'V'
    jmp .done
.is_w: mov al, 'W'
    jmp .done
.is_x: mov al, 'X'
    jmp .done
.is_y: mov al, 'Y'
    jmp .done
.is_z: mov al, 'Z'
    jmp .done
    
.done:
    pop bx
    ret
;===================================================================================================================================================