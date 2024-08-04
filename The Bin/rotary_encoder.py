from machine import Pin
import time

class RotaryEncoder:
    def __init__(self, pin_a, pin_b, button_pin=None, debounce_ms=10):
        self.pin_a = Pin(pin_a, Pin.IN, Pin.PULL_UP)
        self.pin_b = Pin(pin_b, Pin.IN, Pin.PULL_UP)
        self.button = Pin(button_pin, Pin.IN, Pin.PULL_UP) if button_pin is not None else None
        self.debounce_ms = debounce_ms
        self.position = 0
        self.last_a = self.pin_a.value()
        self.last_b = self.pin_b.value()
        self.last_button = self.button.value() if self.button else None
        self.last_update = time.ticks_ms()

        self.pin_a.irq(trigger=Pin.IRQ_RISING | Pin.IRQ_FALLING, handler=self._handle_interrupt)
        self.pin_b.irq(trigger=Pin.IRQ_RISING | Pin.IRQ_FALLING, handler=self._handle_interrupt)
        if self.button:
            self.button.irq(trigger=Pin.IRQ_FALLING, handler=self._handle_button_interrupt)

    def _handle_interrupt(self, pin):
        now = time.ticks_ms()
        if time.ticks_diff(now, self.last_update) < self.debounce_ms:
            return
        self.last_update = now

        a = self.pin_a.value()
        b = self.pin_b.value()

        if a != self.last_a or b != self.last_b:
            if a != self.last_a:
                if b != a:
                    self.position += 1
                else:
                    self.position -= 1
            self.last_a = a
            self.last_b = b

    def _handle_button_interrupt(self, pin):
        # Button press detected
        print("Button Pressed")

    def get_position(self):
        return self.position

    def is_button_pressed(self):
        if self.button:
            return self.button.value() == 0  # Active-low button
        return False
