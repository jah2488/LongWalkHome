package com.jah2488
{
	import org.flixel.*;
	
	public class Heart extends Item
	{
		[Embed(source = './assets/images/heartItem.png')] public var HeartItemClass:Class;

		public function Heart(X:Number=0, Y:Number=0, SimpleGraphic:Class=null)
		{
			super(X, Y, HeartItemClass);
			loadGraphic(HeartItemClass,false,false,16,16);
		}
		
		override public function update():void
		{
			if(this.overlaps(Registry._player)){
				this.pickup();

				FlxG.log("Gotcha!");
				FlxG.score += 1000;
				Registry._player.hasHeart = true;
				this.kill();
			}
		}
	}
}