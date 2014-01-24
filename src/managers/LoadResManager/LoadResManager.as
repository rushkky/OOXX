package managers.LoadResManager
{
	import flash.display.Sprite;
	
	import enums.ActionType;
	import enums.EventType;
	import enums.MyEvent;
	import enums.ResType;
	
	import gtool.GLoader;
	import gtool.GMsg;
	
	import managers.Manager;
	import managers.DataManager.DataManager;
	
	public class LoadResManager extends Manager
	{
		private var _pevID:int;
		private var _roleID:Array;
		private var _monsterID:Array;
		
		private var _arrClsName:Array = [];
		
		public function LoadResManager(container_:Sprite)
		{
			super(container_);
		}
		override public function add(value_:Object):void
		{
			_arrClsName.splice(0,_arrClsName.length);
			//加载数据
			_pevID = value_.pveID;
			_roleID = value_.roleID;
			_monsterID = value_.monsterID;
			//加载地图
			//GLoader.GetInstance().load(DataManager.GetInstance().getPveInfoData(_pevID).map,ResType.SWF,"map_"+_pevID);
			//加载角色
			var i:int = 0;
			var n:int = 0;
			var key:String;
			var path:String = "assets/res/player/";
			var url:String;
			for(i=0;i<_roleID.length;++i)
			{
				var id:int = _roleID[i];
				key = "player_"+id;
				url = path + key + ".swf";
				GLoader.GetInstance().load(url,ResType.SWF,key);
				var arr:Array = [key+"_"+ActionType.Idle,key+"_"+ActionType.Move,key+"_"+ActionType.Magic,key+"_"+ActionType.Dead,key+"_"+ActionType.Attack1,key+"_"+ActionType.Attack2];
				for(n=0;n<arr.length;++n)
				{
					_arrClsName.push(arr[n]);
					url = path + arr[n] + ".xml";
					key = arr[n] + ".xml";
					GLoader.GetInstance().load(url,ResType.TEXT,key);
				}
			}
			//加载怪物
			
			GLoader.GetInstance().addEventListener(EventType.RES_ALLLOAD,onResAllLoad);
		}
		private function onResAllLoad(e:MyEvent):void
		{
			var i:int = 0;
			var n:int = 0;
			var id:int;
			var key:String;
			var cls:Class;
			//生成角色bitmapdata
			for(i=0;i<this._roleID.length;++i)
			{
				id = this._roleID[i];
				key = "player_"+id;
				for(n=0;n<this._arrClsName.length;++n)
				{
					cls = GLoader.GetInstance().getClass(key,this._arrClsName[n]);
					if(cls != null)
					{
						GLoader.GetInstance().addTempRes(_arrClsName[n],new cls);
					}
				}
				GLoader.GetInstance().remove(key);
				
			}
			//生成怪物bitmapdata
			
			GMsg.GetInstance().dispatchMsgEvent("onLoadResComplete");
		}
		override public function dispose():void
		{
			_arrClsName = null;
		}
	}
}