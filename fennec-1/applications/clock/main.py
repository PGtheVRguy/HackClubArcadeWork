from PIL import Image, ImageDraw, ImageFont
import RPi.GPIO as GPIO
import sys
import os
import subprocess
from datetime import datetime
import time


sys.path.insert(1, '/home/pi/') # Gets us all the python for rendering and other useful classes/functions
import render
from functions import buttonHandler, mathClass, drawClass
import constants as c

GPIO.setmode(GPIO.BCM)
GPIO.setup(c.b1, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
GPIO.setup(c.b2, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
GPIO.setup(c.b3, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
GPIO.setup(c.b4, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
GPIO.setup(c.bH, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)


image = Image.new("1", (128,64))
draw = ImageDraw.Draw(image)
fnt5x8 = ImageFont.truetype('fonts/5x8.ttf')
fnt5x3 = ImageFont.truetype('fonts/5x3.ttf')

draw.rectangle((0,0, 128, 64), fill = "black")
drawClass.draw_text((128/2, 32), "Test app!", fnt5x8, draw, "center")



while True:
    now = datetime.now()
    """
    %I = The hour in 12 hour time
    %p = AM/PM text
    refer to https://docs.python.org/3/library/datetime.html#strftime-and-strptime-behavior for more notes :3
    """
    current_time = now.strftime("%I:%M:%S %p")
    
    if(buttonHandler.buttonPressed(c.bH)):
        draw.rectangle((0,0, 128, 64), fill = "black")
        drawClass.draw_text((128/2, 32), "Closing", fnt5x8, draw, "center")

        subprocess.Popen(['python', 'menu.py'])
        os._exit(0)
        
    
    draw.rectangle((0,0, 128, 64), fill="black")
    
    
    drawClass.draw_text((128/2,15), "CURRENT TIME", fnt5x3, draw, "center")
    drawClass.draw_text((128/2,32), current_time, fnt5x8, draw, "center")
   
    render.render_image(image)
    time.sleep(1/30)