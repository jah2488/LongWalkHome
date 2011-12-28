package
{
	import org.flixel.*;
	[SWF(width="852", height="480", backgroundColor="#ffffff")]
	[Frame(factoryClass="Preloader")]

	public class LongWalkHome extends FlxGame
	{
		public function LongWalkHome()
		{
			super(426,240,MenuState,2);
			FlxG.debug=true; // enable debug console

		}
	}
}
