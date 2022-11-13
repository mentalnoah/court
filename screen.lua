local modem  = peripheral.wrap("top")
local monitor = peripheral.find("monitor")
modem.open(55)
modem.open(56)
monitor.setCursorPos(1,1)
monitor.setTextScale(0.5)

local center = function(res, text)
    monitor.setTextScale(tonumber(res))
    x, y = monitor.getSize()
    monitor.setCursorPos(x/2 -(#text / 2), (y/2))
    monitor.write(text)
end
while true do 
    while true do
        event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
        break
    end
    if message == "order" then
        for i = 1 , 3 do
            monitor.setBackgroundColor(colors.white)
            monitor.clear()
            monitor.setTextColor(colors.black)
            center(3, "ORDER!")
            sleep(0.5)
            monitor.setBackgroundColor(colors.black)
            monitor.clear()
            monitor.setTextColor(colors.white)
            center(3, "ORDER!")
            sleep(0.5)
        end
        monitor.clear()
    elseif channel == 56 then
        textsize = message[#message - 2]
        flash = message[#message - 1]
        time = message[#message]
        for i = 1, 3 do
            table.remove(message, #message)
        end
        mergedmessage = table.concat(message)
        if flash == "y" then -- BLACK AND WHITE FLASH CENTER
            for i = 1, time do 
                monitor.setBackgroundColor(colors.white)
                monitor.clear()
                monitor.setTextColor(colors.black)
                center(textsize, mergedmessage)
                sleep(0.5)
                monitor.setBackgroundColor(colors.black)
                monitor.clear()
                monitor.setTextColor(colors.white)
                center(textsize, mergedmessage)
                sleep(0.5)               
            end
        else
            for i = 1, time do
                center(textsize, mergedmessage)
            end
        end 
        monitor.setBackgroundColor(colors.black)
        monitor.setTextColor(colors.white)
        monitor.clear()
    end
end

--MESSAGE FORMATIING VERTICAL CENTERIZAION AND WRAPPING 
