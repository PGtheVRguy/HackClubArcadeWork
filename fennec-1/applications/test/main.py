from PIL import Image, ImageDraw, ImageFont
import rotary_encoder
import RPi.GPIO as GPIO
import sys
import os
import subprocess
import time

sys.path.insert(1, '/home/pi/')
import render
from functions import buttonHandler, mathClass, drawClass
import constants as c


image = Image.new("1", (128,64))
draw = ImageDraw.Draw(image)
fnt5x8 = ImageFont.truetype('fonts/5x8.ttf')

draw.rectangle((0,0, 128, 64), fill = "black")
drawClass.draw_text((128/2, 32), "Test app!", fnt5x8, draw, "center")
time.sleep(1)

counter = 0

def increment():
    global counter
    counter += 1
    print(counter)


def decrement():
    global counter
    counter -= 1
    print(counter)


def press():
    print("PRESS")


def release():
    print("RELEASE")




with rotary_encoder.connect(
    clk_pin=20,                           # required
    dt_pin=21,                            # required
    on_clockwise_turn=increment,          # optional
    on_counter_clockwise_turn=decrement,  # optional
):
    print('hey uwu')
    draw.rectangle((0,0, 128, 64), fill = "black")

    drawClass.draw_text((128/2, 32), counter, fnt5x8, draw, "center")

    render.render_image(image)

