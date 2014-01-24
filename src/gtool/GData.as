package gtool
{
	import flash.utils.Dictionary;
	
	public class GData
	{
		private static var _instance:GData;
		private var _map:Dictionary;
		
		public function GData()
		{
			_instance = this;
			this.init();
		}
		private function init():void
		{
			this._map = new Dictionary();
		}
		public function put(keyName_:String,value_:Object):void
		{
			this._map[keyName_] = value_;
		}
		public function get(keyName_:String):Object
		{
			return this._map[keyName_];
		}
		public static function GetInstance():GData
		{
			if(!_instance) new GData;
			return _instance;
		}
	}
}