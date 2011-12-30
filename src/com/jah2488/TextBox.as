package com.jah2488
{	
	import org.flixel.*;
	
	public class TextBox extends FlxGroup
	{
		[Embed(source = './assets/images/box.png')] private var boxImage:Class;
		
		private var width:Number;
		private var height:Number;
		private var x:Number;
		private var y:Number;
		private var text:FlxText;
		private var textColor:uint;
		private var bgColor:uint;
		private var background:FlxSprite;
		private var isModal:Boolean;
		private var textString:String;
		
		public function TextBox(X:Number, Y:Number, Text:String, Width:uint=200, Height:uint=30, Modal:Boolean=false, bgColor:uint = 0xff000000, textColor:uint = 0xfffffff)
		{
			super();
			this.width      = Width;
			this.height     = Height;
			this.isModal    = Modal;
			this.x          = X;
			this.y          = Y;
			this.textString = Text;
			this.bgColor    = bgColor;
			this.textColor  = textColor;
			
			background = new FlxSprite(X,Y);
			background.loadGraphic(boxImage);
			var scaleAmountX:Number = ( Width  / 200);
			var scaleAmountY:Number = ( Height / 30);
			background.scale.x = scaleAmountX;
			background.scale.y = scaleAmountY;
			background.width   = Width;
			background.height  = Height;
			background.setOriginToCorner();
//			background.offset.x = -(Width / 4);
//			background.makeGraphic(Width,Height,bgColor);
			this.add(background);
			
			text = new FlxText( (X + 5),(Y + (Height/4)),(Width - 10),textString);
			text.alignment = "center";
			text.color = textColor;
			this.add(text);
		}
	}
}