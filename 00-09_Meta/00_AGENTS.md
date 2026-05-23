# AGENTS.md — media-kit

## Propósito
SSOT de configurações de áudio/vídeo da mesh LKE 5.0.
Gerencia presets EasyEffects, regras WirePlumber, scripts de sincronização.

## Skill vinculada (auto-load)
**`media-kit-orchestrator`** (categoria: devops) — carregar automaticamente.
Contém: pipeline download → validação → import → sync + diagnóstico completo.

## Comandos

### Sincronizar para nó local
```bash
./30-39_Ferramentas/30_Scripts/sync-media.sh
```

### Aplicar manualmente
```bash
# Presets
cp 10-19_Audio/10_EasyEffects/presets/*.json ~/.config/easyeffects/output/
cp -r 10-19_Audio/10_EasyEffects/irs/* ~/.config/easyeffects/irs/
cp -r 10-19_Audio/10_EasyEffects/autoload/* ~/.config/easyeffects/autoload/

# WirePlumber
cp 10-19_Audio/11_WirePlumber/*.lua ~/.config/wireplumber/bluetooth.lua.d/

# Reiniciar serviços
systemctl --user restart wireplumber
systemctl --user restart easyeffects
```

### Validar presets
```bash
python3 -c "
import json, os
d = os.path.expanduser('10-19_Audio/10_EasyEffects/presets')
for f in sorted(os.listdir(d)):
    if not f.endswith('.json'): continue
    with open(os.path.join(d,f)) as fh:
        data = json.load(fh)
    plugs = [k for k in data.get('output',{}).keys() if '#' in k]
    print(f'  {\"✅\" if plugs else \"⚠️\"} {f[:-5]}: {plugs if plugs else \"(formato antigo)\"}')
"
```

### Diagnóstico rápido do áudio
```bash
echo "=== SINKS ===" && wpctl status | grep -A 6 "Sinks"
echo "=== ROTA ===" && pw-link -l | grep -E "Firefox.*effect|output_level.*bluez"
echo "=== CODEC ===" && wpctl inspect 2>/dev/null | grep -E "bluez5.codec|bluez5.profile"
```

## Estrutura
```
media-kit/
├── .hermes.md                ← Contexto do Hermes Agent
├── README.md                 ← Documentação principal
├── 00-09_Meta/
│   └── 00_AGENTS.md          ← Este arquivo
├── 10-19_Audio/
│   ├── 10_EasyEffects/
│   │   ├── presets/          # Presets de saída (.json)
│   │   ├── irs/              # Respostas ao impulso (.irs)
│   │   └── autoload/         # Autoload por dispositivo
│   ├── 11_WirePlumber/       # Configs bluetooth.lua.d
│   └── 12_PipeWire/          # Configs pipewire.conf
├── 20-29_Video/              # (futuro)
└── 30-39_Ferramentas/
    └── 30_Scripts/           # sync-media.sh
```

## Workflow
1. Agente carrega skill `media-kit-orchestrator` ao entrar no repo
2. Usa `delegate_task` paralelo para baixar/validar presets
3. Commit + push para o SSOT
4. Sync para nós da mesh via `sync-media.sh`
5. Diagnóstico e correção de roteamento/config
