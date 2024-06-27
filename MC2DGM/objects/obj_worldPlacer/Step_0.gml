try
{
	array_get(global.chunks, obj_camera.currentChunk)
}
catch(_exception)
{
	generateChunk(obj_camera.currentChunk, map_id)
}