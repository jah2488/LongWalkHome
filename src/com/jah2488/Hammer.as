package com.jah2488
{
	import org.flixel.*;
	
	public class Hammer extends Item
	{
		[Embed(source = './assets/images/hammerItem.png')] public var HammerItemClass:Class;
		
		public function Hammer(X:Number=0, Y:Number=0, SimpleGraphic:Class=null)
		{
			super(X, Y, HammerItemClass);
			loadGraphic(HammerItemClass,false,false,16,16);
		}
		override public function update():void
		{
			if(this.overlaps(Registry._player)){
				this.pickup();

				FlxG.log("Gotcha!");
				FlxG.score += 100;
				Registry._player.hasHammer = true;
				this.kill();
			}
		}
	}
}