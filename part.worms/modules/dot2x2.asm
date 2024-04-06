; Based on:
; <Точка Старых>: по координатам, заданным в регистрах L=y, E=x, 
; в произвольном месте экрана (и даже за экран) ставится точка.
; Регистр C равен старшему байту адреса таблиц('TABLE), регистр D=C+2
Set	ld c, DotTable / 256
	ld d, DotTable / 256 + 2
	push hl, de
	call set
	pop de, hl
	inc e
	inc l
set	ld h,c
	ld a,(de)
	inc d    
	or (hl)
	inc h
	ld h,(hl)	
	ld l,a
	ld a, (de)	
	or (hl)	
	ld (hl),a
	ret

ClearLeft	ld c, DotTable / 256
	ld d, DotTable / 256 + 2
	call clear1x1
	inc e
	inc e
	call clear1x1
	inc e
	inc l
	jp clear1x1

ClearRight	ld c, DotTable / 256
	ld d, DotTable / 256 + 2
	call clear1x1
	dec e
	dec e
	call clear1x1
	dec e
	inc l
	jp clear1x1

ClearUp	ld c, DotTable / 256
	ld d, DotTable / 256 + 2
	call clear1x1
	inc l
	inc l
	call clear1x1
	inc l
	inc e
	jp clear1x1

ClearDown	ld c, DotTable / 256
	ld d, DotTable / 256 + 2
	call clear1x1
	dec l
	dec l
	call clear1x1
	dec l
	inc e
	jp clear1x1

clear1x1	push hl, de
	ld h,c
	ld a,(de)
	inc d    
	or (hl)
	inc h
	ld h,(hl)	
	ld l,a
	ld a, (de)
	cpl	
	and (hl)	
	ld (hl),a
	pop de, hl
	ret

clear1x2	push hl, de
	ld h,c
	ld a,(de)
	inc d    
	or (hl)
	inc h
	ld h,(hl)	
	ld l,a
	ld a, (de)
	cpl	
	and (hl)	
	ld (hl),a
	call lib.DownHL
	ld a, (de)
	cpl	
	and (hl)	
	ld (hl),a
	pop de, hl
	ret

	; hl - адрес таблицы 1024 байт + 256
GenTable	ld de, #4000
1 	ld (hl),d  
	dec h       
	ld (hl),e   
	inc h       
	call lib.DownDE
	ld a,d      
	sub 88      
	jr nz, $+3   
	ld d,a      
	inc l       
	jr nz, 1b   
	inc h
	ld a, 128
1 	ld (hl),e  
	inc h      
	ld (hl),a  
	dec h      
	rrca       
	jr nc, $+3  
	inc e 
	inc l      
	jr nz,1b  
	ret
