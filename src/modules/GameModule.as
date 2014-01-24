package modules
{
	import datas.RoleData;
	
	import enums.ActionType;
	import enums.AttributeType;
	
	import gtool.GMsg;
	
	import managers.DataManager.DataManager;
	import managers.LoadResManager.LoadResManager;

	public class GameModule implements IModule
	{
		private var loadresManager:LoadResManager;
		
		//当前Pve
		private var _pveID:int;
		
		public function GameModule()
		{
		}
		
		public function begin(...params):void
		{
			loadresManager = new LoadResManager(null);
			
			
			ModuleManager.GetInstance().begin(UIModule,LayerContainer.GetInstance().uiContainer);
			
			GMsg.GetInstance().addMsgListener(this,"onPveStart",onPveStart);
			GMsg.GetInstance().addMsgListener(this,"onLoadResComplete",onLoadResComplete);
			
			
		}
		//PVE全部资源加载好
		private function onLoadResComplete():void
		{
			ModuleManager.GetInstance().begin(BattleModule,_pveID);
		}
		//进入PVE
		private function onPveStart(pveID_:int):void
		{
			//重新
			if(_pveID == pveID_)
			{
				onLoadResComplete();
			}
			//新的
			else
			{
				_pveID = pveID_;
				//加载数据
				var rd:RoleData = new RoleData;
				var id:int = rd.atrributeData[AttributeType.Res];
				var data:Object = {};
				data.pveID = _pveID;
				data.roleID = [id];
				data.monsterID = [];
				loadresManager.add(data);
				data = null;
			}
			
		}
		public function end():void
		{
		}
	}
}