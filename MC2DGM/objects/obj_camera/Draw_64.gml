/*draw_text(20,20,$"{x},{y}")
draw_text(20,40,$"{x/16},{y/16}")
draw_text_scribble(40,40, "[c_black]TEST")
draw_text(20,60,$"X: {currentChunkX}, Y: {currentChunkY}")*/


currentChunkX = int64(x/256)
currentChunkY = int64(y/256)


if(x/256 < 0)
{
	currentChunkX -= 1
}
if(y/256 < 0)
{
	currentChunkY -= 1
}

