/*vertex_format_begin()

vertex_format_add_position_3d()
vertex_format_add_normal()
vertex_format_add_color()
vertex_format_add_texcoord()


format = vertex_format_end()*/


zoom = 4


camWidth = 455*zoom
camHeight = 256*zoom
display_set_gui_size(455*zoom,256*zoom)
camera_set_view_size(view_camera[0],camWidth,camHeight)

targetPlayer = self

oMx = mouse_x
oMy = mouse_y

_x = x
_y = y

moveSpeed = 4

