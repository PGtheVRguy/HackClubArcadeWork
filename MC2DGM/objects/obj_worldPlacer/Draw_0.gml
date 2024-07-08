var _renderDis = 4
var _rp = []
_rp[0] = -_renderDis/2
_rp[1] = -_renderDis/2


//renderChunk(obj_camera.currentChunkX, obj_camera.currentChunkY)


repeat(_renderDis) //x
{ 
	
	repeat(_renderDis) //y
	{
		_rp[0]++
		renderChunk(obj_camera.currentChunkX+_rp[0], obj_camera.currentChunkY+_rp[1])
	}
	_rp[1]++
	_rp[0] = -_renderDis/2
}


