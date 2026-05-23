-- Força perfil A2DP SBC-XQ para o JBL Endurance Race 2
-- Usa apply_properties (sintaxe compatível com WirePlumber 1.0.x)

rule = {
  matches = {
    {
      { "device.name", "matches", "bluez_card.38_D5_18_A8_D0_1F" },
    },
  },
  apply_properties = {
    ["bluez5.auto-connect"] = "[ a2dp_sink ]",
    ["device.profile"] = "a2dp-sink",
  },
}

table.insert(bluez_monitor.rules, rule)
