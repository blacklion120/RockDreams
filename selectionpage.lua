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
local bull 
local bull2 
local abu 
local abu2 
local unic 
local unic2 
local duro 
local duro2 
local startgametab 
local homebtn 



local backgroundMusic = audio.loadStream("rock.mp3")
local selectfx = audio.loadSound("sel.mp3")
local selectfx2 = audio.loadSound("sword.mp3")
local buharifx = audio.loadSound("buharieffect.mp3")
local atikufx = audio.loadSound("ati.mp3")
local felafx = audio.loadSound("duro.mp3")
local unicefx = audio.loadSound("unn.mp3")
local unicefx2 = audio.loadSound("unn.mp3")
local buharifx2 = audio.loadSound("buharieffect2.mp3")
local backgroundchannel0 = 15
local backgroundloading 

-- 'onRelease' event listener for playBtn








local function nextscene()
	

		if bull.number == 1 then
			composer.gotoScene( "buhari", "fade", 500 )

		elseif bull.number == 2 then
			
			composer.gotoScene( "level1", "fade", 500 )
		
		elseif bull.number == 3 then
			
			composer.gotoScene( "eunice", "fade", 500 )
			
		elseif bull.number == 4 then
		
			composer.gotoScene( "fela", "fade", 500 )
		end
end





local function startgame(event)
	if event.phase == "began" then
			transition.moveTo(startgametab, {x = startgametab.x + 2,  time = 20, onComplete = function (  )
				transition.moveTo(startgametab, {x = startgametab.x - 2,   time = 20, onComplete = function ( )
							if bull.number == 1 then
			transition.fadeIn(backgroundloading, {time = 1000})
			transition.fadeIn( tips, {time = 1500} )
			transition.fadeIn( logo, {time = 1500} )
			transition.fadeIn( vote, {time = 1500} )
			timer.performWithDelay(9000, nextscene, 1)
				display.remove(homebtn)
				display.remove(homebtn)
				display.remove(abu)
				display.remove(duro)
				display.remove(bull2)
				display.remove(unic)
				display.remove(abutext)
				display.remove(durotext)
				display.remove(bulltext)
				display.remove(unictext)
				startgametab:removeEventListener("touch", startgame)
				bull:removeEventListener("touch", selbull)
				abu:removeEventListener("touch", selabu)
				unic:removeEventListener("touch", selunic)
				duro:removeEventListener("touch", selduro)
				display.remove(startgametab)



		elseif bull.number == 2 then
			transition.fadeIn(backgroundloading, {time = 1000})
			transition.fadeIn( tips, {time = 1500} )
			transition.fadeIn( logo, {time = 1500} )
			transition.fadeIn( vote, {time = 1500} )
			timer.performWithDelay(9000, nextscene, 1)
				display.remove(homebtn)
				display.remove(homebtn)
				display.remove(abu2)
				display.remove(duro)
				display.remove(bull)
				display.remove(unic)
				display.remove(abutext)
				display.remove(durotext)
				display.remove(bulltext)
				display.remove(unictext)
				startgametab:removeEventListener("touch", startgame)
				bull:removeEventListener("touch", selbull)
				abu:removeEventListener("touch", selabu)
				unic:removeEventListener("touch", selunic)
				duro:removeEventListener("touch", selduro)
				display.remove(startgametab)
	


		elseif bull.number == 3 then
			
			transition.fadeIn(backgroundloading, {time = 1000})
			transition.fadeIn( tips, {time = 1500} )
			transition.fadeIn( logo, {time = 1500} )
			transition.fadeIn( vote, {time = 1500} )
			timer.performWithDelay(9000, nextscene, 1)
				display.remove(homebtn)
				display.remove(homebtn)
				display.remove(abu)
				display.remove(duro)
				display.remove(bull)
				display.remove(unic2)
				display.remove(abutext)
				display.remove(durotext)
				display.remove(bulltext)
				display.remove(unictext)
				startgametab:removeEventListener("touch", startgame)
				bull:removeEventListener("touch", selbull)
				abu:removeEventListener("touch", selabu)
				unic:removeEventListener("touch", selunic)
				duro:removeEventListener("touch", selduro)
				display.remove(startgametab)
	

		elseif bull.number == 4 then
		
			transition.fadeIn(backgroundloading, {time = 1000})
			transition.fadeIn( tips, {time = 1500} )
			transition.fadeIn( logo, {time = 1500} )
			transition.fadeIn( vote, {time = 1500} )
			timer.performWithDelay(9000, nextscene, 1)
				display.remove(homebtn)
				display.remove(homebtn)
				display.remove(abu)
				display.remove(duro2)
				display.remove(bull)
				display.remove(unic)
				display.remove(abutext)
				display.remove(durotext)
				display.remove(bulltext)
				display.remove(unictext)
				startgametab:removeEventListener("touch", startgame)
				bull:removeEventListener("touch", selbull)
				abu:removeEventListener("touch", selabu)
				unic:removeEventListener("touch", selunic)
				duro:removeEventListener("touch", selduro)
				display.remove(startgametab)


		end
				end})
			end})
		audio.play(selectfx2)
			audio.stop(backgroundchannel0)

	end	
