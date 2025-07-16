local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local function removeHeavyAssets()
    for _, asset in pairs(Workspace:GetChildren()) do
        if asset:IsA("Part") or asset:IsA("MeshPart") then
            asset.Material = Enum.Material.Plastic
            asset.BrickColor = BrickColor.new("Medium stone grey")
            asset.TextureID = "" -- Remove textures
        elseif asset:IsA("Model") then
            for _, part in pairs(asset:GetChildren()) do
                if part:IsA("Part") or part:IsA("MeshPart") then
                    part.Material = Enum.Material.Plastic
                    part.BrickColor = BrickColor.new("Medium stone grey")
                    part.TextureID = "" -- Remove textures
                end
            end
        end
    end
end

local function onChildAdded(child)
    if child:IsA("Part") or child:IsA("MeshPart") then
        child.Material = Enum.Material.Plastic
        child.BrickColor = BrickColor.new("Medium stone grey")
        child.TextureID = "" -- Remove textures
    elseif child:IsA("Model") then
        for _, part in pairs(child:GetChildren()) do
            if part:IsA("Part") or part:IsA("MeshPart") then
                part.Material = Enum.Material.Plastic
                part.BrickColor = BrickColor.new("Medium stone grey")
                part.TextureID = "" -- Remove textures
            end
        end
    end
end

local function onPlayerAdded(player)
    player.CharacterAdded:Connect(function(character)
        character:WaitForChild("Humanoid").Changed:Connect(function()
            removeHeavyAssets()
        end)
    end)
end

Players.PlayerAdded:Connect(onPlayerAdded)
Workspace.ChildAdded:Connect(onChildAdded)

removeHeavyAssets()
