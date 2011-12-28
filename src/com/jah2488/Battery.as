package com.jah2488
{
	import org.flixel.*;
	
	public class Battery extends Item
	{
		[Embed(source = './assets/images/batterItem.png')] public var BatteryItemClass:Class;
		
		public function Battery(X:Number=0, Y:Number=0, SimpleGraphic:Class=null)
		{
			super(X, Y, BatteryItemClass);
			loadGraphic(BatteryItemClass,false,false,16,16);
		}
		
		override public function update():void
		{
			if(this.overlaps(Registry._player)){
				FlxG.log("Gotcha!");
				Registry._player.maxMeter += 200;
				Registry._player.meter += 350;
				FlxG.score += 100;
				this.kill();
			}
		}
	}
}