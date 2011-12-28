package
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import flashx.textLayout.formats.Float;
	
	import com.jah2488.*;
	
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	public class PlayState extends FlxState
	{
		[Embed(source = './assets/images/8bit_tiles.png')] public var mapTiles:Class;
		[Embed(source = './assets/images/bg1.png')]        public var BackgroundImageClass:Class;
		[Embed(source = './assets/images/bg2_night.png')]  public var FargroundImageClass:Class;	
		[Embed(source = './assets/images/hammerIcon.png')] public var HammerImage:Class;
		[Embed(source = './assets/images/booticon.png')]   public var JetImage:Class;
		[Embed(source = './assets/images/jetFlame.png')]   public var JetFlame:Class;
		
				
		private var _level:LevelOne;
		
		private var _map:FlxTilemap;
		private var itemGroup:FlxGroup;
		
		Registry._player = new Player();		
		Registry.fx = new Fx();
		
		private var background1:FlxSprite;
		private var background2:FlxSprite;
		private var darkness:FlxSprite;
		private var light:Lighting;
		private var flashlight:Lighting;
		
		private var lightMeter:FlxBar;
		private var item1HUD:FlxSprite;
		private var item2HUD:FlxSprite;
		private var lightMeterText:FlxText;
		private var scoreMeter:FlxText;
		private var scoreText:FlxText;
		
		private var winRoom:FlxGroup;
		
		public var refillCounter:Number = 0;
		public var depleteCounter:Number = 0;
		
		public var emitter:FlxEmitter;
		
		public static var spritesLayer:FlxGroup;
		public static var stageLayer:FlxGroup;
		public static var hudLayer:FlxGroup;
		public static var shootLayer:FlxGroup;
		public static var enemyLayer:FlxGroup;
		
		override public function create():void
		{
			
			
			FlxG.bgColor = 0xff783629;
			background1 = new FlxSprite(0,0,BackgroundImageClass);
			background2 = new FlxSprite(0,0,FargroundImageClass);
			background1.scrollFactor.x =.5;
			background1.scrollFactor.y =.5;
			background2.scrollFactor.x =.25;
			background2.scrollFactor.y =.25;
			
			spritesLayer = new FlxGroup;
			stageLayer   = new FlxGroup;
			hudLayer     = new FlxGroup;
			shootLayer   = new FlxGroup;
			enemyLayer   = new FlxGroup;
			
			itemGroup    = new FlxGroup;
			
			var testItem:Item = new Item();
			testItem.makeGraphic(16,16,0xff88ff88);
			testItem.x = -100;
			testItem.y = -100;
			itemGroup.add(testItem);
			
			_level = new LevelOne();
			
			Registry._player = new Player(100,100);
			Registry.fx      = new Fx();
			//	Tell flixel how big our game world is
			FlxG.worldBounds = new FlxRect(0, 0, _level.width, _level.height);
			//	Don't let the camera wander off the edges of the map
			FlxG.camera.setBounds(0, 0, _level.width, _level.height);
			//	The camera will follow the player
			FlxG.camera.follow(Registry._player, FlxCamera.STYLE_PLATFORMER);
			
			background1.scale.x = 2;
			background1.scale.y = 2;
			background2.scale.x = 1;
			background2.scale.y = 1;
			
			
			darkness = new FlxSprite(0,0);
			darkness.makeGraphic(FlxG.width, FlxG.height, 0xff000000);
			darkness.scrollFactor.x = darkness.scrollFactor.y = 0;
			darkness.blend = "multiply";
			
			light      = new Lighting(Registry._player.x,Registry._player.y, darkness);
			flashlight = new Lighting(Registry._player.x + 250,Registry._player.y, darkness, "directional");
			
			lightMeter = new FlxBar((FlxG.width/2) - (37), (FlxG.height - (FlxG.height * .95)), FlxBar.FILL_LEFT_TO_RIGHT, 75, 4, Registry._player, "meter");
			lightMeterText = new FlxText((FlxG.width/2) - (25), (FlxG.height - (FlxG.height * .94)),100, Registry._player.meter.toString()); 
			lightMeterText.scrollFactor.x = lightMeterText.scrollFactor.y = 0;
			lightMeter.scrollFactor.x = 0;
			lightMeter.scrollFactor.y = 0;
			
			item1HUD = new FlxSprite( 5, (FlxG.height - (FlxG.height * .95)), HammerImage);
			var item1HUDText:FlxText = new FlxText(9, (FlxG.height - (FlxG.height * .94)),10,"1"); 
			item1HUDText.scrollFactor.x = item1HUDText.scrollFactor.y = 0;
			item1HUD.scrollFactor.x = item1HUD.scrollFactor.y = 0;
			item1HUD.loadGraphic(HammerImage, true, true, 16, 16, false);
			item1HUD.addAnimation("inactive", [0,0,0,0],1,true);
			item1HUD.addAnimation("discovered",[1,1,1,1],1,true);
			item1HUD.addAnimation("active",[1,2,1,2],10,true);
			item1HUD.play("inactive");
			item2HUD = new FlxSprite( 24, (FlxG.height - (FlxG.height * .95)), JetImage);
			var item2HUDText:FlxText = new FlxText(28, (FlxG.height - (FlxG.height * .94)),10,"2"); 
			item2HUDText.scrollFactor.x = item2HUDText.scrollFactor.y = 0;
			item2HUD.scrollFactor.x = item2HUD.scrollFactor.y = 0;
			item2HUD.loadGraphic(JetImage, true, true, 16, 16, false);
			item2HUD.addAnimation("inactive", [0,0,0,0],1,true);
			item2HUD.addAnimation("discovered",[1,1,1,1],1,true);
			item2HUD.addAnimation("active",[1,2,1,2],10,true);
			item2HUD.play("inactive");
			
			scoreMeter = new FlxText((FlxG.width - (FlxG.width * .25)), (FlxG.height - (FlxG.height * .95)), 40,"Score");
			scoreMeter.scrollFactor.x = scoreMeter.scrollFactor.y = 0;
			scoreText = new FlxText((FlxG.width - (FlxG.width * .13)), (FlxG.height - (FlxG.height * .95)), 50, FlxG.score.toString());
			scoreText.scrollFactor.x = scoreText.scrollFactor.y = 0;			
			
			emitter = new FlxEmitter(-1000,-1000); //x and y of the emitter
			emitter.makeParticles(JetFlame, 1000);
			emitter.lifespan = 200;
			emitter.gravity = 600;
			
			addItem();
			
			add(background2);
			add(background1);
			add(_level);
			add(Registry._player);
			add(spritesLayer);
			
			
			
			add(light);
			add(flashlight);
			add(darkness);
			add(emitter);
			add(lightMeter);
			add(lightMeterText);
			
			add(Registry.fx);
			add(Registry.fx.pixels);
			
			add(item1HUD);
			add(item2HUD);		
			add(item1HUDText);
			add(item2HUDText);
			add(scoreMeter);
			add(scoreText);
			
			emitter.start(false);
			Registry._player.hasJet = true;
		}
		
		override public function draw():void {
			darkness.fill(0xff000000);
			super.draw();
		}
		
		override public function update():void
		{
			super.update();
			
			if(FlxG.score >= 5000)
			{
				FlxG.switchState(new WinState);
			}
			
			if(Registry._player.hasHeart == true)
			{
				FlxG.switchState(new WinState);
			}
			
			
			lightMeterText.text = Registry._player.meter.toString();
			scoreText.text = FlxG.score.toString();
			
			if(light.x < Registry._player.x - 5)
			{
				light.x += 1;
			}
			if(light.x > Registry._player.x - 5)
			{
				light.x -= 1;
			}
			if(light.y < Registry._player.y - 10)
			{
				light.y += 2;
			}
			if(light.y > Registry._player.y - 10)
			{
				light.y -= 2;
			}
			//			light.x = Registry._player.x + 5;
			//			light.y = Registry._player.y -10;
			
			
			if(FlxG.keys.ONE == true) 
			{
				if(Registry._player.hasHammer == true)
				{
					Registry._player.activeItem = 1;
				} else {
					item1HUD.flicker(.5);
				}
			}
			if(FlxG.keys.TWO == true)
			{
				if(Registry._player.hasJet == true)
				{
					Registry._player.activeItem = 2;
				} else {
					item2HUD.flicker(.5);
				}
			}
			if(Registry._player.activeItem == 1) { item1HUD.play("active");item2HUD.play("inactive");}
			if(Registry._player.activeItem == 2) { item2HUD.play("active");item1HUD.play("inactive");}
			if(Registry._player.flying == true){ emitter.x = Registry._player.x; emitter.y = Registry._player.y;} else { emitter.x = emitter.y = -1000;}
			
			if(FlxG.keys.SHIFT)
			{
				if (Registry._player.meter >= 5)
				{
					flashlight.facing = Registry._player.facing;
					flashlight.visible = true;
					Registry._player.lightOn = true;
					
					if (flashlight.facing == FlxObject.LEFT)
					{
						flashlight.angle = 180;
						flashlight.x = Registry._player.x - 96;
						flashlight.y = Registry._player.y + 8;
					} else {
						flashlight.angle = 0;
						flashlight.x = Registry._player.x + 100;
						flashlight.y = Registry._player.y + 8;						
					}
					depleteCounter += FlxG.elapsed;
					if (depleteCounter > .15)
					{
						Registry._player.meter -= 1;
						depleteCounter = 0;
					}
				} else {
					flashlight.visible = false;
					Registry._player.lightOn = false;
				}	
			} else {
				flashlight.visible = false;
				Registry._player.lightOn = false;
				
				refillCounter += FlxG.elapsed;
				
				if(Registry._player.velocity.x == 0 && Registry._player.velocity.y == 0){
					if (refillCounter > 0)
					{
						Registry._player.meter += 5;
						refillCounter = 0;
					}				
				} else {
					if (refillCounter > .5)
					{
						Registry._player.meter += 2;
						refillCounter = 0;
					}
				}
			}
			var meterRefill:Number;
			meterRefill = (1 + FlxG.elapsed) * .25;
			Registry._player.meter += (1 + FlxG.elapsed) * .25;
			FlxG.watch(Registry._player, "x", "x");
			FlxG.watch(Registry._player,"y","y");
			FlxG.watch(Registry._player,"meter","meter");
			FlxG.collide(Registry._player, _level);
			FlxG.collide(Registry._player,spritesLayer);
			
		}
		
		public function addItem():void
		{ 
			FlxG.log("Add Items Called");
			
			var bootTile:Array    = _level.map.getTileCoords(5,false);
			var hammerTile:Array  = _level.map.getTileCoords(6,false);
			var heartTile:Array   = _level.map.getTileCoords(7,false);
			var jetTile:Array     = _level.map.getTileCoords(8,false);
			var batteryTile:Array = _level.map.getTileCoords(9,false);
			var keyTile:Array     = _level.map.getTileCoords(10,false);
			var breakTile:Array  = _level.map.getTileCoords(16,false);
			
			
			for each ( var value:* in bootTile)
			{
				FlxG.log(value.x + "," + value.y);
				_level.map.setTile(value.x,value.y,0);
				spritesLayer.add(new Boots(value.x-8,value.y-8));
			}
			for each ( var hammerValue:* in hammerTile)
			{
				FlxG.log(hammerValue.x + "," + hammerValue.y);
				_level.map.setTile(hammerValue.x,hammerValue.y,0);
				spritesLayer.add(new Hammer(hammerValue.x-8,hammerValue.y-8));
			}
			for each ( var heartValue:* in heartTile)
			{
				FlxG.log(heartValue.x + "," + heartValue.y);
				_level.map.setTile(heartValue.x,heartValue.y,0);
				spritesLayer.add(new Heart(heartValue.x-8,heartValue.y-8));
			}		  
			for each ( var jetValue:* in jetTile)
			{
				FlxG.log(jetValue.x + "," + jetValue.y);
				_level.map.setTile(jetValue.x,jetValue.y,0);
				spritesLayer.add(new JetBoots(jetValue.x-8,jetValue.y-8));
			}		  
			for each ( var batteryValue:* in batteryTile)
			{
				FlxG.log(batteryValue.x + "," + batteryValue.y);
				_level.map.setTile(batteryValue.x,batteryValue.y,0);
				spritesLayer.add(new Battery(batteryValue.x-8,batteryValue.y-8));
			}		  
			for each ( var keyValue:* in keyTile)
			{
				FlxG.log(keyValue.x + "," + keyValue.y);
				_level.map.setTile(keyValue.x,keyValue.y,0);
				spritesLayer.add(new Key(keyValue.x-8,keyValue.y-8));
			}
			for each ( var blockValue:* in breakTile)
			{
				FlxG.log("Adding breakable Block" + blockValue.x + "," + blockValue.y);
				_level.map.setTile(blockValue.x,blockValue.y,0);
				spritesLayer.add(new BreakableBlock(blockValue.x,blockValue.y));
			}		  
		}
		
	}
}