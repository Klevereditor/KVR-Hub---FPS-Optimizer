# 🚀 FPS Booster para Roblox - Kleveredito

Um script completo de otimização de FPS para Roblox que remove elementos visuais desnecessários, mantém o áudio intacto e monitora continuamente por novas estruturas carregadas no jogo.

## ✨ Funcionalidades

### 🎯 Otimizações Principais
- **Remove elementos visuais desnecessários**: Decals, texturas, GUIs, partículas, luzes e efeitos
- **Mantém áudio intacto**: Preserva todos os sons e efeitos sonoros
- **Texturas ultra-leves**: Substitui materiais complexos por Plastic simples
- **Iluminação otimizada**: Reduz sombras, fog e efeitos de lighting
- **Monitoramento contínuo**: Detecta e otimiza automaticamente novas estruturas

### 🔄 Sistema Universal
- **Funciona em qualquer jogo**: Script universal que se adapta a diferentes tipos de jogo
- **Carregamento dinâmico**: Detecta automaticamente quando novas partes são carregadas
- **Auto-reexecução**: Aplica otimizações automaticamente em tempo real

## 🛠️ Como Usar

### 📦 Versões Disponíveis

**🚀 fps_booster.lua** - Versão padrão balanceada
- Otimização eficiente mantendo jogabilidade
- Recomendado para a maioria dos casos

**🔥 fps_booster_extreme.lua** - Versão ultra-agressiva  
- Para dispositivos muito fracos
- Remove praticamente tudo exceto sons e geometria básica
- Máxima performance, qualidade visual mínima

### Método 1: Executor de Scripts
1. Escolha a versão adequada para seu dispositivo
2. Copie todo o conteúdo do arquivo escolhido
3. Cole no seu executor de scripts favorito (Synapse X, KRNL, etc.)
4. Execute o script
5. Aguarde a mensagem de confirmação no chat

### Método 2: ServerStorage (Para desenvolvedores)
1. Coloque o script no ServerStorage do seu jogo
2. Configure-o como um ServerScript ou LocalScript conforme necessário

## 📋 O que o Script Remove

### ❌ Elementos Removidos
- `Decal` - Decalques e adesivos
- `Texture` - Texturas em geral  
- `SurfaceGui` - Interfaces em superfícies
- `BillboardGui` - Placas e letreiros 3D
- `ScreenGui` - Interfaces de tela (exceto essenciais)
- `ParticleEmitter` - Sistemas de partículas
- `Beam` - Feixes de luz
- `Trail` - Rastros e trilhas
- `Explosion` - Efeitos de explosão
- `Fire` - Efeitos de fogo
- `Smoke` - Efeitos de fumaça
- `Sparkles` - Efeitos de brilho
- `PointLight` - Luzes pontuais
- `SpotLight` - Holofotes
- `SurfaceLight` - Luzes de superfície
- `Atmosphere` - Efeitos atmosféricos
- `Clouds` - Nuvens
- `Sky` - Skybox personalizado

### ✅ Elementos Preservados
- **Todos os tipos de som**: `Sound`, `SoundGroup` e efeitos sonoros
- **Scripts essenciais**: LocalScripts, ServerScripts, ModuleScripts
- **Estruturas do jogador**: PlayerGui essencial
- **Geometria básica**: Parts e MeshParts (otimizados, mas mantidos)

## ⚡ Otimizações Aplicadas

### 🎨 Texturas e Materiais
- Material convertido para `Plastic` (mais leve)
- `Reflectance` definido como 0
- `TextureID` removido de MeshParts
- Imagens de ImageLabels/ImageButtons removidas

### 💡 Iluminação
- `Brightness` reduzido a 0
- `GlobalShadows` desabilitado
- `FogEnd` maximizado (9e9)
- `Ambient` e `OutdoorAmbient` padronizados

### 📷 Câmera e Workspace
- `StreamingEnabled` ativado para melhor performance
- `FieldOfView` otimizado para 70

## 🎮 Comandos no Chat

### Versão Padrão (fps_booster.lua)
**`/optimize` ou `/fps`** - Reexecuta manualmente a otimização completa. Útil se você notar que algum elemento visual voltou a aparecer.

```
/optimize
```

### Versão Extrema (fps_booster_extreme.lua)
**`/extreme`** - Reexecuta a otimização ultra-agressiva

**`/emergency`** - Ativa o modo de emergência (remove quase tudo)

```
/extreme
/emergency
```

## 🔧 Personalização

### 📁 Arquivo de Configuração (`fps_config.lua`)
Para facilitar a personalização, foi criado um arquivo de configuração completo onde você pode modificar todos os aspectos do script:

