-- FPS Optimizer por Kleveredito
-- Script para melhorar FPS removendo elementos visuais e otimizando texturas

local FPSOptimizer = {}

-- Serviços
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- Variáveis
local player = Players.LocalPlayer
local camera = workspace.CurrentCamera
local originalSettings = {}
local isOptimized = false

-- Configurações de otimização
local optimizationSettings = {
    -- Lighting
    lighting = {
        Ambient = Color3.fromRGB(0, 0, 0),
        Brightness = 0,
        ColorShift_Bottom = Color3.fromRGB(0, 0, 0),
        ColorShift_Top = Color3.fromRGB(0, 0, 0),
        EnvironmentDiffuseScale = 0,
        EnvironmentSpecularScale = 0,
        GlobalShadows = false,
        OutdoorAmbient = Color3.fromRGB(0, 0, 0),
        Technology = Enum.Technology.Compatibility,
        ClockTime = 12,
        GeographicLatitude = 0,
        FogColor = Color3.fromRGB(0, 0, 0),
        FogEnd = 1000000,
        FogStart = 0,
        ExposureCompensation = 0,
        ShadowSoftness = 0
    },
    
    -- Camera
    camera = {
        FieldOfView = 70,
        CameraType = Enum.CameraType.Scriptable
    }
}

-- Função para salvar configurações originais
local function saveOriginalSettings()
    -- Lighting
    for property, value in pairs(optimizationSettings.lighting) do
        if Lighting[property] ~= nil then
            originalSettings[property] = Lighting[property]
        end
    end
    
    -- Camera
    for property, value in pairs(optimizationSettings.camera) do
        if camera[property] ~= nil then
            originalSettings[property] = camera[property]
        end
    end
end

-- Função para aplicar otimizações de lighting
local function optimizeLighting()
    for property, value in pairs(optimizationSettings.lighting) do
        if Lighting[property] ~= nil then
            Lighting[property] = value
        end
    end
end

-- Função para aplicar otimizações de câmera
local function optimizeCamera()
    for property, value in pairs(optimizationSettings.camera) do
        if camera[property] ~= nil then
            camera[property] = value
        end
    end
end

-- Função para otimizar texturas
local function optimizeTextures()
    local function processInstance(instance)
        -- Otimizar BaseTexture
        if instance:IsA("BasePart") then
            if instance.Material ~= Enum.Material.SmoothPlastic then
                instance.Material = Enum.Material.SmoothPlastic
            end
            if instance.Reflectance > 0 then
                instance.Reflectance = 0
            end
            if instance.MaterialVariant ~= "" then
                instance.MaterialVariant = ""
            end
        end
        
        -- Otimizar Decals
        if instance:IsA("Decal") then
            instance.Transparency = 1
        end
        
        -- Otimizar Texture
        if instance:IsA("Texture") then
            instance.Transparency = 1
        end
        
        -- Otimizar SurfaceGui
        if instance:IsA("SurfaceGui") then
            instance.Enabled = false
        end
        
        -- Otimizar BillboardGui
        if instance:IsA("BillboardGui") then
            instance.Enabled = false
        end
        
        -- Otimizar ParticleEmitter
        if instance:IsA("ParticleEmitter") then
            instance.Enabled = false
        end
        
        -- Otimizar Fire
        if instance:IsA("Fire") then
            instance.Enabled = false
        end
        
        -- Otimizar Smoke
        if instance:IsA("Smoke") then
            instance.Enabled = false
        end
        
        -- Otimizar Sparkles
        if instance:IsA("Sparkles") then
            instance.Enabled = false
        end
        
        -- Otimizar Beam
        if instance:IsA("Beam") then
            instance.Enabled = false
        end
        
        -- Otimizar Trail
        if instance:IsA("Trail") then
            instance.Enabled = false
        end
        
        -- Otimizar PointLight
        if instance:IsA("PointLight") then
            instance.Enabled = false
        end
        
        -- Otimizar SpotLight
        if instance:IsA("SpotLight") then
            instance.Enabled = false
        end
        
        -- Otimizar SurfaceLight
        if instance:IsA("SurfaceLight") then
            instance.Enabled = false
        end
        
        -- Processar filhos recursivamente
        for _, child in pairs(instance:GetChildren()) do
            processInstance(child)
        end
    end
    
    -- Processar workspace
    processInstance(workspace)
