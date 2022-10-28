local speaker = peripheral.find("speaker")
local wmodem = peripheral.wrap("right")
local emodem = peripheral.wrap("top")
local instruments = {"harp", "basedrum", "snare", "hat", "bass", "flute", "bell", "guitar", "chime", "xylophone", "iron_xylophone", "cow_bell", "didgeridoo", "bit", "banjo", "pling"}
wmodem.open(44)
wmodem.open(45)
while true do
    while true do
        event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
        break
    end
    if message == "order" then
        emodem.transmit(55,44, "order")
        for i = 1, 50, 1 do
            r_instrument = math.random(1,16)
            pitch = math.random(1,24)
            speaker.playNote(instruments[r_instrument], 3, pitch)
            sleep(0.05)
        end
    elseif channel == 45 then
        emodem.transmit(56,45, message)
    end
end
