package com.jah2488
{
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.flixel.*;
	
	public class GeneratedLevel extends FlxGroup
	{
		public var mapCSV:Class;
		
		[Embed(source = "./assets/images/8bit_tiles.png")] public var mapTiles:Class;
		
		public var map:FlxTilemap;
		
		public var width:int;
		public var height:int;
		
		public var mapData:Array;
		
		public function GeneratedLevel(MaxSize:uint=0)
		{
			super(MaxSize);

			renderInitialMap(50,50);
			trace(mapData);
			FlxG.log("mapData is" + mapData);
		}

		private function renderInitialMap(width:int,height:int):void
		{
			for (var ty:int = 0; ty < width; ty++)
			{
				var newArray:Array = new Array();
				for (var tx:int = 0; tx < height; tx++)
				{
					newArray.push(22);
				}
				mapData.push(newArray);
			}
		}
		
		private function carveOutHoles():void
		{
			
		}
	}
}