package panels.CreateRolePanel
{
	import flash.events.Event;
	
	import gtool.GMsg;
	
	import panels.Panel;
	
	public class CreateRolePanel extends Panel
	{
		public static const NAME:String = "CreateRolePanel";
		
		public function CreateRolePanel(data_:Object=null)
		{
			super(data_);
			super.load(NAME);
		}
		override  public  function init():void
		{
			this.panel.addEventListener("onBtnClick",onBtnClick);
		}
		private function onBtnClick(e:Event):void
		{
			trace(this.panel._name,this.panel._role)
			this.dispose();
			GMsg.GetInstance().dispatchMsgEvent("onShowMainPanel");
		}
		override  public function hideAndClose():void
		{
			this.panel.removeEventListener("onBtnClick",onBtnClick);
			
			super.hideAndClose();
		}
	}
}