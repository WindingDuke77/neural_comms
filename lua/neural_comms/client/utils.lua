ncomms = ncomms or {}
ncomms.config = ncomms.config or {}
local config = ncomms.config

-- Do not touch above this line

local notificationSound = "buttons/lightswitch2.wav"
local function DisplayNotify(msg)
    local txt = msg:ReadString()
    GAMEMODE:AddNotify(txt, msg:ReadShort(), msg:ReadLong())
    surface.PlaySound(notificationSound)
end
usermessage.Hook("ncomms_Notify", DisplayNotify)


net.Receive("ncomms.ChatSend", function(len)
    local msg = net.ReadTable()

    chat.AddText( unpack(msg) )
end)
