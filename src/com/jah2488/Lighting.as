package com.jah2488 
{

	import org.flixel.*;
	
	public class Lighting extends FlxSprite {
		[Embed(source="./assets/images/light2.png")]
		private var LightImageClass:Class;
		[Embed(source="./assets/images/newLight.png")]
		private var DirectionalImageClass:Class;
		[Embed(source="./assets/images/tinyLight.png")]
		private var TinyImageClass:Class;
		
		private var darkness:FlxSprite;
		
		public function Lighting(x:Number, y:Number, darkness:FlxSprite, type:String = "light"):void {
			var lightType:Class;
			if( type == "light")       { lightType = LightImageClass;}
			if( type == "directional") { lightType = DirectionalImageClass;}
			if( type == "tiny")        { lightType = TinyImageClass;}
			super(x, y, lightType);
			
			this.darkness = darkness;
			this.blend = "screen"
			
			if( type == "directional"){
				this.scale.x = 2;
			}
		}
		
		
		override public function draw():void {
			var screenXY:FlxPoint = getScreenXY();
			
			darkness.stamp(this,
				screenXY.x - this.width / 2,
				screenXY.y - this.height / 2);
		}
		

		
	}
	
	
}