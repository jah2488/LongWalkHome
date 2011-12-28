package com.jah2488
{
	import org.flixel.*;
	import org.flixel.FlxSprite;
	
	public class BreakableBlock extends FlxSprite
	{
		[Embed(source = './assets/images/breakableBlock.png')] public var BreakableBlockImageClass:Class;
		[Embed(source = './assets/images/break.png')] public var BrickImageClass:Class;

		public var emitter:FlxEmitter;
		
		public function BreakableBlock(X:Number=0, Y:Number=0, SimpleGraphic:Class=null)
		{
			super(X, Y, BreakableBlockImageClass);
			
			loadGraphic(BreakableBlockImageClass,false,false,8,8);
			
			this.health = 10;
			this.immovable = true;
			this.solid     = true;
			
			emitter = new FlxEmitter(0,0,100);
//			var particles:int = 5;
//			
//			for(var i:int = 0; i < particles; i++)
//			{
//				var particle:FlxSprite = new FlxSprite();
//				particle.loadGraphic(BreakableBlockImageClass,false,false,2,2);
//				emitter.add(particle);
//			}
			emitter.makeParticles(BrickImageClass,8);
			emitter.bounce = 1;
			emitter.gravity = 300;
			emitter.lifespan = 200;

		}
		
		override public function update():void
		{
			super.update();
			FlxG.watch(emitter, "alive", "alive");
			if(this.overlaps(Registry._player))
			{
			
				if(Registry._player.hasHammer == true)
				{
					if(Registry._player.swingingHammer == true)
					{
						emitter.start(true);
						FlxG.score += 5;
						Registry._player.play('fighting');
						shake();
						Registry.fx.explodeBlock(Registry._player.x,Registry._player.y);
						this.hurt(1);	
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
			shake();
			emitter.replace(this,emitter);
			super.kill();
		}
	}
}