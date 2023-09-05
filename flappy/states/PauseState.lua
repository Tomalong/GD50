PauseState = Class{__includes = BaseState}

function PauseState:enter(params)
    self.pipePairs = params.pipePairs
    self.bird = params.bird
    self.score = params.score
end

function PauseState:init()
    sounds['music']:pause()
    sounds['pause']:play()
    
end

function PauseState:update()
    if love.keyboard.wasPressed('p') then
        sounds['music']:play()
        gStateMachine:change('play', {
            pipePairs = self.pipePairs,
            bird = self.bird,
            score = self.score
        })
    end
end

function PauseState:render()
    for k, pair in pairs(self.pipePairs) do
        pair:render()
    end
    self.bird:render()
    -- render count big in the middle of the screen
    love.graphics.setFont(hugeFont)
    love.graphics.printf("Paused", 0, 120, VIRTUAL_WIDTH, 'center')
end