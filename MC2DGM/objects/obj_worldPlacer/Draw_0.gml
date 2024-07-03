

renderChunk(obj_camera.currentChunkX, obj_camera.currentChunkY)

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

