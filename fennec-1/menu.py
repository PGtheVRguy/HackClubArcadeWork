from PIL import Image, ImageDraw, ImageFont
import render
from functions import buttonHandler, mathClass, drawClass
import RPi.GPIO as GPIO
import json
import time
import subprocess
import os
from datetime import datetime
import asyncio
import constants as c


GPIO.setmode(GPIO.BCM)
GPIO.setup(c.b1, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
GPIO.setup(c.b2, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
GPIO.setup(c.b3, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
GPIO.setup(c.b4, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
GPIO.setup(c.bH, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)



cursor = 0
image = Image.new("1", (128, 64))
draw = ImageDraw.Draw(image)
visCursor = -1
cursorVert = 0

fnt7x11 = ImageFont.truetype('fonts/7x11.ttf')
fnt5x8 = ImageFont.truetype('fonts/5x8.ttf')
fnt5x3 = ImageFont.truetype('fonts/5x3.ttf')

last_input_time = time.time()

delayedInput = False

class applications:
    applicationArray = os.listdir("applications/")
    icons = []
    jsons = []

    @classmethod
    def load_icons_and_jsons(cls):
        for i in cls.applicationArray:
            print(i)
            cls.icons.append(Image.open('applications/' + str(i) + '/icon.png').convert('1'))
            cls.jsons.append(json.loads(open('applications/' + str(i) + '/data.json').read()))

    @classmethod
    def renderIcons(cls, draw, cursor):
        for i in range(len(cls.applicationArray)):
            draw.bitmap((5 + 47 * (i - cursor), (32 - 24/2) + cursorVert), cls.icons[i], fill="white")

def create_menu_image():
    draw.rectangle((0, 0, 128, 64), fill="black")
    applications.renderIcons(draw, visCursor)
    drawClass.draw_text((128 / 2, 50 + cursorVert), applications.jsons[cursor]['name'], fnt5x3, draw, "center")
    
    now = datetime.now()
    if (32 - 64 + cursorVert) > 0:
        drawClass.draw_text((128 / 2, (32 - 64) + cursorVert), now.strftime("%I:%M %p"), fnt5x8, draw, "center")
    
    return image



def main():
    global visCursor, cursor, last_input_time, cursorVert, joke, delayedInput
    #joke_task = asyncio.create_task(createJoke())
    
    applications.load_icons_and_jsons()
    menu_image = create_menu_image()
    render.render_image(menu_image)
    previous_menu_image = menu_image.copy()

    while True:
        print(cursor)
        visCursor = mathClass.lerp(visCursor, cursor - 1, 0.15)
        if buttonHandler.buttonPressed(c.b1):
            cursor -= 1
            last_input_time = time.time()
        if buttonHandler.buttonPressed(c.b2):
            cursor += 1
            last_input_time = time.time()

        if buttonHandler.buttonPressed(c.bH):
            if(delayedInput > 60):
                print("Quitting app!")
                draw.rectangle((0, 0, 128, 64), fill="black")
                appName = applications.jsons[cursor]['name']
                drawClass.draw_text((128 / 2, 32), "Loading " + str(appName), fnt5x3, draw, "center")
                render.render_image(image)
                #await asyncio.sleep(0.5)
                subprocess.Popen(['python3', 'applications/' + str(applications.jsons[cursor]['prgm'])])
                GPIO.cleanup()
                os._exit(0)
        if(delayedInput <= 60):
            delayedInput += 1
        if cursor > len(applications.applicationArray) - 1:
            cursor = 0
        if cursor < 0:
            cursor = len(applications.applicationArray) - 1

        menu_image = create_menu_image()
        render.render_image(menu_image)
        previous_menu_image = menu_image.copy()
        
        end_time = time.time()
        elapsed_time = end_time - last_input_time
        
        clockShown = elapsed_time > 5
        
        if clockShown:
            cursorVert = mathClass.lerp(cursorVert, 64, 0.05)
        else:
            cursorVert = mathClass.lerp(cursorVert, 0, 0.15)
        time.sleep(1/30)
        #await asyncio.sleep(1 / 30)

if __name__ == "__main__":
    main()
