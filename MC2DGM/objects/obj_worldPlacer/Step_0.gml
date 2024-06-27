/*try
{
	array_get(global.chunks, obj_camera.currentChunk)
}
catch(_exception)
{
	generateChunk(obj_camera.currentChunk, map_id)
}
*/



if(ds_map_find_value(global.chunks, obj_camera.currentChunk) == undefined)
{
	generateChunk(obj_camera.currentChunk, map_id)
}