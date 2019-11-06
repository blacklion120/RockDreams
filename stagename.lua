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
local campaign
local howto 
local credits 
local backgroundMusic = audio.loadStream("rock.mp3")
local selectfx = audio.loadSound("sel.mp3")


-- 'onRelease' event listener for playBtn
local function gamescript(event)
	if event.phase == "began" then
		-- go to loading scene
		audio.play(selectfx)
		composer.gotoScene( "selectionpage", "fade", 500 )
	end
	
end
local function gamescript2(event)
	if event.phase == "began" then
		-- go to loading scene
		audio.play(selectfx)
		composer.gotoScene( "howtoplay", "slideLeft", 1000 )
	end
	
end
local function gamescript3(event)
	if event.phase == "began" then
		-- go to loading scene
		audio.play(selectfx)
		composer.gotoScene( "creditpage", "slideRight", 1000 )
	end
	
end

function scene:create( event )
	local sceneGroup = self.view

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	-- display a background image
	local background = display.newImageRect( "rock2.png", display.actualContentWidth ,display.actualContentHeight , true)
	background.anchorX = 0
	background.anchorY = 0
	background.x = 0 + display.screenOriginX 
	background.y =   display.screenOriginY 
	background.isVisible = true

	function playmusic( )
		audio.play(backgroundMusic, { channel=15, loops=-1})
		audio.setVolume( 1, { channel=15 } )
	end




	campaign = display.newImageRect("letsplay.png", 130, 80)
	campaign.x, campaign.y =  screenW * 0.79, screenH * 0.8
	campaign.alpha = 0

	howto = display.newImageRect("howto.png", 130, 40)
	howto.x, howto.y =  screenW * 0.79, screenH * 0.35
	howto.alpha = 0

	credits = display.newImageRect("credit.png", 130, 40)
	credits.x, credits.y =  screenW * 0.79, screenH * 0.55
	credits.alpha = 0

	function campaignstart( )
		transition.fadeIn( campaign, {time = 1300} )
		transition.fadeIn( howto, {time = 1300} )
		transition.fadeIn( credits, {time = 1300} )
		campaign:addEventListener("touch", gamescript)
		howto:addEventListener("touch", gamescript2)
		credits:addEventListener("touch", gamescript3)
	end

	timer.performWithDelay(1500, campaignstart, 1)




	timer.performWithDelay(600, playmusic, 1)













	-- all display objects must be inserted into group
	sceneGroup:insert( background)
	sceneGroup:insert( campaign)
	sceneGroup:insert( howto)
	sceneGroup:insert( credits)


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
		composer.removeScene("stagename")
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