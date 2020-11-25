# Panasonic Virtual Thermostat
Create a virtual thermostat for the Panasonic Aquarea series (Heishamon required)

## Requirements

- Domoticz
- Panasonic Aquerea heatpump
- [a link](https://github.com/Egyras/HeishaMon)Heishamon)

## Setup

- Add a Dummy sensor in Domoticz
- Create a Virtual sensor: Thermostat

- Put the script as dzVents in Domoticz:
-- Setup > More Options > Events
-- dzVents

- 'setPointId' the ID of the virtual Thermostat  
- 'roomTemperatureId' the ID of the room temperatue sensor
- 'wpSwitchId' the ID of the heatpump switch (Heishamon)
- 'shiftId' the ID of the shift request temp (Heishamon)

- Set 'switchWp' true or false if you want the swtich on/off the heatpump

- Set a confortable temperature with the Thermostat dummy, eg. 21.5 and go!
