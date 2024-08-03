from PIL import Image, ImageDraw, ImageFont
import RPi.GPIO as GPIO
import sys
import os
import subprocess
import time
import wifi
from wifi import Cell, Scheme


sys.path.insert(1, '/home/pi/')
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

draw.rectangle((0,0, 128, 64), fill = "black")
drawClass.draw_text((128/2, 32), "Not implemented", fnt5x8, draw, "center")


class keyboard():
    keyLow = Image.open('assets/as_key_low.png').convert("1")
    keyHigh = Image.open('assets/as_key_upp.png').convert("1")
    cursor = Image.open('assets/as_key_sel.png').convert("1")

    mode = 0
    chosenKeyboard = keyLow
    if(mode == 1): # upper case
        row1 = ['~','!','@','#','$','%','^','&','*',"(",')','_','+']
        row2 =  ['Q','W','E','R','T','Y','U','I','O','P','{','}','|']
        row3 = ['█','A','S','D','F','G','H','J','K','L',':','"','█']
        row4 = ['█','█','Z','X','C','V','B','N','M','<','>','?','█']
        row5 = ['CAPS', 'CAPS', 'CAPS', 'CAPS','█', '█', ' ', ' ', ' ', ' ', ' ', '█', '█']
        mainRow = [row1, row2, row3, row4, row5]
    if(mode == 0):
        row1 = ['`','1','2','3','4','5','6','7','8','9','0','-','=']
        row2 = ['q','w','e','r','t','y','u','i','o','p','[',']','\\']
        row3 = ['█','a','s','d','f','g','h','j','k','l',';',"'",'█']
        row4 = ['█','█','z','x','c','v','b','n','m',',','.','/','█','█']
        row5 = ['CAPS', 'CAPS', 'CAPS', 'CAPS','█', '█', ' ', ' ', ' ', ' ', ' ', '█', '█']
        mainRow = [row1, row2, row3, row4, row5]
    selX = 0
    selY = 3

    def changeCasing():
        if(keyboard.mode == 0):
            keyboard.mode = 1
            keyboard.chosenKeyboard = keyboard.keyHigh
        else:
            keyboard.mode = 0
            keyboard.chosenKeyboard = keyboard.keyLow

    def getKey(self):
        key = self.mainRow[self.selY][self.selX]
        if(key != '█'):
            if key != 'CAPS':
                print(key)
        if(key == 'CAPS'):
            self.changeCasing()
class settingsNavigation():
    moveStates = ["men_wifi"]
    setCur = 0
    def drawScreen(self, draw):
        print('drawing wifi')
        drawClass.draw_text((15, 5), "Wifi", fnt5x8, draw)
        drawClass.draw_text((6, 5+10*self.setCur), ">", fnt5x8, draw)
class settingsWifi():
    findWifi = False


keyboardOpen = False
state = "nav_set"
while True:
    if(buttonHandler.buttonPressed(c.bH)):
        draw.rectangle((0,0, 128, 64), fill = "black")
        drawClass.draw_text((128/2, 32), "Closing", fnt5x8, draw, "center")

        subprocess.Popen(['python', 'menu.py'])
        os._exit(0)

    draw.rectangle((0,0, 128, 64), fill = "black")
    

    if(state == "nav_set"):
        settingsNavigation.drawScreen(settingsNavigation, draw)

        if(buttonHandler.buttonPressed(2)):
            settingsNavigation.setCur -= 1
        if(buttonHandler.buttonPressed(3)):
            settingsNavigation.setCur += 1
        settingsNavigation.setCur = mathClass.clamp(settingsNavigation.setCur, 0, 5)
        if(buttonHandler.buttonPressed(6)):
            print('a')
            state = settingsNavigation.moveStates[settingsNavigation.setCur]
    if(state == "men_wifi"):
        drawClass.draw_text((0,0), "wifi", fnt5x8, draw)
        this = settingsWifi
        if(not this.findWifi):
            networks = Cell.all('wlan0')
            #this.findWifi = True
            if networks:
                this.available_networks = networks
                this.findWifi = True
            else:
                this.available_networks = []
                this.findWifi = False
        i = 0
        #print('test')
        available_networks = this.available_networks
        #print(available_networks)
        for network in available_networks:
            print(network.ssid)
            drawClass.draw_text((10, 10+(15*i)), (f"wifi:{network.ssid}"), fnt5x8, draw)
            i += 1


    if(keyboardOpen == True):
        if(buttonHandler.buttonPressed(c.b2)):
            keyboard.selX += 1
        if(buttonHandler.buttonPressed(c.b3)):
            keyboard.selY += 1
        draw.bitmap((0,0), keyboard.chosenKeyboard, fill = "white")
        draw.bitmap(((keyboard.selX*5)-keyboard.selX,(keyboard.selY*7)- keyboard.selY), keyboard.cursor, fill = "white")
        #drawClass.draw_text((128/2, 50), "Not implemented", fnt5x8, draw, "center")

        if(keyboard.selX > 12):
            keyboard.selX = 0
            #keyboard.selY += 1
        if(keyboard.selY > 4):
            keyboard.selY = 0
        #keyboard.getKey(keyboard)
        if(buttonHandler.buttonPressed(6, swapped = True)):
            keyboard.getKey(keyboard)

    #print(state)
    render.render_image(image)
    time.sleep(1/30)
    #print(keyboard.mainRow[keyboard.selY][keyboard.selX])