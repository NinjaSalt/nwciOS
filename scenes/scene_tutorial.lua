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
  local tapHand
  
  local options = {
   effect = "fade",
   time = 500
}
  local bkg = display.newRect( centerX, centerY, display.contentWidth, display.contentHeight )
  bkg:setFillColor( gray )
  bkg.alpha = .01
  group:insert (bkg)
  
  bkg:addEventListener("touch", function() return true end)
  bkg:addEventListener("tap", function() return true end)
  local swipe = display.newRect( globals.belts[2].x+20, globals.belts[2].y, 360, 60)
  swipe.alpha = .01
  group:insert (swipe)
  
  local border = display.newRect( display.contentWidth/2, 20, 25, 50)
  border:setFillColor(black)
  group:insert (border)
  
  local back = display.newRect( display.contentWidth/2, 20, 25, 50)
  group:insert (back)
  
  local toDo = display.newText( "Swipe the bottom lane left!", display.contentWidth/2, 30, globals.IMPRIMA, 36 )
  toDo:setFillColor(black)
  group:insert (toDo)
  
  border.x=toDo.x
  border.y=toDo.y
  border.width=toDo.width+10
  border.height=toDo.height+10
  
  back.x=toDo.x
  back.y=toDo.y
  back.width=toDo.width
  back.height=toDo.height

  local function swipeLeft1 ()
    --creates the hand image
    tapHand = display.newImage("images/hand.png", 400, swipe.y+10)
    tapHand.width = 40
    tapHand.height = 40
    group:insert(tapHand)
  end

  local function swipeLeft2 ()
    if (tapHand ~= nil) then
      transition.to( tapHand, { time=1000, x = swipe.x-100, onComplete=
        function() 
          transition.to( tapHand, { time=300, alpha = 0, onComplete=
            function() 
              tapHand:removeSelf( )
              tapHand = nil
              swipeLeft1 ()
            end, 
            tag="animation" } ) 
        end,
        tag="animation" } )
    end
  end

  local function onTapBack( event )
	local phase = event.phase
	if "ended" == phase or "cancelled" == phase then
		if(event.x - event.xStart ~= 0 and event.x - event.xStart < -7)then
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
			hero[2].laneSpeed = 1
			updateMoveSpeed(hero[2])
			globals.levers[hero[2].num]:setSequence( "fast" )
			globals.levers[hero[2].num]:play()
      if (tapHand ~= nil) then
        tapHand:removeSelf( )
        tapHand = nil
      end
			transition.resume()
		end
	end
  end
  
  swipe:addEventListener( "touch", onTapBack )
  swipeLeft1 ()
    if (tapHand ~= nil) then
      timer.performWithDelay(2000, swipeLeft2, 0 )
    end

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
  timer.performWithDelay(1700, tutorialCombo )
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