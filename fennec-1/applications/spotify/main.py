from spotipy.oauth2 import SpotifyClientCredentials
import spotipy.util as util
import requests
from io import BytesIO
import time
import asyncio
import os
import spotipy
from PIL import ImageDraw, Image, ImageFont
import RPi.GPIO as GPIO
import sys
import subprocess



#function path
sys.path.insert(1, '/home/pi/')

from functions import buttonHandler, mathClass, drawClass
import render
import constants as c

GPIO.setmode(GPIO.BCM)
print("STARTING SPOTIFY PROGRAM")

client_id = "7194c587b6b84818bd904241c7df6d29"
secret_id = "f865a906a28e456db51384c7bbeabc81"
os.environ['SPOTIPY_CLIENT_ID'] = client_id
os.environ["SPOTIPY_CLIENT_SECRET"] = secret_id

SPOTIPY_CLIENT_ID = '7194c587b6b84818bd904241c7df6d29'

spotify = spotipy.Spotify(auth_manager=SpotifyClientCredentials())

scope = 'user-read-currently-playing'

redirect_uri = "http://localhost:8080"

username = "SprigaritoFan"  # Replace with real username
#username = input("Username??? : \n")
coolAssBarRes = 1.5  # default is 1 (10 bars)

token = util.prompt_for_user_token(username, scope, client_id=client_id, client_secret=secret_id,
                                   redirect_uri=redirect_uri)

spotify = spotipy.Spotify(auth=token)

#spotify constants
imgSize = (32, 32)
fnt7x11 = ImageFont.truetype('fonts/7x11.ttf')
fnt5x8 = ImageFont.truetype('fonts/5x8.ttf')
fnt5x3 = ImageFont.truetype('fonts/5x3.ttf')

titleWrapVal = 0
authorWrapVal = 0

image = Image.new("1", (128, 64))
draw = ImageDraw.Draw(image)
draw.rectangle((0,0, 128, 64), fill = "black")
drawClass.draw_text((128/2, 32), "Spotify Init...", fnt5x3, draw, "center")

render.render_image(image)

