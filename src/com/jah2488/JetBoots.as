package com.jah2488
{
	import org.flixel.*;
	
	public class JetBoots extends Item
	{
		[Embed(source = './assets/images/jetItem.png')] public var JetItemImage:Class;

		
		public function JetBoots(X:Number=0, Y:Number=0, SimpleGraphic:Class=null)
		{
			super(X, Y, JetItemImage);
			loadGraphic(JetItemImage,false,false,16,16);
		}
		
		override public function update():void
		{
			if(this.overlaps(Registry._player)){
				this.pickup();

				FlxG.log("Gotcha!");
				Registry._player.hasJet = true;
				this.kill();
			}
		}
	}
}