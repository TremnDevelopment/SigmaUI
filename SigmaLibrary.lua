local UI = {}
local TweenService = game:GetService("TweenService")

function UI:CreateGUI(name)
    local gui = Instance.new("ScreenGui")
    gui.Name = name or "MyGUI"
    gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    
    local frame = Instance.new("Frame")
    frame.Name = "MainFrame"
    frame.Size = UDim2.new(0, 600, 0, 400)
    frame.Position = UDim2.new(0.5, -300, 0.5, -200)
    frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    frame.Draggable = true
    frame.Parent = gui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0.1, 0)
    corner.Parent = frame

    return frame
end

function UI:CreateTabContainer(parent)
    local tabContainer = Instance.new("Frame")
    tabContainer.Size = UDim2.new(0, 150, 1, 0)
    tabContainer.Position = UDim2.new(0, 0, 0, 0)
    tabContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    tabContainer.Parent = parent
    tabContainer.Name = "TabContainer"
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0.1, 0)
    corner.Parent = tabContainer

    local tabs = Instance.new("Frame")
    tabs.Size = UDim2.new(1, 0, 0, 30)
    tabs.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    tabs.Parent = tabContainer

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0.1, 0)
    corner.Parent = tabs

    local content = Instance.new("Frame")
    content.Size = UDim2.new(1, 0, 1, -30)
    content.Position = UDim2.new(0, 0, 0, 30)
    content.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    content.Parent = tabContainer
    content.Name = "Content"
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0.1, 0)
    corner.Parent = content

    return tabContainer, tabs, content
end

function UI:CreateTab(parent, name, callback)
    local tab = Instance.new("TextButton")
    tab.Size = UDim2.new(1, 0, 0, 30)
    tab.Text = name
    tab.TextSize = 16
    tab.TextColor3 = Color3.fromRGB(255, 255, 255)
    tab.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    tab.Parent = parent
    tab.Name = name

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0.1, 0)
    corner.Parent = tab

    tab.MouseButton1Click:Connect(function()
        if callback then
            callback()
        end
    end)

    return tab
end

function UI:CreateSection(tabContent, name)
    local section = Instance.new("Frame")
    section.Size = UDim2.new(1, 0, 0, 150)
    section.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    section.Parent = tabContent
    section.Name = name
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0.1, 0)
    corner.Parent = section

    local sectionLabel = Instance.new("TextLabel")
    sectionLabel.Size = UDim2.new(1, 0, 0, 30)
    sectionLabel.Text = name
    sectionLabel.TextSize = 16
    sectionLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    sectionLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    sectionLabel.Parent = section

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0.1, 0)
    corner.Parent = sectionLabel

    local scrollingFrame = Instance.new("ScrollingFrame")
    scrollingFrame.Size = UDim2.new(1, 0, 1, -30)
    scrollingFrame.Position = UDim2.new(0, 0, 0, 30)
    scrollingFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    scrollingFrame.Parent = section
    scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0.1, 0)
    corner.Parent = scrollingFrame

    local listLayout = Instance.new("UIListLayout")
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Padding = UDim.new(0, 10)
    listLayout.Parent = scrollingFrame

    return section, scrollingFrame
end

function UI:CreateButton(parent, text, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, 40)
    button.Text = text
    button.TextSize = 18
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    button.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0.1, 0)
    corner.Parent = button

    button.MouseButton1Click:Connect(function()
        if callback then
            callback()
        end
    end)

    return button
end

function UI:CreateToggle(parent, text, initialState, callback)
    local toggle = Instance.new("Frame")
    toggle.Size = UDim2.new(1, 0, 0, 40)
    toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    toggle.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0.1, 0)
    corner.Parent = toggle

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -40, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.Text = text
    label.TextSize = 16
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.BackgroundTransparency = 1
    label.Parent = toggle

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0.1, 0)
    corner.Parent = label

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 30, 0, 30)
    button.Position = UDim2.new(1, -40, 0, 5)
    button.Text = ""
    button.BackgroundColor3 = initialState and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
    button.Parent = toggle

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0.5, 0)
    corner.Parent = button

    button.MouseButton1Click:Connect(function()
        initialState = not initialState
        button.BackgroundColor3 = initialState and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
        if callback then
            callback(initialState)
        end
    end)

    return toggle
end

function UI:CreateSlider(parent, min, max, initialValue, callback)
    local slider = Instance.new("Frame")
    slider.Size = UDim2.new(1, 0, 0, 40)
    slider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    slider.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0.1, 0)
    corner.Parent = slider

    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(1, 0, 0, 10)
    bar.Position = UDim2.new(0, 0, 0.5, -5)
    bar.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    bar.Parent = slider

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0.1, 0)
    corner.Parent = bar

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 20, 0, 20)
    knob.Position = UDim2.new(0, (initialValue - min) / (max - min) * bar.AbsoluteSize.X, 0.5, -10)
    knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    knob.Parent = bar

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0.5, 0)
    corner.Parent = knob

    local valueLabel = Instance.new("TextLabel")
    valueLabel.Size = UDim2.new(1, 0, 0, 20)
    valueLabel.Position = UDim2.new(0, 0, 0, 10)
    valueLabel.Text = tostring(initialValue)
    valueLabel.TextSize = 16
    valueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Parent = slider

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0.1, 0)
    corner.Parent = valueLabel

    local dragging = false

    local function updateValueFromKnobPosition()
        local barWidth = bar.AbsoluteSize.X
        local knobPositionX = knob.AbsolutePosition.X - bar.AbsolutePosition.X
        if barWidth == 0 then return end
        local value = math.clamp(min + (knobPositionX / barWidth) * (max - min), min, max)
        valueLabel.Text = tostring(math.floor(value))
        if callback then
            callback(math.floor(value))
        end
    end

    knob.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local barWidth = bar.AbsoluteSize.X
            if barWidth <= 0 then return end
            local mouseX = input.Position.X
            local barPositionX = bar.AbsolutePosition.X
            local newPosX = math.clamp(mouseX - barPositionX, 0, barWidth - knob.Size.X.Offset)
            knob.Position = UDim2.new(0, newPosX, 0.5, -10)
            updateValueFromKnobPosition()
        end
    end)

    game:GetService("UserInputService").InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    return slider
end

return UI
