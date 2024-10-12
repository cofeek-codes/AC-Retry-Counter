local clearLapTry = 1
local prevLapCount = ac.getCar(0).lapCount
local isRetryOnCollision = false

function script.windowMain(dt)
 ui.text('clear lap try: ' .. clearLapTry)
 ui.text('clear laps completed: ' .. ac.getCar(0).lapCount)
 retryOnCollisionCheckbox = ui.checkbox('Retry on collision', isRetryOnCollision)
 -- print(ac.getCar().collidedWith)
 -- print(physics.teleportCarTo(ac.SpawnSet.Pits))
end

function script.update(dt)
    local currentLapCount = ac.getCar(0).lapCount
    -- lap counter
    if currentLapCount > prevLapCount then
        clearLapTry = 1
        prevLapCount = currentLapCount
    end
    -- collisionDetection
    if ac.getCar().collidedWith ~= -1 then
       ac.log('collision happened')
           if isRetryOnCollision then
              physics.teleportCarTo(ac.SpawnSet.Pits) -- on collision car gets respawned in pits
           end
    end
    if retryOnCollisionCheckbox then
       isRetryOnCollision = not isRetryOnCollision
       ac.log('retry on colliison is enabled')
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
