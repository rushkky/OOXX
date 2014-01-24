package modules
{
	import flash.utils.Dictionary;

	public class ModuleManager
	{
		private static var _instance:ModuleManager;
		
		private var _moduleMap:Dictionary;
		
		public function ModuleManager()
		{
			_instance = this;
			this.init();
		}
		public function begin(cls_:Class,...params:Array):void
		{
			this.getModule(cls_).begin.apply(null,params);
		}
		public function end(cls_:Class):void
		{
			this.getModule(cls_).end();
		}
		public function getModule(cls_:Class):IModule
		{
			if(this._moduleMap[cls_]) return this._moduleMap[cls_] as IModule;
			
			this._moduleMap[cls_] = new cls_();
			return this._moduleMap[cls_] as IModule;
		}
		public function removeModule(cls_:Class):void
		{
			this.getModule(cls_).end();
			this._moduleMap[cls_] = null;
			delete this._moduleMap[cls_];
		}
		private function init():void
		{
			this._moduleMap = new Dictionary();
		}
		public static function GetInstance():ModuleManager
		{
			if(!_instance) new ModuleManager;
			return _instance;
		}
	}
}