-----------------------------------------------------------------------------------------
--
-- level1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- include Corona's "physics" library
local physics = require "physics"

--------------------------------------------

-- forward declarations and other locals
local screenW, screenH, halfW = display.actualContentWidth, display.actualContentHeight, display.contentCenterX
local perspective = require("perspective")
local camera = perspective.createView()
local player = {}
camera:setBounds(display.contentWidth*0.5, display.contentWidth * 145, 70 , display.contentHeight - 150)
camera:track()
camera.damping = 3
local missile
local controls22 
local controls11 
local controls21 
local controls12 
local boss
local layer35 
local layer34
local layer54 
local layer70
local layer55 
local layer17
local layer18 
local layer19 
local layer20
local layer21


local pickup  


--physics.setDrawMode("hybrid")
mainGroup = display.newGroup( )
behindgroup = display.newGroup( )
BgGroup = display.newGroup( )
bombGroup = display.newGroup( )
local alertfx = audio.loadSound("alert.mp3")
local failfx2 = audio.loadSound("loss.mp3")
local failfx = audio.loadSound("loss.mp3")
local runfx = audio.loadSound("slide2.mp3")
local explosionfx = audio.loadSound("bomb.mp3")
local jumpfx = audio.loadSound("jump.mp3")
local thunderfx = audio.loadSound("thd.mp3")
local rainmusic = audio.loadStream("zz.mp3")
local drivefx = audio.loadSound("driveby.mp3")
local deathfx = audio.loadSound("durofail.mp3")
local deathfx2 = audio.loadSound("death2.mp3")
local votefx = audio.loadSound("vote.mp3")
local planefx = audio.loadSound("airplane.mp3")
local planefx2 = audio.loadSound("plane.mp3")
local planestopfx = audio.loadSound("planestop.mp3")
local victoryfx = audio.loadSound("victory.mp3")
local slidefx = audio.loadSound("slide.mp3")
local dashfx = audio.loadSound("dash.mp3")
local bossfx = audio.loadSound("boss.mp3")
local drummerfx = audio.loadSound("drummer.mp3")


local backgroundMusic = audio.loadStream("anthem.mp3")
		audio.play(backgroundMusic, { channel=16, loops=-1})
		audio.setVolume( 1, { channel=16 } )


local bossmusic = audio.loadStream("bossmusic.mp3")


local backgroundchannel0 = 16
local backgroundchannel1 = 17


function playbosssong( )
	if player.isAlive == true then
		audio.play(bossmusic, { channel=17, loops=-1})
		audio.setVolume( 1, { channel=17 } )
	end
end
explosionBurstSpriteSheet = graphics.newImageSheet( "explosion.png", { width = 100, height = 100, numFrames = 9 } )

bokocueBurstSpriteSheet = graphics.newImageSheet( "bokocue.png", { width = 130, height = 220, numFrames = 3 } )

		function spriteListenerGreenBurst( event )

				    local thisSprite = event.target  -- "event.target" references the sprite

					    if event.phase == "ended" then

					       	thisSprite.isVisible = false
					        thisSprite:removeSelf()
					        thisSprite = nil

					    end

		end


local function setheroproperties() 
	--hero properties
	player.speed = 250
end

local function setherovelocity()
	if player.canrun == true then
		local playerHorizontalVelocity, playerVerticalVelocity = player:getLinearVelocity()
		player:setLinearVelocity (player.velocity, heroVerticalVelocity)
	end
end 



local function docontrolstouch20(event)
	if player.isAlive == true then

		if event.phase == "began"  then
					player.isRunning = true
			
					player.isFacingRight = true
					player.xScale = 0.3
					Runtime:addEventListener("enterFrame", setherovelocity)
					player:setSequence( "run" )
					player:play()			
					player.velocity= player.speed
			



		end

		if event.phase == "moved" then

			player.isRunning = false
			Runtime:removeEventListener("enterFrame", setherovelocity)
			player.velocity= 0
			player:setSequence( "idle" )
			player:play()

					
		elseif event.phase == "ended" then
			player.isRunning = false
			Runtime:removeEventListener("enterFrame", setherovelocity)
			player.velocity= 0
			player:setSequence( "idle" )
			player:play()
		end
	end
end

local function docontrolstouch21(event)

	if player.isAlive == true then
		if event.phase == "began"  then
				
					player.isFacingRight = false
					player.isRunning = true
					player.xScale = -0.3
					Runtime:addEventListener("enterFrame", setherovelocity)
					player:setSequence( "run" )
					player:play()
				
					player.velocity= -player.speed
				

		end

		if event.phase == "moved" then
			player.isRunning = false
			Runtime:removeEventListener("enterFrame", setherovelocity)
			player.velocity= 0
			player:setSequence( "idle" )
			player:play()

					
		elseif event.phase == "ended" then
			player.isRunning = false
			Runtime:removeEventListener("enterFrame", setherovelocity)
			player.velocity= 0
			player:setSequence( "idle" )
			player:play()
		end
	end
end



--Deprecated : Originally meant for player movement.
--[[local function running(  )
				Runtime:addEventListener("enterFrame", setherovelocity)
			
				player.velocity= player.speed
end--]]








function scene:create( event )

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	local sceneGroup = self.view

	-- We need physics started to add bodies, but we don't want the simulaton
	-- running until the scene is on the screen.
	physics.start()
	physics.pause()


	-- create a grey rectangle as the backdrop
	-- the physical screen will likely be a different shape than our defined content area
	-- since we are going to position the background from it's top, left corner, draw the
	-- background at the real top, left corner.

	

	local background0 = display.newRect( display.screenOriginX , display.screenOriginY, screenW * 6, screenH * 2 )
	background0.anchorX = 0 
	background0.anchorY = 0
	background0:setFillColor( 0, 0, 0 )
	background0.alpha = 0.6
	background0.isVisible = false

	local background2 = display.newImageRect( "sky.png", display.actualContentWidth * 60,display.actualContentHeight + 60, true)
	background2.anchorX = 0
	background2.anchorY = 0
	background2.x = 0 + display.screenOriginX 
	background2.y =   display.screenOriginY - 90
	background2.isVisible = true

	local background22 = display.newImageRect( "sky2.png", display.actualContentWidth * 30,display.actualContentHeight + 60, true)
	background22.anchorX = 0
	background22.anchorY = 0
	background22.x = screenW* 60 + background2.x
	background22.y =   display.screenOriginY - 90
	background22.isVisible = true

	local background32 = display.newImageRect( "sky3.png", display.actualContentWidth * 60,display.actualContentHeight + 60, true)
	background32.anchorX = 0
	background32.anchorY = 0
	background32.x = screenW* 30 + background22.x
	background32.y =   display.screenOriginY - 90
	background32.isVisible = true



