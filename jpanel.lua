local monitor = peripheral.wrap("top")
local modem = peripheral.wrap("right")
term.redirect(monitor)
monitor.setTextScale(0.5)
sizex, sizey = term.getSize()
line8 = {"a", "b" ,"c" ,"d" ,"e" ,"f" ,"g" ,"h" ,"i" ,"j" ,"k" ,"l" ,"m" ,"n" ,"o" ,"p" ,"q" ,"r" ,"s" ,"t" ,"u" ,"v" ,"w" ,"x" ,"y" ,"z" ,"1" ,"2" ,"3" ,"4" ,"5" ,"6" ,"7" ,"8" ,"9" ,"0"}
capsline8 = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","1","2","3","4","5","6","7","8","9","0"}
line10 = {"!", "?", ".", "(", ")", "-", "&", "$", "<", ">", "*", "#", "^", "_", ":", ";", "'", "%", "@", "{", "}", "[", "]", "|", ",", "=", "+", "`", "~", "/"}
if #line8 >= (sizex + 1) then 
    line8over = true
else
    line8over = false
end
if #line10 >= (sizex + 1) then
    line10over = true
else
    line10over = false
end


local setup = function()
    term.clear()
    paintutils.drawFilledBox(1,1,6,1, colours.red)
    term.setCursorPos(1,1)
    term.write("ORDER!")
    term.setBackgroundColor(colors.black)
    term.setCursorPos(36,1)
    term.write("O")
    if line8over == true then
        term.setTextColor(colors.red)
        term.setCursorPos(1,9)
        for i = 1, #line8, 1 do
            write(line8[i])
        end
        term.setTextColor(colors.white)
    else
        term.setCursorPos(1,9)
        for i = 1, #line8 do
            write(line8[i])
        end
    end
    if line10over == true then
        term.setTextColor(colors.red)
        term.setCursorPos(1,10)
        for i = 1, #line10, 1 do
            write(line10[i])
        end
        term.setTextColor(colors.white)
    else
        term.setCursorPos(1,10)
        for i = 1, #line10, 1 do 
            write(line10[i])
        end
    end
    term.setCursorPos(33,8)
    term.write("_<^>")
    capslock = false
    term.setCursorPos(1,8)
    input = {}
end
setup()

while true do
    while true do -- the pull event
        event, side, x, y = os.pullEvent("monitor_touch")
        break
    end 
    if x >= 1 and x <= 6 and y == 1 then -- order button
       modem.transmit(44, 33, "order")
    elseif x == 36 and y == 1 then -- top right reset button
        setup()
    elseif x == 35 and y == 8 then -- capslock button
        local cx, cy = term.getCursorPos()
        capslock = not capslock
        if capslock == true then
            term.setCursorPos(1,9)
            for i = 1, #capsline8, 1 do
                write(capsline8[i])
            end
        else
            term.setCursorPos(1,9)
            for i = 1, #line8, 1 do
                write(line8[i])
            end
        end
        term.setCursorPos(cx,cy)
    elseif y == 9 then -- alphabet line
        if capslock then
            write(capsline8[x]) 
            table.insert(input, capsline8[x])
        else
            write(line8[x])
            table.insert(input, line8[x])
        end
    elseif y == 8 and x == 36 then -- send message
        serialinput = table.concat(input)
        modem.transmit(45,34,serialinput)
        setup()
    elseif y == 8 and x == 33 then -- space button
        table.insert(input, " ")
        term.write(" ")
    elseif y == 8 and x == 34 then -- backspace
        local cx, cy = term.getCursorPos()
        table.remove(input, #input)
        term.setCursorPos(cx - 1, cy)
        term.write(" ")
        term.setCursorPos(cx - 1, cy)
    elseif y == 10 then -- line 10 keyboard
        write(line10[x])
        table.insert(input, line8[x])
    end
end
-- make costomisation (text size, flash, text colour, time ) for the messages sent