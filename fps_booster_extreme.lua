-- FPS Booster EXTREMO para Roblox
-- Versão ultra-agressiva para dispositivos muito fracos
-- Criado para Kleveredito

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

-- Configurações EXTREMAS de otimização
local EXTREME_CONFIG = {
    -- Elementos a manter (apenas o essencial)
    KEEP_TYPES = {
        "Sound",
        "SoundGroup"
    },
    
    -- Tipos a remover (lista expandida)
    REMOVE_TYPES = {
        "Decal", "Texture", "SurfaceGui", "BillboardGui", "ScreenGui",
        "ParticleEmitter", "Beam", "Trail", "Explosion", "Fire", "Smoke", 
        "Sparkles", "PointLight", "SpotLight", "SurfaceLight", "Atmosphere",
        "Clouds", "Sky", "SunRaysEffect", "BloomEffect", "BlurEffect",
        "ColorCorrectionEffect", "SunRaysEffect", "DepthOfFieldEffect",
        "ImageLabel", "ImageButton", "VideoFrame"
    },
    
    -- Configurações extremas de iluminação
    LIGHTING_SETTINGS = {
        Brightness = 0,
        ClockTime = 12,
        FogEnd = 9e9,
        FogStart = 0,
        GlobalShadows = false,
        OutdoorAmbient = Color3.fromRGB(200, 200, 200),
        Ambient = Color3.fromRGB(200, 200, 200),
        ShadowSoftness = 0,
        Technology = Enum.Technology.Compatibility
    },
    
    -- Configurações de renderização
    RENDER_SETTINGS = {
        -- Reduzir qualidade de renderização
        QualityLevel = 1,
        GraphicsMode = Enum.GraphicsMode.Manual
    }
}

-- Função para otimização extrema de objeto
local function extremeOptimizeObject(obj)
    if not obj or not obj.Parent then
        return
    end
    
    local className = obj.ClassName
    
    -- Remover elementos da lista
    for _, removeType in pairs(EXTREME_CONFIG.REMOVE_TYPES) do
        if className == removeType then
            pcall(function()
                obj:Destroy()
            end)
            return
        end
    end
    
    -- Manter apenas sons
    for _, keepType in pairs(EXTREME_CONFIG.KEEP_TYPES) do
        if className == keepType then
            return
        end
    end
    
    -- Otimização extrema de Parts
    if obj:IsA("BasePart") then
        pcall(function()
            obj.Material = Enum.Material.Plastic
            obj.Reflectance = 0
            obj.CastShadow = false
            obj.CanCollide = obj.CanCollide -- manter colisão se necessário
            
            -- Remover todos os filhos visuais
            for _, child in pairs(obj:GetChildren()) do
                if not child:IsA("Sound") and not child:IsA("SoundGroup") then
                    if EXTREME_CONFIG.REMOVE_TYPES[child.ClassName] or 
                       child.ClassName:find("Effect") or 
                       child.ClassName:find("Light") or
                       child.ClassName:find("Gui") then
                        child:Destroy()
                    end
                end
            end
        end)
    end
    
    -- Otimização extrema de MeshParts
    if obj:IsA("MeshPart") then
        pcall(function()
            obj.TextureID = ""
            obj.RenderFidelity = Enum.RenderFidelity.Performance
        end)
    end
    
    -- Remover todos os tipos de Mesh com texturas
    if obj:IsA("SpecialMesh") or obj:IsA("BlockMesh") or obj:IsA("CylinderMesh") then
        pcall(function()
            obj.TextureId = ""
        end)
    end
    
    -- Otimizar Unions (extremo)
    if obj:IsA("UnionOperation") then
        pcall(function()
            obj.UsePartColor = true
        end)
    end
end

-- Função para configurações extremas de renderização
local function setupExtremeRendering()
    pcall(function()
        -- Configurações de UserSettings para qualidade mínima
        local UserGameSettings = UserSettings():GetService("UserGameSettings")
        
        -- Definir qualidade gráfica para o mínimo
        UserGameSettings.MasterVolume = UserGameSettings.MasterVolume -- manter som
        
        -- Configurações do cliente (se disponíveis)
        settings().Rendering.QualityLevel = 1
        settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level04
        settings().Rendering.EagerBulkExecution = true
        settings().Rendering.GraphicsMode = Enum.GraphicsMode.Manual
    end)
end

-- Função para otimização extrema de iluminação
local function extremeOptimizeLighting()
    pcall(function()
        -- Aplicar todas as configurações extremas
        for property, value in pairs(EXTREME_CONFIG.LIGHTING_SETTINGS) do
            Lighting[property] = value
        end
        
        -- Remover TODOS os efeitos de iluminação
        for _, child in pairs(Lighting:GetChildren()) do
            if not child:IsA("Sound") and not child:IsA("SoundGroup") then
                child:Destroy()
            end
        end
        
        -- Configurações adicionais extremas
        Lighting.Exposure = 0
        Lighting.ExposureCompensation = 0
    end)
end

-- Função para otimização extrema do Workspace
local function extremeOptimizeWorkspace()
    pcall(function()
        -- Configurações extremas do Workspace
        Workspace.StreamingEnabled = true
        Workspace.StreamingMinRadius = 32
        Workspace.StreamingTargetRadius = 64
        
        -- Otimizar câmera
        if Workspace.CurrentCamera then
            local camera = Workspace.CurrentCamera
            camera.FieldOfView = 60  -- FOV menor pode melhorar performance
        end
        
        -- Tentar reduzir a renderDistance se possível
        if Workspace:FindFirstChild("Terrain") then
            local terrain = Workspace.Terrain
            terrain.Decoration = false
            -- Reduzir materiais do terrain se possível
            pcall(function()
                terrain:FillRegion(
                    Region3.new(Vector3.new(-2048, -512, -2048), Vector3.new(2048, 512, 2048)),
                    4, -- tamanho do voxel
                    Enum.Material.Plastic
                )
            end)
        end
    end)
