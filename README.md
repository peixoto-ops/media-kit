# media-kit

Configurações, presets e ferramentas de áudio e vídeo para a mesh LKE 5.0.

## Escopo

- **Áudio**: EasyEffects presets, WirePlumber configs, PipeWire tweaks
- **Vídeo**: (futuro) configurações de câmera, codificação, streaming
- **Ferramentas**: scripts de automação, profiles, integração mesh

## Johnny.Decimal

| Categoria | Conteúdo |
|:----------|:---------|
| `00-09` | Meta: documentação, agentes, licença |
| `10-19` | Áudio: presets, codecs, servidores |
| `10` | EasyEffects (presets, IRS, autoload) |
| `11` | WirePlumber (bluetooth, regras) |
| `12` | PipeWire (configurações do servidor) |
| `20-29` | Vídeo (futuro) |
| `30-39` | Ferramentas e scripts |

## Ativo: Aspire (peixoto-ops)

- **Fone**: JBL Endurance Race 2 (BT, codec SBC-XQ)
- **Servidor**: PipeWire 1.0.5 + WirePlumber 1.0.5
- **Processamento**: EasyEffects 7.1.6 (serviço systemd user)
- **Perfil BT**: A2DP fixo (HSP/HFP desabilitado)

## SSOT

Este repositório é o **Single Source of Truth** para configurações de mídia.
Cada nó da mesh faz `git pull` — nunca copiar presets manualmente.

## Licença

MIT