---------------------------------------------------------------------------------------------------------------------------------
--Backgrounds	

	local layer = display.newImageRect( "h2.png", display.actualContentWidth * 2 ,display.actualContentHeight * 2.5 , true)
	layer.anchorX = 0
	layer.anchorY = 0
	layer.x = 0 + display.screenOriginX 
	layer.y =   display.screenOriginY - 260


	

	local layer2 = display.newImageRect( "h2.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
	layer2.anchorX = 0
	layer2.anchorY = 0
	layer2.x =  screenW * 1.98 + layer.x 
	layer2.y =   display.screenOriginY - 260
	--layer2:setFillColor(0,0,0)

	local layer3 = display.newImageRect( "h3.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
	layer3.anchorX = 0
	layer3.anchorY = 0
	layer3.x =  screenW * 1.98 + layer2.x 
	layer3.y =   display.screenOriginY - 260
	--layer2:setFillColor(0,0,0)

	local layer4 = display.newImageRect( "h8.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
	layer4.anchorX = 0
	layer4.anchorY = 0
	layer4.x =  screenW * 1.98 + layer3.x 
	layer4.y =   display.screenOriginY - 260
	--layer2:setFillColor(0,0,0)

	local layer5 = display.newImageRect( "h2.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
	layer5.anchorX = 0
	layer5.anchorY = 0
	layer5.x =  screenW * 1.98 + layer4.x 
	layer5.y =   display.screenOriginY - 260
	--layer:setFillColor(0,0,0)

	local layer6 = display.newImageRect( "h1.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
	layer6.anchorX = 0
	layer6.anchorY = 0
	layer6.x =  screenW * 1.98 + layer5.x 
	layer6.y =   display.screenOriginY - 260
	--layer2:setFillColor(0,0,0)

	local layer7 = display.newImageRect( "h5.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
	layer7.anchorX = 0
	layer7.anchorY = 0
	layer7.x =  screenW * 1.98 + layer6.x 
	layer7.y =   display.screenOriginY - 260
	--layer2:setFillColor(0,0,0)	

	local layer8 = display.newImageRect( "h4.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
	layer8.anchorX = 0
	layer8.anchorY = 0
	layer8.x =  screenW * 1.98 + layer7.x 
	layer8.y =   display.screenOriginY - 260
	--layer2:setFillColor(0,0,0)

	local layer9 = display.newImageRect( "h6.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
	layer9.anchorX = 0
	layer9.anchorY = 0
	layer9.x =  screenW * 1.98 + layer8.x 
	layer9.y =   display.screenOriginY - 260
	--layer2:setFillColor(0,0,0)

	local layer10 = display.newImageRect( "h6.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
	layer10.anchorX = 0
	layer10.anchorY = 0
	layer10.x =  screenW * 1.98 + layer9.x 
	layer10.y =   display.screenOriginY - 260
	--layer2:setFillColor(0,0,0)

	local layer11 = display.newImageRect( "h2.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
	layer11.anchorX = 0
	layer11.anchorY = 0
	layer11.x =  screenW * 1.98 + layer10.x 
	layer11.y =   display.screenOriginY - 260
	--layer2:setFillColor(0,0,0)

	local layer12 = display.newImageRect( "h1.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
	layer12.anchorX = 0
	layer12.anchorY = 0
	layer12.x =  screenW * 1.98 + layer11.x 
	layer12.y =   display.screenOriginY - 260
	--layer2:setFillColor(0,0,0)

	local layer13 = display.newImageRect( "h2.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
	layer13.anchorX = 0
	layer13.anchorY = 0
	layer13.x =  screenW * 1.98 + layer12.x 
	layer13.y =   display.screenOriginY - 260
	--layer2:setFillColor(0,0,0)

	local layer14 = display.newImageRect( "h6.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
	layer14.anchorX = 0
	layer14.anchorY = 0
	layer14.x =  screenW * 1.98 + layer13.x 
	layer14.y =   display.screenOriginY - 260
	--layer2:setFillColor(0,0,0)

	local layer15 = display.newImageRect( "h4.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
	layer15.anchorX = 0
	layer15.anchorY = 0
	layer15.x =  screenW *1.98 + layer14.x 
	layer15.y =   display.screenOriginY - 260
	--layer2:setFillColor(0,0,0)

	local layer16 = display.newImageRect( "h1.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
	layer16.anchorX = 0
	layer16.anchorY = 0
	layer16.x =  screenW *1.98 + layer15.x 
	layer16.y =   display.screenOriginY - 260
	--layer16:setFillColor(0,0,0)


----------------------------------------------------------------------------------------------------------------------------------------
	

------------------------------------------------------------------------------------------------------------------------------------------

	

	local tinubusprite = graphics.newImageSheet( "tinubuhat.png", { width = 684, height = 684, numFrames = 4} )

		local tinubusequence =

{

				{ name="roll", sheet=playersprite, start=1, count=4,time = 350, loopcount = 0 },


}




		tinubu = display.newSprite(tinubusprite, tinubusequence)
		tinubu.x = 120000
		tinubu.y = 250
		tinubu.xScale = 0.08
		tinubu.yScale = 0.08
		local voteshape = { 5,-6, 10,-6, 10,6, 5,6 }

		physics.addBody(tinubu, "static", {shape = voteshape})
		tinubu.isSensor = true
		tinubu.name = "tinubu"
		tinubu:setSequence("roll")
		tinubu:play()





	local playersprite2 = graphics.newImageSheet( "felajump.png", { width = 500, height = 400, numFrames = 4} )
	local playersprite3 = graphics.newImageSheet( "felaidle.png", { width = 500, height = 400, numFrames = 2} )
	local playersprite4 = graphics.newImageSheet( "feladie.png", { width = 500, height = 400, numFrames = 4} )
	local playersprite0 = graphics.newImageSheet( "felarun.png", { width = 500, height = 400, numFrames = 8} )
	local playersprite6 = graphics.newImageSheet( "felaslide.png", { width = 500, height = 400, numFrames = 9} )
	local boardwarriorsprite5 = graphics.newImageSheet( "raain4.png", { width = 600, height = 600, numFrames = 2} )
	local playersprite7 = graphics.newImageSheet( "feladance.png", { width = 500, height = 400, numFrames = 6} )
	local playersprite8 = graphics.newImageSheet( "felaboost.png", { width = 500, height = 400, numFrames = 8} )

		local playersequence =

{

				{ name="run", sheet=playersprite0, start=1, count=8,time = 500, loopcount = 0 },
				{ name="jump", sheet=playersprite2, start=1, count=4,time = 850, loopCount = 1 },
				{ name="idle", sheet=playersprite3, start=1, count=2,time = 600, loopcount = 0 },
				{ name="die", sheet=playersprite4, start=1, count=4,time = 600, loopCount = 1 },
				{ name="cry", sheet=playersprite4, start=1, count=4,time = 300, loopCount = 1 },
				{ name="sliding", sheet=playersprite6, start=1, count=8,time = 1000, loopCount = 1 },
				{ name="sliding2", sheet=playersprite6, start=1, count=8,time = 400, loopCount = 1 },
				{ name="speed", sheet=playersprite8, start=1, count=8,time = 300, loopCount = 0 },
				{ name="dance", sheet=playersprite7, start=1, count=6,time = 1250, loopCount = 0 },

}










		player = display.newSprite(playersprite0, playersequence)
		player.x = -600 --68500
		player.y = 250
		local playershape = { -15,-35, 35,-35, 40,49, -15,49 }
	    physics.addBody( player, "dynamic", { density = 10, friction = 1.8, bounce = 0, shape = playershape} )
	    player.name = "player"
	    player.isFixedRotation = true
	    player.gravityScale = 3.3
	    setheroproperties()
	    player.isGrounded = true
	    player.isSliding = false
		player:setSequence("run")
		player:play()
		player.xScale = 0.3
		player.yScale = 0.3
		player.isAlive = true
		playermovement =  4.5
		player.isRunning = true
		player.speed = 250
		player.canrun = true
		

		realplayer = display.newRect(1200 --[[68500--]], player.y , 100, 100)
		realplayer.isVisible = false


		rain = display.newSprite(boardwarriorsprite5, playersequence)
		rain.x = 230 
		rain.y = -180
		rain.alpha = 0.4
		rain.xScale = 1
		rain.yScale = 0.6
		rain.isVisible = true	
		rain:setSequence("playing3")
		rain:play()




---------------------------------------------------------------------
-- RAIN FUNCTION

function rainstart( )
	transition.moveTo(rain, {y = 160, time = 300})
end


 function startraining( )
 	audio.play(rainmusic, { channel=15, loops=-1})
	audio.setVolume( 1, { channel=15 } )
 	background0.isVisible = true
 	timer.performWithDelay(1000, rainstart, 1)
 end



--timer.performWithDelay(6000, startraining, 1)



--------------------------------------------------------------------------------------------------



		local function spriteListener2( event )
		   if event.phase == "ended" then
		   		if player.isAlive == true then
		   			player.isRunning = true
		   			player.isSliding = false
			   		player:setSequence("idle")
					player:play()		
				end
			end
		end



		local function spriteListener( event )
		   if event.phase == "ended" then
		   		if player.isAlive == true then
		   			player.isRunning = true
		   			player.isSliding = false
			   		player:setSequence("run")
					player:play()		
				end
			end
		end

		-- Add sprite listener



	local planesprite = graphics.newImageSheet( "plane.png", { width = 891, height = 398, numFrames = 4} )

		local planesequence =

{

				{ name="crash", sheet=planesprite, start=1, count=4,time = 550, loopcount = 0 },


}



		local planeshape = { -90,-20, 150,-28, 150,80, -90,80 }
		plane = display.newSprite(planesprite, planesequence)
		plane.x = 36700
		plane.y = 145
		plane.xScale = 0.35
		plane.yScale = 0.42
		physics.addBody(plane, "static", {shape = planeshape})
		plane.isSensor = true
		plane.isBullet = true
		plane.isVisible = true
		plane.name = "plane"
		plane:setSequence("crash")
		plane:play()

		local planecollider = display.newRect(plane.x - 1000, plane.y ,60, 400)
	    physics.addBody( planecollider, "static" )
		planecollider.isSensor = true
		planecollider.name = "planecollider"
		planecollider.isVisible = false


		function thunder( )
			audio.play(thunderfx)
		end

--timer.performWithDelay(39000, thunder, 0)
------------------------------------------------------------------------------------------------------		
-- BokoHaram

	local bokosprite = graphics.newImageSheet( "bokocar.png", { width = 800, height = 300, numFrames = 2} )
	local pickupsprite = graphics.newImageSheet( "ballot.png", { width = 516, height = 200, numFrames = 2} )
	local bokosprite2 = graphics.newImageSheet( "destroyedvan.png", { width = 800, height = 300, numFrames = 2} )

		local bokosequence =

{

				{ name="ride", sheet=bokosprite, start=1, count=2,time = 400, loopcount = 0 },
				{ name="ride2", sheet=pickupsprite, start=1, count=2,time = 200, loopcount = 0 },
				{ name="ride3", sheet=bokosprite2, start=1, count=2,time = 400, loopcount = 0 },

}




		cab = display.newSprite(bokosprite, bokosequence)
		cab.x, cab.y =  13000, 200 
		cab.xScale, cab.yScale = 0.5, 0.56
		cab:setSequence("ride")
		cab:play()
		cab.isVisible = false
		
		local cabcollider = display.newRect(cab.x + 1000, cab.y ,200, 400)
	    physics.addBody( cabcollider, "static" )
		cabcollider.isSensor = true
		cabcollider.name = "cabcollider"
		cabcollider.isVisible = false





--------------------------------------------------------------------------------------------------------

		

----------------------------------------------------------------------------------------------------------




		local boss1collider = display.newRect( 10500, 150,200, 400)
	    physics.addBody( boss1collider, "static" )
		boss1collider.isSensor = true
		boss1collider.name = "bosscollider"
		boss1collider.isVisible = false


		local boss = display.newImageRect("oppoy.png", 130, 90)
		boss.x = boss1collider.x +  1000
		boss.y = 50
		boss.isDone = true




---------------------------------------------------------------------------------------




----------------------------------------------------------------------------------------------------------










		local boss2collider = display.newRect( 105000, 150,200, 400)
	    physics.addBody( boss2collider, "static" )
		boss2collider.isSensor = true
		boss2collider.name = "boss2collider"
		boss2collider.isVisible = false


		local boss2 = display.newImageRect("oppob.png", 130, 90)
		boss2.x = boss2collider.x + 1000
		boss2.y = 50
		boss2.isDone = true



---------------------------------------------------------------------------------------
	local votesprite = graphics.newImageSheet( "votes.png", { width = 200, height = 200, numFrames = 2} )
		local votesequence =

{

				{ name="idle", sheet=votesprite, start=1, count=2,time = 500, loopcount = 0 },


}
		local voteshape = { 5,-6, 10,-6, 10,6, 5,6 }
		votes = display.newSprite(votesprite, votesequence)
		votes.x, votes.y = 600, 220
		votes.xScale = 0.2
		votes.yScale = 0.2
		physics.addBody(votes, "static", {shape = voteshape})
		votes.isSensor = true
		votes.name = "votes"
		votes:setSequence("idle")
		votes:play()
		bombGroup:insert(votes)

		votes2 = display.newSprite(votesprite, votesequence)
		votes2.x, votes2.y = votes.x + math.random(700, 900), 240
		votes2.xScale = 0.2
		votes2.yScale = 0.2
		physics.addBody(votes2, "static", {shape = voteshape})
		votes2.isSensor = true
		votes2.name = "votes2"
		votes2:setSequence("idle")
		votes2:play()
		bombGroup:insert(votes2)

		votes3 = display.newSprite(votesprite, votesequence)
		votes3.x, votes3.y = votes.x + math.random(1400, 1500), 240
		votes3.xScale = 0.2
		votes3.yScale = 0.2
		physics.addBody(votes3, "static", {shape = voteshape})
		votes3.isSensor = true
		votes3.name = "votes3"
		votes3:setSequence("idle")
		votes3:play()
		bombGroup:insert(votes3)

		votes4 = display.newSprite(votesprite, votesequence)
		votes4.x, votes4.y = votes.x + math.random(1600, 1900), 240
		votes4.xScale = 0.2
		votes4.yScale = 0.2
		physics.addBody(votes4, "static", {shape = voteshape})
		votes4.isSensor = true
		votes4.name = "votes4"
		votes4:setSequence("idle")
		votes4:play()
		bombGroup:insert(votes4)


		votes5 = display.newSprite(votesprite, votesequence)
		votes5.x, votes5.y = votes.x + math.random(2100, 2200), 240
		votes5.xScale = 0.2
		votes5.yScale = 0.2
		physics.addBody(votes5, "static", {shape = voteshape})
		votes5.isSensor = true
		votes5.name = "votes5"
		votes5:setSequence("idle")
		votes5:play()
		bombGroup:insert(votes5)


		votes6 = display.newSprite(votesprite, votesequence)
		votes6.x, votes6.y = votes.x + math.random(2400, 2500), 240
		votes6.xScale = 0.2
		votes6.yScale = 0.2
		physics.addBody(votes6, "static", {shape = voteshape})
		votes6.isSensor = true
		votes6.name = "votes6"
		votes6:setSequence("idle")
		votes6:play()
		bombGroup:insert(votes6)

		votes7 = display.newSprite(votesprite, votesequence)
		votes7.x, votes7.y = votes.x + math.random(2800, 2900), 240
		votes7.xScale = 0.2
		votes7.yScale = 0.2
		physics.addBody(votes7, "static", {shape = voteshape})
		votes7.isSensor = true
		votes7.name = "votes7"
		votes7:setSequence("idle")
		votes7:play()
		bombGroup:insert(votes7)


		votes8 = display.newSprite(votesprite, votesequence)
		votes8.x, votes8.y = votes.x + math.random(3500, 3600), 240
		votes8.xScale = 0.2
		votes8.yScale = 0.2
		physics.addBody(votes8, "static", {shape = voteshape})
		votes8.isSensor = true
		votes8.name = "votes8"
		votes8:setSequence("idle")
		votes8:play()
		bombGroup:insert(votes8)


		votes9 = display.newSprite(votesprite, votesequence)
		votes9.x, votes9.y = votes.x + math.random(4000, 4100), 240
		votes9.xScale = 0.2
		votes9.yScale = 0.2
		physics.addBody(votes9, "static", {shape = voteshape})
		votes9.isSensor = true
		votes9.name = "votes9"
		votes9:setSequence("idle")
		votes9:play()
		bombGroup:insert(votes9)

		votes10 = display.newSprite(votesprite, votesequence)
		votes10.x, votes10.y = votes.x + math.random(4300, 4500), 240
		votes10.xScale = 0.2
		votes10.yScale = 0.2
		physics.addBody(votes10, "static", {shape = voteshape})
		votes10.isSensor = true
		votes10.name = "votes10"
		votes10:setSequence("idle")
		votes10:play()
		bombGroup:insert(votes10)


		votes11 = display.newSprite(votesprite, votesequence)
		votes11.x, votes11.y = votes.x + math.random(4600, 4700), 240
		votes11.xScale = 0.2
		votes11.yScale = 0.2
		physics.addBody(votes11, "static", {shape = voteshape})
		votes11.isSensor = true
		votes11.name = "votes11"
		votes11:setSequence("idle")
		votes11:play()
		bombGroup:insert(votes11)





----------------------------------------------------------------------------------------------------------



		local boss3collider = display.newRect( 45000, 150,200, 400)
	    physics.addBody( boss3collider, "static" )
		boss3collider.isSensor = true
		boss3collider.name = "boss3collider"
		boss3collider.isVisible = false


		local boss3 = display.newImageRect("oppoa.png", 140, 90)
		boss3.x = boss3collider.x + 1000
		boss3.y = 55
		boss3.isDone = true



---------------------------------------------------------------------------------------



		local youlosegrap = display.newImageRect("lost.png", 200, 200)
		youlosegrap.x, youlosegrap.y =  screenW * 0.4, screenH * 0.5
		youlosegrap.alpha = 0

		local youwongrap = display.newImageRect("won.png", 250, 250)
		youwongrap.x, youwongrap.y =  player.x, screenH * 0.5
		youwongrap.alpha = 0





--obstacles


		local obstacleshape = { -22,-40, 20,-40, 18,42, -20,42 }
		local obstacleshape2 = { -40,-35, 10,-35, 10,42, -50,42 }



		local obstacle = display.newImageRect("pothole.png",160, 50)
		obstacle.x, obstacle.y =  --[[math.random(1200, 1450)--]] 1000, 310
		physics.addBody(obstacle, "static", {shape = obstacleshape2})
		obstacle.name = "obstacle"
	


		local obstacle2 = display.newImageRect("pothole.png",150, 50)
		obstacle2.x, obstacle2.y =  1800, 310
		physics.addBody(obstacle2, "static", {shape = obstacleshape2})
		obstacle2.name = "obstacle"

		local obstacle3 = display.newImageRect("pothole.png",150, 50)
		obstacle3.x, obstacle3.y =  math.random(2400,2500) , 310
		physics.addBody(obstacle3, "static", { shape = obstacleshape2})
		obstacle3.name = "obstacle"

		local obstacle4 = display.newImageRect("pothole.png",150, 50)
		obstacle4.x, obstacle4.y =  3000, 310
		physics.addBody(obstacle4, "static", {shape = obstacleshape2})
		obstacle4.name = "obstacle"


		local obstacle5 = display.newImageRect("pothole.png",150, 50)
		obstacle5.x, obstacle5.y =  3500, 310
		physics.addBody(obstacle5, "static", {shape = obstacleshape2})
		obstacle5.name = "obstacle"

		local obstacle6 = display.newImageRect("pothole.png",150, 50)
		obstacle6.x, obstacle6.y =  4100, 310
		physics.addBody(obstacle6, "static", {shape = obstacleshape2})
		obstacle6.name = "obstacle"

		local obstacle7 = display.newImageRect("pothole.png",150, 50)
		obstacle7.x, obstacle7.y =  math.random(4700,4800), 310
		physics.addBody(obstacle7, "static", {shape = obstacleshape2})
		obstacle7.name = "obstacle"

		local obstacle8 = display.newImageRect("pothole.png",150, 50)
		obstacle8.x, obstacle8.y =  5400, 310
		physics.addBody(obstacle8, "static", {shape = obstacleshape2})
		obstacle8.name = "obstacle"


		local obstacle9 = display.newImageRect("pothole.png",150, 50)
		obstacle9.x, obstacle9.y =  6000, 310
		physics.addBody(obstacle9, "static", {shape = obstacleshape2})
		obstacle9.name = "obstacle"

		local obstacle10 = display.newImageRect("pothole.png",150, 50)
		obstacle10.x, obstacle10.y =  6400 , 310
		physics.addBody(obstacle10, "static", { shape = obstacleshape2})
		obstacle10.name = "obstacle"

		local obstacle11 = display.newImageRect("pothole.png",150, 50)
		obstacle11.x, obstacle11.y =  6900, 310
		physics.addBody(obstacle11, "static", {shape = obstacleshape2})
		obstacle11.name = "obstacle"


		local obstacle12 = display.newImageRect("pothole.png",150, 50)
		obstacle12.x, obstacle12.y =  7300, 310
		physics.addBody(obstacle12, "static", {shape = obstacleshape2})
		obstacle12.name = "obstacle"

		local obstacle13 = display.newImageRect("pothole.png",150, 50)
		obstacle13.x, obstacle13.y =  7900, 310
		physics.addBody(obstacle13, "static", {shape = obstacleshape2})
		obstacle13.name = "obstacle"

		local obstacle14 = display.newImageRect("pothole.png",150, 50)
		obstacle14.x, obstacle14.y =  math.random(8600,8700), 310
		physics.addBody(obstacle14, "static", {shape = obstacleshape2})
		obstacle14.name = "obstacle"

		local obstacle15 = display.newImageRect("pothole.png",150, 50)
		obstacle15.x, obstacle15.y =  9400, 310
		physics.addBody(obstacle15, "static", {shape = obstacleshape2})
		obstacle15.name = "obstacle"

		local alert0 = display.newImageRect("planealert.png",200, 60)
		alert0.x, alert0.y =  800, player.y - 170
		alert0.isVisible = false
		transition.blink( alert0, { time=2000 } )

		local alert = display.newImageRect("bokoslidealert.png",200, 60)
		alert.x, alert.y =  800,player.y - 170
		alert.isVisible = false
		transition.blink( alert, { time=1500 } )

		local alert2 = display.newImageRect("bokojumpalert.png",200, 60)
		alert2.x, alert2.y =  1000,player.y - 170
		alert2.isVisible = false
		transition.blink( alert2, { time=1500 } )

		function alert3dissappear( )
			if player.isAlive == true then
				alert0.isVisible = false
			end
		end


		function alert3appear( )
			if player.isAlive == true then
				audio.play(alertfx)
				alert0.isVisible = true
				timer.performWithDelay(1000,alert3dissappear, 1 ) 
			end
		end


		function alertdissappear( )
			if player.isAlive == true then
				alert.isVisible = false
			end
		end


		function alertappear( )
			if player.isAlive == true then
				audio.play(alertfx)
				alert.isVisible = true
				timer.performWithDelay(1000,alertdissappear, 1 ) 
			end
		end



		function alert2dissappear( )
			if player.isAlive == true then
				alert2.isVisible = false
			end
		end


		function alert2appear( )
			if player.isAlive == true then
				audio.play(alertfx)
				alert2.isVisible = true
				timer.performWithDelay(1500,alert2dissappear, 1 ) 
			end
		end


		local pickupcollider = display.newRect(boss.x , 200 ,200, 400)
	    physics.addBody( pickupcollider, "static" )
		pickupcollider.isSensor = true
		pickupcollider.name = "pickupcollider"
		pickupcollider.isVisible = false


		pickup = display.newSprite(pickupsprite, bokosequence)
		pickup.x, pickup.y =  pickupcollider.x - 800, 225
		pickup.xScale, pickup.yScale = -0.45, 0.5
		pickup:setSequence("ride2")
		pickup:play()
		pickup.isVisible = false



----------------------------------------------------------------------------------------------
	function jump( event )
		
		if event.phase == "began" then
			if player.isAlive == true then
				if player.isRunning == true then
					Runtime:removeEventListener("enterFrame", setherovelocity)
					audio.play(jumpfx)
					player.isRunning = false
					player:setSequence("jump")
					player:play()
					player:applyLinearImpulse( 100, -700 )
					player:addEventListener( "sprite", spriteListener )
				end


			end
		end
	end

		function slide2( event )
		
		if event.phase == "began" then
			if player.isAlive == true then
					player.xScale = 0.3
					audio.play(slidefx)
					player.isRunning = false
					player.isSliding = true
					player:setSequence("sliding2")
					player:play()
					transition.moveTo(player, {x = player.x + 150, time = 400})
					player:addEventListener( "sprite", spriteListener2 )
				end
		end
	end


	function slide( event )
		
		if event.phase == "began" then
			if player.isAlive == true then
				if player.isRunning == true then
					Runtime:removeEventListener("enterFrame", setherovelocity)
					audio.play(slidefx)
					player.isRunning = false
					player.isSliding = true
					player:setSequence("sliding")
					player:play()
					player:applyLinearImpulse( 100, 10 )
					player:addEventListener( "sprite", spriteListener )
				end


			end
		end
	end

	-- create a grass object and add physics (with custom shape)
	local grass = display.newImageRect( "grass.png", screenW, 82 )
	grass.anchorX = 0
	grass.anchorY = 1
	--  draw the grass at the very bottom of the screen
	grass.x, grass.y = display.screenOriginX, display.actualContentHeight + display.screenOriginY + 50
	grass.name = "grass"
	
	-- define a shape that's slightly shorter than image bounds (set draw mode to "hybrid" or "debug" to see)
	local grassShape = { -1200,-30, screenW*250,-30, screenW * 250,34, -1200,34 }
	physics.addBody( grass, "static", { friction=1.5, shape=grassShape } )
	grass.isVisible = false
-------------------------------------------------------------------------------------------------------------
-- control buttons

	local controls11 = display.newImageRect("btnsld.png", 80, 80)
	controls11.x, controls11.y = screenW * 0.1 - 40 , grass.y - 100
	controls11.alpha = 0.3
	controls11.isVisible = false
	controls11:addEventListener("touch", slide)

	local controls12 = display.newImageRect("btnjp.png", 80, 80)
	controls12.x, controls12.y = screenW * 0.8, grass.y - 100
	controls12.alpha = 0.3
	controls12.isVisible = false
	controls12:addEventListener("touch", jump)


	controls21 = display.newImageRect("btnfwd.png", 80, 80)
	controls21.x, controls21.y = screenW * 0.8, grass.y - 100
	controls21.alpha = 0.3
	controls21.isVisible = false




	controls22 = display.newImageRect("btnbck.png", 80, 80)
	controls22.x, controls22.y = screenW * 0.1 - 40 , grass.y - 100
	controls22.alpha = 0.3
	controls22.isVisible = false

------------------------------------------------------------------------------------------------------------------

	function moving()
		if player.isAlive == true then
			player.x = player.x + playermovement
			realplayer.x = player.x + 80
			alert0.x = player.x 
			alert.x = player.x 
			alert2.x = player.x 
			alert2.y = player.y - 170
			youwongrap.x = player.x
		end
	end



	function startgame( )
		transition.moveTo(player, {x = 300, y = player.y + 3, time = 3200})
		transition.moveTo(realplayer, {x = player.x + 300, time = 2800, onComplete = function ( )
				controls11.isVisible = true
				controls12.isVisible = true
				Runtime:addEventListener("enterFrame", moving)
		end})
	
	end




	timer.performWithDelay(1500, startgame, 1)
-------------------------------------------------------------------

	function updatepositions0( )
		if player.isAlive == true then
			planecollider.x = 47000
			plane.x = planecollider.x + 1000


		end

	end


	function updatepositions( )
		if player.isAlive == true then
			boss2collider.x = obstacle15.x + 1000
			boss2.x = boss2collider.x + 1000

		end

	end

	function updatepositions2( )
		if player.isAlive == true then
			tinubu.x = player.x + 1000

			obstacle.x, obstacle.y =  player.x + 2500, 310

			obstacle2.x, obstacle2.y =  obstacle.x + 600, 310

			obstacle3.x, obstacle3.y =  obstacle2.x + 500 , 310

			obstacle4.x, obstacle4.y =  obstacle3.x + 350, 310

			obstacle5.x, obstacle5.y =  obstacle4.x + 400, 310

			obstacle6.x, obstacle6.y =  obstacle5.x + 600, 310

			obstacle7.x, obstacle7.y =  obstacle6.x + 450, 310

			obstacle8.x, obstacle8.y =  obstacle7.x + 600, 310

			obstacle9.x, obstacle9.y =  obstacle8.x + 550, 310


		end

	end


-------------------------------------------------------------------
--reload obstacles

	function reloadobstacles( )
		if player.isAlive == true then
			obstacle.x, obstacle.y =  math.random(34000, 34450), 310

			obstacle2.x, obstacle2.y =  35000, 310

			obstacle3.x, obstacle3.y =  35700 , 310

			obstacle4.x, obstacle4.y =  37000, 310

			obstacle5.x, obstacle5.y =  37500, 310

			obstacle6.x, obstacle6.y =  38000, 310

			obstacle7.x, obstacle7.y =  math.random(38500,38600), 310

			obstacle8.x, obstacle8.y =  39200, 310

			obstacle9.x, obstacle9.y =  39800, 310


			obstacle10.x, obstacle10.y =  40400 , 310


			obstacle11.x, obstacle11.y =  40900, 310


			obstacle12.x, obstacle12.y =  41500, 310


			obstacle13.x, obstacle13.y =  42200, 310


			obstacle14.x, obstacle14.y =  math.random(42700,42800), 310


			obstacle15.x, obstacle15.y =  43700, 310
			
		end
	end


	function reloadobstacles2( )
		if player.isAlive == true then
			obstacle.x, obstacle.y =  47000, 310

			obstacle2.x, obstacle2.y =  obstacle.x + 1000, 310

			obstacle3.x, obstacle3.y =  obstacle2.x + 650, 310

			obstacle4.x, obstacle4.y =  obstacle3.x + 800, 310

			obstacle5.x, obstacle5.y =  obstacle4.x + 600, 310

			obstacle6.x, obstacle6.y =  obstacle5.x +1000, 310

			obstacle7.x, obstacle7.y =  obstacle6.x + 550, 310

			obstacle8.x, obstacle8.y =  obstacle7.x + 650, 310

			obstacle9.x, obstacle9.y =  obstacle8.x + 680, 310


			obstacle10.x, obstacle10.y =  obstacle9.x + 800 , 310


			obstacle11.x, obstacle11.y =  obstacle10.x + 650, 310


			obstacle12.x, obstacle12.y =  obstacle11.x + 750, 310


			obstacle13.x, obstacle13.y =  obstacle12.x + 500, 310


			obstacle14.x, obstacle14.y =  obstacle13.x + 670, 310


			obstacle15.x, obstacle15.y =  obstacle14.x + 700, 310

			timer.performWithDelay(500, updatepositions, 1)
		end
	end


	function reloadobstacles3( )
		if player.isAlive == true then
			obstacle.x, obstacle.y =  47000, 310

			obstacle2.x, obstacle2.y =  obstacle.x + 600, 310

			obstacle3.x, obstacle3.y =  obstacle2.x + 650, 310

			obstacle4.x, obstacle4.y =  obstacle3.x + 800, 310

			obstacle5.x, obstacle5.y =  obstacle4.x + 600, 310

			obstacle6.x, obstacle6.y =  obstacle5.x +1000, 310

			obstacle7.x, obstacle7.y =  obstacle6.x + 550, 310

			obstacle8.x, obstacle8.y =  obstacle7.x + 650, 310

			obstacle9.x, obstacle9.y =  obstacle8.x + 680, 310


			obstacle10.x, obstacle10.y =  obstacle9.x + 800 , 310


			obstacle11.x, obstacle11.y =  obstacle10.x + 650, 310


			obstacle12.x, obstacle12.y =  obstacle11.x + 750, 310


			obstacle13.x, obstacle13.y =  obstacle12.x + 500, 310


			obstacle14.x, obstacle14.y =  obstacle13.x + 670, 310


			obstacle15.x, obstacle15.y =  obstacle14.x + 700, 310

			timer.performWithDelay(500, updatepositions, 1)
		end
	end





-----------------------------------------------------------------------------------------------------------------


		function bokoattackstart( )
			if player.isAlive == true then
				cab.x = realplayer.x + 400
			end
		end

		function removecab( )
			if player.isAlive == true then
				
			end
		end

		local function bokoattackended( )
			if player.isAlive == true then
				cab.y = cab.y - 20
				audio.stop(backgroundchannel1)
				audio.play(backgroundMusic, { channel=16, loops=-1})
				audio.setVolume( 1, { channel=16 } )
				playermovement =  4.5
				audio.play(explosionfx)
									local options =
												{
													name = "splashburst",
													start = 1,
													count = 9,
													time = 800,
													loopCount = 2 -- Play just once and then stop.
												}

												local explosionBurstSprite = display.newSprite( explosionBurstSpriteSheet, options )

												explosionBurstSprite.x = cab.x  
												explosionBurstSprite.y = cab.y - 50 
												explosionBurstSprite.xScale = 1.3
												explosionBurstSprite.yScale = 1.1
												explosionBurstSprite:addEventListener( "sprite", spriteListenerGreenBurst )
												explosionBurstSprite:play()
												bombGroup:insert(explosionBurstSprite)

												local explosionBurstSprite2 = display.newSprite( explosionBurstSpriteSheet, options )

												explosionBurstSprite2.x = cab.x - 50 
												explosionBurstSprite2.y = cab.y 
												explosionBurstSprite2.xScale = 1.3
												explosionBurstSprite2.yScale = 1.1
												explosionBurstSprite2:addEventListener( "sprite", spriteListenerGreenBurst )
												explosionBurstSprite2:play()
												bombGroup:insert(explosionBurstSprite2)
				cab:setSequence("ride3")
				cab:play()



				Runtime:removeEventListener("enterFrame", bokoattackstart)
				reloadobstacles()
				timer.performWithDelay(4000, removecab, 1)
			end

		end 

		local function bokoattackprojectile( )
			if player.isAlive == true then
				audio.play(explosionfx)

					local options =
											{
												name = "splashburst",
												start = 1,
												count = 3,
												time = 500,
												loopCount = 1 -- Play just once and then stop.
											}

											local explosionBurstSprite = display.newSprite( bokocueBurstSpriteSheet, options )

											explosionBurstSprite.x = cab.x - 200 
											explosionBurstSprite.y = cab.y - 100 
											explosionBurstSprite.xScale = 1.3
											explosionBurstSprite.yScale = 1.1
											explosionBurstSprite:addEventListener( "sprite", spriteListenerGreenBurst )
											explosionBurstSprite:play()
											bombGroup:insert(explosionBurstSprite)


				local missilesprite = graphics.newImageSheet( "missilebomb.png", { width = 1388, height = 322, numFrames = 2} )

					local missilesequence =

			{

							{ name="shot", sheet=missilesprite, start=1, count=2,time = 400, loopcount = 0 },


			}



		local missileshape = { -58,-2, 15,-5, 15,6, -58,5 }

				missile66 = display.newSprite(missilesprite, missilesequence)
				missile66.x, missile66.y = cab.x - 150, cab.y - 20
				missile66.xScale, missile66.yScale = 0.07, 0.067
				missile66:setSequence("shot")
				missile66:play()
				physics.addBody( missile66, "static", {shape = missileshape} )
				missile66.isBullet = true
				missile66.isSensor = true
				missile66.name = "missile66"
				behindgroup:insert(missile66)

				transition.moveTo(missile66, {x = player.x - 200, y = missile66.y - 10, time = 3500, onComplete = function ( )
					missile66.y = missile66.y + 60
					missile66.name = "missile67"



					if player.isAlive == true then
						alert2appear()
						bombGroup:insert(missile66)
						missile66.xScale = -0.07
						transition.moveTo(missile66, {x = cab.x + 900, time = 3450, onComplete =  function ( )
								
							
																		local options =
												{
													name = "splashburst",
													start = 1,
													count = 9,
													time = 400,
													loopCount = 1 -- Play just once and then stop.
												}
												audio.play(explosionfx)
												local explosionBurstSprite = display.newSprite( explosionBurstSpriteSheet, options )

												explosionBurstSprite.x = cab.x - 100
												explosionBurstSprite.y = cab.y + 10
												explosionBurstSprite.xScale = 1.6
												explosionBurstSprite.yScale = 1.3
												explosionBurstSprite:addEventListener( "sprite", spriteListenerGreenBurst )
												explosionBurstSprite:play()
												bombGroup:insert(explosionBurstSprite)
							display.remove(missile66)

						end})
					end
					
				end})
			end
		end 


		local function bokoharamattack( )
			if player.isAlive == true then
				Runtime:addEventListener("enterFrame", bokoattackstart)
				timer.performWithDelay(55600, bokoattackended,1)
				timer.performWithDelay(9500, bokoattackprojectile,5)
				timer.performWithDelay(9000, alertappear,5)

			end

		end 


		function damdam(  )
			if player.isAlive == true then
				audio.play(bossfx)
				audio.stop(backgroundchannel0)
			end
		end

		local function bokoharamattackstart( )
			if player.isAlive == true then
				cab.isVisible = true

				timer.performWithDelay(1200, damdam, 1)
				transition.moveTo(cab, {x = player.x + 2180, time = 6400, onComplete = function ( )
					playbosssong()
					transition.moveTo (cab, {x = cab.x + 600, y = 230, time = 1500, onComplete = function ( )
						
						controls11.isVisible = true
						controls12.isVisible = true
						bokoharamattack()					
					end})
					

				end})
			end
		end 
---------------------------------------------------------------------------------------------------------------------------








	-- load new backgrounds









	function loadbgs3( )

		if player.isAlive == true then
	
				layer55 = display.newImageRect( "h6.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
				layer55.anchorX = 0
				layer55.anchorY = 0
				layer55.x =  screenW *1.98 + layer54.x 
				layer55.y =   display.screenOriginY - 260

				local layer56 = display.newImageRect( "h3.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
				layer56.anchorX = 0
				layer56.anchorY = 0
				layer56.x =  screenW *1.98 + layer55.x 
				layer56.y =   display.screenOriginY - 260
				--layer2:setFillColor(0,0,0)

				local layer57 = display.newImageRect( "h3.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
				layer57.anchorX = 0
				layer57.anchorY = 0
				layer57.x =  screenW *1.98 + layer56.x 
				layer57.y =   display.screenOriginY - 260
				--layer2:setFillColor(0,0,0)	

				local layer58 = display.newImageRect( "h4.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
				layer58.anchorX = 0
				layer58.anchorY = 0
				layer58.x =  screenW *1.98 + layer57.x 
				layer58.y =   display.screenOriginY - 260
				--layer2:setFillColor(0,0,0)

				local layer59 = display.newImageRect( "h3.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
				layer59.anchorX = 0
				layer59.anchorY = 0
				layer59.x =  screenW *1.98 + layer58.x 
				layer59.y =   display.screenOriginY - 260
				--layer2:setFillColor(0,0,0)

				local layer60 = display.newImageRect( "h8.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
				layer60.anchorX = 0
				layer60.anchorY = 0
				layer60.x =  screenW *1.98 + layer59.x 
				layer60.y =   display.screenOriginY - 260
				--layer2:setFillColor(0,0,0)


				local layer61 = display.newImageRect( "h7.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
				layer61.anchorX = 0
				layer61.anchorY = 0
				layer61.x =  screenW *1.98 + layer60.x 
				layer61.y =   display.screenOriginY - 260
				--layer2:setFillColor(0,0,0)

				local layer62 = display.newImageRect( "h8.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
				layer62.anchorX = 0
				layer62.anchorY = 0
				layer62.x =  screenW *1.98 + layer61.x 
				layer62.y =   display.screenOriginY - 260
				--layer2:setFillColor(0,0,0)

				local layer63 = display.newImageRect( "h8.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
				layer63.anchorX = 0
				layer63.anchorY = 0
				layer63.x =  screenW *1.98 + layer62.x 
				layer63.y =   display.screenOriginY - 260
				--layer63:setFillColor(0,0,0)

				local layer64 = display.newImageRect( "h5.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
				layer64.anchorX = 0
				layer64.anchorY = 0
				layer64.x =  screenW *1.98 + layer63.x 
				layer64.y =   display.screenOriginY - 260
				--layer2:setFillColor(0,0,0)

				local layer65 = display.newImageRect( "h3.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
				layer65.anchorX = 0
				layer65.anchorY = 0
				layer65.x =  screenW *1.98 + layer64.x 
				layer65.y =   display.screenOriginY - 260
				--layer2:setFillColor(0,0,0)

				local layer66 = display.newImageRect( "h1.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
				layer66.anchorX = 0
				layer66.anchorY = 0
				layer66.x =  screenW *1.98 + layer65.x 
				layer66.y =   display.screenOriginY - 260
				--layer2:setFillColor(0,0,0)

				local layer67 = display.newImageRect( "h1.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
				layer67.anchorX = 0
				layer67.anchorY = 0
				layer67.x =  screenW *1.98 + layer66.x 
				layer67.y =   display.screenOriginY - 260
				--layer2:setFillColor(0,0,0)

				local layer68 = display.newImageRect( "h2.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
				layer68.anchorX = 0
				layer68.anchorY = 0
				layer68.x =  screenW *1.98 + layer67.x 
				layer68.y =   display.screenOriginY - 260
				--layer68:setFillColor(0,0,0)

				local layer69 = display.newImageRect( "h4.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
				layer69.anchorX = 0
				layer69.anchorY = 0
				layer69.x =  screenW *1.98 + layer68.x 
				layer69.y =   display.screenOriginY - 260
				--layer2:setFillColor(0,0,0)

				layer70 = display.newImageRect( "h3.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
				layer70.anchorX = 0
				layer70.anchorY = 0
				layer70.x =  screenW *1.98 + layer69.x 
				layer70.y =   display.screenOriginY - 260
				--layer2:setFillColor(0,0,0)

				BgGroup:insert(layer55)
				BgGroup:insert(layer56)
				BgGroup:insert(layer57)
				BgGroup:insert(layer58)
				BgGroup:insert(layer59)
				BgGroup:insert(layer60)
				BgGroup:insert(layer61)
				BgGroup:insert(layer62)
				BgGroup:insert(layer63)
				BgGroup:insert(layer64)
				BgGroup:insert(layer65)
				BgGroup:insert(layer66)
				BgGroup:insert(layer67)
				BgGroup:insert(layer68)
				BgGroup:insert(layer69)
				BgGroup:insert(layer70)
		end

	end






	function loadbgs2( )
	
	if player.isAlive == true then

			layer35 = display.newImageRect( "h6.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
			layer35.anchorX = 0
			layer35.anchorY = 0
			layer35.x =  screenW *1.98 + layer34.x 
			layer35.y =   display.screenOriginY - 260
			--layer2:setFillColor(0,0,0)

			local layer36 = display.newImageRect( "h2.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
			layer36.anchorX = 0
			layer36.anchorY = 0
			layer36.x =  screenW *1.98 + layer35.x 
			layer36.y =   display.screenOriginY - 260
			--layer2:setFillColor(0,0,0)

			local layer37 = display.newImageRect( "h4.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
			layer37.anchorX = 0
			layer37.anchorY = 0
			layer37.x =  screenW *1.98 + layer36.x 
			layer37.y =   display.screenOriginY - 260
			--layer2:setFillColor(0,0,0)	

			local layer38 = display.newImageRect( "h2.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
			layer38.anchorX = 0
			layer38.anchorY = 0
			layer38.x =  screenW *1.98 + layer37.x 
			layer38.y =   display.screenOriginY - 260
			--layer2:setFillColor(0,0,0)

			local layer39 = display.newImageRect( "h4.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
			layer39.anchorX = 0
			layer39.anchorY = 0
			layer39.x =  screenW *1.98 + layer38.x 
			layer39.y =   display.screenOriginY - 260
			--layer2:setFillColor(0,0,0)

			local layer40 = display.newImageRect( "h5.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
			layer40.anchorX = 0
			layer40.anchorY = 0
			layer40.x =  screenW *1.98 + layer39.x 
			layer40.y =   display.screenOriginY - 260
			--layer2:setFillColor(0,0,0)


			local layer41 = display.newImageRect( "h6.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
			layer41.anchorX = 0
			layer41.anchorY = 0
			layer41.x =  screenW *1.98 + layer40.x 
			layer41.y =   display.screenOriginY - 260
			--layer2:setFillColor(0,0,0)

			local layer42 = display.newImageRect( "h2.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
			layer42.anchorX = 0
			layer42.anchorY = 0
			layer42.x =  screenW *1.98 + layer41.x 
			layer42.y =   display.screenOriginY - 260
			--layer2:setFillColor(0,0,0)

			local layer43 = display.newImageRect( "h3.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
			layer43.anchorX = 0
			layer43.anchorY = 0
			layer43.x =  screenW *1.98 + layer42.x 
			layer43.y =   display.screenOriginY - 260
			--layer2:setFillColor(0,0,0)

			local layer44 = display.newImageRect( "h6.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
			layer44.anchorX = 0
			layer44.anchorY = 0
			layer44.x =  screenW *1.98 + layer43.x 
			layer44.y =   display.screenOriginY - 260
			--layer2:setFillColor(0,0,0)

			local layer45 = display.newImageRect( "h3.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
			layer45.anchorX = 0
			layer45.anchorY = 0
			layer45.x =  screenW *1.98 + layer44.x 
			layer45.y =   display.screenOriginY - 260
			--layer2:setFillColor(0,0,0)

			local layer46 = display.newImageRect( "h1.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
			layer46.anchorX = 0
			layer46.anchorY = 0
			layer46.x =  screenW *1.98 + layer45.x 
			layer46.y =   display.screenOriginY - 260
			--layer2:setFillColor(0,0,0)

			local layer47 = display.newImageRect( "h2.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
			layer47.anchorX = 0
			layer47.anchorY = 0
			layer47.x =  screenW *1.98 + layer46.x 
			layer47.y =   display.screenOriginY - 260
			--layer2:setFillColor(0,0,0)

			local layer48 = display.newImageRect( "h6.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
			layer48.anchorX = 0
			layer48.anchorY = 0
			layer48.x =  screenW *1.98 + layer47.x 
			layer48.y =   display.screenOriginY - 260
			--layer2:setFillColor(0,0,0)

			local layer49 = display.newImageRect( "h5.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
			layer49.anchorX = 0
			layer49.anchorY = 0
			layer49.x =  screenW *1.98 + layer48.x 
			layer49.y =   display.screenOriginY - 260
			--layer2:setFillColor(0,0,0)

			local layer50 = display.newImageRect( "h1.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
			layer50.anchorX = 0
			layer50.anchorY = 0
			layer50.x =  screenW *1.98 + layer49.x 
			layer50.y =   display.screenOriginY - 260
			--layer2:setFillColor(0,0,0)

			local layer51 = display.newImageRect( "h3.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5, true)
			layer51.anchorX = 0
			layer51.anchorY = 0
			layer51.x = screenW *1.98 + layer50.x
			layer51.y =   display.screenOriginY - 260


			

			local layer52 = display.newImageRect( "h6.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
			layer52.anchorX = 0
			layer52.anchorY = 0
			layer52.x =  screenW *1.98 + layer51.x 
			layer52.y =   display.screenOriginY - 260
			--layer2:setFillColor(0,0,0)

			local layer53 = display.newImageRect( "h5.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
			layer53.anchorX = 0
			layer53.anchorY = 0
			layer53.x =  screenW *1.98 + layer52.x 
			layer53.y =   display.screenOriginY - 260
			--layer2:setFillColor(0,0,0)

			layer54 = display.newImageRect( "h2.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
			layer54.anchorX = 0
			layer54.anchorY = 0
			layer54.x =  screenW *1.98 + layer53.x 
			layer54.y =   display.screenOriginY - 260
			--layer2:setFillColor(0,0,0)



			BgGroup:insert(layer35)
			BgGroup:insert(layer36)
			BgGroup:insert(layer37)
			BgGroup:insert(layer38)
			BgGroup:insert(layer39)
			BgGroup:insert(layer40)
			BgGroup:insert(layer41)
			BgGroup:insert(layer42)
			BgGroup:insert(layer43)
			BgGroup:insert(layer44)
			BgGroup:insert(layer45)
			BgGroup:insert(layer46)
			BgGroup:insert(layer47)
			BgGroup:insert(layer48)
			BgGroup:insert(layer49)
			BgGroup:insert(layer50)
			BgGroup:insert(layer51)
			BgGroup:insert(layer52)
			BgGroup:insert(layer53)
			BgGroup:insert(layer54)
		end
	end



	function loadbgs( )
	

		if player.isAlive == true then

				layer17 = display.newImageRect( "h6.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
				layer17.anchorX = 0
				layer17.anchorY = 0
				layer17.x =  screenW *1.98 + layer16.x 
				layer17.y =   display.screenOriginY - 260
				--layer2:setFillColor(0,0,0)

				layer18 = display.newImageRect( "h3.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
				layer18.anchorX = 0
				layer18.anchorY = 0
				layer18.x =  screenW *1.98 + layer17.x 
				layer18.y =   display.screenOriginY - 260
				--layer2:setFillColor(0,0,0)

				layer19 = display.newImageRect( "h2.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
				layer19.anchorX = 0
				layer19.anchorY = 0
				layer19.x =  screenW *1.98 + layer18.x 
				layer19.y =   display.screenOriginY - 260
				--layer2:setFillColor(0,0,0)

				layer20 = display.newImageRect( "h1.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
				layer20.anchorX = 0
				layer20.anchorY = 0
				layer20.x =  screenW *1.98 + layer19.x 
				layer20.y =   display.screenOriginY - 260
				--layer2:setFillColor(0,0,0)

				layer21 = display.newImageRect( "h5.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
				layer21.anchorX = 0
				layer21.anchorY = 0
				layer21.x =  screenW *1.98 + layer20.x 
				layer21.y =   display.screenOriginY - 260
				--layer2:setFillColor(0,0,0)

				local layer22 = display.newImageRect( "h6.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
				layer22.anchorX = 0
				layer22.anchorY = 0
				layer22.x =  screenW *1.98 + layer21.x 
				layer22.y =   display.screenOriginY - 260
				--layer2:setFillColor(0,0,0)

				local layer23 = display.newImageRect( "h2.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
				layer23.anchorX = 0
				layer23.anchorY = 0
				layer23.x =  screenW *1.98 + layer22.x 
				layer23.y =   display.screenOriginY - 260
				--layer2:setFillColor(0,0,0)

				local layer24 = display.newImageRect( "h3.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
				layer24.anchorX = 0
				layer24.anchorY = 0
				layer24.x =  screenW *1.98 + layer23.x 
				layer24.y =   display.screenOriginY - 260
				--layer2:setFillColor(0,0,0)

				local layer25 = display.newImageRect( "h4.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
				layer25.anchorX = 0
				layer25.anchorY = 0
				layer25.x =  screenW *1.98 + layer24.x 
				layer25.y =   display.screenOriginY - 260
				--layer2:setFillColor(0,0,0)

				local layer26 = display.newImageRect( "h5.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
				layer26.anchorX = 0
				layer26.anchorY = 0
				layer26.x =  screenW *1.98 + layer25.x 
				layer26.y =   display.screenOriginY - 260
				--layer2:setFillColor(0,0,0)

				local layer27 = display.newImageRect( "h6.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
				layer27.anchorX = 0
				layer27.anchorY = 0
				layer27.x =  screenW *1.98 + layer26.x 
				layer27.y =   display.screenOriginY - 260
				--layer2:setFillColor(0,0,0)

				local layer28 = display.newImageRect( "h2.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
				layer28.anchorX = 0
				layer28.anchorY = 0
				layer28.x =  screenW *1.98 + layer27.x 
				layer28.y =   display.screenOriginY - 260
				--layer2:setFillColor(0,0,0)

				local layer29 = display.newImageRect( "h1.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
				layer29.anchorX = 0
				layer29.anchorY = 0
				layer29.x =  screenW *1.98 + layer28.x 
				layer29.y =   display.screenOriginY - 260
				--layer2:setFillColor(0,0,0)

				local layer30 = display.newImageRect( "h6.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
				layer30.anchorX = 0
				layer30.anchorY = 0
				layer30.x =  screenW *1.98 + layer29.x 
				layer30.y =   display.screenOriginY - 260
				--layer2:setFillColor(0,0,0)

				local layer31 = display.newImageRect( "h2.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5, true)
				layer31.anchorX = 0
				layer31.anchorY = 0
				layer31.x = screenW *1.98 + layer30.x
				layer31.y =   display.screenOriginY - 260


				local layer32 = display.newImageRect( "h3.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
				layer32.anchorX = 0
				layer32.anchorY = 0
				layer32.x =  screenW *1.98 + layer31.x 
				layer32.y =   display.screenOriginY - 260
				--layer2:setFillColor(0,0,0)

				local layer33 = display.newImageRect( "h4.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
				layer33.anchorX = 0
				layer33.anchorY = 0
				layer33.x =  screenW *1.98 + layer32.x 
				layer33.y =   display.screenOriginY - 260
				--layer2:setFillColor(0,0,0)

				layer34 = display.newImageRect( "h5.png", display.actualContentWidth * 2,display.actualContentHeight * 2.5 , true)
				layer34.anchorX = 0
				layer34.anchorY = 0
				layer34.x =  screenW *1.98 + layer33.x 
				layer34.y =   display.screenOriginY - 260
				--layer2:setFillColor(0,0,0)

				

				BgGroup:insert(layer17)
				BgGroup:insert(layer18)
				BgGroup:insert(layer19)
				BgGroup:insert(layer20)
				BgGroup:insert(layer21)
				BgGroup:insert(layer22)
				BgGroup:insert(layer23)
				BgGroup:insert(layer24)
				BgGroup:insert(layer25)
				BgGroup:insert(layer26)
				BgGroup:insert(layer27)
				BgGroup:insert(layer28)
				BgGroup:insert(layer29)
				BgGroup:insert(layer30)
				BgGroup:insert(layer31)
				BgGroup:insert(layer32)
				BgGroup:insert(layer33)
				BgGroup:insert(layer34)
		end

	end





 		local barrier = display.newRect( player.x - halfW - 50, player.y - 1000,200, 200)
	    physics.addBody( barrier, "static" )
	    barrier.isVisible = false
	    bombGroup:insert(barrier)

 		local barrier2 = display.newRect( player.x + halfW + 50, player.y - 1000,200, 200)
	    physics.addBody( barrier2, "static",{ density = 40, friction = 30} )
	    barrier2.isVisible = false
	    bombGroup:insert(barrier2)


-- player death
function backmenu( )
	print("dead")
	composer.gotoScene( "selectionpage", "fade", 500 )
end


--------------------------------------------------------------------------------------------
function youlose( )
		audio.play(failfx)
		audio.play(failfx2)
		transition.fadeIn( youlosegrap, {time = 500} )
		display.remove(player)	
end





 function batdeath( )
 	timer.performWithDelay(8000, backmenu, 1)
  	timer.performWithDelay(500, youlose, 1)	
 	player:setSequence("cry")
	player:play()
	audio.stopWithDelay( 470, { channel=backgroundchannel1 }  )
	audio.stopWithDelay( 470, { channel=backgroundchannel0 }  )
 end
-----------------------------------------------------------------------------------------------------




------------------------------------------------------------------------------------------------------
--boss battle 1


function removebug( )
	if player.isAlive == true then
		player.canrun = true
	end

end

--end attack
function endbossbattle(  )
	if player.isAlive == true then
		player:setSequence("idle")
		audio.stop(backgroundchannel1)
		audio.play(backgroundMusic, { channel=16, loops=-1})
		audio.setVolume( 1, { channel=16 } )
		player:play()
		player.canrun = false
		boss.isDone = false
		loadbgs()
		controls21:removeEventListener("touch", docontrolstouch20)
		controls22:removeEventListener("touch", docontrolstouch21)
		timer.performWithDelay(300, loadbgs2, 1)
		timer.performWithDelay(450, loadbgs3, 1)
		player.xScale = 0.3
		transition.moveTo(boss, { y = boss.y - 500, time = 3000, onComplete = function ( )
		
					display.remove(boss)
			 	transition.to(barrier2, {y = -2220 , time = 500, onComplete = function ( )
 		
				 	end})

				 	transition.to(barrier, { y = 2220 , time = 500, onComplete = function ( )
				 			controls11.isVisible = true
				 			controls12.isVisible = true		
							controls21.isVisible = false
							controls22.isVisible = false
							
				 			player.xScale = 0.3
				 			player:setSequence("run")
							player:play()
							playermovement =  4.5
							player.isRunning = true
				 			Runtime:addEventListener("enterFrame", moving)
				 			timer.performWithDelay(4000, removebug, 1)

				 	end})
		end})
	end
end

--boss starts dropping bombs
function dropbomb4(  )
	if player.isAlive == true then
				missile2 = display.newImageRect("missile.png", 30, 30)
				missile2.x, missile2.y = boss.x, boss.y 
				physics.addBody( missile2, "dynamic" )
				missile2.name = "missile2"
				missile.gravityScale = 0
				missile2.isSensor = true
				mainGroup:insert(missile2)

				transition.moveTo(missile2, { y = player.y + 30, time = 600, onComplete = function ( )
											audio.play(explosionfx)
																					local options =
											{
												name = "splashburst",
												start = 1,
												count = 9,
												time = 400,
												loopCount = 1 -- Play just once and then stop.
											}

											local explosionBurstSprite = display.newSprite( explosionBurstSpriteSheet, options )

											explosionBurstSprite.x = missile2.x 
											explosionBurstSprite.y = missile2.y -10
											explosionBurstSprite.xScale = 1.6
											explosionBurstSprite.yScale = 1.3
											explosionBurstSprite:addEventListener( "sprite", spriteListenerGreenBurst )
											explosionBurstSprite:play()
											bombGroup:insert(explosionBurstSprite)
					display.remove(missile2)
				end})
	end
				
end

function dropbomb3(  )
	if player.isAlive == true then
				missile = display.newImageRect("missile.png", 30, 30)
				missile.x, missile.y = boss.x, boss.y 
				physics.addBody( missile, "dynamic" )
				missile.name = "missile"
				missile.gravityScale = 0
				missile.isSensor = true
				mainGroup:insert(missile)

				transition.moveTo(missile, { y = player.y + 30, time = 700, onComplete = function ( )
							audio.play(explosionfx)
																local options =
											{
												name = "splashburst",
												start = 1,
												count = 9,
												time = 400,
												loopCount = 1 -- Play just once and then stop.
											}

											local explosionBurstSprite = display.newSprite( explosionBurstSpriteSheet, options )

											explosionBurstSprite.x = missile.x 
											explosionBurstSprite.y = missile.y - 10
											explosionBurstSprite.xScale = 1.6
											explosionBurstSprite.yScale = 1.3
											explosionBurstSprite:addEventListener( "sprite", spriteListenerGreenBurst )
											explosionBurstSprite:play()
											bombGroup:insert(explosionBurstSprite)
					display.remove(missile)
				end})
				timer.performWithDelay(700, dropbomb4, 1)
	end
				
end

function dropbomb2( )
	if player.isAlive == true then
			transition.moveTo(boss, {x = boss.x - 1000, time = 3500, onComplete = function ( )
				timer.performWithDelay(500, dropbomb, 1)
				boss.xScale = -1

			end})
	end
end

function dropbomb( )
	if player.isAlive == true then
		if boss.isDone == true then
			transition.moveTo(boss, {x = boss.x + 1000, time = 3900, onComplete = function ( )
				boss.xScale = 1
				timer.performWithDelay(500, dropbomb2, 1)
			end})
		end
	end
end


--camera returns to player
 function returnback( )
 	if player.isAlive == true then
 			transition.moveTo(realplayer, {x = player.x - 30, time = 2200, onComplete = function ( )
 			
			controls21.isVisible = true
 			controls22.isVisible = true
 			controls21:addEventListener("touch", docontrolstouch20)
			controls22:addEventListener("touch", docontrolstouch21)
		end})

 			transition.moveTo(boss, {x = player.x, time = 3200, onComplete = function ( )

 				transition.moveTo(boss, {x = boss.x - 500, time = 1700, onComplete = function ( )
 					boss.xScale = -1
 					dropbomb()
 					timer.performWithDelay(2200, dropbomb3, 15)
 					timer.performWithDelay(37300, endbossbattle, 1)

 				end})
 			end})
 	end
 end


--boss is shown
function bossappear( )
	timer.performWithDelay(1200, damdam, 1)
	transition.moveTo(realplayer, { x = boss.x, time = 2500, onComplete = function ( )

		timer.performWithDelay(500, returnback, 1)
		 playbosssong()
		
	end})
end


--barriers are placed
 function bossbattlestart( )
 	Runtime:removeEventListener("enterFrame", moving)
 	timer.performWithDelay(1500, bossappear, 1)
 	transition.to(barrier2, {x = player.x + halfW + 210, y = 220 , time = 500, onComplete = function ( )
 		
 	end})

 	transition.to(barrier, {x = player.x - halfW - 50, y = 220 , time = 500, onComplete = function ( )
 			controls11.isVisible = false
 			controls12.isVisible = false		


 	end})


 	transition.moveTo(player, {x = player.x + 100, time = 1200, onComplete = function ( )
 		player.isRunning = false
 		player:setSequence("idle")
		player:play()
 	end})
 end
---------------------------------------------------------------------------------------------------------------------------









		local endgamecollider = display.newRect(68500, 200 ,200, 400)
	    physics.addBody( endgamecollider, "static" )
		endgamecollider.isSensor = true
		endgamecollider.name = "endgamecollider"
		endgamecollider.isVisible = false


		local limo = display.newImageRect("limo.png", 500, 300)
		limo.x, limo.y = endgamecollider.x + 60, 220 
		mainGroup:insert(limo)

		local limo2 = display.newImageRect("whyte.png", 500, 300)
		limo2.x, limo2.y = endgamecollider.x - 350, 220 
		mainGroup:insert(limo2)


	local lootsprite = graphics.newImageSheet( "moneybag.png", { width = 500, height = 400, numFrames = 2} )
		local lootsequence =

{

				{ name="idle", sheet=loot, start=1, count=2,time = 500, loopcount = 0 },


}
		loot = display.newSprite(lootsprite, lootsequence)
		loot.x, loot.y = limo.x + 100, 220
		loot.xScale = 0.14
		loot.yScale = 0.14
		loot:setSequence("idle")
		loot:play()
		mainGroup:insert(loot)

		loot2 = display.newSprite(lootsprite, lootsequence)
		loot2.x, loot2.y = limo.x + 150, 220
		loot2.xScale = 0.14
		loot2.yScale = 0.14
		loot2:setSequence("idle")
		loot2:play()
		mainGroup:insert(loot2)

		loot3 = display.newSprite(lootsprite, lootsequence)
		loot3.x, loot3.y = limo.x + 50, 220
		loot3.xScale = 0.14
		loot3.yScale = 0.14
		loot3:setSequence("idle")
		loot3:play()
		mainGroup:insert(loot3)

		local jet = display.newImageRect("jet.png", 600, 550)
		jet.x, jet.y = endgamecollider.x + 2000, -170 
		mainGroup:insert(jet)





		--timer.performWithDelay(3000,jetlanding, 1)
----------------------------------------------------------



function killboko( )
	if player.isAlive == true then
		updatepositions2()
		player:setSequence("idle")
		player:play()

		audio.stop(backgroundchannel1)
		audio.play(backgroundMusic, { channel=16, loops=-1})
		audio.setVolume( 1, { channel=16 } )
						player.canrun = false
						boss2.isDone = false
						controls21:removeEventListener("touch", docontrolstouch20)
						controls22:removeEventListener("touch", docontrolstouch21)
						controls11:removeEventListener("touch", slide2)
						controls11:addEventListener("touch", slide)
						player.xScale = 0.3
						
							 	transition.to(barrier2, {y = -2220 , time = 500, onComplete = function ( )
				 		

								 	transition.to(barrier, { y = 2220 , time = 500, onComplete = function ( )
								 			controls11.y = controls21.y
								 			controls11.isVisible = true
								 			controls12.isVisible = true		
											controls21.isVisible = false
											controls22.isVisible = false
											
								 			player.xScale = 0.3
								 			player:setSequence("run")
											player:play()
											playermovement =  4.5
											player.isRunning = true
								 			Runtime:addEventListener("enterFrame", moving)
								 			--timer.performWithDelay(100, removebug, 1)
								 			--timer.performWithDelay(1000, removebug2, 1)

								 	end})
						end})
		end		
	end

function destroyedall( )
	if player.isAlive == true then
		timer.performWithDelay(1100, killboko, 1)
	end
end


function killedthem( )
	if player.isAlive == true then
				boss2.isDone = false
				boss2.xScale = 1
				transition.moveTo(boss2, {x = boss.x - 400, time = 1500, onComplete = function ( )

						
								destroyedall()
								
							end})
	end
end

--boss2 starts dropping bombs


function dropbomb300(  )
	if player.isAlive == true then
				missile = display.newImageRect("missile.png", 30, 30)
				missile.x, missile.y = boss2.x, boss2.y 
				physics.addBody( missile, "dynamic" )
				missile.name = "missile"
				missile.gravityScale = 0
				missile.isSensor = true
				mainGroup:insert(missile)

				transition.moveTo(missile, { y = player.y + 30, time = 700, onComplete = function ( )
							audio.play(explosionfx)
																local options =
											{
												name = "splashburst",
												start = 1,
												count = 9,
												time = 400,
												loopCount = 1 -- Play just once and then stop.
											}

											local explosionBurstSprite = display.newSprite( explosionBurstSpriteSheet, options )

											explosionBurstSprite.x = missile.x 
											explosionBurstSprite.y = missile.y - 10
											explosionBurstSprite.xScale = 1.6
											explosionBurstSprite.yScale = 1.3
											explosionBurstSprite:addEventListener( "sprite", spriteListenerGreenBurst )
											explosionBurstSprite:play()
											bombGroup:insert(explosionBurstSprite)
					display.remove(missile)
				end})
				
	end
				
end

function dropbomb200( )
	if player.isAlive == true then
		if boss2.isDone == true then
				boss2.xScale = 1
				transition.moveTo(boss2, {x = barrier.x, time = 3500, onComplete = function ( )
					timer.performWithDelay(500, dropbomb100, 1)
				end})
		end
	end
end

function dropbomb100( )
	if player.isAlive == true then
		if boss2.isDone == true then
			boss2.xScale = -1
			transition.moveTo(boss2, {x = barrier2.x, time = 3900, onComplete = function ( )
				timer.performWithDelay(500, dropbomb200, 1)
			end})
		end
	end
end

function lastboko(  )
				if player.isAlive == true then
				audio.play(explosionfx)

					local options =
											{
												name = "splashburst",
												start = 1,
												count = 3,
												time = 500,
												loopCount = 1 -- Play just once and then stop.
											}

											local explosionBurstSprite = display.newSprite( bokocueBurstSpriteSheet, options )

											explosionBurstSprite.x = cab.x - 200 
											explosionBurstSprite.y = cab.y - 100 
											explosionBurstSprite.xScale = 1.3
											explosionBurstSprite.yScale = 1.1
											explosionBurstSprite:addEventListener( "sprite", spriteListenerGreenBurst )
											explosionBurstSprite:play()
											bombGroup:insert(explosionBurstSprite)


				local missilesprite = graphics.newImageSheet( "missilebomb.png", { width = 1388, height = 322, numFrames = 2} )

					local missilesequence =

			{

							{ name="shot", sheet=missilesprite, start=1, count=2,time = 400, loopcount = 0 },


			}



		local missileshape = { -58,-2, 15,-5, 15,6, -58,5 }

				missile66 = display.newSprite(missilesprite, missilesequence)
				missile66.x, missile66.y = cab.x - 150, cab.y - 20
				missile66.xScale, missile66.yScale = 0.07, 0.067
				missile66:setSequence("shot")
				missile66:play()
				physics.addBody( missile66, "static", {shape = missileshape} )
				missile66.isBullet = true
				missile66.isSensor = true
				missile66.name = "missile66"
				behindgroup:insert(missile66)

				transition.moveTo(missile66, {x = player.x - 500, time = 4000, onComplete = function ( )
					display.remove(missile66)
					
				end})
			end
end




function startwar( )
	timer.performWithDelay(1000, dropbomb100, 1)
	timer.performWithDelay(2800, dropbomb300, 20)
	timer.performWithDelay(6000, lastboko, 10)
	timer.performWithDelay(68000, killedthem, 1)


end


function nxtrig(  )
		transition.moveTo(realplayer, {x = player.x + 150, time = 2500})
			controls11:addEventListener("touch", slide2)

		transition.moveTo(cab, {x = player.x + 300, time = 3000, onComplete = function ( )
			transition.moveTo(cab, {y = cab.y + 20, x = cab.x + 250, time = 1900, onComplete = function (  )
			controls21.isVisible = true
 			controls22.isVisible = true
 			controls11.y = controls22.y - 90
 			controls11.isVisible = true
 			controls21:addEventListener("touch", docontrolstouch20)
			controls22:addEventListener("touch", docontrolstouch21)
			startwar()
			end})
		end})
end

function bokorevealation( )
	transition.moveTo(realplayer, {x = cab.x , time = 3500, onComplete = function ( )
		controls11:removeEventListener("touch", slide)

		timer.performWithDelay(500, nxtrig, 1)
	end})
end

--boss2 is shown
function boss2appear( )
	timer.performWithDelay(1200, damdam, 1)
	transition.moveTo(realplayer, { x = boss2.x, time = 2500, onComplete = function ( )
		playbosssong()
		timer.performWithDelay(500, bokorevealation, 1)
		cab.isVisible = true
 			transition.moveTo(boss2, {x = player.x, time = 3200, onComplete = function ( )
 				transition.moveTo(boss2, {x = barrier.x , time = 3500})
 			end})
		
	end})
end


--barriers are placed
 function boss2battlestart( )
 	Runtime:removeEventListener("enterFrame", moving)
 	cab:setSequence("ride")
 	cab:play()
 	cab.x, cab.y = boss2.x - 2000, 200
 	timer.performWithDelay(1500, boss2appear, 1)
 	transition.to(barrier2, {x = player.x + halfW + 370, y = 220 , time = 500, onComplete = function ( )
 		
 	end})

 	transition.to(barrier, {x = player.x - halfW + 100, y = 220 , time = 500, onComplete = function ( )
 			controls11.isVisible = false
 			controls12.isVisible = false	
 			barrier2.name = "deadlybarrier"	


 	end})


 	transition.moveTo(player, {x = player.x + 100, time = 1200, onComplete = function ( )
 		player.isRunning = false
 		player:setSequence("idle")
		player:play()
 	end})
 end
---------------------------------------------------------------------------------------------------------------------------









---------------------------------------------







-----------------------------------------------------------------------------



--boss battle 2

--end attack
function endboss3battle(  )
	if player.isAlive == true then
		player:setSequence("idle")
		player:play()
		player.canrun = false
		boss3.isDone = false
		reloadobstacles2()
		loadbgs3()
		audio.stop(backgroundchannel1)
		audio.play(backgroundMusic, { channel=16, loops=-1})
		audio.setVolume( 1, { channel=16 } )
		updatepositions0()
		controls21:removeEventListener("touch", docontrolstouch20)
		controls22:removeEventListener("touch", docontrolstouch21)
		player.xScale = 0.3
		transition.moveTo(boss3, { y = boss3.y - 500, time = 3000, onComplete = function ( )
			display.remove(boss3)
			 	transition.to(barrier2, {y = -2220 , time = 500, onComplete = function ( )
 		
				 	end})

				 	transition.to(barrier, { y = 2220 , time = 500, onComplete = function ( )
				 			controls11.isVisible = true
				 			controls12.isVisible = true		
				 			controls21.isVisible = false
				 			controls22.isVisible = false
				 			player.xScale = 0.3
				 			player:setSequence("run")
							player:play()
							playermovement =  4.5
							player.isRunning = true
							timer.performWithDelay(4000, removebug, 1)
				 			Runtime:addEventListener("enterFrame", moving)

				 	end})
		end})
	end
end

--boss2 starts dropping bombs


function fallingbomb( )
	if player.isAlive == true then
		transition.moveTo(missile, {y = player.y + 30, time = 200, onComplete = function ( )
			audio.play(explosionfx)
																	local options =
												{
													name = "splashburst",
													start = 1,
													count = 9,
													time = 400,
													loopCount = 1 -- Play just once and then stop.
												}

												local explosionBurstSprite = display.newSprite( explosionBurstSpriteSheet, options )

												explosionBurstSprite.x = missile.x 
												explosionBurstSprite.y = missile.y - 10
												explosionBurstSprite.xScale = 1.6
												explosionBurstSprite.yScale = 1.3
												explosionBurstSprite:addEventListener( "sprite", spriteListenerGreenBurst )
												explosionBurstSprite:play()
												bombGroup:insert(explosionBurstSprite)
						display.remove(missile)
		end})
		transition.moveTo(missile2, {y = player.y + 30, time = 200, onComplete = function ( )
			audio.play(explosionfx)
																	local options =
												{
													name = "splashburst",
													start = 1,
													count = 9,
													time = 400,
													loopCount = 1 -- Play just once and then stop.
												}

												local explosionBurstSprite = display.newSprite( explosionBurstSpriteSheet, options )

												explosionBurstSprite.x = missile2.x 
												explosionBurstSprite.y = missile2.y - 10
												explosionBurstSprite.xScale = 1.6
												explosionBurstSprite.yScale = 1.3
												explosionBurstSprite:addEventListener( "sprite", spriteListenerGreenBurst )
												explosionBurstSprite:play()
												bombGroup:insert(explosionBurstSprite)
						display.remove(missile2)
		end})
		transition.moveTo(missile3, {y = player.y + 30, time = 200, onComplete = function ( )
			audio.play(explosionfx)
																	local options =
												{
													name = "splashburst",
													start = 1,
													count = 9,
													time = 400,
													loopCount = 1 -- Play just once and then stop.
												}

												local explosionBurstSprite = display.newSprite( explosionBurstSpriteSheet, options )

												explosionBurstSprite.x = missile3.x 
												explosionBurstSprite.y = missile3.y - 10
												explosionBurstSprite.xScale = 1.6
												explosionBurstSprite.yScale = 1.3
												explosionBurstSprite:addEventListener( "sprite", spriteListenerGreenBurst )
												explosionBurstSprite:play()
												bombGroup:insert(explosionBurstSprite)
						display.remove(missile3)
		end})
		transition.moveTo(missile4, {y = player.y + 30, time = 200, onComplete = function (  )
			audio.play(explosionfx)
																	local options =
												{
													name = "splashburst",
													start = 1,
													count = 9,
													time = 400,
													loopCount = 1 -- Play just once and then stop.
												}

												local explosionBurstSprite = display.newSprite( explosionBurstSpriteSheet, options )

												explosionBurstSprite.x = missile4.x 
												explosionBurstSprite.y = missile4.y - 10
												explosionBurstSprite.xScale = 1.6
												explosionBurstSprite.yScale = 1.3
												explosionBurstSprite:addEventListener( "sprite", spriteListenerGreenBurst )
												explosionBurstSprite:play()
												bombGroup:insert(explosionBurstSprite)
						display.remove(missile4)
		end})
	end

end





function fallingbomb2(  )
	if player.isAlive == true then
			transition.moveTo(missile, {y = player.y + 30, time = 200, onComplete = function ( )
		audio.play(explosionfx)
																local options =
											{
												name = "splashburst",
												start = 1,
												count = 9,
												time = 400,
												loopCount = 1 -- Play just once and then stop.
											}

											local explosionBurstSprite = display.newSprite( explosionBurstSpriteSheet, options )

											explosionBurstSprite.x = missile.x 
											explosionBurstSprite.y = missile.y - 10
											explosionBurstSprite.xScale = 1.6
											explosionBurstSprite.yScale = 1.3
											explosionBurstSprite:addEventListener( "sprite", spriteListenerGreenBurst )
											explosionBurstSprite:play()
											bombGroup:insert(explosionBurstSprite)
					display.remove(missile)
	end})
	end
end








function lastattack( )
	if player.isAlive == true then
				missile = display.newImageRect("missile.png", 30, 30)
				missile.x, missile.y = boss3.x, boss3.y + 20 
				physics.addBody( missile, "dynamic" )
				missile.name = "missile"
				missile.gravityScale = 0
				missile.isSensor = true
				mainGroup:insert(missile)

				transition.moveTo(missile, { x = player.x, time = 300, onComplete = function ( )
					timer.performWithDelay(500, fallingbomb2, 1)
				end})
	end
end




function nextattackseq( )
	if player.isAlive == true then
		
		transition.moveTo(boss3, {x = boss3.x - 900, time = 2800, onComplete = function (  )
			boss3.xScale = -1
			transition.moveTo(boss3, {x = boss3.x + 400, time = 1500, onComplete = function ( )
				attack.number = math.random(1,2)

			end})

			timer.performWithDelay(2200, lastattack, 10 )
			timer.performWithDelay(25000, endboss3battle, 1)
		end})
	end
end





function dropbomb35(  )
	if player.isAlive == true then
				missile = display.newImageRect("missile.png", 30, 30)
				missile.x, missile.y = boss3.x, boss3.y +20
				physics.addBody( missile, "dynamic" )
				missile.name = "missile"
				missile.gravityScale = 0
				missile.isSensor = true
				mainGroup:insert(missile)

				missile2 = display.newImageRect("missile.png", 30, 30)
				missile2.x, missile2.y = boss3.x, boss3.y +20
				physics.addBody( missile2, "dynamic" )
				missile2.name = "missile2"
				missile2.gravityScale = 0
				missile2.isSensor = true
				mainGroup:insert(missile2)

				missile3 = display.newImageRect("missile.png", 30, 30)
				missile3.x, missile3.y = boss3.x, boss3.y + 20
				physics.addBody( missile3, "dynamic" )
				missile3.name = "missile3"
				missile3.gravityScale = 0
				missile3.isSensor = true
				mainGroup:insert(missile3)


				missile4 = display.newImageRect("missile.png", 30, 30)
				missile4.x, missile4.y = boss3.x, boss3.y +20
				physics.addBody( missile4, "dynamic" )
				missile4.name = "missile4"
				missile4.gravityScale = 0
				missile4.isSensor = true
				mainGroup:insert(missile4)

				transition.moveTo(missile, { x = boss3.x - 500, time = 1000, onComplete = function ( )
					timer.performWithDelay(1900, fallingbomb, 1)
				end})

				transition.moveTo(missile2, { x = boss3.x - 200, time = 1000, onComplete = function ( )
					
				end})

				transition.moveTo(missile3, { x = boss3.x - 100, time = 1000, onComplete = function ( )
					
				end})

				transition.moveTo(missile4, { x = boss3.x - 350, time = 1000, onComplete = function ( )
					
				end})

				

				
	end
				
end


function dropbomb34(  )
	if player.isAlive == true then
				missile = display.newImageRect("missile.png", 30, 30)
				missile.x, missile.y = boss3.x, boss3.y + 20
				physics.addBody( missile, "dynamic" )
				missile.name = "missile"
				missile.gravityScale = 0
				missile.isSensor = true
				mainGroup:insert(missile)

				missile2 = display.newImageRect("missile.png", 30, 30)
				missile2.x, missile2.y = boss3.x, boss3.y + 20
				physics.addBody( missile2, "dynamic" )
				missile2.name = "missile2"
				missile2.gravityScale = 0
				missile2.isSensor = true
				mainGroup:insert(missile2)

				missile3 = display.newImageRect("missile.png", 30, 30)
				missile3.x, missile3.y = boss3.x, boss3.y + 20
				physics.addBody( missile3, "dynamic" )
				missile3.name = "missile3"
				missile3.gravityScale = 0
				missile3.isSensor = true
				mainGroup:insert(missile3)


				missile4 = display.newImageRect("missile.png", 30, 30)
				missile4.x, missile4.y = boss3.x, boss3.y + 20
				physics.addBody( missile4, "dynamic" )
				missile4.name = "missile4"
				missile4.gravityScale = 0
				missile4.isSensor = true
				mainGroup:insert(missile4)

				transition.moveTo(missile, { x = boss3.x - 500, time = 1000, onComplete = function ( )
					timer.performWithDelay(1900, fallingbomb, 1)
				end})

				transition.moveTo(missile2, { x = boss3.x - 250, time = 1000, onComplete = function ( )
					
				end})

				transition.moveTo(missile3, { x = boss3.x - 150, time = 1000, onComplete = function ( )
					
				end})

				transition.moveTo(missile4, { x = boss3.x - 50, time = 1000, onComplete = function ( )
					
				end})				
	end
				
end


function dropbomb33(  )
	if player.isAlive == true then
				missile = display.newImageRect("missile.png", 30, 30)
				missile.x, missile.y = boss3.x, boss3.y + 20
				physics.addBody( missile, "dynamic" )
				missile.name = "missile"
				missile.gravityScale = 0
				missile.isSensor = true
				mainGroup:insert(missile)

				missile2 = display.newImageRect("missile.png", 30, 30)
				missile2.x, missile2.y = boss3.x, boss3.y + 20
				physics.addBody( missile2, "dynamic" )
				missile2.name = "missile2"
				missile2.gravityScale = 0
				missile2.isSensor = true
				mainGroup:insert(missile2)

				missile3 = display.newImageRect("missile.png", 30, 30)
				missile3.x, missile3.y = boss3.x, boss3.y + 20
				physics.addBody( missile3, "dynamic" )
				missile3.name = "missile3"
				missile3.gravityScale = 0
				missile3.isSensor = true
				mainGroup:insert(missile3)


				missile4 = display.newImageRect("missile.png", 30, 30)
				missile4.x, missile4.y = boss3.x, boss3.y + 20
				physics.addBody( missile4, "dynamic" )
				missile4.name = "missile4"
				missile4.gravityScale = 0
				missile4.isSensor = true
				mainGroup:insert(missile4)

				transition.moveTo(missile, { x = boss3.x - 400, time = 1000, onComplete = function ( )
					timer.performWithDelay(1900, fallingbomb, 1)
				end})

				transition.moveTo(missile2, { x = boss3.x - 500, time = 1000, onComplete = function ( )
					
				end})

				transition.moveTo(missile3, { x = boss3.x - 250, time = 1000, onComplete = function ( )
					
				end})

				transition.moveTo(missile4, { x = boss3.x - 50, time = 1000, onComplete = function ( )
					
				end})				
	end
				
end


function startbombdroping( )
	if player.isAlive == true then
		if attack.number == 1 then
			attack.number = math.random(2,3)
			dropbomb33()



		elseif attack.number == 2 then
			attack.number = math.random(3, 4)
			dropbomb34()


		elseif attack.number == 3 then
			attack.number = math.random(1,2)
			dropbomb35()

		elseif attack.number == 4 then
			attack.number = math.random(2,3)
			dropbomb33()


		elseif attack.number == 5 then
			attack.number = math.random(3,4)
			dropbomb34()

		end 
	end
end

	attack = {}
	attack.number = math.random(1,5)
	


--camera returns to player
 function returnback3( )
 	if player.isAlive == true then
 			transition.moveTo(realplayer, {x = player.x - 30, time = 2200, onComplete = function ( )
			controls21.isVisible = true
 			controls22.isVisible = true
 			controls21:addEventListener("touch", docontrolstouch20)
			controls22:addEventListener("touch", docontrolstouch21)
		end})

 			transition.moveTo(boss3, {x = player.x + 200, time = 2500, onComplete = function ( )

 					timer.performWithDelay(3400, startbombdroping, 6)
 					
 					timer.performWithDelay(24000, nextattackseq, 1)

 			end})
 	end
 end


--boss2 is shown
function boss3appear( )
	timer.performWithDelay(1200, damdam, 1)
	transition.moveTo(realplayer, { x = boss3.x, time = 2500, onComplete = function ( )
		playbosssong()
		timer.performWithDelay(500, returnback3, 1)

		
	end})
end


--barriers are placed
 function boss3battlestart( )
 	Runtime:removeEventListener("enterFrame", moving)
 	timer.performWithDelay(1500, boss3appear, 1)
 	transition.to(barrier2, {x = player.x + halfW + 210, y = 220 , time = 500, onComplete = function ( )
 		
 	end})

 	transition.to(barrier, {x = player.x - halfW - 50, y = 220 , time = 500, onComplete = function ( )
 			controls11.isVisible = false
 			controls12.isVisible = false		


 	end})


 	transition.moveTo(player, {x = player.x + 100, time = 1200, onComplete = function ( )
 		player.isRunning = false
 		player:setSequence("idle")
		player:play()
 	end})
 end
---------------------------------------------------------------------------------------------------------------------------


function goasorock( )
	composer.gotoScene( "selectionpage", "fade", 500 )
end

function youwon( )
	transition.fadeIn( youwongrap, {time = 1500} )
	audio.play(victoryfx)
	timer.performWithDelay(14000, goasorock, 1)
end


function jetlanding(  )
			if player.isAlive == true then
				audio.play(drummerfx)
				player.isAlive = false
				controls12.isVisible = false
				controls11.isVisible = false
				Runtime:removeEventListener("enterFrame", moving)
				Runtime:removeEventListener("enterFrame", setherovelocity)

				transition.moveTo(realplayer, {x = jet.x, y = jet.y, time = 4500, onComplete = function ( )
					player:setSequence("dance")
					player:play()
					audio.play(planefx2)
					player:setSequence("dance")
					player:play()
					transition.moveTo( jet, { x = limo.x + 800, y = limo.y - 50, time = 4000})
					transition.moveTo( realplayer, { x = limo.x + 800, y = limo.y, time = 4000, onComplete = function ( )
						audio.play(planestopfx)
						transition.moveTo( jet, { x = limo.x + 350, y = limo.y - 50, time = 2050, transition=easing.inOutQuart})
						transition.moveTo( realplayer, { x = limo.x + 350, y = limo.y, time = 2100, transition=easing.inOutQuart, onComplete = function ( )
							transition.moveTo( realplayer, { x = player.x, y = limo.y, time = 2000, transition=easing.outSine, onComplete = function ( )
								timer.performWithDelay(4500, youwon, 1)
							end})
						end})
					end})
				end})
			end
			
end







function planeattack( )
	if player.isAlive == true then
		audio.play(planefx)

		transition.moveTo(plane, {x = plane.x - 2000, time = 6000, onComplete = function ( )
			--display.remove(plane)
		end})
	end
end




function runningsound( )
	if player.isAlive == true then
		if player.isRunning == true then
			audio.play(runfx, {channel = 6})
		print("runfx")
		end
	end
end

function playaudio( )
	if player.isAlive == true then
		audio.play(drivefx)
	end

end

function stopmoving(  )
	player:setSequence("idle")
	player:play()
	Runtime:removeEventListener("enterFrame", moving)
end



---------------------------------------------------------------------------------------------------------------------------
	local function playercollision( self, event )
				    --print( event.target.name )        --the first object in the collision


		if event.target.name == "player" and event.other.name == "cabcollider" then  
				if event.phase == "began" then
					if player.isAlive == true then
							controls12.isVisible = false
							controls11.isVisible = false
							print("collided")
							cab.isVisible = true
							display.remove(cabcollider)
							bokoharamattackstart()
					end
				end				  		
		end



		if event.target.name == "player" and event.other.name == "thiefnubu" then  
				if event.phase == "began" then
					if player.isAlive == true then

							player:setSequence("hyperrun")
								player:play()
								playermovement = 9
							
					end
				end		  		
		end


				if event.target.name == "player" and event.other.name == "grass" then  
					if event.phase == "began" then
						if player.isAlive == true then

							--timer.performWithDelay(10, runningsound, 0)
							
						end
					end		  		
				end


				if event.target.name == "player" and event.other.name == "bosscollider" then  
					if event.phase == "began" then
						if player.isAlive == true then
							print(player.x)
							
							
							bossbattlestart()
							display.remove(boss1collider)
							
						end
					end		  		
				end


				if event.target.name == "player" and event.other.name == "boss2collider" then  
					if event.phase == "began" then
						if player.isAlive == true then
							boss2battlestart()
							display.remove(boss2collider)
							
						end
					end		  		
				end


				if event.target.name == "player" and event.other.name == "boss3collider" then  
					if event.phase == "began" then
						if player.isAlive == true then
							boss3battlestart()
							display.remove(boss3collider)
							
						end
					end		  		
				end

				if event.target.name == "player" and event.other.name == "pickupcollider" then  
					if event.phase == "began" then
						if player.isAlive == true then
							display.remove(pickupcollider)
							pickup.isVisible = true
							timer.performWithDelay(1000, playaudio,1)
							
							transition.moveTo(pickup, {x = player.x + 8000, time = 14000, onComplete = function ( )
								if player.isAlive == true then
									display.remove(pickup)
								end
							end})
							
						end
					end		  		
				end


				if event.target.name == "player" and event.other.name == "votes" then  
					if event.phase == "began" then
						if player.isAlive == true then
							if player.isSliding == false then
								audio.play(votefx)
								transition.moveTo(votes, {xScale = 0.02, yScale = 0.02, y = - 200, time = 400, onComplete = function ( )
									votes.xScale, votes.yScale = 0.2, 0.2
									votes.x, votes.y = votes.x + math.random(4300, 4450), math.random(210, 220) 
								end})
							end	
						end
					end		  		
				end



				if event.target.name == "player" and event.other.name == "votes2" then  
					if event.phase == "began" then
						if player.isAlive == true then
								audio.play(votefx)
								transition.moveTo(votes2, {xScale = 0.02, yScale = 0.02, y = - 200, time = 500, onComplete = function ( )
									votes2.xScale, votes2.yScale = 0.2, 0.2
									votes2.x, votes2.y = votes2.x + math.random(4700, 4850), 240 
								end})
						end
					end		  		
				end


				if event.target.name == "player" and event.other.name == "votes3" then  
					if event.phase == "began" then
						if player.isAlive == true then
								audio.play(votefx)
								transition.moveTo(votes3, {xScale = 0.02, yScale = 0.02, y = - 200, time = 500, onComplete = function ( )
									votes3.xScale, votes3.yScale = 0.2, 0.2
									votes3.x, votes3.y = votes3.x + math.random(4800, 4930), 240 
								end})
						end
					end		  		
				end

				if event.target.name == "player" and event.other.name == "votes4" then  
					if event.phase == "began" then
						if player.isAlive == true then
								audio.play(votefx)
								transition.moveTo(votes4, {xScale = 0.02, yScale = 0.02, y = - 200, time = 500, onComplete = function ( )
									votes4.xScale, votes4.yScale = 0.2, 0.2
									votes4.x, votes4.y = votes4.x + math.random(4800, 4950), 240 
								end})
								
						end
					end		  		
				end


				if event.target.name == "player" and event.other.name == "votes5" then  
					if event.phase == "began" then
						if player.isAlive == true then
								audio.play(votefx)
								transition.moveTo(votes5, {xScale = 0.02, yScale = 0.02, y = - 200, time = 500, onComplete = function ( )
									votes5.xScale, votes5.yScale = 0.2, 0.2
									votes5.x, votes5.y = votes5.x + math.random(4800, 4950), 240 
								end})
						end
					end		  		
				end


				if event.target.name == "player" and event.other.name == "votes6" then  
					if event.phase == "began" then
						if player.isAlive == true then
								audio.play(votefx)
								transition.moveTo(votes6, {xScale = 0.02, yScale = 0.02, y = - 200, time = 500, onComplete = function ( )
									votes6.xScale, votes6.yScale = 0.2, 0.2
									votes6.x, votes6.y = votes6.x + math.random(4700, 4800), 230 
								end})
						end
					end		  		
				end


				if event.target.name == "player" and event.other.name == "votes7" then  
					if event.phase == "began" then
						if player.isAlive == true then
								audio.play(votefx)
								transition.moveTo(votes7, {xScale = 0.02, yScale = 0.02, y = - 200, time = 500, onComplete = function ( )
									votes7.xScale, votes7.yScale = 0.2, 0.2
									votes7.x, votes7.y = votes7.x + math.random(4700, 4800), math.random(230, 240) 
								end})
						end
					end		  		
				end


				if event.target.name == "player" and event.other.name == "votes8" then  
					if event.phase == "began" then
						if player.isAlive == true then
								audio.play(votefx)
								transition.moveTo(votes8, {xScale = 0.02, yScale = 0.02, y = - 200, time = 500, onComplete = function ( )
									votes8.xScale, votes8.yScale = 0.2, 0.2
									votes8.x, votes8.y = votes8.x + math.random(4600, 4700), math.random(235, 250) 
								end})
						end
					end		  		
				end

				if event.target.name == "player" and event.other.name == "votes9" then  
					if event.phase == "began" then
						if player.isAlive == true then
								audio.play(votefx)
								transition.moveTo(votes9, {xScale = 0.02, yScale = 0.02, y = - 200, time = 500, onComplete = function ( )
									votes9.xScale, votes9.yScale = 0.2, 0.2
									votes9.x, votes9.y = votes9.x + math.random(4800, 4900), math.random(235, 250) 
								end})
						end
					end		  		
				end

				if event.target.name == "player" and event.other.name == "votes10" then  
					if event.phase == "began" then
						if player.isAlive == true then
								audio.play(votefx)
								transition.moveTo(votes10, {xScale = 0.02, yScale = 0.02, y = - 200, time = 500, onComplete = function ( )
									votes10.xScale, votes10.yScale = 0.2, 0.2
									votes10.x, votes10.y = votes10.x + math.random(4900, 5000), math.random(235, 250) 
								end})
						end
					end		  		
				end


				if event.target.name == "player" and event.other.name == "votes11" then  
					if event.phase == "began" then
						if player.isAlive == true then
								audio.play(votefx)
								transition.moveTo(votes11, {xScale = 0.02, yScale = 0.02, y = - 200, time = 500, onComplete = function ( )
									votes11.xScale, votes11.yScale = 0.2, 0.2
									votes11.x, votes11.y = votes11.x + math.random(4900, 5000), math.random(235, 250) 
								end})
						end
					end		  		
				end


				if event.target.name == "player" and event.other.name == "tinubu" then  
					if event.phase == "began" then
						if player.isAlive == true then
							display.remove(tinubu)
							audio.play(runfx)
							audio.play(votefx)	
							controls22.isVisible = false
							controls21.isVisible = false
							controls11.isVisible = false
							controls12.isVisible = false
							transition.moveTo(player, {y = 250, time = 100, onComplete = function ( )
								transition.moveTo(player, {x = player.x +  6000, time = 7000, onComplete = function ( )
								player:setSequence("run")
								player:play()
								controls12.isVisible = true
								controls11.isVisible = true
								player.name = "player"
								planecollider.x = player.x + 1500
								plane.x = planecollider.x + 1000
								
							end})
							end })

							player.name = "invisible"
							player:setSequence("speed")
							player:play()	
						end
					end		  		
				end

	if event.target.name == "player" and event.other.name == "endgamecollider" then  
		if event.phase == "began" then
			if player.isAlive == true then
				audio.stopWithDelay( 3000, { channel=backgroundchannel0 }  )
				timer.performWithDelay(300, stopmoving, 1)
				timer.performWithDelay(2000, jetlanding, 1)	
			end
		end		  		
	end



				if event.target.name == "player" and event.other.name == "planecollider" then  
					if event.phase == "began" then
						if player.isAlive == true then
							timer.performWithDelay(600, planeattack,1)
							alert3appear()

							
							
						end
					end		  		
				end


				if event.target.name == "player" and event.other.name == "plane" then  
					if event.phase == "began" then
						if player.isAlive == true then
							if player.isSliding == false then
								player.isAlive = false
								audio.play(deathfx)
								player:setSequence("die")
								player:play()
								Runtime:removeEventListener("enterFrame", setherovelocity)
								Runtime:removeEventListener("enterFrame", moving)
								transition.moveTo(player, {x = player.x - 300, time = 1100, onComplete = function (  )
									timer.performWithDelay(210, batdeath, 1)
								end})
								
							end
							
						end
					end		  		
				end

				if event.target.name == "player" and event.other.name == "missile" then  
					if event.phase == "began" then
						if player.isAlive == true then
							if player.isSliding == false then
								audio.play(explosionfx)
								player.isRunning = false
								Runtime:removeEventListener("enterFrame", setherovelocity)
								player.isAlive = false
								display.remove(missile)
								Runtime:removeEventListener("enterFrame", moving)
								Runtime:removeEventListener("enterFrame", bokoattackstart)
								player:setSequence("die")
								player:play()
								audio.stopWithDelay( 470, { channel=backgroundchannel1 }  )
								audio.stopWithDelay( 470, { channel=backgroundchannel0 }  )
								timer.performWithDelay(310, batdeath, 1)
								
												local options =
												{
													name = "splashburst",
													start = 1,
													count = 9,
													time = 400,
													loopCount = 1 -- Play just once and then stop.
												}

												local explosionBurstSprite = display.newSprite( explosionBurstSpriteSheet, options )

												explosionBurstSprite.x = player.x 
												explosionBurstSprite.y = player.y 
												explosionBurstSprite.xScale = 1.6
												explosionBurstSprite.yScale = 1.3
												explosionBurstSprite:addEventListener( "sprite", spriteListenerGreenBurst )
												explosionBurstSprite:play()
												bombGroup:insert(explosionBurstSprite)
							end
							
						end
					end
				end

				if event.target.name == "player" and event.other.name == "missile67" then  
					if event.phase == "began" then
						if player.isAlive == true then
							if player.isSliding == false then
								audio.play(explosionfx)
								player.isRunning = false
								audio.stopWithDelay( 470, { channel=backgroundchannel1 }  )
								audio.stopWithDelay( 470, { channel=backgroundchannel0 }  )
								Runtime:removeEventListener("enterFrame", setherovelocity)
								player.isAlive = false
								display.remove(missile66)
								Runtime:removeEventListener("enterFrame", moving)
								Runtime:removeEventListener("enterFrame", bokoattackstart)
								player:setSequence("die")
								player:play()
								timer.performWithDelay(310, batdeath, 1)
								transition.moveTo(cab, {x = cab.x + 200, time = 1500})
												local options =
												{
													name = "splashburst",
													start = 1,
													count = 9,
													time = 400,
													loopCount = 1 -- Play just once and then stop.
												}

												local explosionBurstSprite = display.newSprite( explosionBurstSpriteSheet, options )

												explosionBurstSprite.x = player.x 
												explosionBurstSprite.y = player.y 
												explosionBurstSprite.xScale = 1.6
												explosionBurstSprite.yScale = 1.3
												explosionBurstSprite:addEventListener( "sprite", spriteListenerGreenBurst )
												explosionBurstSprite:play()
												bombGroup:insert(explosionBurstSprite)
							end
							
						end
					end
				end



				if event.target.name == "player" and event.other.name == "missile66" then  
					if event.phase == "began" then
						if player.isAlive == true then
							if player.isSliding == false then
								audio.play(explosionfx)
								player.isRunning = false
								Runtime:removeEventListener("enterFrame", setherovelocity)
								player.isAlive = false
								audio.stopWithDelay( 470, { channel=backgroundchannel1 }  )
								audio.stopWithDelay( 470, { channel=backgroundchannel0 }  )
								display.remove(missile66)
								Runtime:removeEventListener("enterFrame", moving)
								Runtime:removeEventListener("enterFrame", bokoattackstart)
								player:setSequence("die")
								player:play()
								timer.performWithDelay(310, batdeath, 1)
								transition.moveTo(cab, {x = cab.x + 200, time = 1500})
												local options =
												{
													name = "splashburst",
													start = 1,
													count = 9,
													time = 400,
													loopCount = 1 -- Play just once and then stop.
												}

												local explosionBurstSprite = display.newSprite( explosionBurstSpriteSheet, options )

												explosionBurstSprite.x = player.x 
												explosionBurstSprite.y = player.y 
												explosionBurstSprite.xScale = 1.6
												explosionBurstSprite.yScale = 1.3
												explosionBurstSprite:addEventListener( "sprite", spriteListenerGreenBurst )
												explosionBurstSprite:play()
												bombGroup:insert(explosionBurstSprite)
							end
							
						end
					end
				end

				if event.target.name == "player" and event.other.name == "deadlybarrier" then  
					if event.phase == "began" then
						if player.isAlive == true then
							player.isRunning = false
							Runtime:removeEventListener("enterFrame", setherovelocity)
							player.isAlive = false
							audio.stopWithDelay( 470, { channel=backgroundchannel1 }  )
							audio.stopWithDelay( 470, { channel=backgroundchannel0 }  )
							Runtime:removeEventListener("enterFrame", moving)
							player:setSequence("die")
							player:play()
							timer.performWithDelay(310, batdeath, 1)

							
						end
					end
				end

				if event.target.name == "player" and event.other.name == "missile3" then  
					if event.phase == "began" then
						if player.isAlive == true then
							audio.play(explosionfx)
							player.isRunning = false
							audio.stopWithDelay( 470, { channel=backgroundchannel1 }  )
								audio.stopWithDelay( 470, { channel=backgroundchannel0 }  )
							Runtime:removeEventListener("enterFrame", setherovelocity)
							player.isAlive = false
							display.remove(missile3)
							Runtime:removeEventListener("enterFrame", moving)
							player:setSequence("die")
							player:play()
							timer.performWithDelay(310, batdeath, 1)
											local options =
											{
												name = "splashburst",
												start = 1,
												count = 9,
												time = 400,
												loopCount = 2 -- Play just once and then stop.
											}

											local explosionBurstSprite = display.newSprite( explosionBurstSpriteSheet, options )

											explosionBurstSprite.x = player.x 
											explosionBurstSprite.y = player.y 
											explosionBurstSprite.xScale = 1.6
											explosionBurstSprite.yScale = 1.3
											explosionBurstSprite:addEventListener( "sprite", spriteListenerGreenBurst )
											explosionBurstSprite:play()
											bombGroup:insert(explosionBurstSprite)
							
						end
					end
				end


	if event.target.name == "player" and event.other.name == "missile4" then  
		if event.phase == "began" then
			if player.isAlive == true then
				audio.play(explosionfx)
					player.isRunning = false
					Runtime:removeEventListener("enterFrame", setherovelocity)
					player.isAlive = false
					audio.stopWithDelay( 470, { channel=backgroundchannel1 }  )
					audio.stopWithDelay( 470, { channel=backgroundchannel0 }  )
					display.remove(missile4)
					Runtime:removeEventListener("enterFrame", moving)
					player:setSequence("die")
					player:play()
					timer.performWithDelay(310, batdeath, 1)
								local options =
										{
											name = "splashburst",
											start = 1,
											count = 9,
											time = 400,
											loopCount = 2 -- Play just once and then stop.
										}

							local explosionBurstSprite = display.newSprite( explosionBurstSpriteSheet, options )
							explosionBurstSprite.x = player.x 
							explosionBurstSprite.y = player.y 
							explosionBurstSprite.xScale = 1.6
							explosionBurstSprite.yScale = 1.3
							explosionBurstSprite:addEventListener( "sprite", spriteListenerGreenBurst )
							explosionBurstSprite:play()
							bombGroup:insert(explosionBurstSprite)			
			end
		end
	end


				if event.target.name == "player" and event.other.name == "obstacle" then  
					if event.phase == "began" then
						if player.isAlive == true then
							audio.play(deathfx)
							player.isRunning = false
							Runtime:removeEventListener("enterFrame", setherovelocity)
							player.isAlive = false
							Runtime:removeEventListener("enterFrame", moving)
							player:setSequence("die")
							player:play()
							timer.performWithDelay(410, batdeath, 1)
								transition.moveTo(player, {x = player. x + 50, time = 290, onComplete = function (  )
									audio.play(deathfx2)
									transition.moveTo(player, {y = player.y + 250, time = 850})
								end  })				
						end
					end
				end



				if event.target.name == "player" and event.other.name == "missile2" then  
					if event.phase == "began" then
						if player.isAlive == true then
							audio.play(explosionfx)
							player.isRunning = false
							Runtime:removeEventListener("enterFrame", setherovelocity)
							player.isAlive = false
							audio.stopWithDelay( 470, { channel=backgroundchannel1 }  )
								audio.stopWithDelay( 470, { channel=backgroundchannel0 }  )
							display.remove(missile2)
							Runtime:removeEventListener("enterFrame", moving)
							player:setSequence("die")
							player:play()
							timer.performWithDelay(310, batdeath, 1)
											local options =
											{
												name = "splashburst",
												start = 1,
												count = 9,
												time = 400,
												loopCount = 2 -- Play just once and then stop.
											}

											local explosionBurstSprite = display.newSprite( explosionBurstSpriteSheet, options )

											explosionBurstSprite.x = player.x 
											explosionBurstSprite.y = player.y 
											explosionBurstSprite.xScale = 1.6
											explosionBurstSprite.yScale = 1.3
											explosionBurstSprite:addEventListener( "sprite", spriteListenerGreenBurst )
											explosionBurstSprite:play()
											bombGroup:insert(explosionBurstSprite)
								
						end
					end
				end

		end

				player.collision = playercollision
				player:addEventListener("collision", player)

	-- all display objects must be inserted into group
	BgGroup:insert(layer)
	BgGroup:insert(layer2)
	BgGroup:insert(layer3)
	BgGroup:insert(layer4)
	BgGroup:insert(layer5)
	BgGroup:insert(layer6)
	BgGroup:insert(layer7)
	BgGroup:insert(layer8)
	BgGroup:insert(layer9)
	BgGroup:insert(layer10)
	BgGroup:insert(layer11)
	BgGroup:insert(layer12)
	BgGroup:insert(layer13)
	BgGroup:insert(layer14)
	BgGroup:insert(layer15)
	BgGroup:insert(layer16)

	camera:add(alert0, 1, false)

	camera:add(alert, 1, false)
	camera:add(alert2, 1, false)

	camera:add(BgGroup, 7, false)
	camera:add(mainGroup, 5, false)
	camera:add(bombGroup, 1, false)

	camera:add(cab, 5, false)
	camera:add(cabcollider, 2, false)
	camera:add(player, 3, false)
	camera:add(plane, 3, false)
	camera:add(obstacle4, 4, false)
	camera:add(obstacle3, 4, false)
	camera:add(obstacle2, 4, false)
	camera:add(obstacle, 4, false)
	camera:add(obstacle5, 4, false)
	camera:add(obstacle6, 4, false)
	camera:add(obstacle7, 4, false)
	camera:add(obstacle8, 4, false)
	camera:add(obstacle9, 4, false)
	camera:add(obstacle10, 4, false)
	camera:add(obstacle11, 4, false)
	camera:add(obstacle12, 4, false)
	camera:add(obstacle13, 4, false)
	camera:add(obstacle14, 4, false)
	camera:add(obstacle15, 4, false)

	camera:add(behindgroup, 6, false)
	camera:add(youwongrap, 4, false)




	camera:add(realplayer, 3, true)
	camera:add(grass, 1, false)
	camera:add(background2, 8, false)
	camera:add(background22, 8, false)
	camera:add(background32, 8, false)
	camera:add(boss, 3, false)
	camera:add(boss2, 3, false)
	camera:add(boss2collider, 3, false)
	camera:add(boss1collider, 3, false)
	camera:add(boss3, 3, false)
	camera:add(boss3collider, 3, false)
	camera:add(tinubu, 2, false)
	camera:add(planecollider, 3, false)
	camera:add(pickup, 5, false)
	camera:add(pickupcollider, 2, false)
	camera:add(endgamecollider, 3, false)

	--sceneGroup:insert( background2 )

	sceneGroup:insert( camera )
	sceneGroup:insert( rain )
	sceneGroup:insert( background0 )

	sceneGroup:insert( controls21 )
	sceneGroup:insert( controls22 )
	sceneGroup:insert( controls11 )
	sceneGroup:insert( controls12 )
	sceneGroup:insert( youlosegrap )
	--sceneGroup:insert( youwongrap )


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
		physics.start()
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
		physics.stop()
	elseif phase == "did" then
		composer.removeScene("fela")
		camera:destroy()
		-- Called when the scene is now off screen
	end	
	
end

function scene:destroy( event )

	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	local sceneGroup = self.view
	
	package.loaded[physics] = nil
	physics = nil
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene