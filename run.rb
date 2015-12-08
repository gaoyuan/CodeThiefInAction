
loadTestDB

module H1_Menu_nav

  def self.startTest(loopTime)

    tcase = TestCase.new("startTest")

    tcase.run(loopTime)

  end

  def self.mainLoop(loopTime)

    WebSocketXServer.setAutoUpdate(false)

    index = $mainResumeMainLoop
    $mainResumeMainLoop = 0

    writelog("mainLoop::#{index}::Resume") if index > 0

    while index < loopTime

      $curMainLoopNum = index

      $actionParamInput = "none"
      Menu_nav 1

      waitsecond(2)


      sendStatus("Done::mainLoop::Loop::#{index}")


      writelog("Finish::Loop::#{$curMainLoopNum}")


      saveLogFileToGist if $saveLogToGist

      index += 1

    end

    $engineStatus = "Idle"
    resetStatus
    sendStatus("Finish::mainLoop::END")

  end

  def self.Menu_nav(loopTime)

    tcase = TestCase.new("Menu_nav")

    tcase << TestAction.new(:scriptAction_7) do
      $appCounter = 0;
    end

    tcase << TestAction.new(:scriptAction_2) do
      
      until $appCounter > 2
      	$appCounter += 1
      	gotoApp(db('AppName')[$appCounter-1])
          waitsecond(2)
        	pressHome
      end
    end

    tcase.run(loopTime)

  end

  def self.exception_handler
    puts "Module Exception Hanlder..."
  end

  def self.run(loop)
      mainLoop loop
  end

end

$exceptionPackageNameList = []
$exceptionPackageNameList_exclude = []

def exception_handler
  H1_Menu_nav.exception_handler
end

$curProjectLogFile = $useLastLogFile

$curProjectLogFile = "H1_Menu_nav_#{getTimeStamp}.log" if $useLastLogFile.nil?

$useLastLogFile = nil



