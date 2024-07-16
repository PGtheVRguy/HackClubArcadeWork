

x = following.x
y = following.y

x = int64(x)
y = int64(y)

if(keyboard_check(vk_add))
{
	zoom -= 0.1
	camWidth = 455*zoom
	camHeight = 256*zoom
	//display_set_gui_size(455*zoom,256*zoom)
	camera_set_view_size(view_camera[0],camWidth,camHeight)

}
if(keyboard_check(vk_subtract))
{
	zoom += 0.1
	camWidth = 455*zoom
	camHeight = 256*zoom
	//display_set_gui_size(455*zoom,256*zoom)
	camera_set_view_size(view_camera[0],camWidth,camHeight)

}