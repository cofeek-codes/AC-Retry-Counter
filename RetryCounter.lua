local clearLapTry = 1
local prevLapCount = ac.getCar(0).lapCount

function script.windowMain(dt)
 ui.text('clear lap try: ' .. clearLapTry)
 ui.text('clear laps completed: ' .. ac.getCar(0).lapCount)
 -- width: 150
 -- height: 100
end

function script.update(dt)
    local currentLapCount = ac.getCar(0).lapCount
    
    if currentLapCount > prevLapCount then
        clearLapTry = 1
        prevLapCount = currentLapCount
    end
end

ac.onConsoleInput(function(msg)
  if msg == 'rhelp' then
    ac.console('**help message from RetryCounter**')
  end
end)

ac.onCarJumped(0, function(carIndex)
  ac.console('**YOU PRESSED RETRY**')
  clearLapTry = clearLapTry + 1
end)
