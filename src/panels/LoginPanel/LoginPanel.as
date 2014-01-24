package panels.LoginPanel
{
	import flash.events.Event;
	
	import gtool.GMsg;
	
	import panels.Panel;
	
	public class LoginPanel extends Panel
	{
		public static const NAME:String = "LoginPanel";
		
		public function LoginPanel(data_:Object=null)
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
			trace(this.panel._account,this.panel._password)
			this.dispose();
			GMsg.GetInstance().dispatchMsgEvent("onShowCreateRolePanel");
		}
		override  public function hideAndClose():void
		{
			this.panel.removeEventListener("onBtnClick",onBtnClick);
			
			super.hideAndClose();
		}
	}
}