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
local playBtn

-- 'onRelease' event listener for playBtn
local function nxtscript()
	
	-- go to level1.lua scene
	composer.gotoScene( "stagename", "zoomOutIn", 500 )
	
	
end

function scene:create( event )
	local sceneGroup = self.view

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	-- display a background image
	local background2 = display.newImageRect( "bg.jpg", display.actualContentWidth ,display.actualContentHeight , true)
	background2.anchorX = 0
	background2.anchorY = 0
	background2.x = 0 + display.screenOriginX 
	background2.y =   display.screenOriginY 
	background2.isVisible = true

	local background3 = display.newImageRect( "bg.jpg", display.actualContentWidth ,display.actualContentHeight , true)
	background3.anchorX = 0
	background3.anchorY = 0
	background3.x = 0 + display.screenOriginX 
	background3.y =   display.screenOriginY 
	background3.isVisible = false
	
		local blacace = display.newImageRect("BlackAce.png", 200, 200)
		blacace.x, blacace.y =  screenW * 0.4, screenH * 0.5
		blacace.alpha = 0

		local ics = display.newImageRect("ics.png", 200, 200)
		ics.x, ics.y =  screenW * 0.4, screenH * 0.5
		ics.alpha = 0
	
		local playimage = display.newImageRect("Playfactor.png", 200, 200)
		playimage.x, playimage.y =  screenW * 0.4, screenH * 0.5
		playimage.alpha = 0


		function playout( )
			transition.fadeOut( playimage, {time = 800} )
			timer.performWithDelay(1500, nxtscript, 1)
		end

		function playshow( )
			transition.fadeIn( playimage, {time = 2500} )
			timer.performWithDelay(3700, playout, 1)
		end

		function icsfadeout( )
			transition.fadeOut( ics, {time = 800} )
			timer.performWithDelay(1300, playshow, 1)
		end

		function icsshows( )
			transition.fadeIn( ics, {time = 2500} )
			timer.performWithDelay(3700, icsfadeout, 1)
		end



		function loadace2( )
			transition.fadeOut( blacace, {time = 800} )
			
			timer.performWithDelay(1200, icsshows, 1)
		end


		function loadace( )
			transition.fadeIn( blacace, {time = 2500} )
			timer.performWithDelay(3500, loadace2, 1)
		end




		timer.performWithDelay(1000, loadace, 1)


	-- all display objects must be inserted into group
	sceneGroup:insert( background3)
	sceneGroup:insert( background2)
	sceneGroup:insert( blacace)
	sceneGroup:insert( ics)

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
		composer.removeScene("icons")
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