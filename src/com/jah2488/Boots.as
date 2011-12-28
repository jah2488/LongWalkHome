package com.jah2488
{
	import org.flixel.*;
	
	public class Boots extends Item
	{
		[Embed(source = './assets/images/bootItem.png')] public var BootItemClass:Class;
		
		public function Boots(X:Number=0, Y:Number=0, SimpleGraphic:Class=null)
		{
			super(X, Y, BootItemClass);
			loadGraphic(BootItemClass,false,false,16,16);
		}
		
		override public function update():void
		{
			if(this.overlaps(Registry._player)){
				FlxG.log("Gotcha!");
				Registry._player.hasBoots = true;
				this.kill();
			}
		}
	}
}