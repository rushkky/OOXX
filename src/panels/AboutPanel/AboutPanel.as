package panels.AboutPanel
{
	import flash.events.Event;
	
	import panels.Panel;
	
	public class AboutPanel extends Panel
	{
		public static const NAME:String = "AboutPanel";
		
		public function AboutPanel(data_:Object=null)
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
			this.dispose();
		}
		override  public function hideAndClose():void
		{
			this.panel.removeEventListener("onBtnClick",onBtnClick);
			
			super.hideAndClose();
		}
	}
}