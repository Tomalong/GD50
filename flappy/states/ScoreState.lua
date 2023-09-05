--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}

local GOLD_TROPHY_IMAGE = love.graphics.newImage('gold.png')
local SILVER_TROPHY_IMAGE = love.graphics.newImage('silver.png')
local BRONZE_TROPHY_IMAGE = love.graphics.newImage('bronze.png')

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()

    DrawTrophy(self.score)

    -- simply render the score to the middle of the screen    
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oof! You lost!', 0, 160, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 200, VIRTUAL_WIDTH, 'center')

    love.graphics.printf('Press Enter to Play Again!', 0, 230, VIRTUAL_WIDTH, 'center')
end

function DrawTrophy(score)

    love.graphics.setFont(flappyFont)
    local color = ''

    if score > 9 then
        color = 'gold'
        image = GOLD_TROPHY_IMAGE
    elseif score > 4 then
        color = 'silver'
        image = SILVER_TROPHY_IMAGE
    elseif score > 2 then
        color = 'bronze'
        image = BRONZE_TROPHY_IMAGE
    end

    if color ~= '' then 
        love.graphics.printf('You won ' .. color ..'!', 0, 50, VIRTUAL_WIDTH, 'center')
        love.graphics.draw(
            image, 
            (VIRTUAL_WIDTH / 2 - (BRONZE_TROPHY_IMAGE:getWidth() / 4) + 10), 
            100,
            0,
            .25, 
            25
        )
    end

end