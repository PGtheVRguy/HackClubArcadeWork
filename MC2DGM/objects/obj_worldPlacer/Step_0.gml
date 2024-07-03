/*try
{
	array_get(global.chunks, obj_camera.currentChunk)
}
catch(_exception)
{
	generateChunk(obj_camera.currentChunk, map_id)
}
*/
/*


if(ds_map_find_value(global.chunks, obj_camera.currentChunk) == undefined)
{
	generateChunk(obj_camera.currentChunk, map_id)
}
*/
/*
if(ds_map_find_value(global.chunks, obj_camera.currentChunkX) == undefined)
{
	generateChunk(obj_camera.currentChunkX, obj_camera.currentChunkY)
}
else
{
	var _cs = ds_map_find_value(global.chunks, obj_camera.currentChunkX)
	//show_debug_message(_cs)
	if(ds_map_find_value(_cs, obj_camera.currentChunkY) == undefined)
	{
		var _debug = ds_map_find_first(_cs)
		repeat(100)
		{
			if(_debug != undefined)
			{
				show_debug_message(_debug)
			}
			_debug = ds_map_find_next(_cs, _debug)
		}
		
		
		show_debug_message("COULDNT FIND Y")
		generateChunk(obj_camera.currentChunkX, obj_camera.currentChunkY)
	}
}

*/

try
{
	var e = ds_map_find_value(ds_map_find_value(global.chunks, obj_camera.currentChunkX), obj_camera.currentChunkY)
}
catch(_exception)
{
	show_debug_message("GENERATING FROM WORLDPLACER OBJECT")
	generateChunk(obj_camera.currentChunkX, obj_camera.currentChunkY)
}