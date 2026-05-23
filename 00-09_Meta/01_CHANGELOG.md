# Changelog — media-kit

Registro permanente das sessões de configuração de áudio/vídeo da mesh.

---

## 2026-05-23 — Sessão Inaugural: Setup de Áudio

**Objetivo:** Diagnosticar e corrigir qualidade de áudio no Aspire com JBL Endurance Race 2,
instalar EasyEffects, importar presets, criar SSOT, replicar no Inspiron.

### Diagnóstico
- JBL Endurance Race 2 conectado em **HSP/HFP (codec mSBC)** — qualidade telefônica
  - mSBC: 16kHz mono, ~64kbps
  - **Corrigido para A2DP SBC-XQ**: 48kHz estéreo, ~452kbps
- Fone não suporta AAC/aptX/LDAC — SBC-XQ é o codec máximo

### WirePlumber (Bluetooth)
- HSP/HFP desabilitado permanentemente: `bluetooth.lua.d/60-desabilita-hsp-hfp.lua`
- Regra específica para JBL forçar A2DP: `51-jbl-a2dp.lua`
- `bluez5.roles = "[ a2dp_sink a2dp_source ]"` — sem perfis de telefone

### EasyEffects
- **Aspire**: v7.1.6 (apt), serviço systemd user
- **Inspiron**: v8.2.4 (Flatpak — Ubuntu 22.04 não tem no apt)

### Presets
| Nome | Plugins | Finalidade |
|:-----|:--------|:-----------|
| `cinema` | Crossfeed + EQ + Compressor | Filmes |
| `Loudness+Autogain` | Autogain + Bass + Crossfeed + EQ + Loudness | Música geral |
| `Bass Enhancing + Perfect EQ - LL` | Convolver + EQ + Limiter | Alta fidelidade |
| `jbl-autoeq` | EQ 32 bandas (Harman target) + Limiter | JBL Endurance Race 2 |

- Importados de: JackHack96, crachecode/AutoEQ, Bundy01
- 14 presets no total, 7 válidos (formato #0), 7 formato antigo

### Atalhos
- `~/bin/media-sync` — sync presets/configs do SSOT pro nó local
- Criado em Aspire e Inspiron

### Skill
- `media-kit-orchestrator` (devops) — pipeline: download → validar → importar → sync

### Lições Aprendidas
1. **Formato de preset EasyEffects 7.x**: chaves com `#0` (ex: `equalizer#0`).
   Formato antigo (sem `#0`) não carrega — mostra "sem efeitos".
2. **Limiter parâmetros**: `mode` é string (`"Herm Thin"`), não int.
   `dithering` e `oversampling` são strings (`"None"`), não números.
3. **WirePlumber Lua**: hífens em nomes de propriedade quebram o Lua.
   Usar `["update-props"]` em vez de `update-props`.
4. **EasyEffects via SSH**: não inicia em sessão headless — precisa de display.
   Solução: serviço systemd user inicia no login gráfico.
5. **Autoload**: presets carregam automático por dispositivo via JSON em `autoload/`.
