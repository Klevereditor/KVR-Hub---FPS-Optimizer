-- FPS Optimizer por Kleveredito
-- Script para melhorar FPS removendo elementos visuais e otimizando texturas

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local SoundService = game:GetService("SoundService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- Configurações de otimização
local settings = {
    removeParticles = true,
    removeDecals = true,
    removeTextures = true,
    removeShadows = true,
    removeReflections = true,
    removeWater = true,
    removeGrass = true,
    removeTrees = true,
    removeClouds = true,
    removeSunRays = true,
    removeBloom = true,
    removeBlur = true,
    removeDepthOfField = true,
    removeAtmosphere = true,
    removeWind = true,
    optimizeLighting = true,
    keepSound = true
}

-- Função para remover partículas
local function removeParticles()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("ParticleEmitter") or obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Sparkles") then
            obj.Enabled = false
        end
    end
end

-- Função para remover decals
local function removeDecals()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Decal") or obj:IsA("Texture") then
            obj:Destroy()
        end
    end
end

-- Função para otimizar texturas
local function optimizeTextures()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            -- Remove texturas de partes
            if obj.Material ~= Enum.Material.SmoothPlastic then
                obj.Material = Enum.Material.SmoothPlastic
            end
            
            -- Remove texturas de superfície
            if obj.TopSurface ~= Enum.SurfaceType.Smooth then
                obj.TopSurface = Enum.SurfaceType.Smooth
            end
            if obj.BottomSurface ~= Enum.SurfaceType.Smooth then
                obj.BottomSurface = Enum.SurfaceType.Smooth
            end
            if obj.LeftSurface ~= Enum.SurfaceType.Smooth then
                obj.LeftSurface = Enum.SurfaceType.Smooth
            end
            if obj.RightSurface ~= Enum.SurfaceType.Smooth then
                obj.RightSurface = Enum.SurfaceType.Smooth
            end
            if obj.FrontSurface ~= Enum.SurfaceType.Smooth then
                obj.FrontSurface = Enum.SurfaceType.Smooth
            end
            if obj.BackSurface ~= Enum.SurfaceType.Smooth then
                obj.BackSurface = Enum.SurfaceType.Smooth
            end
        end
        
        -- Remove texturas de meshes
        if obj:IsA("MeshPart") then
            if obj.Material ~= Enum.Material.SmoothPlastic then
                obj.Material = Enum.Material.SmoothPlastic
            end
        end
        
        -- Remove texturas de unions
        if obj:IsA("UnionOperation") then
            if obj.Material ~= Enum.Material.SmoothPlastic then
                obj.Material = Enum.Material.SmoothPlastic
            end
        end
    end
end

-- Função para remover sombras
local function removeShadows()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") or obj:IsA("MeshPart") or obj:IsA("UnionOperation") then
            obj.CastShadow = false
        end
    end
end

-- Função para remover água
local function removeWater()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Water") then
            obj:Destroy()
        end
    end
end

-- Função para remover grama
local function removeGrass()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Part") and obj.Name:lower():find("grass") then
            obj:Destroy()
        end
    end
end

-- Função para remover árvores
local function removeTrees()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Part") and (obj.Name:lower():find("tree") or obj.Name:lower():find("leaf")) then
            obj:Destroy()
        end
    end
end

-- Função para otimizar iluminação
local function optimizeLighting()
    -- Configurações básicas de iluminação
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 9e9
    Lighting.Brightness = 2
    Lighting.ClockTime = 14
    Lighting.GeographicLatitude = 0
    Lighting.OutdoorAmbient = Color3.fromRGB(127, 127, 127)
    
    -- Remove efeitos atmosféricos
    Lighting.Atmosphere = nil
    Lighting.Bloom = nil
    Lighting.Blur = nil
    Lighting.DepthOfField = nil
    Lighting.SunRays = nil
end

-- Função para remover nuvens
local function removeClouds()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Part") and obj.Name:lower():find("cloud") then
            obj:Destroy()
        end
    end
end

-- Função para remover vento
local function removeWind()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Part") and obj.Name:lower():find("wind") then
            obj:Destroy()
        end
    end
end

-- Função principal de otimização
local function applyOptimizations()
    if settings.removeParticles then
        removeParticles()
    end
    
    if settings.removeDecals then
        removeDecals()
    end
    
    if settings.removeTextures then
        optimizeTextures()
    end
    
    if settings.removeShadows then
        removeShadows()
    end
    
    if settings.removeWater then
        removeWater()
    end
    
    if settings.removeGrass then
        removeGrass()
    end
    
    if settings.removeTrees then
        removeTrees()
    end
    
    if settings.removeClouds then
        removeClouds()
    end
    
    if settings.removeWind then
        removeWind()
    end
    
    if settings.optimizeLighting then
        optimizeLighting()
    end
end

-- Sistema de monitoramento para novas estruturas
local function setupStructureMonitoring()
    local connection
    
    local function onDescendantAdded(descendant)
        -- Aguarda um pequeno delay para garantir que o objeto foi carregado
        wait(0.1)
        
        -- Aplica otimizações apenas em novos objetos
        if descendant:IsA("BasePart") or descendant:IsA("MeshPart") or descendant:IsA("UnionOperation") then
            if settings.removeTextures then
                if descendant.Material ~= Enum.Material.SmoothPlastic then
                    descendant.Material = Enum.Material.SmoothPlastic
                end
            end
            
            if settings.removeShadows then
                descendant.CastShadow = false
            end
        end
        
        if descendant:IsA("ParticleEmitter") or descendant:IsA("Fire") or descendant:IsA("Smoke") or descendant:IsA("Sparkles") then
            if settings.removeParticles then
                descendant.Enabled = false
            end
        end
        
        if descendant:IsA("Decal") or descendant:IsA("Texture") then
            if settings.removeDecals then
                descendant:Destroy()
            end
        end
        
        if descendant:IsA("Water") then
            if settings.removeWater then
                descendant:Destroy()
            end
        end
    end
    
    -- Conecta o monitoramento
    connection = workspace.DescendantAdded:Connect(onDescendantAdded)
    
    -- Retorna a conexão para poder desconectar se necessário
    return connection
end

-- Função para otimizar câmera
local function optimizeCamera()
    camera.CameraType = Enum.CameraType.Scriptable
    camera.CameraSubject = player.Character and player.Character:FindFirstChild("Humanoid")
end

-- Função para otimizar renderização
local function optimizeRendering()
    settings().Rendering.QualityLevel = 1
    settings().Physics.PhysicsEnvironmentalThrottle = 1
    settings().Network.PhysicsSend = Enum.PhysicsSendMethod.TopNErrors
    settings().Network.ExperimentalPhysicsEnabled = false
end

-- Função principal de inicialização
local function initialize()
    print("FPS Optimizer por Kleveredito - Iniciando...")
    
    -- Aguarda o carregamento inicial
    wait(1)
    
    -- Aplica otimizações iniciais
    applyOptimizations()
    
    -- Configura monitoramento de novas estruturas
    local structureMonitor = setupStructureMonitoring()
    
    -- Otimiza câmera
    optimizeCamera()
    
    -- Otimiza renderização
    optimizeRendering()
    
    print("FPS Optimizer ativado com sucesso!")
    print("Monitorando novas estruturas para otimização automática...")
    
    -- Loop de otimização contínua (a cada 5 segundos)
    spawn(function()
        while wait(5) do
            -- Reaplica otimizações básicas periodicamente
            if settings.removeParticles then
                removeParticles()
            end
            if settings.removeTextures then
                optimizeTextures()
            end
        end
    end)
end

-- Inicia o otimizador quando o script é executado
initialize()

-- Retorna funções para controle manual (opcional)
return {
    applyOptimizations = applyOptimizations,
    removeParticles = removeParticles,
    removeDecals = removeDecals,
    optimizeTextures = optimizeTextures,
    removeShadows = removeShadows,
    removeWater = removeWater,
    removeGrass = removeGrass,
    removeTrees = removeTrees,
    optimizeLighting = optimizeLighting,
    settings = settings
}