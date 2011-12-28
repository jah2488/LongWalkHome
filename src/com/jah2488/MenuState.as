package com.jah2488
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxSpecialFX;

	public class MenuState extends FlxState
	{
		[Embed(source = './assets/images/bg2.png')] public var titlePage:Class;
		
		public function MenuState()
		{
			var t:FlxText;

			t = new FlxText(0,FlxG.height/2-10,FlxG.width,"The Long Walk Home");
			t.size = 16;
			t.alignment = "center";
			add(t);
			t = new FlxText(FlxG.width/2-50,FlxG.height-20,100,"Press Any Key to Start");
			t.alignment = "center";
			add(t);
			
		}
		
		override public function update():void
		{

			if (FlxG.keys.any())
			{
				FlxG.flash(0xffffffff, 0.75);
				FlxG.fade(0xff000000, 1, onFade);
			}            
			super.update();
		}
	
		private function onFade():void
		{
			FlxG.switchState(new PlayState);
		}
	
	}
}
