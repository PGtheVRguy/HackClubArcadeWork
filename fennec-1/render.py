from luma.core.interface.serial import spi
from luma.oled.device import ssd1309
from luma.core.render import canvas


serial = spi(device=0, port=0)
device = ssd1309(serial)


def render_image(draw):

    
    with canvas(device) as draw_canvas:
        print("rendering image")
        draw_canvas.rectangle(device.bounding_box, outline="white", fill="black")
        draw_canvas.bitmap((0, 0), draw, fill="white")
        draw_canvas.rectangle(device.bounding_box, outline="white", fill="black")

if __name__ == "__main__":

    pass
