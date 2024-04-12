; DE = starting screen address (#4000, #c000, etc...)
playerReset     equ $+1
play	        ld	hl, 0
	        ld	c,(hl)  :  inc hl	; Screen shift
                ld	b,(hl)  :  inc hl
                ex	de,hl
                add	hl,bc
                ld	b,0
cycle	        ld	a,(de)  :  inc de
                ld	c,a
                add	a
                jr	nc,2f
                jp	m, nextFrame
                ; long jump
                ld	a,c
                and	#0f
                add	a,h : ld h,a
                bit	4,c
                jr	z, cycle
                ld	c,#80
                add	hl,bc
                jp	cycle
    
2	        jp	m,nearJmp
                inc	c
                ex	de,hl
                ldir
                ex	de,hl
                jp	cycle
    
nearJmp         res	6,c
                inc	c
                add	hl,bc
                jp	cycle
nextFrame       ld	(play+1),de
                ret


	        module movingRightFast
FRAME_0000	include "moving-right-fast/0000.asm"
FRAME_0001	include "moving-right-fast/0001.asm"
FRAME_0002	include "moving-right-fast/0002.asm"
FRAME_0003	include "moving-right-fast/0003.asm"
FRAME_0004	include "moving-right-fast/0004.asm"
FRAME_0005	include "moving-right-fast/0005.asm"
FRAME_0006	include "moving-right-fast/0006.asm"
FRAME_0007	include "moving-right-fast/0007.asm"
FRAME_0008	include "moving-right-fast/0008.asm"
FRAME_END
                endmodule

	        module movingRight
FRAME_0000	include "moving-right/0000.asm"        
FRAME_0001	include "moving-right/0001.asm"
FRAME_0002	include "moving-right/0002.asm"
FRAME_0003	include "moving-right/0003.asm"
FRAME_0004	include "moving-right/0004.asm"
FRAME_0005	include "moving-right/0005.asm"
FRAME_0006	include "moving-right/0006.asm"
FRAME_0007	include "moving-right/0007.asm"
FRAME_0008	include "moving-right/0008.asm"
FRAME_0009	include "moving-right/0009.asm"
FRAME_000a	include "moving-right/000a.asm"
FRAME_000b	include "moving-right/000b.asm"
FRAME_000c	include "moving-right/000c.asm"
FRAME_000d	include "moving-right/000d.asm"
FRAME_000e	include "moving-right/000e.asm"
FRAME_000f	include "moving-right/000f.asm"
; FRAME_0010	include "moving-right/0010.asm"
FRAME_END
                endmodule