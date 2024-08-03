from PIL import Image, ImageDraw, ImageFont, ImageSequence
import RPi.GPIO as GPIO
import sys
import os
import subprocess
from datetime import datetime
import time

sys.path.insert(1, '/home/pi/')  # Gets us all the python for rendering and other useful classes/functions
import render
from functions import buttonHandler, mathClass, drawClass
import constants as c

# GPIO setup
GPIO.setmode(GPIO.BCM)
GPIO.setup(c.b1, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
GPIO.setup(c.b2, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
GPIO.setup(c.b3, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
GPIO.setup(c.b4, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
GPIO.setup(c.bH, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)

# Create new image for the display
image = Image.new("1", (128, 64))
draw = ImageDraw.Draw(image)
fnt5x8 = ImageFont.truetype('fonts/5x8.ttf')
fnt5x3 = ImageFont.truetype('fonts/5x3.ttf')

# Initial display
draw.rectangle((0, 0, 128, 64), fill="black")
drawClass.draw_text((128 / 2, 32), "Test app!", fnt5x8, draw, "center")
render.render_image(image)

# Load the GIF
gif = Image.open('applications/rambley/rambley.gif')  # Adjust the path accordingly

# Function to check button press
def check_button():
    return GPIO.input(c.bH) == GPIO.HIGH

while True:
    for frame in ImageSequence.Iterator(gif):
        if check_button():
            draw.rectangle((0, 0, 128, 64), fill="black")
            drawClass.draw_text((128 / 2, 32), "Closing", fnt5x8, draw, "center")
            render.render_image(image)  # Update the display with the closing message
            subprocess.Popen(['python3', 'menu.py'])  # Use python3 for consistency
            os._exit(0)

        # Resize the frame to fit the display
        frame = frame.resize((128, 64), Image.ANTIALIAS)
        # Convert the frame to 1-bit image to match the display mode
        frame = frame.convert("1")
        render.render_image(frame)
        time.sleep(1 / 30)
