package modules
{
	import flash.display.Sprite;
	
	import managers.MapManager.MapManager;

	public class BattleModule implements IModule
	{
		private var _mapManager:MapManager;
				
		private var _avatarContainer:Sprite;
		private var _skillContainer:Sprite;
		private var _effectContainer:Sprite;
		private var _clickContainer:Sprite;
		
		private var _pveID:int;
		
		public function BattleModule()
		{
			init();
		}
		private function init():void
		{
			_avatarContainer = new Sprite();
			_skillContainer = new Sprite();
			_effectContainer = new Sprite();
			_clickContainer = new Sprite();
			
			_mapManager = new MapManager(LayerContainer.GetInstance().mapContainer);
			
		}
		private function initManager():void
		{
			_mapManager.add(_pveID);
		}
		
		public function begin(...params):void
		{
			_pveID = params[0];
			
			
			initManager();
			
		}
		
		public function end():void
		{
			_mapManager.dispose();
			_mapManager = null;
		}
	}
}