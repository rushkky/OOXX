package
{

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import enums.EventType;
	import enums.MyEvent;
	
	import gtool.GLoader;
	
	import managers.DataManager.DataManager;
	
	import modules.GameModule;
	import modules.ModuleManager;

	
	[SWF(frameRate="30", width="960" , height="640")]
	
	public class OOXX extends Sprite
	{
		private var lr:LoadRes;
		private var ipc:ImportPanelClass;
		private var uniqueID:String="0";

		public function OOXX()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		public function init(data_:Object):void
		{
			uniqueID = data_ as String;
		}
		private function onAddToStage(e):void
		{
			stage.color = 0x0;
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.quality = StageQuality.LOW;
						
			lr = new LoadRes();
			GLoader.GetInstance().addEventListener(EventType.RES_ALLLOAD,onResAllLoad);
		}
		private function onResAllLoad(e:MyEvent):void
		{
			lr = null;

			//层级初始化
			addChild(LayerContainer.GetInstance());
			//数据初始化
			DataManager.GetInstance().init();
			//游戏模块开启
			ModuleManager.GetInstance().begin(GameModule);
			

			//LayerContainer.GetInstance().out(uniqueID);
			GLoader.GetInstance().removeEventListener(EventType.RES_ALLLOAD,onResAllLoad);

		}

	}
}