- **Elementos a manter/remover**: Listas personalizáveis
- **Configurações de iluminação**: Brightness, shadows, fog, etc.
- **Configurações de materiais**: Material padrão, reflexão, transparência
- **Monitoramento**: Intervalos, delays, areas monitoradas
- **Renderização**: Qualidade, detalhes de mesh, modo gráfico
- **Comandos de chat**: Personalize os comandos do chat
- **Notificações**: Cores, fontes, mensagens personalizadas

### Personalização Rápida nos Scripts

#### Modificar Elementos a Manter
Edite a tabela `CONFIG.KEEP_TYPES` para adicionar tipos de objetos que devem ser preservados:

```lua
KEEP_TYPES = {
    "Sound",
    "SoundGroup",
    -- Adicione aqui outros tipos que queira manter
    "SeuTipoPersonalizado"
}
```

#### Modificar Elementos a Remover
Edite a tabela `CONFIG.REMOVE_TYPES` para personalizar quais elementos devem ser removidos:

```lua
REMOVE_TYPES = {
    "Decal",
    "Texture",
    -- Adicione ou remova tipos conforme necessário
}
```

#### Exemplo de Configuração Personalizada
```lua
-- Para jogos de corrida (manter efeitos de velocidade)
KEEP_TYPES = {
    "Sound", "SoundGroup",
    "Trail", -- manter rastros dos carros
    "Beam"   -- manter feixes de luz
}

-- Para jogos de tiro (remover elementos que atrapalham visão)
REMOVE_TYPES = {
    "Decal", "Texture", "ParticleEmitter",
    "Atmosphere", "Clouds" -- remover efeitos atmosféricos
}
```

## ⚠️ Avisos Importantes

1. **Backup de jogos importantes**: Embora o script seja seguro, sempre teste primeiro em jogos menos importantes
2. **Alguns elementos podem voltar**: Jogos que regeneram elementos constantemente podem exigir o uso do comando `/optimize`
3. **Compatibilidade**: O script é universal, mas alguns jogos específicos podem ter comportamentos únicos
4. **Performance vs Visual**: O script prioriza performance sobre qualidade visual

## 🎯 Resultados Esperados

- **FPS aumentado significativamente** especialmente em dispositivos mais fracos
- **Menor uso de memória** devido à remoção de texturas e efeitos
- **Carregamento mais rápido** de novas áreas do jogo
- **Jogo mais responsivo** em geral

## 💡 Dicas de Otimização Avançadas

### 🎮 Para Diferentes Tipos de Jogos

**🏃 Jogos de Obby/Parkour**
- Use a versão padrão mantendo `Trail` para ver plataformas
- Reduza FOV para 60-65 para melhor precisão

**🚗 Jogos de Corrida**  
- Mantenha `Trail` e `Beam` para efeitos de velocidade
- Configure `CAMERA_FOV = 80` para melhor visão

**⚔️ Jogos de PvP/Tiro**
- Use versão extrema para máxima performance
- Remova todos os efeitos atmosféricos
- Mantenha apenas sons de impacto

**🏗️ Jogos de Construção**
- Configure `AGGRESSIVE_MODE = false`
- Mantenha `SurfaceGui` se necessário para interfaces

### 📱 Para Dispositivos Específicos

**💻 PC Médio**
- Use versão padrão
- `QUALITY_LEVEL = 3-5`
- Mantenha algumas texturas básicas

**📱 Mobile Fraco**
- Use versão extrema
- `QUALITY_LEVEL = 1`
- `CAMERA_FOV = 60`

**🖥️ PC Muito Fraco**
- Use versão extrema + modo emergência
- Desative monitoramento: `MONITORING.ENABLED = false`
- `STARTUP_DELAY = 5` para aguardar carregamento

## 🤝 Suporte

Script criado especialmente para **Kleveredito** da comunidade Roblox!

### 📋 Arquivos Incluídos
- `fps_booster.lua` - Script principal balanceado
- `fps_booster_extreme.lua` - Versão ultra-agressiva
- `fps_config.lua` - Arquivo de configuração personalizável
- `README.md` - Documentação completa

### 🐛 Resolução de Problemas

**Script não funciona:** Verifique se o executor suporta as funções do Roblox
**FPS ainda baixo:** Tente a versão extrema ou modo emergência
**Elementos importantes removidos:** Adicione-os à lista `KEEP_TYPES`
**Jogo trava:** Aumente o `STARTUP_DELAY` ou use menos otimizações

Se encontrar algum problema ou tiver sugestões de melhoria, sinta-se à vontade para modificar o código conforme suas necessidades específicas.

---

**Desenvolvido com ❤️ para a comunidade Roblox**
**Por um Roblox mais fluido e divertido para todos! 🚀**
