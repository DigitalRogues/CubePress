from machine import Pin, PWM
from utime import sleep_ms
import network, socket, secrets, time, servos, json

############################################# MAIN PROGRAM ####################################################

def settingsDictionary(file_name):
    #initalize servos
    f = open(file_name,'r')
    print("Reading JSON")
    settings_string = f.read()
    f.close()
    dictionary = json.loads(settings_string)
    print('Data: ', dictionary)
    return dictionary


file_name = 'settings.json' #JSON workspace
settings_dictionary = settingsDictionary(file_name) #dictionary based on JSON workspace
arm = servos.arm_servo(settings_dictionary['bot'],settings_dictionary['mid'],settings_dictionary['top'], 15)
table = servos.table_servo(settings_dictionary['left'],settings_dictionary['center'],settings_dictionary['right'], 16)

f = open(file_name,'w')
print("Dumping to JSON")
json.dump(settings_dictionary, f)
f.close()

f = open(file_name,'r')
settings_string = f.read()
f.close()
print('Got settings:', settings_string)
settings_dict = json.loads(settings_string)

#set secret values
ssid = secrets.ssid
password = secrets.password

#connect to local network
wlan = network.WLAN(network.STA_IF)
wlan.active(True)
wlan.connect(ssid, password)

#webpage html
html = """<!DOCTYPE html>
<html>
<head> <title>Pico W</title> </head>
<body> <h1>Bob's Pico W HTTP Server</h1>
<p>Hello, World!</p>
</body>
</html>
"""

# Wait for connect or fail
max_wait = 10
while max_wait > 0:
    if wlan.status() < 0 or wlan.status() >= 3:
        break
    max_wait -= 1
    print('waiting for connection...')
    time.sleep(1)
    
# Handle connection error
if wlan.status() != 3:
    raise RuntimeError('network connection failed')
else:
    print('Connected')
    status = wlan.ifconfig()
    print( 'ip = ' + status[0] )
    
# Open socket
addr = socket.getaddrinfo('0.0.0.0', 80)[0][-1]
s = socket.socket()
s.bind(addr)
s.listen(1)
print('listening on', addr)

# Listen for connections, serve client
while True:
    try:       
        cl, addr = s.accept()
        print('client connected from', addr)
        request = cl.recv(1024)
        #print("request:")
        #print(request)
        request = str(request)
        print("-----request----- : " + str(request))
        
        if 'settings' in request:
            if 'settings==' in request:
                settings = process_settings(request) #Convert from string to settings dictionary
                set_servos(arm, table, settings) #Set servos here
            #else:
            #return servo settings here
        elif 'bot' in request:
            arm.move_bot()
        elif 'mid' in request:
            arm.move_mid()
        elif 'top' in request:
            arm.move_top()
        elif 'left' in request:
            table.move_left()
        elif 'center' in request:
            table.move_center()
        elif 'right' in request:
            table.move_right()
        else:
            print("No Valid Instruction")
        
        # Create and send response
        response = html
        cl.send('HTTP/1.0 200 OK\r\nContent-type: text/html\r\n\r\n')
        cl.send()
        cl.close()
        
    except OSError as e:
        cl.close()
        print('connection closed')