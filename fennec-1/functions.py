import RPi.GPIO as GPIO

GPIO.setmode(GPIO.BCM)

buttonsPressedList = []

class buttonHandler():
    
    def buttonPressed(pin, swapped = False):
        #print(buttonsPressedList)
        inputPin = GPIO.input(pin)
        if swapped == False:
            read = GPIO.LOW
        else:
            read = GPIO.HIGH
        if inputPin == read:
            if str(pin) in buttonsPressedList:
                return False
            else:
                buttonsPressedList.append(str(pin))
                return True
                
        else:
            if(str(pin) in buttonsPressedList):
                buttonsPressedList.remove(str(pin))
            return False

class mathClass():
    #
    # Linear Interpretation
    #
    def lerp(a, b, alpha):
        # Ensure alpha is in the range [0, 1]
        alpha = max(0.0, min(alpha, 1.0))
        
        # Perform linear interpolation
        interpolated_value = a * (1 - alpha) + b * alpha
        
        return interpolated_value

    #
    # Clamping!!
    #

    def clamp(n, min, max): 
        if n < min: 
            return min
        elif n > max: 
            return max
        else: 
            return n 

class drawClass():
    def draw_text(xy, text, font, draw, align = "left"):
        w = 0
        h = 0
        if align == "center":
            s, s, w, h = font.getbbox(text)
        if align == "right":
            s, s, w, h = font.getbbox(text)  
            w = w*2
            h = h*2     
        draw.text(((xy[0] -w/2), ((xy[1] - h/2))), text, font = font, fill = 1)

    def draw_text_loop(xy, text, font, draw, wrapVal, align = "left"):
        #print(xy[0])
        drawClass.draw_text((xy[0] + wrapVal, xy[1]), text, font, draw, align) # Title
        drawClass.draw_text((xy[0] + font.getbbox(text)[2] + wrapVal, xy[1]), text, font, draw, align) # Title