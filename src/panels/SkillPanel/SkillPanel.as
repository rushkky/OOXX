package panels.SkillPanel
{
	import flash.events.Event;
	
	import panels.Panel;
	
	public class SkillPanel extends Panel
	{
		public static const NAME:String = "SkillPanel";
		
		public function SkillPanel(data_:Object=null)
		{
			super(data_);
			super.load(NAME);
		}
		override  public  function init():void
		{
			this.panel.addEventListener("onReturnBtnClick",onReturnBtnClick);
		}
		private function onReturnBtnClick(e:Event):void
		{
			this.dispose();
		}
		override  public function hideAndClose():void
		{
			this.panel.removeEventListener("onReturnBtnClick",onReturnBtnClick);
			
			super.hideAndClose();
		}
	}
}