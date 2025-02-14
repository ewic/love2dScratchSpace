local initValues = require "init"

local position = initValues.position
local height = initValues.height
local xVelocity = initValues.xVelocity
local yVelocity = initValues.yVelocity

local startHeight = initValues.startHeight
local groundHeight = initValues.groundHeight

local maxVelocity = initValues.maxVelocity
local terminalVelocity = initValues.terminalVelocity

local accel = initValues.accel
local gravity = initValues.gravity
local friction = initValues.friction
local initJumpVelocity = initValues.initJumpVelocity

local upButton = initValues.upButton
local downButton = initValues.downButton
local leftButton = initValues.leftButton
local rightButton = initValues.rightButton
local jumpButton = initValues.jumpButton

function love.load()


end

function love.update(dt)

    if love.keyboard.isDown(rightButton) then
        if math.abs(xVelocity) < maxVelocity then 
            xVelocity = xVelocity + accel * dt;
        end
    elseif love.keyboard.isDown(leftButton) then
        if math.abs(xVelocity) < maxVelocity then
            xVelocity = xVelocity - accel * dt
        end
    end

    if love.keyboard.isDown(jumpButton) and yVelocity == 0 then
        yVelocity = -initJumpVelocity
    end

    if xVelocity ~= 0 and not love.keyboard.isDown(rightButton) and not love.keyboard.isDown(leftButton) then
        if math.abs(xVelocity) < 10 then
            xVelocity = 0;
        else
            xVelocity = xVelocity / (1 + friction * dt)
        end
    end 

    
    if love.keyboard.isDown(upButton) then
        height = height-100*dt
    elseif love.keyboard.isDown(downButton) then
        height = height+100*dt
    end
    
    -- Movement
    position = position + xVelocity * dt
    height = height + yVelocity * dt

    -- Gravity


    if height > groundHeight then
        height = groundHeight
    end

    -- if height > groundHeight then
    --     if yVelocity > terminalVelocity then
    --         yVelocity = yVelocity - gravity * dt
    --     end
    -- end
    if yVelocity < terminalVelocity and height ~= groundHeight then
        yVelocity = yVelocity + gravity * dt
    end

    if height == groundHeight then
        yVelocity = 0
    end

end

function love.draw()
    love.graphics.rectangle("line", position, height, 20, 40)    

    love.graphics.print("xVelocity:", 0, 0)
    love.graphics.print(xVelocity, 0, 15)

    love.graphics.print("yVelocity:", 0, 30)
    love.graphics.print(yVelocity, 0, 45)

end
