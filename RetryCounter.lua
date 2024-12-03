local clearLapTry = 1
local prevLapCount = ac.getCar(0).lapCount
local isRetryOnCollision = false
local triesOnPrevLap = 0


function script.windowMain(dt)
 ui.text('clear lap try: ' .. clearLapTry)
 ui.text('clear laps completed: ' .. ac.getCar(0).lapCount)
 ui.text('tries on last clear lap: ' .. triesOnPrevLap)

 retryOnCollisionCheckbox = ui.checkbox('Retry on collision', isRetryOnCollision)
end

function script.update(dt)
    local currentLapCount = ac.getCar(0).lapCount
    -- lap counter
    if currentLapCount > prevLapCount then
      -- clear lap happened
      triesOnPrevLap = clearLapTry
        clearLapTry = 1
        prevLapCount = currentLapCount
    end
    -- collisionDetection
    if ac.getCar().collidedWith ~= -1 then
           if isRetryOnCollision then
              physics.teleportCarTo(ac.SpawnSet.Pits) -- on collision car gets respawned in pits
           end
    end
    if retryOnCollisionCheckbox then
       isRetryOnCollision = not isRetryOnCollision
    end

end

ac.onConsoleInput(function(msg)
  if msg == 'rchelp' then
    ac.console('**help message from RetryCounter**')
  end
  if msg == 'tp' then
     physics.teleportCarTo(ac.SpawnSet.Pits)
  end
end)

ac.onCarJumped(0, function(carIndex)
  ac.console('**YOU PRESSED RETRY**')
  clearLapTry = clearLapTry + 1
end)
