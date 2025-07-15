# FPS Optimizer por Kleveredito

Um script avançado para melhorar o FPS no Roblox, removendo elementos visuais desnecessários e otimizando texturas automaticamente.

## 🚀 Características

- **Remoção de Partículas**: Desabilita ParticleEmitter, Fire, Smoke e Sparkles
- **Otimização de Texturas**: Converte todas as texturas para SmoothPlastic (mais leve)
- **Remoção de Decals**: Remove decals e texturas desnecessárias
- **Remoção de Sombras**: Desabilita sombras para melhor performance
- **Otimização de Iluminação**: Remove efeitos atmosféricos pesados
- **Monitoramento Inteligente**: Detecta e otimiza novas estruturas automaticamente
- **Preservação de Som**: Mantém todos os sons do jogo intactos

## 📋 Como Usar

### Método 1: Executor de Scripts
1. Abra seu executor de scripts (Synapse X, KRNL, etc.)
2. Cole o código do arquivo `FPSOptimizer.lua`
3. Execute o script
4. O otimizador será ativado automaticamente

### Método 2: Auto-Execute
1. Salve o script como `FPSOptimizer.lua`
2. Configure seu executor para auto-executar este script
3. O script será executado automaticamente ao entrar em qualquer jogo

## ⚙️ Configurações

O script possui configurações que podem ser modificadas no início do código:

```lua
local settings = {
    removeParticles = true,      -- Remove partículas
    removeDecals = true,         -- Remove decals
    removeTextures = true,       -- Otimiza texturas
    removeShadows = true,        -- Remove sombras
    removeWater = true,          -- Remove água
    removeGrass = true,          -- Remove grama
    removeTrees = true,          -- Remove árvores
    removeClouds = true,         -- Remove nuvens
    removeWind = true,           -- Remove vento
    optimizeLighting = true,     -- Otimiza iluminação
    keepSound = true            -- Mantém sons
}
```

## 🔧 Funcionalidades Avançadas

### Monitoramento de Estruturas
- Detecta automaticamente quando novas estruturas são carregadas
- Aplica otimizações em tempo real
- Funciona com jogos que carregam estruturas dinamicamente

### Otimização Contínua
- Reaplica otimizações a cada 5 segundos
- Garante que novas partículas sejam desabilitadas
- Mantém texturas otimizadas

### Compatibilidade Universal
- Funciona em qualquer jogo do Roblox
- Não interfere com mecânicas de jogo
- Preserva funcionalidades essenciais

## 📊 Benefícios Esperados

- **Aumento de FPS**: 20-50% de melhoria dependendo do jogo
- **Redução de Lag**: Menos elementos visuais para renderizar
- **Melhor Performance**: Especialmente em dispositivos mais fracos
- **Estabilidade**: Menos crashes relacionados a gráficos

## ⚠️ Observações Importantes

- O script preserva todos os sons do jogo
- Não afeta mecânicas de gameplay
- Funciona em conjunto com outros scripts
- Pode ser executado múltiplas vezes sem problemas

## 🛠️ Solução de Problemas

### Script não funciona
- Verifique se seu executor tem permissões adequadas
- Certifique-se de que o script está sendo executado corretamente
- Tente executar novamente após alguns segundos

### FPS ainda baixo
- Alguns jogos podem ter limitações do servidor
- Considere reduzir outras configurações gráficas do Roblox
- Verifique se há outros scripts interferindo

## 📝 Changelog

### v1.0
- Lançamento inicial
- Sistema de monitoramento de estruturas
- Otimização completa de texturas
- Remoção de elementos visuais pesados

## 👨‍💻 Autor

**Kleveredito** - Desenvolvedor da comunidade Roblox

---

*Este script foi desenvolvido para melhorar a experiência de jogo, especialmente em dispositivos com recursos limitados.*
