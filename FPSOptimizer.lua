-- FPS Optimizer por Kleveredito
-- Script para melhorar FPS removendo elementos visuais e otimizando texturas

local FPSOptimizer = {}

-- Serviços
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")

-- Variáveis
local player = Players.LocalPlayer
local camera = workspace.CurrentCamera
local optimizedParts = {}
local textureOptimizationEnabled = true

-- Configurações de otimização
local settings = {
    removeParticles = true,
    removeDecals = true,
    removeBeams = true,
    removeSmoke = true,
    removeFire = true,
    removeSparkles = true,
    removePointLights = true,
    removeSpotLights = true,
    removeSurfaceLights = true,
    optimizeLighting = true,
    textureQuality = 0.1, -- Qualidade das texturas (0.1 = muito baixa)
    maxTextureSize = 64, -- Tamanho máximo das texturas
    disableShadows = true,
    disableAmbientOcclusion = true,
    disableBloom = true,
    disableDepthOfField = true,
    disableSunRays = true,
    disableColorCorrection = true,
    disableBlur = true
}

-- Função para otimizar texturas
local function optimizeTexture(texture)
    if not texture or not textureOptimizationEnabled then return end
    
    -- Otimizar Texture
    if texture:IsA("Texture") then
        texture.TextureQuality = settings.textureQuality
        if texture.TextureSize then
            texture.TextureSize = Vector2.new(settings.maxTextureSize, settings.maxTextureSize)
        end
    end
    
    -- Otimizar Decal
    if texture:IsA("Decal") then
        texture.TextureQuality = settings.textureQuality
    end
    
    -- Otimizar MeshPart
    if texture:IsA("MeshPart") and texture.MeshId ~= "" then
        -- Reduzir qualidade do mesh
        texture.RenderFidelity = Enum.RenderFidelity.Precise
    end
end

-- Função para otimizar uma parte específica
local function optimizePart(part)
    if not part or optimizedParts[part] then return end
    optimizedParts[part] = true
    
    -- Remover elementos visuais
    if settings.removeParticles then
        for _, particle in pairs(part:GetDescendants()) do
            if particle:IsA("ParticleEmitter") or particle:IsA("Fire") or particle:IsA("Smoke") or particle:IsA("Sparkles") then
                particle.Enabled = false
            end
        end
    end
    
    if settings.removeBeams then
        for _, beam in pairs(part:GetDescendants()) do
            if beam:IsA("Beam") then
                beam.Enabled = false
            end
        end
    end
    
    if settings.removeDecals then
        for _, decal in pairs(part:GetDescendants()) do
            if decal:IsA("Decal") then
                decal.Transparency = 1
            end
        end
    end
    
    -- Otimizar texturas
    for _, texture in pairs(part:GetDescendants()) do
        if texture:IsA("Texture") or texture:IsA("Decal") or texture:IsA("MeshPart") then
            optimizeTexture(texture)
        end
    end
    
    -- Remover luzes
    if settings.removePointLights then
        for _, light in pairs(part:GetDescendants()) do
            if light:IsA("PointLight") or light:IsA("SpotLight") or light:IsA("SurfaceLight") then
                light.Enabled = false
            end
        end
    end
end

-- Função para otimizar lighting
local function optimizeLighting()
    if not settings.optimizeLighting then return end
    
    -- Configurações básicas
    Lighting.GlobalShadows = not settings.disableShadows
    Lighting.AmbientOcclusion = not settings.disableAmbientOcclusion
    Lighting.Bloom.Enabled = not settings.disableBloom
    Lighting.DepthOfField.Enabled = not settings.disableDepthOfField
    Lighting.SunRays.Enabled = not settings.disableSunRays
    Lighting.ColorCorrection.Enabled = not settings.disableColorCorrection
    Lighting.Blur.Enabled = not settings.disableBlur
    
    -- Reduzir qualidade
    Lighting.Technology = Enum.Technology.Compatibility
    Lighting.ShadowSoftness = 0
    Lighting.Brightness = 1
    Lighting.ClockTime = 12
    Lighting.ExposureCompensation = 0
end

-- Função para otimizar workspace
local function optimizeWorkspace()
    for _, part in pairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") or part:IsA("Model") or part:IsA("Part") then
            optimizePart(part)
        end
    end
end

-- Função para monitorar novas estruturas
local function monitorNewStructures()
    local connection
    connection = workspace.DescendantAdded:Connect(function(descendant)
        if descendant:IsA("BasePart") or descendant:IsA("Model") or descendant:IsA("Part") then
            -- Aguardar um frame para garantir que a estrutura foi carregada
            RunService.Heartbeat:Wait()
            optimizePart(descendant)
        end
    end)
    
    return connection
end

-- Função para otimizar câmera
local function optimizeCamera()
    if camera then
        camera.CameraType = Enum.CameraType.Scriptable
        camera.CameraSubject = player.Character and player.Character:FindFirstChild("Humanoid")
    end
end

-- Função principal de inicialização
function FPSOptimizer:Initialize()
    print("🚀 FPS Optimizer por Kleveredito inicializado!")
    
    -- Aguardar o carregamento inicial
    wait(1)
    
    -- Aplicar otimizações
    optimizeLighting()
    optimizeWorkspace()
    optimizeCamera()
    
    -- Monitorar novas estruturas
    local monitorConnection = monitorNewStructures()
    
    -- Otimizar periodicamente
    RunService.Heartbeat:Connect(function()
        -- Reativar otimização de texturas se necessário
        if not textureOptimizationEnabled then
            textureOptimizationEnabled = true
        end
        
        -- Otimizar partes que podem ter sido modificadas
        for part, _ in pairs(optimizedParts) do
            if part and part.Parent then
                optimizePart(part)
            else
                optimizedParts[part] = nil
            end
        end
    end)
    
    print("✅ Otimizações aplicadas com sucesso!")
    print("📊 Texturas otimizadas, elementos visuais removidos")
    print("🎮 FPS deve estar significativamente melhor!")
end

-- Função para alternar otimizações
function FPSOptimizer:ToggleOptimizations(enabled)
    textureOptimizationEnabled = enabled
    if enabled then
        print("🔄 Reativando otimizações...")
        optimizeWorkspace()
    else
        print("⏸️ Pausando otimizações...")
    end
end

-- Função para limpar otimizações
function FPSOptimizer:Cleanup()
    optimizedParts = {}
    textureOptimizationEnabled = false
    print("🧹 Otimizações limpas!")
end

-- Auto-inicialização
FPSOptimizer:Initialize()

return FPSOptimizer