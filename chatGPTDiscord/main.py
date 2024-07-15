#from TTS.tts.models.tortoise import Tortoise

import openai
from gtts import gTTS
import discord
import os
import variables as v
from discord.ext import commands


bot = commands.Bot(command_prefix="!", intents=discord.Intents.all())




def generate_voice_line(text, output_filename="ai.wav"):
    print("voice")

async def askAI(prompt, channel):
    async with channel.typing():
        print("Gotten prompt: " + prompt)
        response = rtx_api.send_message(prompt)
        #response = response.replace(" gh", " fuck")
        #response = response.replace(" GH", " FUCK")
        #response = response.replace(" Gh", " Fuck")
        print("response: " + response)
        return response


def sayTest(prompt):
    language = "en"
    print("creating mp3")
    myobj = gTTS(text=prompt, lang=language, slow=False)
    myobj.save("audio.mp3")
    print("mp3 saved, playing...")
    os.system("start audio.mp3")

@bot.event
async def on_ready():
    print("Hello! Bot is ready uwu")

@bot.event
async def on_message(message):
    if message.author == bot.user:
        return  # Ignore messages sent by the bot itself

    # Check if the message contains the phrase "doug"
    if "doug" in message.content.lower():
        response = await askAI(message.content, message.channel)
        await message.channel.send(response)
    if message.content.lower() == "dogie":
        # Get the role named "new role"
        role = discord.utils.get(message.guild.roles, name="AIBot")
        if role:
            # Grant the role to the author of the message
            await message.author.add_roles(role)
            await message.channel.send("Hey I'm Doug Doug")
        else:
            await message.channel.send("I'm not Doug Doug")


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

bot.run(v.TOKEN_ID)