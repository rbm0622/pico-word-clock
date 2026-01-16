# main.py

import utime
from words import WORDS
from clock_logic import time_to_words
from display import clear, light_word, show

import wifi_utils
# from machine import Pin

def setTime():
    # 1. Connect (utils now handles reading the text file)
    wifi_utils.connect()
    
    # 2. Sync
    wifi_utils.sync_time()
    
    # 3. Output
    print(f"Current System Time: {wifi_utils.get_time_string()}")
    
    # Light up the onboard LED on success
#    Pin("LED", Pin.OUT).on()

setTime()

def show_time(hour, minute):
    clear()
    for word in time_to_words(hour, minute):
        light_word(WORDS[word])
    show()



# -----------------------
# Demo loop (replace with RTC later)
# -----------------------
while True:
    now = utime.localtime()
    hour = now[3]
    minute = now[4]
#    minute = 15

    show_time(hour, minute)
    print(f"Time: {now}")
    print (f"Hour:  {hour}") 
    print (f"Minute:  {minute}") 
    utime.sleep(30)
