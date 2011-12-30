package com.jah2488 
{

	
	import org.flixel.*;
	
	public class Lighting extends FlxSprite {
		[Embed(source="./assets/images/light2.png")]
		private var LightImageClass:Class;
		[Embed(source="./assets/images/newLight.png")]
		private var DirectionalImageClass:Class;
		[Embed(source="./assets/images/tinyLight2.png")]
		private var TinyImageClass:Class;
		
		private var darkness:FlxSprite;
		private var isAnimated:Boolean = false;
		
		public function Lighting(x:Number, y:Number, darkness:FlxSprite, type:String = "light"):void {
			var lightType:Class;
			if( type == "light")       { lightType = LightImageClass;}
			if( type == "directional") { lightType = DirectionalImageClass;}
			if( type == "tiny")        { lightType = TinyImageClass; isAnimated = true;}
		
			super(x, y, lightType);
			this.loadGraphic(lightType,isAnimated,false);
			
			
			this.darkness = darkness;
			this.blend = "screen"
			
			if( type == "directional"){
				this.scale.x = 2;
			}
			if( type == "tiny")
			{
				this.addAnimation('flicker',[0,1,2,3],16,true);
				this.play('flicker');
			}
			if(this.x > (FlxG.width * 5))
			{
				this.kill();
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