from machine import Pin, I2C
from ssd1306 import SSD1306_I2C
import ds1307
import utime
from rotary_encoder import RotaryEncoder  # Import the RotaryEncoder class

# Constants
PIX_RES_X = 128
PIX_RES_Y = 64

# Pin assignments for the rotary encoder
ENCODER_A_PIN = 0  # GPIO0
ENCODER_B_PIN = 1  # GPIO1
BUTTON_PIN = 2     # GPIO2

changingTime = False

def get_date_string(ds1307rtc):
    dt = ds1307rtc.datetime
    return f"{dt[1]:02d}/{dt[2]:02d}/{dt[0]:04d}"

def get_time_string(ds1307rtc):
    dt = ds1307rtc.datetime
    return f"{dt[3]:02d}:{dt[4]:02d}:{dt[5]:02d}"

def init_i2c(scl_pin, sda_pin):
    i2c_dev = I2C(1, scl=Pin(scl_pin), sda=Pin(sda_pin), freq=200000)
    i2c_addr = [hex(ii) for ii in i2c_dev.scan()]
    
    if not i2c_addr:
        print('No I2C Display Found')
        sys.exit()
    else:
        print("I2C Address      : {}".format(i2c_addr[0]))
        print("I2C Configuration: {}".format(i2c_dev))
    
    return i2c_dev

def display_time(oled, ds1307rtc, encoder):
    global changingTime
    while True:
        oled.fill(0)
        date_string = get_date_string(ds1307rtc)
        time_string = get_time_string(ds1307rtc)
        encoder_position = encoder.get_position()

        oled.text(date_string, 5, 5)
        center_text(oled, time_string, 50, 25)
        #oled.text(f"Encoder: {encoder_position}", 5, 45)
        if encoder.is_button_pressed():
            changingTime = not changingTime

        if changingTime:
            oled.text("CHANGING TIME", 5, 45)
        
        oled.show()
        utime.sleep(0.2)  # Update every second

def center_text(oled, text, _x, _y, text_width=8):
    offset = (len(text) * text_width) // 2
    oled.text(text, _x - (offset) // 2, _y)

def main():
    global changingTime
    print("Initializing I2C for OLED...")
    i2c_dev = init_i2c(scl_pin=27, sda_pin=26)
    oled = SSD1306_I2C(PIX_RES_X, PIX_RES_Y, i2c_dev)
    
    print("Initializing I2C for RTC...")
    i2c_rtc = I2C(0, scl=Pin(9), sda=Pin(8), freq=100000)
    ds1307rtc = ds1307.DS1307(i2c_rtc, 0x68)
    
    print("Initializing Rotary Encoder...")
    encoder = RotaryEncoder(ENCODER_A_PIN, ENCODER_B_PIN)
    

    print("Displaying current time and encoder position...")
    display_time(oled, ds1307rtc, encoder)
    

if __name__ == '__main__':
    main()
