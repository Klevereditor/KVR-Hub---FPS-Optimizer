-- Arquivo de Configuração Personalizável para FPS Booster
-- Criado para Kleveredito
-- Modifique as configurações abaixo conforme suas necessidades

local FPS_CONFIG = {
    
    -- ========================================
    -- CONFIGURAÇÕES GERAIS
    -- ========================================
    
    -- Nome do jogador (deixe vazio para auto-detectar)
    PLAYER_NAME = "",
    
    -- Aguardar tempo em segundos antes de iniciar otimização
    STARTUP_DELAY = 2,
    
    -- Exibir mensagens de debug no console
    DEBUG_MESSAGES = true,
    
    -- Mostrar notificações no chat do jogo
    SHOW_CHAT_NOTIFICATIONS = true,
    
    -- ========================================
    -- ELEMENTOS PARA MANTER (NÃO REMOVER)
    -- ========================================
    
    KEEP_TYPES = {
        -- Áudio (sempre manter)
        "Sound",
        "SoundGroup", 
        "EqualizerSoundEffect",
        "ReverbSoundEffect",
        "ChorusSoundEffect",
        "CompressorSoundEffect",
        "DistortionSoundEffect",
        "EchoSoundEffect",
        "FlangeSoundEffect",
        "PitchShiftSoundEffect",
        "TremoloSoundEffect",
        
        -- Scripts essenciais
        "LocalScript",
        "Script",
        "ModuleScript",
        
        -- Adicione aqui outros tipos que você quer manter
        -- Exemplo: "SpecialMesh" (se você quiser manter meshes especiais)
    },
    
    -- ========================================
    -- ELEMENTOS PARA REMOVER
    -- ========================================
    
    REMOVE_TYPES = {
        -- Visuais básicos
        "Decal",
        "Texture",
        
        -- Interfaces
        "SurfaceGui",
        "BillboardGui",
        "ScreenGui",
        
        -- Efeitos de partículas
        "ParticleEmitter",
        "Beam",
        "Trail",
        "Explosion",
        "Fire",
        "Smoke",
        "Sparkles",
        
        -- Iluminação
        "PointLight",
        "SpotLight",
        "SurfaceLight",
        
        -- Atmosfera
        "Atmosphere",
        "Clouds",
        "Sky",
        
        -- Adicione aqui outros tipos que você quer remover
        -- Exemplo: "ForceField", "Humanoid" (cuidado com estes!)
    },
    
    -- ========================================
    -- CONFIGURAÇÕES DE ILUMINAÇÃO
    -- ========================================
    
    LIGHTING_SETTINGS = {
        Brightness = 0,              -- 0 = mais escuro, 2 = padrão
        ClockTime = 12,              -- Hora do dia (12 = meio-dia)
        FogEnd = 9e9,               -- Distância do fog (9e9 = sem fog)
        FogStart = 0,               -- Início do fog
        GlobalShadows = false,      -- true/false para sombras
        OutdoorAmbient = Color3.fromRGB(128, 128, 128), -- Luz ambiente externa
        Ambient = Color3.fromRGB(128, 128, 128),        -- Luz ambiente geral
        
        -- Configurações adicionais (descomente se quiser usar)
        -- ShadowSoftness = 0,
        -- Technology = Enum.Technology.Compatibility,
        -- Exposure = 0,
    },
    
    -- ========================================
    -- CONFIGURAÇÕES DE MATERIAIS
    -- ========================================
    
    MATERIAL_SETTINGS = {
        -- Material padrão para substituir todos os outros
        DEFAULT_MATERIAL = Enum.Material.Plastic,  -- Plastic é o mais leve
        
        -- Configurações para Parts
        REFLECTANCE = 0,            -- 0 = sem reflexo, 1 = espelho
        DEFAULT_TRANSPARENCY = 0,   -- 0 = opaco, 1 = invisível
        CAST_SHADOW = false,        -- true/false para sombras
    },
    
    -- ========================================
    -- CONFIGURAÇÕES DE MONITORAMENTO
    -- ========================================
    
    MONITORING = {
        -- Ativar monitoramento contínuo
        ENABLED = true,
        
        -- Intervalo de verificação periódica (em segundos)
        CHECK_INTERVAL = 5,
        
        -- Delay após adicionar novos objetos (em segundos)
        NEW_OBJECT_DELAY = 0.1,
        
        -- Monitorar ReplicatedStorage
        MONITOR_REPLICATED_STORAGE = true,
        
        -- Monitorar PlayerGui
        MONITOR_PLAYER_GUI = false,
    },
    
    -- ========================================
    -- CONFIGURAÇÕES DE WORKSPACE
    -- ========================================
    
    WORKSPACE_SETTINGS = {
        -- Ativar StreamingEnabled
        STREAMING_ENABLED = true,
        
        -- Configurações de câmera
        CAMERA_FOV = 70,            -- Campo de visão (60-120)
        
        -- Otimizar terrain
        OPTIMIZE_TERRAIN = true,
        TERRAIN_DECORATION = false,
    },
    
    -- ========================================
    -- CONFIGURAÇÕES DE RENDERIZAÇÃO
    -- ========================================
    
    RENDERING = {
        -- Tentar modificar qualidade de renderização
        MODIFY_QUALITY = true,
        
        -- Nível de qualidade (1 = mínimo, 21 = máximo)
        QUALITY_LEVEL = 1,
        
        -- Nível de detalhe de MeshParts
        MESH_DETAIL_LEVEL = Enum.MeshPartDetailLevel.Level04, -- Level04 = menor detalhe
        
        -- Modo gráfico manual
        GRAPHICS_MODE = Enum.GraphicsMode.Manual,
    },
    
    -- ========================================
    -- CONFIGURAÇÕES ESPECIAIS
    -- ========================================
    
    SPECIAL = {
        -- Remover texturas de MeshParts
        REMOVE_MESH_TEXTURES = true,
        
        -- Remover texturas de SpecialMesh
        REMOVE_SPECIAL_MESH_TEXTURES = true,
        
        -- Otimizar ImageLabels/ImageButtons (em vez de remover)
        OPTIMIZE_IMAGE_ELEMENTS = true,
        
        -- Limpeza de PlayerGui (cuidado: pode remover interfaces importantes)
        CLEAN_PLAYER_GUI = false,
        
        -- Modo agressivo (remove mais elementos)
        AGGRESSIVE_MODE = false,
    },
    
    -- ========================================
    -- COMANDOS DE CHAT PERSONALIZÁVEIS
    -- ========================================
    
    CHAT_COMMANDS = {
        -- Comando para reotimizar
        REOPTIMIZE = {"optimize", "fps", "boost"},
        
        -- Comando para modo agressivo (se disponível)
        AGGRESSIVE = {"extreme", "max"},
        
        -- Comando para emergência
        EMERGENCY = {"emergency", "help"},
        
        -- Comando para estatísticas
        STATS = {"stats", "info"},
    },
    
    -- ========================================
    -- CONFIGURAÇÕES DE NOTIFICAÇÃO
    -- ========================================
    
    NOTIFICATIONS = {
        -- Cores das mensagens
        SUCCESS_COLOR = Color3.fromRGB(0, 255, 0),
        WARNING_COLOR = Color3.fromRGB(255, 255, 0),
        ERROR_COLOR = Color3.fromRGB(255, 0, 0),
        INFO_COLOR = Color3.fromRGB(0, 150, 255),
        
        -- Fonte das mensagens
        FONT = Enum.Font.GothamBold,
        FONT_SIZE = Enum.FontSize.Size18,
        
        -- Mensagens personalizadas
        STARTUP_MESSAGE = "🚀 FPS Booster ativado por Kleveredito!",
        REOPTIMIZE_MESSAGE = "🔄 Otimização reexecutada!",
        COMPLETE_MESSAGE = "✅ Otimização concluída!",
    }
}

-- ========================================
-- RETORNAR CONFIGURAÇÃO
-- ========================================

return FPS_CONFIG