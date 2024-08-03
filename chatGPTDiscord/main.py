#from TTS.tts.models.tortoise import Tortoise

from openai import OpenAI
from gtts import gTTS
import discord
import os
#import variables as v
from discord.ext import commands
import tbapy

tba = tbapy.TBA("DTMnL4hL8CpDwSj65VEJWEy5q9nE1yNZbFQKL1rvMVo9fBZt1Vwo8Ui0vGnhRxPC")
character = "doug"
bot = commands.Bot(command_prefix="!", intents=discord.Intents.all())

#openai.my_api_key = open('token.txt', 'r')
apiKey = open('token.txt', 'r').read()
print(apiKey)
client = OpenAI(api_key= apiKey)

with open('prompt.txt', 'r') as file:
    generalRules = file.read().replace('\n', '')
rules = "0. You are the character " + character + "\n" + generalRules
with open('characterRules.txt', 'r') as file:
    characterRules = file.read().replace('\n', '')
rules = rules + "\n" + characterRules + "\n You also have a few members you are allowed to tag! These are "
with open('members.txt', 'r') as file:
    members = file.read().replace('\n', '')
rules = rules + members
print(rules)

#client.api_key = apiKey

TOKENID = open('discordToken.txt', 'r').read()
print(TOKENID)
#IF YOU ARE USING THIS REPO FOR ANYTHING IN THE FUTURE, KEEP YOUR TOKEN.TXT ONLY TO YOURSELF!!
# There are bots here that scrape OpenAI tokens!!

def split_string_to_chunks(long_string, chunk_size=2000):
    # List comprehension to create chunks
    return [long_string[i:i+chunk_size] for i in range(0, len(long_string), chunk_size)]

def generate_voice_line(text, output_filename="ai.wav"):
    print("voice")

async def askAI(prompt, channel):
    async with channel.typing():

        #prompt = prompt.replace("doug", "")
        print("Gotten prompt: " + prompt)
        response = client.chat.completions.create(
            model="gpt-4o",
            #response_format={"type": "json_object"},
            messages=[
                {"role": "system", "content": rules},
                {"role": "user", "content": prompt}
            ]
        )
        print(response.choices[0].message.content)
        clippedResponse = response.choices[0].message.content
        #response = chat.choices[0].message.content
        #response = rtx_api.send_message(prompt)
        #response = response.replace(" gh", " fuck")
        #response = response.replace(" GH", " FUCK")
        #response = response.replace(" Gh", " Fuck")
        #print("response: " + response)
        return clippedResponse


def sayTest(prompt):
    language = "en"
    print("creating mp3")
    myobj = gTTS(text=prompt, lang=language, slow=False)
    myobj.save("audio.mp3")
    print("mp3 saved, playing...")
    os.system("start audio.mp3")

playingText = "as " + character
@bot.event
async def on_ready():
    activity = discord.Game(name="as " + character, type=3)
    await bot.change_presence(status=discord.Status.idle, activity=activity)
    print("Hello! Bot is ready!")

@bot.event
async def on_message(message):
    if message.author == bot.user:
        return  # Ignore messages sent by the bot itself

    # Check if the message contains the phrase "doug"
    if character in message.content.lower():
        response = await askAI(message.content, message.channel)
        if("[tba]" in response):
            print('tba')
            eventKey = str.replace(response, "[tba][", "")
            eventKey = str.replace(eventKey, "]", "")
            print(eventKey)
            matches = tba.event_matches(eventKey)
            print(matches)
            newResponse = "Hey can you summarize the following FRC match! This is the events data from tba: " + str(matches)
            response = askAI(newResponse, message.channel)
        chunks = split_string_to_chunks(response)


        for i, chunk in enumerate(chunks):
            await message.channel.send(chunk)
    '''if message.content.lower() == "dogie":
        # Get the role named "new role"
        role = discord.utils.get(message.guild.roles, name="AIBot")
        if role:
            # Grant the role to the author of the message
            await message.author.add_roles(role)
            await message.channel.send("Hey I'm Doug Doug")
        else:
            await message.channel.send("I'm not Doug Doug")'''


'''
@bot.event()
async def ask(ctx, *, x):
    await ctx.send(askAI(x))
@bot.command()
async def join(ctx):
    author = ctx.message.author
    voice_channel = author.voice.channel

    # Check if the bot is already connected to a voice channel
    if ctx.voice_client:
        await ctx.send("I'm already in a voice channel.")
    elif voice_channel:
        voice_client = await voice_channel.connect()
        await ctx.send(f"Joined {voice_channel.name}")
        v.in_vc = True
        v.voice_client = ctx.voice_client
    else:
        await ctx.send("You are not in a voice channel.")
'''

bot.run(TOKENID)