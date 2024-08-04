from machine import Pin, I2C
from ssd1306 import SSD1306_I2C
import ds1307
import utime
from rotary_encoder import RotaryEncoder  

# Constants
PIX_RES_X = 128
PIX_RES_Y = 64

# Pin assignments for the rotary encoder
ENCODER_A_PIN = 0  # GPIO0
ENCODER_B_PIN = 1  # GPIO1
BUTTON_PIN = 2     # GPIO2

changingTime = False
alarm_time = [0, 0, 0]  # [hour, minute, second]
alarmSet = False

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
    global changingTime, alarm_time, alarmSet
    
    while True:
        oled.fill(0)
        date_string = get_date_string(ds1307rtc)
        time_string = get_time_string(ds1307rtc)
        
        oled.text(date_string, 5, 5)
        center_text(oled, time_string, 50, 25)
        
        if encoder.is_button_pressed():
            changingTime = not changingTime
            encoder.reset()  # Reset the encoder position when toggling changingTime
            if changingTime:
                at = ds1307rtc.datetime
                alarm_time = [at[3], at[4], at[5]]
            else:
                alarmSet = True

        if changingTime:
            oled.text("SETTING ALARM", 5, 45)
            encoder_position = encoder.get_position()
            print(f"Encoder position: {encoder_position}")  # Debugging print
            alarm_time[2] += encoder_position
            if alarm_time[2] >= 60:
                alarm_time[2] = 0
                alarm_time[1] += 1
            elif alarm_time[2] < 0:
                alarm_time[2] = 59
                alarm_time[1] -= 1

            encoder.reset()  

            oled.text(f"{alarm_time[0]:02d}:{alarm_time[1]:02d}:{alarm_time[2]:02d}", 5, 55)
        
        if alarmSet:
            oled.text(f"{alarm_time[0]:02d}:{alarm_time[1]:02d}:{alarm_time[2]:02d}", 5, 55)
            ct = ds1307rtc.datetime
            if (ct[3] == alarm_time[0] and ct[4] == alarm_time[1] and ct[5] >= alarm_time[2]):
                while alarmSet:
                    oled.fill(0)
                    center_text(oled, "!!ALARM!!", 50, 25)
                    oled.show()
                    if encoder.is_button_pressed():
                        alarmSet = False
                    utime.sleep(0.05)
        
        oled.show()
        utime.sleep(0.2)

def center_text(oled, text, _x, _y, text_width=8):
    offset = (len(text) * text_width) // 2
    oled.text(text, _x - (offset) // 2, _y)

class RotaryEncoder:
    def __init__(self, pin_a, pin_b, button_pin):
        self.pin_a = Pin(pin_a, Pin.IN, Pin.PULL_UP)
        self.pin_b = Pin(pin_b, Pin.IN, Pin.PULL_UP)
        self.button = Pin(button_pin, Pin.IN, Pin.PULL_UP)
        self.position = 0
        self.last_state = self.pin_a.value()

        self.pin_a.irq(trigger=Pin.IRQ_FALLING | Pin.IRQ_RISING, handler=self.update)

    def update(self, pin):
        state = self.pin_a.value()
        if state != self.last_state:
            if self.pin_b.value() != state:
                self.position += 1
            else:
                self.position -= 1
        self.last_state = state

    def get_position(self):
        pos = self.position
        return pos

    def reset(self):
        self.position = 0

    def is_button_pressed(self):
        return not self.button.value()

def main():
    global changingTime
    print("Initializing I2C for OLED...")
    i2c_dev = init_i2c(scl_pin=27, sda_pin=26)
    oled = SSD1306_I2C(PIX_RES_X, PIX_RES_Y, i2c_dev)
    
    print("Initializing I2C for RTC...")
    i2c_rtc = I2C(0, scl=Pin(9), sda=Pin(8), freq=100000)
    ds1307rtc = ds1307.DS1307(i2c_rtc, 0x68)
    
    print("Initializing Rotary Encoder...")
    encoder = RotaryEncoder(ENCODER_A_PIN, ENCODER_B_PIN, BUTTON_PIN)
    
    print("Displaying current time")
    display_time(oled, ds1307rtc, encoder)

if __name__ == '__main__':
    main()