end


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
	local background = display.newImageRect( "characterselectbg.jpg", display.actualContentWidth ,display.actualContentHeight , true)
	background.anchorX = 0
	background.anchorY = 0
	background.x = 0 + display.screenOriginX 
	background.y =   display.screenOriginY 
	background.isVisible = true


	backgroundloading = display.newImageRect( "loading.jpg", display.actualContentWidth ,display.actualContentHeight , true)
	backgroundloading.anchorX = 0
	backgroundloading.anchorY = 0
	backgroundloading.x = 0 + display.screenOriginX 
	backgroundloading.y =   display.screenOriginY 
	backgroundloading.alpha = 0


	homebtn = display.newImageRect("home.png", 90, 60)
	homebtn.x, homebtn.y =  screenW * 0.1 - 40, screenH * 0.88
	homebtn:addEventListener("touch", goback)
	homebtn.alpha = 0

	function playmusic( )
		audio.play(backgroundMusic, { channel=15, loops=-1})
		audio.setVolume( 1, { channel=15 } )
	end

	timer.performWithDelay(200, playmusic, 1)

	------------------------------------------------
	--functions
		function selbull(event )
			if event.phase == "began" then
				audio.play(buharifx)
				bull.number = 1
				bull2.isVisible = true
				bull.isVisible = false
				abu.isVisible = true
				abu2.isVisible = false
				duro.isVisible = true
				duro2.isVisible = false
				unic.isVisible = true
				unic2.isVisible = false

			end
		end


		function selabu(event )
			if event.phase == "began" then
				audio.play(atikufx)
				bull.number = 2
				abu.isVisible = false
				abu2.isVisible = true
				duro.isVisible = true
				duro2.isVisible = false
				unic.isVisible = true
				unic2.isVisible = false
				bull2.isVisible = false
				bull.isVisible = true
			end
		end


		function selunic(event )
			if event.phase == "began" then
				audio.play(unicefx)
				bull.number = 3
				abu.isVisible = true
				abu2.isVisible = false
				duro.isVisible = true
				duro2.isVisible = false
				unic.isVisible = false
				unic2.isVisible = true
				bull2.isVisible = false
				bull.isVisible = true
			end
		end


		function selduro(event )
			if event.phase == "began" then
				audio.play(felafx)
				bull.number = 4
				abu.isVisible = true
				abu2.isVisible = false
				duro.isVisible = false
				duro2.isVisible = true
				unic.isVisible = true
				unic2.isVisible = false
				bull2.isVisible = false
				bull.isVisible = true
			end
		end


		startgametab = display.newImageRect("startgametab.png", 200, 40)
		startgametab.x, startgametab.y =  screenW * 0.7 , screenH * 0.9
		startgametab:addEventListener("touch", startgame)
		startgametab.alpha = 0

		bull = display.newImageRect("bull.png", 120, 200)
		bull.x, bull.y =  screenW * 0.2 , -230
		bull.number = 0
		bull:addEventListener("touch", selbull)
		
		bull2 = display.newImageRect("bull2.png", 120, 200)
		bull2.x, bull2.y =  screenW * 0.21 , 130
		bull2.isVisible = false


		abu = display.newImageRect("abu.png", 120, 200)
		abu.x, abu.y =  screenW * 0.4 , -230	
		abu:addEventListener("touch", selabu)
		
		abu2 = display.newImageRect("abu2.png", 120, 200)
		abu2.x, abu2.y =  screenW * 0.4 , 130
		abu2.isVisible = false

		unic = display.newImageRect("unic.png", 120, 200)
		unic.x, unic.y =  screenW * 0.6 , -230
		unic:addEventListener("touch", selunic)
		
		unic2 = display.newImageRect("unic2.png", 120, 200)
		unic2.x, unic2.y =  screenW * 0.61 , 130
		unic2.isVisible = false

		duro = display.newImageRect("duro.png", 120, 200)
		duro.x, duro.y =  screenW * 0.8 , -230
		duro:addEventListener("touch", selduro)

		duro2 = display.newImageRect("duro2.png", 120, 200)
		duro2.x, duro2.y =  screenW * 0.81 , 130
		duro2.isVisible = false
