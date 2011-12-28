package com.jah2488
{
	import org.flixel.FlxEmitter;
	import org.flixel.FlxParticle;
	import org.flixel.FlxSprite;
	import org.flixel.plugin.photonstorm.FlxExplode;
	
	public class Item extends FlxSprite
	{
//		[Embed(source = './assets/images/pickup.wav')] private var PickupSoundClass:Class;
		
		public function Item(X:Number=0, Y:Number=0, SimpleGraphic:Class=null)
		{
			super(X, Y, SimpleGraphic);
		}
		
	}
}