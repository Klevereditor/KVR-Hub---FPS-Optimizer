--KVR Hub - FPS Optimizer

local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

-- Configurações de iluminação para performance
Lighting.Brightness = 0
Lighting.OutdoorAmbient = Color3.new(0, 0, 0)
Lighting.Ambient = Color3.new(0, 0, 0)
Lighting.GlobalShadows = false
Lighting.FogEnd = 100000
Lighting.FogStart = 0
Lighting.ColorShift_Top = Color3.new(0, 0, 0)
Lighting.ColorShift_Bottom = Color3.new(0, 0, 0)

-- Função para otimizar partes
local function optimizePart(part)
    if part:IsA("BasePart") then
        part.CastShadow = false
        part.Material = Enum.Material.Plastic -- Material mais leve
        part.Reflectance = 0
        part.Transparency = 0
        -- Tenta simplificar a geometria se for um MeshPart
        if part:IsA("MeshPart") then
            part.RenderFidelity = Enum.RenderFidelity.Performance
        end
    end
end

-- Percorre todos os objetos existentes e otimiza
for _, obj in ipairs(game:GetDescendants()) do
    optimizePart(obj)
end

-- Conecta a função a novos objetos adicionados ao jogo
game.DescendantAdded:Connect(optimizePart)

-- Otimização de texturas (exemplo: reduzir a qualidade)
-- Isso é mais complexo e geralmente requer manipulação de AssetIds ou substituição de texturas.
-- Para um script simples sem GUI, a melhor abordagem é usar materiais leves.
-- Se houver texturas personalizadas, elas precisariam ser substituídas por versões de baixa resolução.
-- Isso não é trivial de fazer automaticamente sem uma lista de AssetIds ou um sistema de substituição.

print("Script de otimização de performance ativado!")
print("Som e texturas (com materiais leves) foram mantidos.")
