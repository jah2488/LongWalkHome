package com.jah2488
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	public class Player extends FlxSprite
	{
		[Embed(source = './assets/images/player1.png')] public var PlayerImage:Class;

		// Player Specific Variables // 
		private var _move_speed:int = 100;
		private var _jump_power:int = 800;   
		private var _max_health:int =  10;
		
		public var lightOn:Boolean = false;
		public var hasHammer:Boolean = false;
		public var swingingHammer:Boolean = false;
		public var hasBoots:Boolean = false;
		public var hasBattery:Boolean = false;
		public var hasHeart:Boolean  = false;
		public var hasJet:Boolean = false;
		public var flying:Boolean = false;
		
		public var jumpHeight:int = 200;
		public var playerSpeed:int = 100;
		
		public var activeItem:int = 0;
		public var keyCount:int = 0;
		
		public var meter:int = 100;
		public var maxMeter:Number = 100;
		private var lightMeter:FlxBar;
		private var darkness:FlxSprite;
		private var flashlight:Lighting;
		
		public function Player(X:Number=0, Y:Number=0, SimpleGraphic:Class=null)
		{
			super(X, Y, PlayerImage);
			loadGraphic(PlayerImage,true,true,16,16,true);

			this.addAnimation("idle", [0], 0, false);
			this.addAnimation("walk", [1, 2], 10, true);
			this.addAnimation("fighting", [4, 5], 10, true);
			
			if ( FlxG.getPlugin(FlxControl) == null )
			{
				FlxG.addPlugin(new FlxControl);
			}
			FlxControl.create(this, FlxControlHandler.MOVEMENT_ACCELERATES, FlxControlHandler.STOPPING_DECELERATES, 1, true, false);
			//	Sprite will be controlled with the left and right cursor keys
			FlxControl.player1.setWASDControl(false,false,true,true);
			
			//	And SPACE BAR will make them jump up to a maximum of 200 pixels (per second), only when touching the FLOOR
			FlxControl.player1.setJumpButton("W", FlxControlHandler.KEYMODE_PRESSED, jumpHeight, FlxObject.FLOOR, 250, 200);
			
						
			//	Stop the player running off the edge of the screen and falling into nothing
//			FlxControl.player1.setBounds(0,0,FlxG.worldBounds.width,FlxG.worldBounds.height);
			
			//	Because we are using the MOVEMENT_ACCELERATES type the first value is the acceleration speed of the sprite
			//	Think of it as the time it takes to reach maximum velocity. A value of 100 means it would take 1 second. A value of 400 means it would take 0.25 of a second.			
		   FlxControl.player1.setMovementSpeed(400, 0, 100, 200, 400, 0);

			//	Set a downward gravity of 400px/sec
			FlxControl.player1.setGravity(0, 500);
			
			//	By default the sprite is facing to the right.
			//	Changing this tells Flixel to flip the sprite frames to show the left-facing ones instead.
			facing = FlxObject.RIGHT;
			
			
		}
		
		override public function update():void
		{
			if(meter < 0){ meter = 0; }
			if(meter > maxMeter){ meter  = maxMeter;}
			
			if(touching == FlxObject.FLOOR)
			{
				if(velocity.x != 0)
				{
					play("walk");
				}
			}

			FlxG.watch(this.velocity,"x","xVelocity");
			FlxG.watch(this,"frame","frame");
			if( FlxG.keys.justReleased('SPACE'))
			{
				useItem();
			}else{
				play("fighting");
				swingingHammer = false;
			}
			
			if( hasBoots == true) {
				jumpHeight = 400;
				playerSpeed = 150;
			} else {
				if( lightOn == true )
				{
					playerSpeed = 100;
					jumpHeight  = 200;
				} else {
					playerSpeed = 50;
					jumpHeight  = 100;
				} 
			}
			
			
			FlxControl.player1.setMovementSpeed(400, 0, playerSpeed, 200, 400, 0);
			
			if (FlxControl.player1.isPressedRight || FlxControl.player1.isPressedLeft){
				play("walk");
			}
			if( this.isTouching(FlxObject.FLOOR)){
				flying = false;
				this.frame = 0;
			} else {
				this.frame = 3;
			}
		}
		private function useItem():void
		{
			if( activeItem == 0 ) {
				FlxG.log("No Item Selected");
			}
			else if( activeItem == 1 )
			{
				FlxG.log("Use Hammer!");
				play("fighting");
				if( hasHammer == true )
				{
					swingHammer();
				}
				else 
				{
					FlxG.log("oh snap, you dont have the hammer");
				}
			}
			else if( activeItem == 2 )
			{
				FlxG.log("Use Jet Boots!");
				if( hasJet == true )
				{
					boostUpwards();
				}
				else
				{
					FlxG.log("Oh shit son, you have no jet boots.");
				}
			}
		}
		
		private function swingHammer():void
		{
			swingingHammer = true;
		}
		private function boostUpwards():void
		{
			if( meter > 0 )
			{
				flying = true;
				velocity.y = -70;
				this.meter += -1;
			} else {
				flying = false;
			}
		}
	}
}