# CONTROLS
GPIO.setup(c.b1, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
GPIO.setup(c.b2, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
GPIO.setup(c.b3, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
GPIO.setup(c.b4, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
GPIO.setup(c.bH, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
class cached:
    imageFile = None
    imageSongName = "song"
    title = "song"  # defaults in case catching song fails
    author = "author"
    imageURL = "no image"
    progress = 0
    duration = 0
    percComp = 0.69
    progTime = 0
    titleFont = fnt5x8
    authorFont = fnt5x8

    wrapTitle = False
    wrapAuthor = False

def msToNorm(timeInMs):
    # progress
    sec = timeInMs / 1000
    min = 0
    for i in range(int(timeInMs / 1000 / 60)):
        sec -= 60
        min += 1
    sec = round(sec)
    if (sec < 10):
        sec = "0" + str(sec)
    return (min, sec)


async def findImage(url, name):
    print("Hunting down new image")
    response = requests.get(url)
    img = Image.open(BytesIO(response.content))


    img = img.resize(imgSize)  # make sure to resize before compressing colors
    #img = img.convert("L")
    img = img.convert("1")

    cached.imageFile = img
    cached.imageSongName = name
    cached.imageFile.save('icon.png')
    print("New image found uwu")

async def findData(current_track):
    try:
        cached.title = current_track['item']['name']
        cached.author = current_track["item"]["artists"][0]['name']
        cached.imageURL = current_track["item"]['album']["images"][0][
            'url']  # In theory the only thing you will need to not constantly grab is the image, everything else is in this json thingy

        cached.progress = current_track["progress_ms"]
        cached.duration = current_track["item"]["duration_ms"]

        cached.percComp = cached.progress / cached.duration
        # print("Found data!")
    except TypeError:
        print("fuck")
    # time.sleep(1)
async def IncrementTimer():
    time.sleep(1)
    cached.progTime += 1000
draw.rectangle((0,0, 128, 64), fill = "black")
drawClass.draw_text((128/2, 32), "READY!", fnt5x3, draw, "center")
render.render_image(image)
try:
    while True:
        current_track = spotify.current_user_playing_track()
        asyncio.run(findData(current_track)) # Current track stuff
        #time.sleep(0.05) # Small delay mainly for the terminal, everything else is async so should be fine running max speed

        title = cached.title # Moves cache data to local (no reason besides poor planning)
        author = cached.author
        imageURL = cached.imageURL
        progress = cached.progress
        duration = cached.duration
        percComp = cached.percComp
        titleFont = cached.titleFont
        authorFont = cached.authorFont
        wrapTitle = cached.wrapTitle
        wrapAuthor = cached.wrapAuthor

        # getting image
        if title != cached.imageSongName:
            asyncio.run(findImage(imageURL, title))
            cached.titleFont = fnt5x8
            cached.authorFont = fnt5x8
            cached.wrapTitle = False
            cached.wrapAuthor = False
            print("noah waz here")
            #for fnt5x8
            if(fnt5x8.getbbox(title)[2] > (128 - imgSize[0]+5) - 12):
                cached.titleFont = fnt5x3
            if(fnt5x8.getbbox(author)[2] > (128 - imgSize[0]+5) - 2):
                cached.authorFont = fnt5x3

            if(fnt5x3.getbbox(title)[2] > (128 - imgSize[0]+5) - 12):
                cached.wrapTitle = True
            if(fnt5x3.getbbox(author)[2] > (128 - imgSize[0]+5) - 2):
                cached.wrapAuthor = True
            authorWrapVal = 0
            titleWrapVal = 0
            
        # Cool ass bar
        coolAssBar = "["
        for i in range(int(percComp * coolAssBarRes * 10)): #for the amount done
            coolAssBar = coolAssBar + "#"
        for i in range(int((1 - percComp) * coolAssBarRes * 10)): #set the rest as ~
            coolAssBar = coolAssBar + "-"
        coolAssBar = coolAssBar + "]"

        progTime = msToNorm(progress)
        durTime = msToNorm(duration)


        if(buttonHandler.buttonPressed(17)): #executes the program
            draw.rectangle((0,0, 128, 64), fill = "black")
            drawClass.draw_text((128/2, 32), "Going home!", fnt5x3, draw, "center")
            render.render_image(image)
            subprocess.Popen(['python', '/home/pi/menu.py'])
            os._exit(0)
        if(buttonHandler.buttonPressed(2, swapped = True)): #executes the program
            print('hey')
        if(buttonHandler.buttonPressed(3)): #executes the program
            print('hey')

        #print(device.bounding_box)
        draw.rectangle((0,0, 128, 64), outline="black", fill="black")
        drawClass.draw_text(((128/2) + imgSize[0]/2 + 7 + titleWrapVal, (imgSize[1]/3)+4), title, cached.titleFont, draw, "center") # Title
        if(wrapTitle == True):
            drawClass.draw_text(((128/2) + imgSize[0]/2 + 7 + fnt5x3.getbbox(title)[2] + titleWrapVal, (imgSize[1]/3)+4), title, cached.titleFont, draw, "center") # Title
            titleWrapVal -= 4
            if(abs(titleWrapVal) >= fnt5x3.getbbox(title)[2]):
                titleWrapVal = 0
        
        drawClass.draw_text(((128/2) + imgSize[0]/2 + 5 + authorWrapVal, (imgSize[1]/3)+20), author, cached.authorFont, draw, "center") # Title
        if(wrapAuthor == True):
            drawClass.draw_text(((128/2) + imgSize[0]/2 + 5 + fnt5x3.getbbox(author)[2] + authorWrapVal, (imgSize[1]/3)+20), author, cached.authorFont, draw, "center") # Title
            authorWrapVal -= 1
            if(abs(authorWrapVal) >= fnt5x3.getbbox(author)[2]):
                authorWrapVal = 0
            
        drawClass.draw_text((0, (imgSize[1]*2)-8), coolAssBar, fnt5x8, draw, "left")
        draw.rectangle((0,0, 32+5, 48), fill = "black")
        if(cached.imageFile != None):
            draw.bitmap((5,5), cached.imageFile, fill = "white")
        #img = Image.new("1", (128, 64), color="black")
        #img.paste(draw, (0,0))
        #print(image)

        render.render_image(image) #renders the image
        time.sleep(1/30) #30fps
except KeyboardInterrupt:            
    #subprocess.Popen(['python', '/home/pi/menu.py'])
    draw.rectangle((0,0, 128, 64), fill = "black")
    drawClass.draw_text((128/2, 32), "CRASH!", fnt5x3, draw, "center")
    render.render_image(image)
    os._exit(0)