end

-- Função para remoção extrema de elementos desnecessários
local function extremeCleanup()
    pcall(function()
        -- Remover todos os StarterGui desnecessários
        for _, gui in pairs(player.PlayerGui:GetChildren()) do
            if gui.Name ~= "Chat" and gui.Name ~= "PlayerList" then
                -- Manter apenas elementos essenciais
                local hasEssential = false
                for _, child in pairs(gui:GetDescendants()) do
                    if child:IsA("Sound") or child:IsA("SoundGroup") then
                        hasEssential = true
                        break
                    end
                end
                if not hasEssential then
                    gui:Destroy()
                end
            end
        end
        
        -- Limpeza extrema do ReplicatedStorage
        if ReplicatedStorage then
            for _, item in pairs(ReplicatedStorage:GetChildren()) do
                if not item:IsA("Sound") and not item:IsA("SoundGroup") and not item.Name:find("Script") then
                    extremeOptimizeObject(item)
                end
            end
        end
    end)
end

-- Função principal de otimização extrema
local function performExtremeOptimization()
    print("🔥 INICIANDO OTIMIZAÇÃO EXTREMA DE FPS...")
    
    -- Configurar renderização extrema
    setupExtremeRendering()
    
    -- Otimizar iluminação extrema
    extremeOptimizeLighting()
    
    -- Otimizar workspace extremo
    extremeOptimizeWorkspace()
    
    -- Limpeza extrema
    extremeCleanup()
    
    -- Otimizar todos os objetos existentes
    for _, obj in pairs(Workspace:GetDescendants()) do
        extremeOptimizeObject(obj)
    end
    
    if ReplicatedStorage then
        for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
            extremeOptimizeObject(obj)
        end
    end
    
    print("🔥 OTIMIZAÇÃO EXTREMA CONCLUÍDA!")
end

-- Sistema de monitoramento ultra-agressivo
local function setupExtremeMonitoring()
    -- Monitoramento imediato e agressivo
    local function onChildAdded(child)
        extremeOptimizeObject(child)
        
        -- Otimizar descendentes imediatamente
        for _, descendant in pairs(child:GetDescendants()) do
            extremeOptimizeObject(descendant)
        end
    end
    
    -- Conectar eventos
    Workspace.ChildAdded:Connect(onChildAdded)
    Workspace.DescendantAdded:Connect(extremeOptimizeObject)
    
    if ReplicatedStorage then
        ReplicatedStorage.DescendantAdded:Connect(extremeOptimizeObject)
    end
    
    -- Monitoramento ultra-frequente
    spawn(function()
        while true do
            wait(2) -- Verificar a cada 2 segundos
            
            -- Limpeza agressiva contínua
            for _, obj in pairs(Workspace:GetDescendants()) do
                for _, removeType in pairs(EXTREME_CONFIG.REMOVE_TYPES) do
                    if obj.ClassName == removeType then
                        pcall(function()
                            obj:Destroy()
                        end)
                    end
                end
            end
        end
    end)
    
    print("🔥 MONITORAMENTO ULTRA-AGRESSIVO ATIVADO!")
end

-- Função para modo de emergência (quando FPS está muito baixo)
local function emergencyMode()
    print("🚨 MODO DE EMERGÊNCIA ATIVADO!")
    
    -- Remover absolutamente tudo exceto sons e estruturas básicas
    for _, obj in pairs(game:GetDescendants()) do
        if obj ~= player and obj ~= Workspace and obj ~= Lighting then
            if not obj:IsA("Sound") and not obj:IsA("SoundGroup") and 
               not obj:IsA("BasePart") and not obj.Name:find("Script") then
                pcall(function()
                    obj:Destroy()
                end)
            end
        end
    end
    
    -- Configurações de emergência
    pcall(function()
        settings().Rendering.QualityLevel = 0.1
        Lighting.GlobalShadows = false
        Lighting.Brightness = 0
        Lighting.FogEnd = 9e9
    end)
end

-- Inicialização do modo extremo
local function initializeExtreme()
    print("🔥 FPS BOOSTER EXTREMO para Kleveredito iniciado!")
    
    wait(1)
    
    performExtremeOptimization()
    setupExtremeMonitoring()
    
    -- Mensagem de confirmação
    StarterGui:SetCore("ChatMakeSystemMessage", {
        Text = "🔥 MODO EXTREMO ativado! Performance máxima, qualidade mínima.";
        Color = Color3.fromRGB(255, 100, 0);
        Font = Enum.Font.GothamBold;
        FontSize = Enum.FontSize.Size18;
    })
end

-- Comandos especiais
game.Players.LocalPlayer.Chatted:Connect(function(message)
    if message:lower() == "/extreme" then
        performExtremeOptimization()
        StarterGui:SetCore("ChatMakeSystemMessage", {
            Text = "🔥 Otimização extrema reexecutada!";
            Color = Color3.fromRGB(255, 150, 0);
        })
    elseif message:lower() == "/emergency" then
        emergencyMode()
        StarterGui:SetCore("ChatMakeSystemMessage", {
            Text = "🚨 Modo de emergência ativado!";
            Color = Color3.fromRGB(255, 0, 0);
        })
    end
end)

-- Executar
initializeExtreme()

print("🔥 FPS BOOSTER EXTREMO carregado!")
print("💬 Comandos: /extreme (reotimizar) | /emergency (modo emergência)")