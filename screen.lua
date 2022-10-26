local modem  = peripheral.wrap("top")
local monitor = peripheral.find("monitor")
modem.open(55)
modem.open(56)
monitor.setCursorPos(1,1)
monitor.setTextScale(0.5)

local center = function(res, text)
    monitor.setTextScale(res)
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
        for i = 1 , 20 do
            monitor.setBackgroundColor(colors.black)
            monitor.clear()
            monitor.setTextColor(colors.white)
            center(3, "ORDER!")
            sleep(0.5)
            monitor.setBackgroundColor(colors.white)
            monitor.clear()
            monitor.setTextColor(colors.black)
            center(3, "ORDER!")
            sleep(0.5)
        end
        monitor.clear()
    elseif channel == 56 then
        center(3, message)
        sleep(5)
        monitor.clear()
    end
end
