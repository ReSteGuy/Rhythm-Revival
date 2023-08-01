-- Libraries
local tween = require "lib.tween"
local lovebpm = require "lib.lovebpm"
-- Icon
local icon = "icon.png"
local iconData = love.image.newImageData(icon)
-- Graphics
local logo = love.graphics.newImage("/graphics/logo.png")
local button1 = love.graphics.newImage("/graphics/button1.png")
local button2 = love.graphics.newImage("/graphics/button2.png")
local button3 = love.graphics.newImage("/graphics/button3.png")
local button4 = love.graphics.newImage("/graphics/button4.png")
local buttonSelection = love.graphics.newImage("/graphics/selectMainMenu.png")
local menuBG = love.graphics.newImage("/graphics/menubg.png")
-- Music/Sfx
local music = lovebpm.newTrack()
local selectaudio = love.audio.newSource("/sfx/moveselection.ogg", "static")
local selectedaudio = love.audio.newSource("/sfx/selectselection.ogg", "static")
-- Selection Values
local selectedMenu = 1
local selectionSize = 1
local currMenuState = "main"
-- Position/Object Values
local bgMovementPos = 0
local logoSize = 1
-- Tweens
local buttonXValue = {x=1480}
local buttontween = tween.new(1, buttonXValue, {x=1056}, "outBounce") 
local logoYValue = {y=720}
local logotween = tween.new(1, logoYValue, {y=0}, "outCirc") 
local selectYValue = 64

function love.load()
    love.window.setIcon(iconData)
    love.window.setTitle("Project: Rhythm Revival")
    love.window.setMode(1280, 720)
    music:load("/music/Main Menu.ogg")
    music:setBPM(130)
    music:setLooping(true)
    music:on("beat", function(n) logoSize = 1.2 end)
    music:play()
end

function love.update(dt)
    music:update()
    buttontween:update(dt)
    logotween:update(dt)
    if selectedMenu == 5 then
        selectedMenu = 1
    end
    if selectedMenu == 0 then
        selectedMenu = 4
    end
    if selectedMenu == 1 then
        selectYValue = 64
    end
    if selectedMenu == 2 then
        selectYValue = 208
    end
    if selectedMenu == 3 then
        selectYValue = 352
    end
    if selectedMenu == 4 then
        selectYValue = 496
    end
    if selectionSize > 1 then
        selectionSize = selectionSize - 0.025
    end
    if logoSize > 1 then
        logoSize = logoSize - 0.005
    end
    if bgMovementPos < 128 then
        bgMovementPos = bgMovementPos + 1
    end
    if bgMovementPos == 128 then
        bgMovementPos = 0
    end
end

function love.draw()
    love.graphics.draw(menuBG, -128+bgMovementPos, -128+bgMovementPos)
    love.graphics.draw(logo, -200-((1280*logoSize-1280)/2), logoYValue.y-((720*logoSize-720)/2), 0, logoSize, logoSize)
    love.graphics.draw(button1, buttonXValue.x, 64)
    love.graphics.draw(button2, buttonXValue.x, 208)
    love.graphics.draw(button3, buttonXValue.x, 352)
    love.graphics.draw(button4, buttonXValue.x, 496)
    love.graphics.draw(buttonSelection, buttonXValue.x-((128*selectionSize-128)/2), selectYValue-((128*selectionSize-128)/2), 0, selectionSize, selectionSize)
end

function love.keypressed(key, scancode, isrepeat)
    if key == "w" and scancode == "w" then
        selectedMenu = selectedMenu - 1
        selectionSize = 1.2
        selectaudio:stop()
        selectaudio:play()
    end
    if key == "s" and scancode == "s" then
        selectedMenu = selectedMenu + 1
        selectionSize = 1.2
        selectaudio:stop()
        selectaudio:play()
    end
    if key == "z" and scancode == "z" then
        if selectedMenu == 1 then
            local byebye1tween = tween.new(1, buttonXValue, {x=1480}, "inBounce") 
            local byebye2tween = tween.new(1, logoYValue, {y=720}, "inCirc") 
            currMenuState = "levels"
            selectedaudio:stop()
            selectedaudio:play()
        end
        if selectedMenu == 2 then
            local byebye1tween = tween.new(1, buttonXValue, {x=1480}, "inBounce") 
            local byebye2tween = tween.new(1, logoYValue, {y=720}, "inCirc") 
            currMenuState = "practice"
            selectedaudio:stop()
            selectedaudio:play()
        end
        if selectedMenu == 3 then
            local byebye1tween = tween.new(1, buttonXValue, {x=1480}, "inBounce") 
            local byebye2tween = tween.new(1, logoYValue, {y=720}, "inCirc") 
            currMenuState = "options"
            selectedaudio:stop()
            selectedaudio:play()
        end
        if selectedMenu == 4 then
            love.event.quit()
        end
    end
end