local function valid(pin_sum)
    -- A sum of pins is only valid if between 0 and 10 pins
    -- are downed.  You can never down negative pins (obv.)
    -- and each frame has a maximum of 10 pins
    return 0 <= pin_sum and pin_sum <= 10
end

local function frame(first_ball)
    assert(valid(first_ball))
    if first_ball == 10 then
        -- There are two fill balls required after a strike
        local fill_first = coroutine.yield()
        local fill_second = coroutine.yield()

        -- After getting a strike you can only get two strikes, a spare,
        -- or a non-strike non-spare
        if fill_first < 10 then
            assert(fill_first + fill_second <= 10)
        end

        -- And your total is the sum of the strike and two fill balls
        coroutine.yield(first_ball + fill_first + fill_second)
    else
        local second_ball = coroutine.yield()
        assert(valid(first_ball + second_ball))

        -- If you got a spare then the total is the sum of the spare and
        -- a fill ball.  Otherwise the total is the sum of both balls
        if first_ball + second_ball == 10 then
            coroutine.yield(first_ball + second_ball + coroutine.yield())
        else
            coroutine.yield(first_ball + second_ball)
        end
    end
end

local function frame_generator(pins)
    -- There are up to 10 frames.  If you get a strike
    -- in any one frame then you move immediately to the
    -- next frame.  Otherwise each frame needs two balls.
    for i = 2, 10 do
        if pins == 10 then
            pins = coroutine.yield(true)
        else
            coroutine.yield()
            pins = coroutine.yield(true)
        end
    end
end

local BowlingScorer = {}

function BowlingScorer:new()
    local new_scorer = {
        continuations = {coroutine.create(frame)},
        total_score = 0,
        frame_gen = coroutine.create(frame_generator)
    }

    setmetatable(new_scorer, self)
    self.__index = self
    return new_scorer
end

function BowlingScorer:game_over()
    -- The game is over when all 10 frames have been played and
    -- there are no more frames which require fill balls
    return coroutine.status(self.frame_gen) == "dead" and #self.continuations == 0
end

function BowlingScorer:roll(pins)
    assert(not self:game_over())

    -- For each frame that requires continuation to its score, add the 
    -- current ball to the score
    for i = 1, #self.continuations do
        continuation = table.remove(self.continuations, 1)
        no_error, value = coroutine.resume(continuation, pins)
        assert(no_error)

        -- If the frame no longer requires continuation (the score is "locked")
        -- then add it to the game's total score, otherwise push it back to
        -- the end of the continuation list
        if value then
            self.total_score = self.total_score + value
        else
            table.insert(self.continuations, #self.continuations + 1, continuation)
        end
    end

    -- Generate the next frame if required
    if coroutine.status(self.frame_gen) ~= "dead" then
        _, create_frame = coroutine.resume(self.frame_gen, pins)
        if create_frame then
            table.insert(self.continuations, #self.continuations + 1, coroutine.create(frame))
        end
    end
end

function BowlingScorer:score()
    assert(self:game_over())
    return self.total_score
end

return function()
    local bowling_scorer = BowlingScorer:new()
    return {
        roll = function(pins) bowling_scorer:roll(pins) end,
        score = function() return bowling_scorer:score() end
    }
end
