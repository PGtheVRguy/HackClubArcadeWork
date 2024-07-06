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

/*
if(mouse_check_button(mb_left))
{
	var mx = tilemap_get_cell_x_at_pixel(map_id, mouse_x, mouse_y);
	//show_debug_message(mx)
	var my = tilemap_get_cell_y_at_pixel(map_id, mouse_x, mouse_y);
	var data = tilemap_get(map_id, mx, my);

	//show_debug_message($"Placing tile {_t} at {_rx},{_ry}")

	var ind = tile_get_index(data);
	data = tile_set_index(data, 1);
	
	tilemap_set_at_pixel(map_id, data, mouse_x, mouse_y); 
}