end

-- Função para remover elementos visuais desnecessários
local function removeVisualElements()
    local function processInstance(instance)
        -- Remover decorações
        if instance.Name:lower():match("decor") or 
           instance.Name:lower():match("ornament") or
           instance.Name:lower():match("detail") or
           instance.Name:lower():match("flower") or
           instance.Name:lower():match("plant") or
           instance.Name:lower():match("bush") or
           instance.Name:lower():match("tree") then
            instance:Destroy()
            return
        end
        
        -- Processar filhos recursivamente
        for _, child in pairs(instance:GetChildren()) do
            processInstance(child)
        end
    end
    
    -- Processar workspace
    processInstance(workspace)
end

-- Função para monitorar carregamento de estruturas
local function monitorStructureLoading()
    local function onChildAdded(child)
        -- Aguardar um pouco para garantir que a estrutura foi carregada
        wait(0.1)
        
        -- Verificar se é uma estrutura (Part, Model, etc.)
        if child:IsA("BasePart") or child:IsA("Model") then
            -- Aplicar otimizações na nova estrutura
            local function processNewInstance(instance)
                -- Otimizar texturas
                if instance:IsA("BasePart") then
                    if instance.Material ~= Enum.Material.SmoothPlastic then
                        instance.Material = Enum.Material.SmoothPlastic
                    end
                    if instance.Reflectance > 0 then
                        instance.Reflectance = 0
                    end
                end
                
                -- Processar filhos
                for _, grandChild in pairs(instance:GetChildren()) do
                    processNewInstance(grandChild)
                end
            end
            
            processNewInstance(child)
        end
    end
    
    -- Conectar ao evento ChildAdded do workspace
    workspace.ChildAdded:Connect(onChildAdded)
    
    -- Conectar ao evento ChildAdded de todos os modelos existentes
    local function connectToExistingModels(parent)
        for _, child in pairs(parent:GetChildren()) do
            if child:IsA("Model") then
                child.ChildAdded:Connect(onChildAdded)
            end
            connectToExistingModels(child)
        end
    end
    
    connectToExistingModels(workspace)
end

-- Função principal de otimização
function FPSOptimizer.optimize()
    if isOptimized then return end
    
    print("🔧 Iniciando otimização de FPS...")
    
    -- Salvar configurações originais
    saveOriginalSettings()
    
    -- Aplicar otimizações
    optimizeLighting()
    optimizeCamera()
    optimizeTextures()
    removeVisualElements()
    
    -- Iniciar monitoramento de carregamento
    monitorStructureLoading()
    
    isOptimized = true
    print("✅ Otimização de FPS concluída!")
end

-- Função para restaurar configurações originais
function FPSOptimizer.restore()
    if not isOptimized then return end
    
    print("🔄 Restaurando configurações originais...")
    
    -- Restaurar lighting
    for property, value in pairs(originalSettings) do
        if Lighting[property] ~= nil then
            Lighting[property] = value
        end
    end
    
    isOptimized = false
    print("✅ Configurações restauradas!")
end

-- Função para alternar otimização
function FPSOptimizer.toggle()
    if isOptimized then
        FPSOptimizer.restore()
    else
        FPSOptimizer.optimize()
    end
end

-- Atalho de teclado (F5 para alternar)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.F5 then
        FPSOptimizer.toggle()
    end
end)

-- Auto-otimização ao carregar
FPSOptimizer.optimize()

return FPSOptimizer