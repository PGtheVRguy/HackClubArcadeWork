from PIL import Image, ImageDraw
import render
import subprocess
import time
def create_splash_image():
    image = Image.open('splash.png')
    image = image.resize((128, 64)).convert("1")  # Resize and convert to 1-bit mode
    return image

if __name__ == "__main__":
    splash_image = create_splash_image()
    render.render_image(splash_image)
    time.sleep(2)
    subprocess.Popen(['bin/python3', 'menu.py'])
