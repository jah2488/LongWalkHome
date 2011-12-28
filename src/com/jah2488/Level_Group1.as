//Code generated with DAME. http://www.dambots.com

package com.jah2488 
{
	import org.flixel.*;
	import flash.utils.Dictionary;
	public class Level_Group1 extends BaseLevel
	{
		//Embedded media...
		[Embed(source="Assets/mapCSV_Group1_Map1.csv", mimeType="application/octet-stream")] public var CSV_Map1:Class;
		[Embed(source="Assets/8bit_tiles.png")] public var Img_Map1:Class;

		//Tilemaps
		public var layerMap1:FlxTilemap;

		//Sprites
		public var Layer2Group:FlxGroup = new FlxGroup;

		//Properties


		public function Level_Group1(addToStage:Boolean = true, onAddCallback:Function = null, parentObject:Object = null)
		{
			// Generate maps.
			var properties:Array = [];
			var tileProperties:Dictionary = new Dictionary;

			properties = generateProperties( null );
			layerMap1 = addTilemap( CSV_Map1, Img_Map1, 0.000, 0.000, 8, 8, 1.000, 1.000, false, 20, 1, properties, onAddCallback );

			//Add layers to the master group in correct order.
			masterLayer.add(layerMap1);
			masterLayer.add(Layer2Group);

			if ( addToStage )
				createObjects(onAddCallback, parentObject);

			boundsMinX = 0;
			boundsMinY = 0;
			boundsMaxX = 600;
			boundsMaxY = 800;
			bgColor = 0xff777777;
		}

		override public function createObjects(onAddCallback:Function = null, parentObject:Object = null):void
		{
			addSpritesForLayerLayer2(onAddCallback);
			generateObjectLinks(onAddCallback);
			if ( parentObject != null )
				parentObject.add(masterLayer);
			else
				FlxG.state.add(masterLayer);
		}

		public function addSpritesForLayerLayer2(onAddCallback:Function = null):void
		{
			addSpriteToLayer(null, Gold, Layer2Group , 360.000, 128.000, 0.000, 1, 1, false, 1.000, 1.000, generateProperties( null ), onAddCallback );//"Gold"
			addSpriteToLayer(null, Gold, Layer2Group , 424.000, 168.000, 0.000, 1, 1, false, 1.000, 1.000, generateProperties( null ), onAddCallback );//"Gold"
			addSpriteToLayer(null, Gold, Layer2Group , 160.000, 160.000, 0.000, 1, 1, false, 1.000, 1.000, generateProperties( null ), onAddCallback );//"Gold"
			addSpriteToLayer(null, Gold, Layer2Group , 112.000, 128.000, 0.000, 1, 1, false, 1.000, 1.000, generateProperties( null ), onAddCallback );//"Gold"
		}

		public function generateObjectLinks(onAddCallback:Function = null):void
		{
		}

	}
}
