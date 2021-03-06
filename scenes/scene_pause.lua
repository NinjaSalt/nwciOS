---------------------------------------------------------------------------------
-- PAUSE SCENE
-- Scene notes go here

---------------------------------------------------------------------------------
 
local storyboard = require( "storyboard" )
local globals = require("classes.globals")
local scene = storyboard.newScene()
 
-- Clear previous scene
storyboard.removeAll()
 
-- local forward references should go here --
 
---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
 
-- Called when the scene's view does not exist:
function scene:createScene( event )
  local group = self.view
  
  local options = {
   effect = "fade",
   time = 500
}
  local bkg = display.newRect( centerX, centerY, display.contentWidth, display.contentHeight )
  bkg:setFillColor( gray )
  bkg.alpha = .5
  group:insert (bkg)
  
  bkg:addEventListener("touch", function() return true end)
  bkg:addEventListener("tap", function() return true end)

  local menuBack = display.newImage("images/pauseBack.png", 150, 150, true)
  menuBack.width = 250
  menuBack.height = 150
  menuBack.x = display.contentWidth/2
  menuBack.y = display.contentHeight/2
  group:insert (menuBack)

  -- title
  local pauseTitle = display.newText( "Paused!", display.contentWidth/2, display.contentHeight/2 -35 , globals.LOBSTERTWO, 35 )
  pauseTitle:setFillColor( black )
  group:insert(pauseTitle)

  -- y button location
  local buttonY = display.contentHeight/2 + 20
  
  local replayButton= display.newImage( "images/buttonReplay.png", 150,150, true )
  replayButton.width = 50
  replayButton.height = 50
  replayButton.x = display.contentWidth/2 - 60
  replayButton.y = buttonY
  group:insert( replayButton)
  
  local function onTapReplay( event )
    storyboard.removeScene( scene )
	   if (antagonistTimer ~= nil) then
        timer.pause(antagonistTimer)
      end
	 replayLevel()
  end
  
  replayButton:addEventListener( "tap", onTapReplay )
  
  local worldButton = display.newImage("images/buttonMenu.png", 150, 150, true)
  worldButton.width = 50
  worldButton.height = 50
  worldButton.x = display.contentWidth/2
  worldButton.y = buttonY
  group:insert (worldButton)
  
  local function onTapWorld( event )
    storyboard.removeScene( scene )
    storyboard.gotoScene( "scenes.scene_worldmap",options)
    if ( antagonistTimer ~= nil) then
	timer.cancel(antagonistTimer)
end
  end
  
  worldButton:addEventListener( "tap", onTapWorld )

  
  local backButton = display.newImage( "images/buttonBack.png", 150, 150, true )
  backButton.width = 50
  backButton.height = 50
  backButton.x = display.contentWidth/2 + 60 
  backButton.y = buttonY
  group:insert (backButton)

  local function onTapBack( event )
    storyboard.hideOverlay( "slideUp", 500 )
    storyboard.showOverlay("scenes.scene_hud", {effect = "fade", time = 500})
    --timer.resume(attackTimer)
    timer.resume(spawnEneTimer)
  if (globals.breakfastButton~=nil) then
    globals.breakfastButton:play()
  end
    if (globals.dinnerButton~=nil) then
    globals.dinnerButton:play()
  end
    if (globals.dessertButton~=nil) then
    globals.dessertButton:play()
  end
    globals.breakfastanimation:play()
    globals.dinneranimation:play()
  globals.dessertanimation:play()
    if ( antagonistTimer ~= nil) then
	     timer.resume(antagonistTimer)
    end
    for n=0, 2, 1 do
      globals.belts[n]:play()
    end
    transition.resume()
  end
  
  backButton:addEventListener( "tap", onTapBack )

  --startButton:addEventListener( "tap", onTap )
end
 
-- Called BEFORE scene has moved onscreen:
function scene:willEnterScene( event )
  local group = self.view
 
end
 
-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
  local group = self.view
 
end
 
-- Called when scene is about to move offscreen:
function scene:exitScene( event )
  local group = self.view
 
end
 
-- Called AFTER scene has finished moving offscreen:
function scene:didExitScene( event )
  local group = self.view
 
end
 
-- Called prior to the removal of scene's "view" (display view)
function scene:destroyScene( event )
  local group = self.view
 
end
 
-- Called if/when overlay scene is displayed via storyboard.showOverlay()
function scene:overlayBegan( event )
  local group = self.view
  local overlay_name = event.sceneName  -- name of the overlay scene
 
end
 
-- Called if/when overlay scene is hidden/removed via storyboard.hideOverlay()
function scene:overlayEnded( event )
  local group = self.view
  local overlay_name = event.sceneName  -- name of the overlay scene
 
end
 
---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
 
-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )
 
-- "willEnterScene" event is dispatched before scene transition begins
scene:addEventListener( "willEnterScene", scene )
 
-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )
 
-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )
 
-- "didExitScene" event is dispatched after scene has finished transitioning out
scene:addEventListener( "didExitScene", scene )
 
-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )
 
-- "overlayBegan" event is dispatched when an overlay scene is shown
scene:addEventListener( "overlayBegan", scene )
 
-- "overlayEnded" event is dispatched when an overlay scene is hidden/removed
scene:addEventListener( "overlayEnded", scene )
 
---------------------------------------------------------------------------------
 
return scene