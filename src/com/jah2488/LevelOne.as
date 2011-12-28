package com.jah2488
{
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
		
	import org.flixel.*;
	
	public class LevelOne extends FlxGroup
	{
		[Embed(source = "./assets/mapCSV_Group1_blockbreak.csv", mimeType = "application/octet-stream")]
		public var mapCSV:Class;
		[Embed(source = "./assets/images/8bit_tiles.png")] public var mapTiles:Class;
		
		public var map:FlxTilemap;
		
		public var width:int;
		public var height:int;
		public var items:FlxGroup;
		public var totalItems:int;
		
		public function LevelOne(MaxSize:uint=0)
		{
			super(MaxSize);
			map = new FlxTilemap;
			map.loadMap(new mapCSV, mapTiles, 8,8,0,0,1,20);
			
			map.setTileProperties(22, FlxObject.UP, null, null, 3);

			width  = map.width;
			height = map.height;
			addItems();
			add(map);
			
		}
		
		private function addItems():void
		{
			FlxG.log("Add Items Called");
			items = new FlxGroup();
			
			for (var ty:int = 0; ty < map.heightInTiles; ty++)
			{
				for (var tx:int = 0; tx < map.widthInTiles; tx++)
				{
					if (map.getTile(tx, ty) == 5)
					{
						FlxG.log("map tile was 5");
						items.add(new JetBoots(tx,ty));
						totalItems++;
					}
				}
			}
		}

	}
}