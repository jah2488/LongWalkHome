package
{
	import org.flixel.*;

	public class MenuState extends FlxState
	{
		override public function create():void
		{
			var t:FlxText;
			t = new FlxText(0,FlxG.height/2-10,FlxG.width,"A Long Walk Home");
			t.size = 16;
			t.alignment = "center";
			add(t);
			t = new FlxText(FlxG.width/2-100,FlxG.height-20,200,"Press Any Key to Play");
			t.alignment = "center";
			add(t);
			
			FlxG.mouse.show();
		}

		override public function update():void
		{
			super.update();
		  	if (FlxG.keys.any())
		  	{
				FlxG.flash(0xffffffff, 0.75);
				FlxG.fade(0xff000000, 1, onFade);
			}            
		}
		
		private function onFade():void
		{
			FlxG.switchState(new PlayState);
		}
	}
}