------------------------------------------------------------------


--character text


		local bulltext = display.newImageRect("characterb.png", 80, 22.5)
		bulltext.x, bulltext.y =  screenW * 0.19 , 240
		bulltext.isVisible = false

		local abutext = display.newImageRect("charactera.png", 80, 22)
		abutext.x, abutext.y =  screenW * 0.4 , 240	
		abutext.isVisible = false

		local unictext = display.newImageRect("charactery.png", 80, 22)
		unictext.x, unictext.y =  screenW * 0.6 , 240
		unictext.isVisible = false

		local durotext = display.newImageRect("characterd.png", 80, 22)
		durotext.x, durotext.y =  screenW * 0.8 , 240
		durotext.isVisible = false

		smoke = display.newImageRect("cloud.png", 900, 50)
		smoke.x, smoke.y =  screenW * 0.2 , screenH * 0.72
		smoke.alpha = 0.2


			function  becomevisible( )
					bulltext.isVisible = true
					abutext.isVisible = true
					unictext.isVisible = true
					durotext.isVisible = true	
					transition.fadeIn(homebtn, {time = 1500} )	
					transition.fadeIn(startgametab, {time = 2500} )			
			end

			function appearnow( )
				transition.moveTo(bull, {y = 130, time = 100})
				transition.moveTo(abu, {y = 130, time = 100})
				transition.moveTo(duro, {y = 130, time = 100})
				transition.moveTo(unic, {y = 130, time = 100,  onComplete = function ( )

					timer.performWithDelay(700, becomevisible, 1)
				end})
			end

			timer.performWithDelay(1500, appearnow, 1)

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
		vote.alpha = 0







	function tipsstart( )

	end

	timer.performWithDelay(1500, tipsstart, 1)

















	-- all display objects must be inserted into group
	sceneGroup:insert( background)
	sceneGroup:insert( bull)
	sceneGroup:insert( bull2)
	sceneGroup:insert( abu)
	sceneGroup:insert( abu2)
	sceneGroup:insert( duro)
	sceneGroup:insert( duro2)
	sceneGroup:insert( unic2)
	sceneGroup:insert( unic)
	sceneGroup:insert( smoke)
	sceneGroup:insert( bulltext)
	sceneGroup:insert( abutext)
	sceneGroup:insert( unictext)
	sceneGroup:insert( durotext)
	sceneGroup:insert( startgametab)
	sceneGroup:insert( homebtn)
	sceneGroup:insert( backgroundloading)
	sceneGroup:insert( tips)
	sceneGroup:insert( logo)
	sceneGroup:insert( vote)

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
		composer.removeScene("selectionpage")
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