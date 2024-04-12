DisplayFrame    ld hl,FRAME_0000
                jp(hl)

NextFrame	ld HL,FRAMES
	inc hl : inc hl
	ld a,l
	cp low(FRAMES_END)
	jp nz, 1f
	ld a,h
	cp high(FRAMES_END)
	jp nz,1f
	ld hl,FRAMES
1	ld (NextFrame+1),hl
	ld e, (hl)
	inc hl
	ld d,(hl)
	ex de,hl
	ld (DisplayFrame+1),hl
	ret

FRAMES
	dw FRAME_0000
	dw FRAME_0001
	dw FRAME_0002
	dw FRAME_0003
	dw FRAME_0004
	dw FRAME_0005
	dw FRAME_0006
	dw FRAME_0007
	dw FRAME_0008
	dw FRAME_0009
	dw FRAME_000a
	dw FRAME_000b
	dw FRAME_000c
	dw FRAME_000d
	dw FRAME_000e
	dw FRAME_000f
	dw FRAME_0010
FRAMES_END
FRAME_0000	include "res/0000.asm"
FRAME_0001	include "res/0001.asm"
FRAME_0002	include "res/0002.asm"
FRAME_0003	include "res/0003.asm"
FRAME_0004	include "res/0004.asm"
FRAME_0005	include "res/0005.asm"
FRAME_0006	include "res/0006.asm"
FRAME_0007	include "res/0007.asm"
FRAME_0008	include "res/0008.asm"
FRAME_0009	include "res/0009.asm"
FRAME_000a	include "res/000a.asm"
FRAME_000b	include "res/000b.asm"
FRAME_000c	include "res/000c.asm"
FRAME_000d	include "res/000d.asm"
FRAME_000e	include "res/000e.asm"
FRAME_000f	include "res/000f.asm"
FRAME_0010	include "res/0010.asm"
