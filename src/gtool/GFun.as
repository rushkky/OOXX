package gtool
{
	import flash.utils.Dictionary;

	public class GFun
	{
		private static var _instance:GFun;
		private var _map:Dictionary;
		public function GFun()
		{
			_instance = this;
			this.init();	
		}
		private function init():void
		{
			this._map = new Dictionary();	
		}
		public function put(keyName_:String,fun_:Function):void
		{
			this._map[keyName_] = fun_;
		}
		public function exeFun(keyName_:String,...parames_:Array):Object
		{
			var fun:Function = this._map[keyName_];
			if(fun==null) return null;
			return fun.apply(null,parames_);
		}
		public function removeFun(keyName_:String):void
		{
			this._map[keyName_] = null;
			delete this._map[keyName_];
		}
		public function removeAllFun():void
		{
			for(var keyName:String in this._map)
			{
				delete this._map[keyName];
			}
		}
		public static function GetInstance():GFun
		{
			if(!_instance) new GFun;
			return _instance;
		}
	}
}