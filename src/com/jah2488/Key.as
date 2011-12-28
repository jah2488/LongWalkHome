package com.jah2488
{
	import org.flixel.*;
	
	public class Key extends Item
	{
		[Embed(source = './assets/images/keyItem.png')] public var KeyItemClass:Class;
		
		public function Key(X:Number=0, Y:Number=0, SimpleGraphic:Class=null)
		{
			super(X, Y, KeyItemClass);
			loadGraphic(KeyItemClass,false,false,16,16);
		}
		
		override public function update():void
		{
			if(this.overlaps(Registry._player)){
				this.pickup();

				FlxG.log("Gotcha!");
				Registry._player.keyCount += 1;
				FlxG.score += 300;
				this.kill();
			}
		}
	}	
}