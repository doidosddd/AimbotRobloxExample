local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera


function GetClosestPlayer()
    local ClosestPlayer = nil
    local ClosestDistance = math.huge

    for _, v in pairs(Players:GetPlayers()) do
        if v ~= Player and
           v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 and
           Player.Character and Player.Character:FindFirstChild("Humanoid")
            and Player.Character.Humanoid.Health > 0 and not v.Team == Player.Team then

            local vRoot = v.Character:FindFirstChild("HumanoidRootPart")
            local pRoot = Player.Character:FindFirstChild("HumanoidRootPart")

            if vRoot and pRoot then
                local distance = (vRoot.Position - pRoot.Position).Magnitude
                if distance < ClosestDistance then
                    ClosestDistance = distance
                    ClosestPlayer = v
                end
            end
        end
    end

    return ClosestPlayer
end

RunService.RenderStepped:Connect(function()
    local target = GetClosestPlayer()

    if target and target.Character and target.Character:FindFirstChild("Head") then
        local targetPos = target.Character.HumanoidRootPart.Position
        local camPos = Camera.CFrame.Position
        local newCFrame = CFrame.new(camPos, targetPos)
        Camera.CFrame = newCFrame
    end
end)

