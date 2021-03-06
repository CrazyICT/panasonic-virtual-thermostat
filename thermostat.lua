return {
    on = {
        devices = {
            56 -- only run on temperature change
        }
    },

    logging = {
        level = domoticz.LOG_DEBUG, -- LOG_DEBUG or LOG_ERROR
        marker = "WP: Thermostaat [ Script ]"
    },

    execute = function(domoticz, item)

        -- set to true if you want to swtich on/off the heater
        local switchWp = false

        local setPointId = 194          -- Dummy thermostaat device
        local roomTemperatureId = 56
        local wpSwitchId = 92           -- Heatpump_State
        local shiftId = 119             -- Z1_Heat_Request_Temp

        local setPoint = domoticz.utils.round(domoticz.devices(setPointId).setPoint, 2)

        -- script default values settings
        local roomTemperature = tonumber(domoticz.devices(roomTemperatureId).rawData[1])
        local wpState = 1
        local shift = 0
        local wpSetpointDevice = domoticz.devices(shiftId)

        domoticz.log('setpoint temperatuur: ' .. setPoint .. ' oC ', domoticz.LOG_DEBUG)

        if (roomTemperature > (setPoint + 0.2)) then
            wpState = 1  -- testing value
            if (true == switchWp) then
                domoticz.devices(wpSwitchId).switchOff()
            end
        elseif (roomTemperature < (setPoint + 0.05)) then
            if (true == switchWp) then
                domoticz.devices(wpSwitchId).switchOn()
            end
        end

        if (wpState == 1) then
            if (roomTemperature < (setPoint - 0.3)) then
                shift = 3
            elseif (roomTemperature < (setPoint - 0.2)) then
                shift = 2
            elseif (roomTemperature < (setPoint - 0.1)) then
                shift = 1
            elseif (roomTemperature > (setPoint + 0.1)) then
                shift = -1
            end

            if (wpSetpointDevice.setPoint ~= domoticz.utils.round(shift, 1)) then
                domoticz.log('WP HIT!!: ' .. domoticz.utils.round(shift, 1), domoticz.LOG_DEBUG)
                wpSetpointDevice.updateSetPoint(shift)
            end
        end

        domoticz.devices(setPointId).updateSetPoint(setPoint) -- update dummy sensor in case of red indicator ;-)

        domoticz.log('WP shift: ' .. domoticz.utils.round(shift, 1), domoticz.LOG_DEBUG)
        domoticz.log('WP status: ' .. wpState, domoticz.LOG_DEBUG)

    end
}
