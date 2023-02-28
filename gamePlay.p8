pico-8 cartridge // http://www.pico-8.com
version 38
__lua__
--웃eu de plateforme dansante

function _init()
	create_player()
	timer = 1
	colors_square={
	64,68,72,76,
	128,132,
	136,140,192
	}
	random_color ={
	{0,0,0},
	{0,0,0},
	{0,0,0}
	}
	loop_end = false
	startgame = false
	--fjnzdkz
end

function _update()
	timer_color()
	update_camera()
	check_flag()
	player_movement()
	starter()
end

function _draw()
 cls()
	draw_map()
	create_plateform()
	
	if timer == 0 then
		loop_end = false
		create_plateform()
		timer = 3
	end
	print("time: ",40,128)
	print(timer,60,128)
	draw_player()
	if startgame == false then
		print("start", 55, 256-64)
	end

end
-->8
--map

function draw_map()
	map(0,0,0,0,128,64)
end

function check_flag(flag,x,y)
	local sprite=mget(x,y)
	return fget(sprite,flag)
end

function update_camera()
	local camx=flr(p.x/16)*16
	local camy=flr(p.y/16)*16
	camera(camx*8,camy*8)
end

function next_tile(x,y)
 sprite=mget(x,y)
	mset(x,y,sprite+1)
end

function pick_up_key(x,y)
	next_tile(x,y)
	p.keys+=1
end

function open_door(x,y)
	next_tile(x,y)
	p.keys-=1
end


-->8
--player

function create_player()
	p={
		x=14,
		y=1,
		sprite=10,
		keys=0
		}
end

function draw_player()
	spr(p.sprite,p.x*8,p.y*8)
end

function player_movement()
	newx=p.x
	newy=p.y
	if (btnp(➡️)) newx+=1
	if (btnp(⬅️)) newx-=1
	if (btnp(⬇️)) newy+=1
	if (btnp(⬆️)) newy-=1
	
	interact(newx,newy) 

	if not check_flag(0,newx,newy) then
		p.x=mid(0,newx,127)
		p.y=mid(0,newy,63)
		else
		sfx(0)
	end
end

function interact(x,y)
	if check_flag(1,x,y) then
		pick_up_key(x,y)
	elseif check_flag(2,x,y)
	and p.keys>=1 then
		open_door(x,y)
	end
end

function timer_color()
	timer -= 0.1
	
	if timer <= 0 then
		timer = 0
	end
	if timer <= 10 then
		color(8)
	end
end

-->8
-- plateform~=

function create_plateform()

if loop_end == false then
	for i=1,3 do
		for j=1,3 do
			random_color[i][j] = rnd(colors_square)
			if j >= 2 then
				while random_color[i][j] == random_color[i][j-1] do
					random_color[i][j] = rnd(colors_square)
				end
			end
			if i >= 2 then
				while random_color[i][j] == random_color[i-1][j] do
					random_color[i][j] = rnd(colors_square)
				end
			end
		end
	end
	loop_end = true
end

	for i=1,3 do
		for j=1,3 do
			if i == 2 and j == 2 then
			else
			spr(random_color[i][j],
			i*32-16,j*32+128-16,4,4)
			end
		end
	end
end
-->8
-- gameplay

function starter ()
 if p.x >= 48 and p.x <= 80 and
	p.y >=48+128 and p.y <= 80+128 then
	startgame = true 
	end
