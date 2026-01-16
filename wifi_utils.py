import network
import time
import ntptime
import json
import machine

def load_config():
    try:
        with open("config.txt", "r") as f:
            return json.load(f)
    except:
        return None

def connect():
    config = load_config()
    if not config: return
    wlan = network.WLAN(network.STA_IF)
    wlan.active(True)
    wlan.connect(config['ssid'], config['password'])
    
    timeout = 10
    while timeout > 0 and wlan.status() != 3:
        timeout -= 1
        time.sleep(1)

def sync_time():
    config = load_config()
    offset_hours = config.get('utc_offset', 0)
    
    try:
        # 1. Get UTC time from NTP server
        ntptime.settime() 
        
        # 2. Get the current time in seconds since epoch (UTC)
        # We then add the offset (hours * 3600 seconds)
        utc_seconds = time.time()
        local_seconds = utc_seconds + (offset_hours * 3600)
        
        # 3. Convert seconds back into a time tuple
        l = time.localtime(local_seconds)
        
        # 4. Manually set the Pico's Hardware RTC to the local time
        # machine.RTC().datetime format: (year, month, day, weekday, hours, minutes, seconds, subseconds)
        # Note: we use 0 for weekday and subseconds as fillers
        machine.RTC().datetime((l[0], l[1], l[2], 0, l[3], l[4], l[5], 0))
        
        print(f"Time synced with offset: {offset_hours}h")
    except Exception as e:
        print("NTP sync failed:", e)

def get_time_string():
    t = time.localtime()
    return f"{t[0]}-{t[1]:02d}-{t[2]:02d} {t[3]:02d}:{t[4]:02d}:{t[5]:02d}"