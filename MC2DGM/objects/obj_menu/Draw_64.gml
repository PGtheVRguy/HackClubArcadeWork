draw_text_scribble(guiWidth()/2,64,"[fa_center]2D Tile Game")



draw_text_scribble(guiWidth()/2,120,"[fa_center]Play")
if(mouseAt(guiWidth()/2, 130, 64, 6) && (input_check_pressed("lclick")))
{
	room_goto(Room1)
}


draw_text_scribble(guiWidth()/2,140,"[fa_center]Website")

if(mouseAt(guiWidth()/2, 150, 64, 6)  && (input_check_pressed("lclick")))
{
	url_open("http://fennecs.dev")
}

draw_text_scribble(guiWidth()/2,guiHeight()-5,"[fa_center][fa_bottom][scale,0.5]This is really early and super broken")

