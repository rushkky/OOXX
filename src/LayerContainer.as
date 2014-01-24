package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import enums.GlobalSetType;
	
	import utils.Stats;
	
	public class LayerContainer extends Sprite
	{
		private static var _instance:LayerContainer;
		
		public var logContainer:Sprite;
		public var uiContainer:Sprite;
		public var battleContainer:Sprite;
		public var mapContainer:Sprite;
		
		private var stats:Stats;
		
		public function LayerContainer()
		{
			super();
			
			this.logContainer = new Sprite();
			this.uiContainer = new Sprite();
			this.battleContainer = new Sprite();
			this.mapContainer = new Sprite();
			
			addChild(this.mapContainer);
			addChild(this.battleContainer);
			addChild(this.uiContainer);
			addChild(this.logContainer);
			
			_instance = this;
			
			addEventListener(Event.ADDED_TO_STAGE, init, false, 0, true);
			
		}
		private function init(e):void
		{
			stats = new Stats;
			stats.x = GlobalSetType.ScreenWidth - 70;
			this.logContainer.addChild(stats);
		}
		public function out(strInfo : String):void
		{
			if(stats)
			stats.out(strInfo);
		}
		public static function GetInstance():LayerContainer
		{
			if(!_instance) new LayerContainer();
			return _instance;
		}
	}
}