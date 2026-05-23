# media-kit

Configurações, presets e ferramentas de **áudio e vídeo** para a mesh LKE 5.0.

## 🎯 Escopo

- **Áudio**: EasyEffects presets, WirePlumber configs, PipeWire tweaks
- **Vídeo**: (futuro) configurações de câmera, codificação, streaming
- **Ferramentas**: scripts de automação, sync mesh, diagnóstico

## 📦 Presets Disponíveis (14)

| Nome | Plugins | Tipo | Ideal para |
|:-----|:--------|:----:|:-----------|
| `cinema` | Crossfeed + EQ + Compressor | 🎬 | Filmes |
| `Loudness+Autogain` | Autogain + Bass + Crossfeed + EQ + Loudness | 🎵 | Música geral |
| `Bass Enhancing + Perfect EQ - LL` | Convolver + EQ + Limiter | 🎧 | Alta fidelidade |
| `Music` | Diversos | 🎵 | Música |
| `Video` | Diversos | 🎬 | Vídeo |
| `Bose` / `Sony` | EQ específico | 🎧 | Fones dessas marcas |

*Presets em formato antigo (precisam recriar via GUI): Bass Boosted, Perfect EQ, Advanced Auto Gain, Boosted*

## 🎛️ Pilha de Áudio (Aspire)

```
Firefox → Easy Effects Sink → [PipeWire] → JBL Endurance Race 2 (SBC-XQ)
                │
         Equalizador (15 bandas)
         Crossfeed / Bass Enhancer
         Compressor / Limiter / Loudness
```

## 🔧 Comandos Rápidos

```bash
# Sincronizar tudo pro nó local
./30-39_Ferramentas/30_Scripts/sync-media.sh

# Verificar estado do áudio
wpctl status | grep -A 20 "Audio"

# Forçar A2DP SBC-XQ no JBL
pw-cli s $(pw-cli ls Device | grep -B1 "bluez_card.38_D5_18_A8_D0_1F" | head -1 | awk '{print $2}' | tr -d ',') Profile "{ index: 6 }"

# Reiniciar serviços
systemctl --user restart wireplumber
systemctl --user restart easyeffects
```

## 📁 Estrutura Johnny.Decimal

```
media-kit/
├── 00-09_Meta/               # Documentação, AGENTS.md
├── 10-19_Audio/
│   ├── 10_EasyEffects/       # Presets (.json) + IRS (.irs) + autoload
│   ├── 11_WirePlumber/       # Regras bluetooth.lua.d
│   └── 12_PipeWire/          # Configs do servidor (futuro)
├── 20-29_Video/              # (futuro)
└── 30-39_Ferramentas/        # Scripts de automação
```

## 🤖 Skill: `media-kit-orchestrator`

O Hermes Agent carrega automaticamente a skill ao entrar neste repositório.
Ela gerencia: download de presets, validação, importação, sincronização mesh,
diagnóstico de codec e correção de problemas de áudio.

## 🔗 SSOT

Este repositório é o **Single Source of Truth**. Nós da mesh fazem `git pull`.
Nunca copiar presets manualmente entre máquinas.

## Licença

MIT © Peixoto Ops
