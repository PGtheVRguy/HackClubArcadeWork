from micropython import const

# register definitions (see datasheet)
_DATETIME_REGISTER = const(0x00)
_CONTROL_REGISTER = const(0x07)

class DS1307():


    def __init__(self, i2c_bus: I2C, addr = 0x68) -> None:
        self.i2c = i2c_bus
        self.addr = addr
        self.buf = bytearray(7)
        self.buf1 = bytearray(1)

    @property
    def datetime(self) -> tuple:
        """Returns the current date, time and day of the week."""
        self.i2c.readfrom_mem_into(self.addr, _DATETIME_REGISTER, self.buf)
        hr24 = False if (self.buf[2] & 0x40) else True
        _datetime = (self._bcd2dec(self.buf[6]) + 2000,
                    self._bcd2dec(self.buf[5]),
                    self._bcd2dec(self.buf[4]),
                    self._bcd2dec(self.buf[2]) if hr24 else
                        self._bcd2dec((self.buf[2] & 0x1f))
                        + 12 if (self.buf[2] & 0x20) else 0,
                    self._bcd2dec(self.buf[1]), # minutes
                    self._bcd2dec(self.buf[0] & 0x7f), # seconds, remove oscilator disable flag
                    self.buf[3] -1,
                    None # unknown number of days since start of year
                    )
        return _datetime
    @datetime.setter
    def datetime(self, datetime: tuple = None):
        """Set the current date, time and day of the week, and starts the
clock."""
        self.buf[6] = self._dec2bcd(datetime[0] % 100) # years
        self.buf[5] = self._dec2bcd(datetime[1] ) # months
        self.buf[4] = self._dec2bcd(datetime[2] ) # days
        self.buf[2] = self._dec2bcd(datetime[3] ) # hours
        self.buf[1] = self._dec2bcd(datetime[4] ) # minutes
        self.buf[0] = self._dec2bcd(datetime[5] ) # seconds
        self.buf[3] = self._dec2bcd(datetime[6] +1) # weekday (0-6)
        self.i2c.writeto_mem(self.addr, _DATETIME_REGISTER, self.buf)
        
    @property
    def datetimeRTC(self) -> tuple:
        _dt = self.datetime
        return _dt[0:3] + (None,) + _dt[3:6] + (None,)

    @property
    def disable_oscillator(self) -> bool:
        """True if the oscillator is disabled."""
        self.i2c.readfrom_mem_into(self.addr, _DATETIME_REGISTER, self.buf1)
        self._disable_oscillator = bool(self.buf1[0] & 0x80)
        return self._disable_oscillator

    @disable_oscillator.setter
    def disable_oscillator(self, value: bool):
        """Set or clear the DS1307 disable oscillator flag."""
        self._disable_oscillator = value
        self.i2c.readfrom_mem_into(self.addr, _DATETIME_REGISTER, self.buf1)
        self.buf1[0] &= 0x7f # preserve seconds
        self.buf1[0] |= self._disable_oscillator << 7
        self.i2c.writeto_mem(self.addr, _DATETIME_REGISTER, self.buf1)

    def _bcd2dec(self, bcd):
        """Convert binary-coded decimal to decimal. Works for values from 0 to 99
(decimal)."""
        return (bcd >> 4) * 10 + (bcd & 0x0F)

    def _dec2bcd(self, decimal):
        """Convert decimal to binary-coded decimal. Works for values from 0 to
99."""
        return ((decimal // 10) << 4) + (decimal % 10)