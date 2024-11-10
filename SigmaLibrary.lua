local UI = {}

function UI:CreateButton(parent, position, size, text, callback)
    local button = Instance.new("TextButton")
    button.Size = size
    button.Position = position
    button.Text = text
    button.TextSize = 18
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    button.Parent = parent

    button.MouseButton1Click:Connect(function()
        if callback then
            callback()
        end
    end)

    return button
end

function UI:CreateToggle(parent, position, size, text, initialState, callback)
    local toggle = Instance.new("Frame")
    toggle.Size = size
    toggle.Position = position
    toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    toggle.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -30, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.Text = text
    label.TextSize = 16
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.BackgroundTransparency = 1
    label.Parent = toggle

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 30, 0, 30)
    button.Position = UDim2.new(1, -40, 0, 5)
    button.Text = ""
    button.BackgroundColor3 = initialState and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
    button.Parent = toggle

    button.MouseButton1Click:Connect(function()
        initialState = not initialState
        button.BackgroundColor3 = initialState and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
        if callback then
            callback(initialState)
        end
    end)

    return toggle
end

function UI:CreateSlider(parent, position, size, min, max, initialValue, callback)
    local slider = Instance.new("Frame")
    slider.Size = size
    slider.Position = position
    slider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    slider.Parent = parent

    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(1, 0, 0, 10)
    bar.Position = UDim2.new(0, 0, 0.5, -5)
    bar.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    bar.Parent = slider

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 20, 0, 20)
    knob.Position = UDim2.new(0, (initialValue - min) / (max - min) * bar.Size.X.Offset, 0.5, -10)
    knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    knob.Parent = bar

    local valueLabel = Instance.new("TextLabel")
    valueLabel.Size = UDim2.new(1, 0, 0, 20)
    valueLabel.Position = UDim2.new(0, 0, 0, 10)
    valueLabel.Text = tostring(initialValue)
    valueLabel.TextSize = 16
    valueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Parent = slider

    local dragging = false

    local function updateValueFromKnobPosition()
        local knobPositionX = knob.Position.X.Offset
        local barWidth = bar.Size.X.Offset
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
            local mouseX = input.Position.X
            local barPositionX = bar.AbsolutePosition.X
            local newPosX = math.clamp(mouseX - barPositionX, 0, bar.Size.X.Offset)

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
