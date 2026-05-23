-- Remove os perfis HSP/HFP para forçar apenas A2DP em QUALQUER fone
-- Motivo: o JBL Endurance Race 2 fica alternando entre perfis e perdendo qualidade
-- Esta máquina não é usada para ligações via Bluetooth
bluez_monitor.properties["bluez5.roles"] = "[ a2dp_sink a2dp_source ]"
