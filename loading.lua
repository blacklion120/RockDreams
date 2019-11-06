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
local tips 

-- 'onRelease' event listener for playBtn
local function nextscene()
		-- go to characterselection scene
		composer.gotoScene( "selectionpage", "fade", 1000 )
	
end

local backgroundMusic = audio.loadStream("punk.mp3")


function scene:create( event )
	local sceneGroup = self.view

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	-- display a background image
	local background = display.newImageRect( "loading.jpg", display.actualContentWidth ,display.actualContentHeight , true)
	background.anchorX = 0
	background.anchorY = 0
	background.x = 0 + display.screenOriginX 
	background.y =   display.screenOriginY 
	background.isVisible = true

	function playmusic( )
		audio.play(backgroundMusic, { channel=15, loops=-1})
		audio.setVolume( 1, { channel=15 } )
	end

	tips = display.newImageRect("tips.png", 400, 130)
	tips.x, tips.y =  screenW * 0.4, screenH * 0.6
	tips.alpha = 0

	logo = display.newImageRect("logo.png", 120, 110)
	logo.x, logo.y =  screenW * 0.4, screenH * 0.2
	logo.alpha = 0

	local votesprite = graphics.newImageSheet( "voteanime.png", { width = 200, height = 202, numFrames = 4} )

		local votesequence =

{

				{ name="voting", sheet=votesprite, start=1, count=3,time = 2200, loopcount = 0 },


}




		vote = display.newSprite(votesprite, votesequence)
		vote.x = screenW * 0.83
		vote.y = screenH * 0.82
		vote.xScale = 0.5
		vote.yScale = 0.5
		vote:setSequence("voting")
		vote:play()







	function tipsstart( )
		transition.fadeIn( tips, {time = 1300} )
		transition.fadeIn( logo, {time = 1300} )
	end

	timer.performWithDelay(1500, tipsstart, 1)

	timer.performWithDelay(11000, nextscene, 1)



	--timer.performWithDelay(600, playmusic, 1)













	-- all display objects must be inserted into group
	sceneGroup:insert( background)
	sceneGroup:insert( tips)
	sceneGroup:insert( vote)
	sceneGroup:insert( logo)


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
		composer.removeScene("loading")
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