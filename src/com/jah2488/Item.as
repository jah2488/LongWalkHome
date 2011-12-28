package com.jah2488
{
	import org.flixel.*;
	import org.flixel.FlxParticle;
	import org.flixel.FlxSprite;
	import org.flixel.plugin.photonstorm.FlxExplode;
	
	public class Item extends FlxSprite
	{
     	[Embed(source = './assets/sounds/pickup.mp3')] private var PickupSoundClass:Class;
		
		public function Item(X:Number=0, Y:Number=0, SimpleGraphic:Class=null)
		{
			super(X, Y, SimpleGraphic);
		}
		
		 public function pickup():void
		{
				FlxG.play(PickupSoundClass);
		}
	}
}