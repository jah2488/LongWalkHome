package 
{
	import com.jah2488.*;
	
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxSpecialFX;
	
	public class WinState extends FlxState
	{
		
		public function WinState()
		{
			var t:FlxText;
			FlxG.bgColor = 0xff000000;
			
			t = new FlxText(0,FlxG.height/2-10,FlxG.width,"You Won! with a score of");
			t.size = 16;
			t.alignment = "center";
			add(t);
			t = new FlxText(FlxG.width/2-75,FlxG.height-100,150,FlxG.score.toString());
			t.size = 16;
			t.alignment = "center";
			add(t);
			t = new FlxText(FlxG.width/2-75,FlxG.height-20,150,"Press C Key to Startover");
			t.alignment = "center";
			add(t);
			
		}
		
		override public function update():void
		{
			
			if (FlxG.keys.C)
			{
				FlxG.flash(0xffffffff, 0.75);
				FlxG.fade(0xff000000, 1, onFade);
			}            
			super.update();
		}
		
		private function onFade():void
		{
			FlxG.score = 0;
			FlxG.switchState(new PlayState);
		}
		
	}
}
