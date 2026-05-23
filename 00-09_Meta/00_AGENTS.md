# AGENTS.md — media-kit

## 📋 Propósito
Repositório SSOT de configurações de áudio/vídeo da mesh LKE 5.0.
Gerencia presets, codecs, servidores de áudio e documentação.

## 🔧 Comandos

### Sincronização para nó local
```bash
# Copiar presets EasyEffects
cp 10-19_Audio/10_EasyEffects/presets/*.json ~/.config/easyeffects/output/
cp -r 10-19_Audio/10_EasyEffects/irs/* ~/.config/easyeffects/irs/
cp -r 10-19_Audio/10_EasyEffects/autoload/* ~/.config/easyeffects/autoload/

# Copiar config WirePlumber
cp 10-19_Audio/11_WirePlumber/*.lua ~/.config/wireplumber/bluetooth.lua.d/
```

### Atalho para aplicar presets
```bash
./30-39_Ferramentas/30_Scripts/sync-media.sh
```

## 📁 Estrutura
```
media-kit/
├── 00-09_Meta/
│   └── 00_MANUAL_DE_CONFIGURACAO.md
├── 10-19_Audio/
│   ├── 10_EasyEffects/
│   │   ├── presets/       # Presets de saída (.json)
│   │   ├── irs/           # Respostas ao impulso (.irs)
│   │   └── autoload/      # Autoload por dispositivo
│   ├── 11_WirePlumber/    # Configs bluetooth.lua.d
│   └── 12_PipeWire/       # Configs pipewire.conf
├── 20-29_Video/           # (futuro)
└── 30-39_Ferramentas/
    └── 30_Scripts/        # sync-media.sh
```

## 🔄 Workflow
1. Presets criados/ajustados via EasyEffects GUI
2. Copiados para `10_EasyEffects/presets/`
3. Commit + push
4. `sync-media.sh` distribui para nós da mesh
