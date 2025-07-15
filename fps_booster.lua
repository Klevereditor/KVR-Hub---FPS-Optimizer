-- FPS Booster Script para Roblox
-- Criado para Kleveredito
-- Remove elementos visuais desnecessários, mantém áudio e otimiza texturas

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer

-- Configurações de otimização
local CONFIG = {
    -- Elementos a manter (não remover)
    KEEP_TYPES = {
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
        "TremoloSoundEffect"
    },
    
    -- Tipos a remover completamente
    REMOVE_TYPES = {
        "Decal",
        "Texture", 
        "SurfaceGui",
        "BillboardGui",
        "ScreenGui",
        "ParticleEmitter",
        "Beam",
        "Trail",
        "Explosion",
        "Fire",
        "Smoke",
        "Sparkles",
        "PointLight",
        "SpotLight",
        "SurfaceLight",
        "Atmosphere",
        "Clouds",
        "Sky"
    },
    
    -- Propriedades de iluminação para reduzir
    LIGHTING_SETTINGS = {
        Brightness = 0,
        ClockTime = 12,
        FogEnd = 9e9,
        FogStart = 0,
        GlobalShadows = false,
        OutdoorAmbient = Color3.fromRGB(128, 128, 128),
        Ambient = Color3.fromRGB(128, 128, 128)
    }
}

-- Função para verificar se um objeto deve ser mantido
local function shouldKeepObject(obj)
    local className = obj.ClassName
    
    -- Manter objetos de áudio
    for _, keepType in pairs(CONFIG.KEEP_TYPES) do
        if className == keepType then
            return true
        end
    end
    
    -- Manter estruturas essenciais do jogador
    if obj:IsDescendantOf(player.PlayerGui) and className ~= "ScreenGui" then
        return true
    end
    
    -- Manter scripts essenciais
    if className:find("Script") then
        return true
    end
    
    return false
end

-- Função para verificar se um objeto deve ser removido
local function shouldRemoveObject(obj)
    local className = obj.ClassName
    
    for _, removeType in pairs(CONFIG.REMOVE_TYPES) do
        if className == removeType then
            return true
        end
    end
    
    return false
end

-- Função para otimizar um objeto
local function optimizeObject(obj)
    if not obj or not obj.Parent then
        return
    end
    
    -- Remover objetos desnecessários
    if shouldRemoveObject(obj) then
        pcall(function()
            obj:Destroy()
        end)
        return
    end
    
    -- Se deve manter, não modificar
    if shouldKeepObject(obj) then
        return
    end
    
    -- Otimizar Parts e MeshParts
    if obj:IsA("BasePart") then
        pcall(function()
            obj.Material = Enum.Material.Plastic
            obj.Reflectance = 0
            obj.Transparency = 0
            
            -- Remover texturas
            for _, child in pairs(obj:GetChildren()) do
                if shouldRemoveObject(child) then
                    child:Destroy()
                end
            end
        end)
    end
    
    -- Otimizar MeshParts especificamente
    if obj:IsA("MeshPart") then
        pcall(function()
            obj.TextureID = ""
        end)
    end
    
    -- Otimizar SpecialMesh
    if obj:IsA("SpecialMesh") then
        pcall(function()
            obj.TextureId = ""
        end)
    end
    
    -- Otimizar ImageLabels e ImageButtons (reduzir a transparência ao invés de remover)
    if obj:IsA("ImageLabel") or obj:IsA("ImageButton") then
        pcall(function()
            obj.Image = ""
            obj.BackgroundTransparency = 0.9
        end)
    end
end

-- Função para otimizar todos os objetos em um container
local function optimizeContainer(container)
    if not container then return end
    
    -- Otimizar o próprio container
    optimizeObject(container)
    
    -- Otimizar todos os descendentes
    for _, descendant in pairs(container:GetDescendants()) do
        optimizeObject(descendant)
    end
end