end
__gfx__
00000000000000007777777788888888444444888844444488888888444444440888888033333333007770008888888844444488bbbbbbbb8444444444444444
0000000000000000777777778888888844444488884444448844484444444444882820883333333307fff7008888888844444488bbbbbbbb844444444ffffff4
007007000000000077777777444444444444448888444444844444444444444482020002333333337f2ff2204444448844444488bbbbbbbb8444444444f44444
0007700000000000777777774444444444444488884444448444444444444444820200023333333378ffff704444448844444488bbbbbbbb844444444ffffff4
00077000000000007777777744444444444444888844444488444444444444442000020233333333788888704444448844444488bbbbbbbb844444444444f444
00700700000000007777777744444444444444888844444488444444444444448000022233333333077777004444448844444488bbbbbbbb844448844ffffff4
00000000000000007777777744444444444444888844444488444444888888888222222233333333071111004444448888888888bbbbbbbb844488844ffffff4
00000000000000007777777744444444444444888844444488444444888888880022222033333333078008004444448888888888bbbbbbbb8888888844444444
00000000000000003333333300000000000000000000000000000000000000000000000029a2222888a999a90000000000000000000000000000000000000000
00000000000000003333b33300000000000000000000000000000000000000000000000098298292988899990000000000000000000000000000000000000000
0000000000000000b3b33b330000000000000000000000000000000000000000000000002a2a922a9899889a0000000000000000000000000000000000000000
00000000000000003b33333300000000000000000000000000000000000000000000000022822a22999a98990000000000000000000000000000000000000000
00000000000000003333333b0000000000000000000000000000000000000000000000002892a98299aa99990000000000000000000000000000000000000000
000000000000000033b333b30000000000000000000000000000000000000000000000002a2a8222a99999a90000000000000000000000000000000000000000
000000000000000033bb3333000000000000000000000000000000000000000000000000892922a9999999990000000000000000000000000000000000000000
0000000000000000333333330000000000000000000000000000000000000000000000009892a298999999990000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000033333333333333333333333300000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000333b3333333333333333333300000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b3b33333333333333333333300000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003b33333b33333a333333333300000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000333333b33aaaa3a33333333300000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000333333333a333a333333333300000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000044444444333333333333333300000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000cccccccc333333333333333300000000
00000000000000000000000000000000000000000000000000000000000000000000000033bbbb333bbbbbb30000000014444100144200010000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000003bbaabb3bbbaabb30000000044444449445200000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000003bbbab13bbbbabbb0000000094050509955200000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000003bbbb313bbbbbbb10000000094444444954200000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000313b3313bbbbbab30000000044444149444200000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000003311113311b333330000000094444649944200000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000033322333331333330000000094242444942000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000033144233313333330000000042242424420000000000000000000000
11111111111111111111111111111111222222222222222222222222222222223333333333333333333333333333333344444444444444444444444444444444
11111111111111111111111111111111222222222222222222222222222222223333333333333333333333333333333344444444444444444444444444444444
11111111111111111111111111111111222222222222222222222222222222223333333333333333333333333333333344444444444444444444444444444444
11111111111111111111111111111111222222222222222222222222222222223333333333333333333333333333333344444444444444444444444444444444
11111111111111111111111111111111222222222222222222222222222222223333333333333333333333333333333344444444444444444444444444444444
11111111111111111111111111111111222222222222222222222222222222223333333333333333333333333333333344444444444444444444444444444444
11111111111111111111111111111111222222222222222222222222222222223333333333333333333333333333333344444444444444444444444444444444
11111111111111111111111111111111222222222222222222222222222222223333333333333333333333333333333344444444444444444444444444444444
11111111111111111111111111111111222222222222222222222222222222223333333333333333333333333333333344444444444444444444444444444444
11111111111111111111111111111111222222222222222222222222222222223333333333333333333333333333333344444444444444444444444444444444
11111111111111111111111111111111222222222222222222222222222222223333333333333333333333333333333344444444444444444444444444444444
11111111111111111111111111111111222222222222222222222222222222223333333333333333333333333333333344444444444444444444444444444444
11111111111111111111111111111111222222222222222222222222222222223333333333333333333333333333333344444444444444444444444444444444
11111111111111111111111111111111222222222222222222222222222222223333333333333333333333333333333344444444444444444444444444444444
11111111111111111111111111111111222222222222222222222222222222223333333333333333333333333333333344444444444444444444444444444444
11111111111111111111111111111111222222222222222222222222222222223333333333333333333333333333333344444444444444444444444444444444
11111111111111111111111111111111222222222222222222222222222222223333333333333333333333333333333344444444444444444444444444444444
11111111111111111111111111111111222222222222222222222222222222223333333333333333333333333333333344444444444444444444444444444444
11111111111111111111111111111111222222222222222222222222222222223333333333333333333333333333333344444444444444444444444444444444
11111111111111111111111111111111222222222222222222222222222222223333333333333333333333333333333344444444444444444444444444444444
11111111111111111111111111111111222222222222222222222222222222223333333333333333333333333333333344444444444444444444444444444444
11111111111111111111111111111111222222222222222222222222222222223333333333333333333333333333333344444444444444444444444444444444
11111111111111111111111111111111222222222222222222222222222222223333333333333333333333333333333344444444444444444444444444444444
11111111111111111111111111111111222222222222222222222222222222223333333333333333333333333333333344444444444444444444444444444444
11111111111111111111111111111111222222222222222222222222222222223333333333333333333333333333333344444444444444444444444444444444
11111111111111111111111111111111222222222222222222222222222222223333333333333333333333333333333344444444444444444444444444444444
11111111111111111111111111111111222222222222222222222222222222223333333333333333333333333333333344444444444444444444444444444444
11111111111111111111111111111111222222222222222222222222222222223333333333333333333333333333333344444444444444444444444444444444
11111111111111111111111111111111222222222222222222222222222222223333333333333333333333333333333344444444444444444444444444444444
11111111111111111111111111111111222222222222222222222222222222223333333333333333333333333333333344444444444444444444444444444444
11111111111111111111111111111111222222222222222222222222222222223333333333333333333333333333333344444444444444444444444444444444
11111111111111111111111111111111222222222222222222222222222222223333333333333333333333333333333344444444444444444444444444444444
5555555555555555555555555555555566666666666666666666666666666666bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccccccccccccccccc
5555555555555555555555555555555566666666666666666666666666666666bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccccccccccccccccc
5555555555555555555555555555555566666666666666666666666666666666bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccccccccccccccccc
5555555555555555555555555555555566666666666666666666666666666666bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccccccccccccccccc
5555555555555555555555555555555566666666666666666666666666666666bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccccccccccccccccc
5555555555555555555555555555555566666666666666666666666666666666bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccccccccccccccccc
5555555555555555555555555555555566666666666666666666666666666666bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccccccccccccccccc
5555555555555555555555555555555566666666666666666666666666666666bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccccccccccccccccc
5555555555555555555555555555555566666666666666666666666666666666bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccccccccccccccccc
5555555555555555555555555555555566666666666666666666666666666666bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccccccccccccccccc
5555555555555555555555555555555566666666666666666666666666666666bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccccccccccccccccc
5555555555555555555555555555555566666666666666666666666666666666bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccccccccccccccccc
5555555555555555555555555555555566666666666666666666666666666666bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccccccccccccccccc
5555555555555555555555555555555566666666666666666666666666666666bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccccccccccccccccc
5555555555555555555555555555555566666666666666666666666666666666bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccccccccccccccccc
5555555555555555555555555555555566666666666666666666666666666666bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccccccccccccccccc
5555555555555555555555555555555566666666666666666666666666666666bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccccccccccccccccc
5555555555555555555555555555555566666666666666666666666666666666bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccccccccccccccccc
5555555555555555555555555555555566666666666666666666666666666666bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccccccccccccccccc
5555555555555555555555555555555566666666666666666666666666666666bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccccccccccccccccc
5555555555555555555555555555555566666666666666666666666666666666bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccccccccccccccccc
5555555555555555555555555555555566666666666666666666666666666666bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccccccccccccccccc
5555555555555555555555555555555566666666666666666666666666666666bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccccccccccccccccc
5555555555555555555555555555555566666666666666666666666666666666bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccccccccccccccccc
5555555555555555555555555555555566666666666666666666666666666666bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccccccccccccccccc
5555555555555555555555555555555566666666666666666666666666666666bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccccccccccccccccc
5555555555555555555555555555555566666666666666666666666666666666bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccccccccccccccccc
5555555555555555555555555555555566666666666666666666666666666666bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccccccccccccccccc
5555555555555555555555555555555566666666666666666666666666666666bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccccccccccccccccc
5555555555555555555555555555555566666666666666666666666666666666bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccccccccccccccccc
5555555555555555555555555555555566666666666666666666666666666666bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccccccccccccccccc
5555555555555555555555555555555566666666666666666666666666666666bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccccccccccccccccc
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020
__gff__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000200000000000000000000000101000500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
3a3a3a3a3a3a3a3a3a3a3a3a3a3a3a3a02020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202
3a09120909090909090909090909093a02020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202
3a093a3a3a3a3a3a3a3a3a3a3a3a3a3a02020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202
3a093a09090909120909090909093a3a02020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202
3a093a3a3a3a093a3a3a3a3a3a3a3a3a02020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202
3a09090909090909090909090912093a02020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202
3a3a3a3a3a3a3a3a3a093a3a3a3a3a3a02020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202
3a3a2d0909120909090909090909123a02020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202
3a3a09093a3a3a3a3a3a3a3a3a3a093a02020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202
3a3a3a3a3a090909090909091209093a02020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202
3a09090909093a3a3a3a3a3a3a3a3a3a02020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202
3a093a093a093a3a3a3a3a3a3a3a3a3a02020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202
3a123a093a090909090909090912093a02020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202
3a093a093a3a3a3a3a3a3a3a3a3a3a3a02020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202
3a3a3a3c3a3a3a3a3a3a3a3a3a3a3a3902020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202
2c2c2c0f2c2c2c2c2c2c2c2c2c2c2c2c02020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202
0603030f03030303030303030303030b02020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202
0508190f19191919191919081919190402020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202
0519020202020202020202020202080402020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202
0519020202020202020202020202190402020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202
0519020202020202020202020202190402020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202
0519020202020202020202020202190402020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202
0519020202020202020202020202190402020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202
0519020202020202020202020202190402020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202
0519020202020202020202020202190402020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202
0519020202020202020202020202190402020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202
0519020202020202020202020202190402020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202
0519020202020202020202020202190402020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202
0519020202020202020202020202190402020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202
0519020202020202020202020202190402020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202
05081919191908190f1919191919080402020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202
0e070707070707070f0707070707070c02020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202
__sfx__
000b00002107021070000002107021070210702107021070210702107023070230702407024070230702307021070000002107021070210702107021070210702107021070210700000021070000002107021070
000b00001f070000001f070000001f0700000021070210701f070000001f0701f0701d070000001d0701d0701c070000001c0701c0701c0701c0701c0701c0701c0701c070000001c0701c0701d0701d0701c070
000b0000000001c0701c0701d0701d0701d0701c070000001c070000001c070000001c070000001a070000001a0701a070000001c0701c070000001a0701a0701a070000001a070000001c07000000000001c070
000b00001c070000001c0701c070000001c0701c0701c0701c0701c070000001c0701c07020070000002007000000200702107021070230702307023070230702307023070000000000000000210702107021070
000b0000210702107021070210702107000000210700000021070000002107000000210702107021070210702107021070210702107021070000002107021070000002107000000210702107021070210701f070
000b0000000001f070000001f0702107021070210701f070000001f070000001f070000001f0701f0701f0701d0701d0701d070000001c0701c0701c0701c0701c0701c0701c070000001c070000001d0701d070
000b00001d0701c070000001c070000001c0701d0701d0701d0701c070000001c070000001c0701c0701c070000001a0701a070000001a0701a070000001c0701c070000001a0701a0701a070000001a07000000
000b00001c070000001c0701c070000001c0701c070000001c0701c0701c0701c0701c070000001c0701c07020070000002007020070200702107021070210702307023070230702307023070000002107000000
000b00002107021070210700000000000000002107021070210700000021070210702107021070210700000021070210702107021070210700000021070210700000021070210701f0701f0701f0700000021070
000b00000000021070210701f070000001f070000001f0702107021070210701f070000001f0701f0701d070000001d0701d0701c070000001c070000001c0701d0701d0701d0701c0701c0701c0701c07000000
000b00001c0701d0701d0701c070000001c070000001c0701d0701d0701c0701c0701c070000001c070000001c0701c0701a070000001a070000001a0701c0701c0701c0701a0701a0701a070000001a0701a070
000b0000000001c070000001c0701c070000001c0701c070000001c0701c0701c0701c0701c070000001c0701c0701c0701c07020070200702007021070210702107023070230702307023070230702307000000
000b00000000021070210702107021070210702107021070210702107021070210700000023070230702407024070210702107021070210702107021070210702107021070000002107000000210702107000000
000b00002107021070210701f070000001f070000001f0702107021070210701f070000001f070000001f070000001f0701f0701f0701f0701f0701f0701f0701f0701f0701f0701f0701f07000000000001c070
000b00001c0701d0701d0701c070000001c070000001c0701d0701d0701d0701c0701c070000001c070000001c070000001d0701d0701c0701c070000001a0701a070000001c0701c0701c0701c0701c07000000
000b00001c070000001c070000001c0701c070000001c0701c070000001c0701c0701c0701c07020070200701c0701c0701c07000000200702007020070210702107021070230702307023070000000000020070
000b00002007020070200700000021070210702107021070210702107021070210702107021070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000b00000000000000190500000000000000002005000000000000000020050000000000020050000001c05000000000002105000000000001b0500000000000000001b0500000000000000001b0500000000000
000b00000000000000190500000000000000002005000000000000000020050000000000020050000001c05000000000002105000000000001b0500000000000000001b0500000000000000001b0500000015050
000b000000000190200000000000000002002000000000000000020020000000000020020000001c02000000000002102000000000001b0200000000000000001b0200000000000000001b020000000000000000
000b00000000000000000000000000000000001c0601c0601c0601c06000000000001c060000001c0601c0601c0601c06000000000001c060000001c060000001c06000000000001e06000000000001b0601b060
000b000000000190200000000000200200000000000000002002000000000002002000000000001c02000000000002102000000000001b0200000000000000000000000000000000000000000000000000000000
010b0000000000000000000000001b050000001c0501c0501c0501c05000000000001c050000001c0501c0501c0501c05000000000001c050000001c050000001c0501c050000001e06000000000001b0501b050
000b000000000000001b050000001b060000001c0701c0701c0701c07000000000001c050000001c0501c0501c0501c05000000000001c050000001c050000001c0501c05000000000001e05000000000001b050
000b1c0000000190200000000000200200000000000000002002000000000002002000000000001c02000000000002102000000000001b0200000000000000000000000000000000000001400014000140001400
000b00001b05000000000001b050000001b060000001c0501c0501c0501c05000000000001c050000001c0501c0501c0501c05000000000001c050000001c050000001c05000000000001e05000000000001b060
000b000000740007400074000740197400074000740007400a7400074000740007401874000740007400074000740007400574008740007400074000740197400074000740007400274004740007400074000740
000b00000000000000190000000000000000002000000000000000000020000000000000020000000001c00000000000002100000000000001b0000000000000000001b0000000000000000001b0000000000000
000f0000140000000000000190000000000000200000000000000000002000000000000002000000000000001c00000000000002100000000000001b000000000000000000000000000000000000000000000000
000f000000000190000000000000000002000000000000000000020000000000000020000000001c00000000000002100000000000001b0000000000000000001b0000000000000000001b000000000000000000
000f00000000000000000000000000000000001c0001c0001c0001c00000000000001c000000001c0001c0001c0001c00000000000001c000000001c000000001c00000000000001e00000000000001b0001b000
000f000000000190000000000000200000000000000000002000000000000002000000000000001c00000000000002100000000000001b0000000000000000000000000000000000000000000000000000000000
000f0000000000000000000000001b000000001c0001c0001c0001c00000000000001c000000001c0001c0001c0001c00000000000001c000000001c000000001c0001c000000001e00000000000001b0001b000
010b000000000000000000000000000002c0002c0002c0002c0002c0002c0002c0002c0002c0002c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000f000000000000001b050000001b060000001c0701c0701c0701c07000000000001c050000001c0501c0501c0501c05000000000001c050000001c050000001c0501c05000000000001e05000000000001b050
000f1c0000000190500000000000200600000000000000002005000000000002005000000000001c05000000000002105000000000001b0500000000000000000000000000000000000001400014000140001400
000f00001b05000000000001b050000001b060000001c0501c0501c0501c05000000000001c050000001c0501c0501c0501c05000000000001c050000001c050000001c05000000000001e05000000000001b060
000b000022000220002200022000220003005035050380503a0502200000000250002500022000220000000000000290002900029000290002900029000250002500025000250002500000000240002400024000
000b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000027000000000000000000000000000000000000000000000000
000b00002400024000240002400024000240002400024000240002700027000270002700027000270002700027000270002700027000000002000000000220002300023000000002200020000000002000020000
000b0000000001d0001b00020000200001b0000000020000000001b0002000020000200001d0001d000000002000020000200001b0001b0001b00000000000000000022000220002200022000220002200022000
000b00002200022000220002200025000250002500025000250002500025000250002500025000250000000025000250002200000000000002900029000290002900029000250002500025000250002500000000
000f00002700027000270002700027000270002700027000270002700027000240002400024000240002400024000240002400024000240002400000000000000000022000270002700023000000002000000000
000f0000000001d0000000020000200001d0000000022000270002300027000220000000027000200000000027000270002700027000270002700027000270002700020000200002000020000200002000020000
000f00002000020000000000000000000200000000022000270002400000000220002700027000270002700024000240002400000000220002700024000220002700020000000002200022000220002200022000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002000020000200002100021000
000f00000000000000000002700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000f0000220002200022000270000000027000270002700000000220002400024000240002400024000240000000022000000002400024000240000000000000000000000000000000001d000000000000027000
001000001c000000001c0001c000000001d0001d0001c000000001c000000001c000000001c0001c0001a0001a000000001a0001a0001c0001c0001a0001a000000001a0001a0001c000000001c0001c00000000
001000001c0001c0001c0001c0001c0001c0001c0001c0001c0001c0001c000200000000020000200002000021000210002100023000230002300020000200002000020000200002100021000210002100021000
000f00002900029000000002700027000270000000024000250002400000000200002000020000200002000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000f00000000000000000000000029000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000f00000000000000000000000000000000000000000000000000000000000000002c0002c0002c0002c0002c0002c0002c0002c0002c0002c0002c0002c0002c0002c0002c0002c0002c0002c0000000000000
000f00000000020000000002200029000250000000022000270002700023000240000000020000200002000020000200002000020000200002000020000200002000020000200002000020000200002000020000
000f00000000000000000000000000000000000000000000000000000000000000002c0002c0002c0002c0002c0002c0002c0002c0002c0002c0002c0002c0002c0002c0002c0000000000000000000000000000
000f00002000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000027000270002700000000000000003000000000000000000000
000f000000000000000000000000200002000022000270002400025000000002200027000270002400000000200002000020000000002000020000200000000000000000002a0002a0002a0002a0002a0002a000
000f00002a0002a000290002900000000000002a0002a0002c0002a00029000000000000027000000000000000000200002c00000000200002000020000200002000020000200002000020000200002000020000
000f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000027000270000000000000000000000000000000000000000000
000f0000200002000020000200002000020000200002000000000220002700000000250002900000000220002700027000000002000020000000002000020000000000000000000000002a0002a0002a0002a000
000f00000000000000000000000000000000000000000000000000000000000000000000000000000000000027000270002700000000000000000000000000000000000000000000000000000000000000000000
000f00002a0002a0002a0002c0002a000290002900000000000002a0002a0002a0002a00029000290000000000000270002700000000000002c0002c000200002000000000200002000020000200002000020000
000f00002000020000200002000020000200002000020000200002000020000000002200027000270002700027000270002300022000000002000000000200002000020000200002000020000200002000020000
__music__
00 41404040
00 41404040
01 00004040
00 01014040
00 02024040
00 03034040
00 04044040
00 05054040
00 06064040
00 07074040
00 08084040
00 09094040
00 0a0a4040
00 0b0b4040
00 0c0c4040
00 0d0d4040
00 0e0e4040
00 0f0f4040
02 10104040
01 51404040
01 12124040
00 13141340
00 15161540
00 13171340
02 18191840
00 1b404040
00 1c404040
00 1d1e4040
00 1f204040
00 1d224040
04 23244040
00 62404040
00 25404040
00 64404040
00 65664040
00 67404040
00 68404040
00 69404040
00 6a404040
00 6b404040
00 6c6e4040
00 6f404040
00 72734040
00 74744040
00 75404040
00 75764040
00 77784040
00 79404040
00 7a7b4040
00 7c7d4040
00 7e404040
00 7f404040
00 80404040
00 80404040
00 80404040
00 80404040
00 80404040
00 80404040
00 80404040
00 80404040
00 80404040
00 80404040
00 80404040
00 80404040

