-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- include Corona's "widget" library
local widget = require "widget"
local screenW, screenH, halfW = display.actualContentWidth, display.actualContentHeight, display.contentCenterX

--------------------------------------------

-- forward declarations and other locals

local credits 
local backgroundMusic = audio.loadStream("rock.mp3")
local selectfx = audio.loadSound("sel.mp3")


-- 'onRelease' event listener for playBtn
local function goback(event)
	if event.phase == "began" then
		-- go to loading scene
		audio.play(selectfx)
		composer.gotoScene( "stagename", "slideLeft", 1000 )
	end
	
end



function scene:create( event )
	local sceneGroup = self.view

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	-- display a background image
	local background = display.newImageRect( "howtop.jpg", display.actualContentWidth ,display.actualContentHeight , true)
	background.anchorX = 0
	background.anchorY = 0
	background.x = 0 + display.screenOriginX 
	background.y =   display.screenOriginY 
	background.isVisible = true

	function playmusic( )
		audio.play(backgroundMusic, { channel=15, loops=-1})
		audio.setVolume( 1, { channel=15 } )
	end


	homebtn = display.newImageRect("home.png", 100, 60)
	homebtn.x, homebtn.y =  screenW * 0.1 - 40, screenH * 0.8
	homebtn.alpha = 0


	function btnshow( )
		transition.fadeIn( homebtn, {time = 1300} )
		homebtn:addEventListener("touch", goback)
	end

	timer.performWithDelay(1500, btnshow, 1)



	timer.performWithDelay(600, playmusic, 1)













	-- all display objects must be inserted into group
	sceneGroup:insert( background)
	sceneGroup:insert( homebtn)



end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		composer.removeScene("howtoplay")
		-- Called when the scene is now off screen
	end	
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	
	if playBtn then
		playBtn:removeSelf()	-- widgets must be manually removed
		playBtn = nil
	end
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene