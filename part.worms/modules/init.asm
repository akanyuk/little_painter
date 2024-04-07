Init	ld hl, RndTable
1	ld a, r
	ld (hl), a
	inc l
	ld a, l : or a : jr nz, 1b
	
 	ld hl, DotTable + 256
	jp dot2x2.GenTable

colors1	db #42, #43, #42, #43, #42, #43, #42, #43
colors2	db #41, #42, #43, #44, #41, #42, #43, #44
colors4	db #42, #43, #42, #43, #42, #43, #42, #43
colors5	db #42, #42, #42, #42, #42, #42, #42, #42

Scene1	ld a, 2 : ld (SPEED), a

	ld d, 3 ; cols
	ld e, 2 ; rows
	call pillars_data.SetupDimension

	ld d, 80 ; margin X
	ld e, 56 ; margin Y
	call pillars_data.SetupMargins

	ld d, %01111111 ; empty color
	ld e, %01111111 ; busy color
	call pillars_data.SetupColors

	ld a, 40 ; margin between pillars
	call pillars_data.Build

	ld a, 2 : ld (NUM_WORMS), a

	ld a, 12 ; min length 
	ld hl, colors1
	call worms_data.Build

	call worms_data.Reset
	jp pillars_data.Show

Scene2	ld a, 2 : ld (SPEED), a

	ld d, 5 ; cols
	ld e, 2 ; rows
	call pillars_data.SetupDimension

	ld d, 40 ; margin X
	ld e, 56 ; margin Y
	call pillars_data.SetupMargins

	ld d, %01111111 ; empty color
	ld e, %01111111 ; busy color
	call pillars_data.SetupColors

	ld a, 40 ; margin between pillars
	call pillars_data.Build

	ld a, 8 : ld (NUM_WORMS), a

	ld a, 12 ; min length 
	ld hl, colors2
	call worms_data.Build

	call worms_data.Reset
	jp pillars_data.Show

Scene3	ld a, 1 : ld (SPEED), a

	ld d, 5 ; cols
	ld e, 4 ; rows
	call pillars_data.SetupDimension

	ld d, 40 ; margin X
	ld e, 16 ; margin Y
	call pillars_data.SetupMargins

	ld d, %01111111 ; empty color
	ld e, %01111111 ; busy color
	call pillars_data.SetupColors

	ld a, 40 ; margin between pillars
	call pillars_data.Build

	ld a, 12 : ld (NUM_WORMS), a

	ld a, 7 ; min length 
	ld hl, colors2
	call worms_data.Build

	call worms_data.Reset
	jp pillars_data.Show

Scene4	ld a, 1 : ld (SPEED), a

	ld d, 10 ; cols
	ld e, 6 ; rows
	call pillars_data.SetupDimension

	ld d, 16 ; margin X
	ld e, 16 ; margin Y
	call pillars_data.SetupMargins

	ld d, %00001001 ; empty color
	ld e, %01111111 ; busy color
	call pillars_data.SetupColors

	ld a, 24 ; margin between pillars
	call pillars_data.Build

	ld a, 14 : ld (NUM_WORMS), a

	ld a, 7 ; min length 
	ld hl, colors4
	call worms_data.Build

	call worms_data.Reset
	jp pillars_data.Show

Scene5	ld a, 2 : ld (SPEED), a

	ld d, 11 ; cols
	ld e, 7 ; rows
	call pillars_data.SetupDimension

	ld d, 0 ; margin X
	ld e, 0 ; margin Y
	call pillars_data.SetupMargins

	ld d, %00000000 ; empty color
	ld e, %01011011 ; busy color
	call pillars_data.SetupColors

	ld a, 24 ; margin between pillars
	call pillars_data.Build

	ld a, 18 : ld (NUM_WORMS), a

	ld a, 7 ; min length 
	ld hl, colors5
	call worms_data.Build

	call worms_data.Reset
	jp pillars_data.Show

