package com.jah2488
{
	import org.flixel.*;
	import org.flixel.FlxSprite;
	import org.flixel.plugin.photonstorm.FlxDelay;
	
	public class BreakableBlock extends FlxSprite
	{
		[Embed(source = './assets/images/breakableBlock.png')] public var BreakableBlockImageClass:Class;
		[Embed(source = './assets/images/break.png')] public var BrickImageClass:Class;
		[Embed(source = './assets/sounds/hit.mp3')] public var HitSound:Class;

		public var emitter:FlxEmitter;
		
		public function BreakableBlock(X:Number=0, Y:Number=0, SimpleGraphic:Class=null)
		{
			super(X, Y, BreakableBlockImageClass);
			
			loadGraphic(BreakableBlockImageClass,false,false,8,8);
			
			this.health    = 5;
			this.immovable = true;
			this.solid     = true;
			
			emitter = new FlxEmitter(0,0,100);
			emitter.makeParticles(BrickImageClass,5);
			emitter.bounce = 1;
			emitter.gravity = 300;
			emitter.lifespan = 200;

		}
		
		override public function update():void
		{
			super.update();
			if(this.overlaps(Registry._player))
			{
				if(Registry._player.activeItem == 1) {
					if(Registry._player.hasHammer == true)
					{
						if(Registry._player.swingingHammer == true)
						{
							emitter.start(true);
							FlxG.score += 5;
							Registry._player.play('fighting');
							shake();
							FlxG.play(HitSound);
							this.hurt(1);	
						}
						
					}
				}
			}
			emitter.update();
		}
		override public function draw():void
		{
			super.draw();
			emitter.draw();
		}
		public function shake():void
		{
			this.flicker();
			emitter.at(this);
			emitter.update();
		}
		override public function kill():void
		{
			emitter.start(true);
			shake();
			super.kill();
		}
	}
}