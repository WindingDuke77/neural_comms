ncomms = ncomms or {}
ncomms.MODULE = GAS.Logging:MODULE()
ncomms.MODULE.Category = "Neural Studio"
ncomms.MODULE.Name = "Comms"
ncomms.MODULE.Colour = Color(153,0,255)

ncomms.MODULE:Setup(function()
end)
GAS.Logging:AddModule( ncomms.MODULE )