-- Função para otimizar configurações de iluminação
local function optimizeLighting()
    pcall(function()
        for property, value in pairs(CONFIG.LIGHTING_SETTINGS) do
            Lighting[property] = value
        end
        
        -- Remover efeitos de iluminação
        for _, child in pairs(Lighting:GetChildren()) do
            if shouldRemoveObject(child) then
                child:Destroy()
            end
        end
    end)
end

-- Função para otimizar configurações do Workspace
local function optimizeWorkspace()
    pcall(function()
        -- Desabilitar sombras e efeitos visuais
        Workspace.StreamingEnabled = true
        
        -- Otimizar câmera
        if Workspace.CurrentCamera then
            Workspace.CurrentCamera.FieldOfView = 70
        end
    end)
end

-- Função principal de otimização
local function performOptimization()
    print("🚀 Iniciando otimização de FPS...")
    
    -- Otimizar iluminação
    optimizeLighting()
    
    -- Otimizar workspace
    optimizeWorkspace()
    
    -- Otimizar workspace e seus descendentes
    optimizeContainer(Workspace)
    
    -- Otimizar ReplicatedStorage se existir
    if ReplicatedStorage then
        optimizeContainer(ReplicatedStorage)
    end
    
    print("✅ Otimização inicial concluída!")
end

-- Sistema de monitoramento contínuo
local function setupContinuousMonitoring()
    -- Monitorar adições no Workspace
    local function onChildAdded(child)
        wait(0.1) -- Pequeno delay para garantir que o objeto foi totalmente carregado
        optimizeObject(child)
        
        -- Se for um modelo ou container, otimizar seus descendentes também
        if child:IsA("Model") or child:IsA("Folder") then
            for _, descendant in pairs(child:GetDescendants()) do
                optimizeObject(descendant)
            end
        end
    end
    
    -- Conectar eventos de monitoramento
    Workspace.ChildAdded:Connect(onChildAdded)
    Workspace.DescendantAdded:Connect(function(descendant)
        wait(0.05)
        optimizeObject(descendant)
    end)
    
    -- Monitorar ReplicatedStorage também
    if ReplicatedStorage then
        ReplicatedStorage.DescendantAdded:Connect(function(descendant)
            wait(0.05)
            optimizeObject(descendant)
        end)
    end
    
    -- Monitoramento periódico para capturar elementos que podem ter sido perdidos
    spawn(function()
        while true do
            wait(5) -- Verificar a cada 5 segundos
            
            -- Re-otimizar objetos que podem ter sido adicionados
            for _, obj in pairs(Workspace:GetDescendants()) do
                if shouldRemoveObject(obj) then
                    pcall(function()
                        obj:Destroy()
                    end)
                end
            end
        end
    end)
    
    print("👁️ Sistema de monitoramento contínuo ativado!")
end

-- Inicializar script
local function initialize()
    print("🎮 FPS Booster para Kleveredito iniciado!")
    
    -- Aguardar um pouco para garantir que o jogo carregou
    wait(2)
    
    -- Executar otimização inicial
    performOptimization()
    
    -- Configurar monitoramento contínuo
    setupContinuousMonitoring()
    
    -- Feedback final
    StarterGui:SetCore("ChatMakeSystemMessage", {
        Text = "🚀 FPS Booster ativado! Texturas otimizadas e elementos visuais removidos.";
        Color = Color3.fromRGB(0, 255, 0);
        Font = Enum.Font.GothamBold;
        FontSize = Enum.FontSize.Size18;
    })
end

-- Executar inicialização
initialize()

-- Comando para reexecutar otimização manualmente (opcional)
game.Players.LocalPlayer.Chatted:Connect(function(message)
    if message:lower() == "/optimize" or message:lower() == "/fps" then
        performOptimization()
        StarterGui:SetCore("ChatMakeSystemMessage", {
            Text = "🔄 Otimização reexecutada!";
            Color = Color3.fromRGB(255, 255, 0);
        })
    end
end)

print("🎯 Script FPS Booster carregado com sucesso!")
print("💬 Digite '/optimize' ou '/fps' no chat para reexecutar a otimização")