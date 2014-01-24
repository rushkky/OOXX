package managers.MapManager
{
	import flash.display.Sprite;
	
	import gtool.GLoader;
	
	import managers.Manager;
	
	public class MapManager extends Manager
	{
		private var _pveID:int;
		private var _map:*;
		
		public function MapManager(container_:Sprite)
		{
			super(container_);
		}
		override public function add(value_:Object):void
		{
			_pveID = value_ as int;
			var key:String = "map_" + _pveID;
			var cls:Class = GLoader.GetInstance().getClass(key,key);
			if(cls != null)
			{
				_map = new cls();
				this.container.addChild(_map);
			}	
		}
		override public function dispose():void
		{
			this.container.removeChild(_map);
			_map = null;
		}
	}
}