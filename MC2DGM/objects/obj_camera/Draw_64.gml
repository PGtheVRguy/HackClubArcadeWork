draw_text(20,20,$"{x},{y}")
draw_text(20,40,$"{x/16},{y/16}")

currentChunk = int64(x/256)

if(x/256 < 0)
{
	currentChunk -= 1
}

draw_text(20,60,$"Current Chunk: {currentChunk}")