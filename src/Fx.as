package 
{
	import org.flixel.*;
	
	public class Fx extends FlxGroup
	{
		public var pixels:FlxGroup;
		
		[Embed(source = './assets/images/breakableBlock.png')] public var BrickImageClass:Class;


		public function Fx()
		{
			super();
			
			pixels = new FlxGroup();
			
			//	Here we create an FlxGroup containing 40 FlxEmitters, all the same, used when the aliens are shot/explode
			for (var i:int = 0; i < 40; i++)
			{
				var tempPixel:FlxEmitter = new FlxEmitter();
				tempPixel.setSize(8, 8);
				tempPixel.gravity = 200;
				tempPixel.setXSpeed(-50, 50);
				tempPixel.setYSpeed( -30, -60);
				tempPixel.setRotation(0, 0);	// VITAL!!!
				tempPixel.makeParticles(BrickImageClass);
				
				pixels.add(tempPixel);
			}
			
			add(pixels);
		}
		
		override public function update():void
		{
			super.update();
			
			//	We can't use jet.at(Registry.player) because we need to offset the x/y a little to make
			//	it look like the jets are coming from the bottom middle of the ship
//			jet.x = Registry.player.x + 4;
//			jet.y = Registry.player.y + 12;
		}
		
		public function explodeBlock(ax:int, ay:int):void
		{
			FlxG.log("ExploadBlock Called");
			var pixel:FlxEmitter = FlxEmitter(pixels.getFirstAvailable());
			
			if (pixel)
			{
				pixel.x = ax;
				pixel.y = ay;
				pixel.start(true);
			}
		}
	}
}