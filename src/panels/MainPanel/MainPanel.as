package panels.MainPanel
{
	import flash.events.Event;
	
	import gtool.GMsg;
	
	import panels.Panel;
	
	public class MainPanel extends Panel
	{
		public static const NAME:String = "MainPanel";
		
		public function MainPanel(data_:Object=null)
		{
			super(data_);
			super.load(NAME);
		}
		override  public  function init():void
		{
			this.panel.addEventListener("onLeftBtn",onLeftBtn);
			this.panel.addEventListener("onRightBtn",onRightBtn);
			this.panel.addEventListener("onPkBtn",onPkBtn);
			this.panel.addEventListener("onBossBtn",onBossBtn);
			this.panel.addEventListener("onRankingBtn",onRankingBtn);
			this.panel.addEventListener("onRoleBtn",onRoleBtn);
			this.panel.addEventListener("onSkillBtn",onSkillBtn);
			this.panel.addEventListener("onMakeBtn",onMakeBtn);
			this.panel.addEventListener("onTradeBtn",onTradeBtn);
			this.panel.addEventListener("onFriendBtn",onFriendBtn);
			this.panel.addEventListener("onSetBtn",onSetBtn);
			this.panel.addEventListener("onAboutBtn",onAboutBtn);
		}
		private function onLeftBtn(e:Event):void
		{
			LayerContainer.GetInstance().out("onLeftBtn");
		}
		private function onRightBtn(e:Event):void
		{
			LayerContainer.GetInstance().out("onRightBtn");
			this.dispose();
		}
		private function onPkBtn(e:Event):void
		{
			LayerContainer.GetInstance().out("onPkBtn");
		}
		private function onBossBtn(e:Event):void
		{
			LayerContainer.GetInstance().out("onBossBtn");
		}
		private function onRankingBtn(e:Event):void
		{
			LayerContainer.GetInstance().out("onRankingBtn");
		}
		private function onRoleBtn(e:Event):void
		{
			LayerContainer.GetInstance().out("onRoleBtn");
		}
		private function onSkillBtn(e:Event):void
		{
			LayerContainer.GetInstance().out("onSkillBtn");
			GMsg.GetInstance().dispatchMsgEvent("onShowSkillPanel");
		}
		private function onMakeBtn(e:Event):void
		{
			LayerContainer.GetInstance().out("onMakeBtn");
		}
		private function onTradeBtn(e:Event):void
		{
			LayerContainer.GetInstance().out("onTradeBtn");
		}
		private function onFriendBtn(e:Event):void
		{
			LayerContainer.GetInstance().out("onFriendBtn");
		}
		private function onSetBtn(e:Event):void
		{
			LayerContainer.GetInstance().out("onSetBtn");
		}
		private function onAboutBtn(e:Event):void
		{
			LayerContainer.GetInstance().out("onAboutBtn");
			GMsg.GetInstance().dispatchMsgEvent("onShowAboutPanel");
		}
		override  public function hideAndClose():void
		{

			this.panel.removeEventListener("onLeftBtn",onLeftBtn);
			this.panel.removeEventListener("onRightBtn",onRightBtn);
			this.panel.removeEventListener("onPkBtn",onPkBtn);
			this.panel.removeEventListener("onBossBtn",onBossBtn);
			this.panel.removeEventListener("onRankingBtn",onRankingBtn);
			this.panel.removeEventListener("onRoleBtn",onRoleBtn);
			this.panel.removeEventListener("onSkillBtn",onSkillBtn);
			this.panel.removeEventListener("onMakeBtn",onMakeBtn);
			this.panel.removeEventListener("onTradeBtn",onTradeBtn);
			this.panel.removeEventListener("onFriendBtn",onFriendBtn);
			this.panel.removeEventListener("onSetBtn",onSetBtn);
			this.panel.removeEventListener("onAboutBtn",onAboutBtn);
			
			super.hideAndClose();
		}
	}
}