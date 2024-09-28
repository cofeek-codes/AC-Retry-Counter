local clearLapTry = 1
local prevLapCount = ac.getCar(0).lapCount

function script.windowMain(dt)
 ui.text('clear lap try: ' .. clearLapTry)
 ui.text('clear laps completed: ' .. ac.getCar(0).lapCount)
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
       -- @TODO: add optional `restart on cars collision`
       ac.log('collision happened')
       -- physics.teleportCarTo(ac.SpawnSet.Pits)
    end
end

ac.onConsoleInput(function(msg)
  if msg == 'rhelp' then
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
