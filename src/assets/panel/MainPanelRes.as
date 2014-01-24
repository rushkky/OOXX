package 
{

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;


	public class MainPanelRes extends MovieClip
	{

		private var arrBtn:Array;
		
		public function MainPanelRes()
		{
			arrBtn = [fBtn1,fBtn2,fLeftBtn,fRightBtn,fPkBtn,fBossBtn,fRankingBtn,fRoleBtn,fSkillBtn,fMakeBtn,fTradeBtn,fFriendBtn,fSetBtn,fAboutBtn];
			for(var i:int=0;i<arrBtn.length;++i)
			{
				arrBtn[i].addEventListener(MouseEvent.CLICK,onBtnClick)
			}
			fPkBtn.visible = false;
			fBossBtn.visible = false;
			fRankingBtn.visible = false;
			
			fRoleBtn.visible = false;
			fSkillBtn.visible = false;
			fMakeBtn.visible = false;
			fTradeBtn.visible = false;
			fFriendBtn.visible = false;
			fSetBtn.visible = false;
			fAboutBtn.visible = false;
			
			fBtn1.gotoAndStop(1);
			fBtn2.gotoAndStop(1);
		}
		private function onBtnClick(e:MouseEvent):void
		{
			var btn:* = e.currentTarget;
			if(btn == fBtn1)
			{
				if(fPkBtn.visible)
				{
					fBtn1.gotoAndStop(1);
					fPkBtn.visible = false;
					fBossBtn.visible = false;
					fRankingBtn.visible = false;
				}
				else
				{
					fBtn1.gotoAndStop(2);
					fPkBtn.visible = true;
					fBossBtn.visible = true;
					fRankingBtn.visible = true;
				}
			}
			else if(btn == fBtn2)
			{
				if(fRoleBtn.visible)
				{
					fBtn2.gotoAndStop(1);
					fRoleBtn.visible = false;
					fSkillBtn.visible = false;
					fMakeBtn.visible = false;
					fTradeBtn.visible = false;
					fFriendBtn.visible = false;
					fSetBtn.visible = false;
					fAboutBtn.visible = false;
				}
				else
				{
					fBtn2.gotoAndStop(2);
					fRoleBtn.visible = true;
					fSkillBtn.visible = true;
					fMakeBtn.visible = true;
					fTradeBtn.visible = true;
					fFriendBtn.visible = true;
					fSetBtn.visible = true;
					fAboutBtn.visible = true;
				}
			}
			else if(btn == fLeftBtn)
			{
				dispatchEvent(new Event("onLeftBtn"))
			}
			else if(btn == fRightBtn)
			{
				dispatchEvent(new Event("onRightBtn"))
			}
			else if(btn == fPkBtn)
			{
				dispatchEvent(new Event("onPkBtn"))
			}
			else if(btn == fBossBtn)
			{
				dispatchEvent(new Event("onBossBtn"))
			}
			else if(btn == fRankingBtn)
			{
				dispatchEvent(new Event("onRankingBtn"))
			}
			else if(btn == fRoleBtn)
			{
				dispatchEvent(new Event("onRoleBtn"))
			}
			else if(btn == fSkillBtn)
			{
				dispatchEvent(new Event("onSkillBtn"))
			}
			else if(btn == fMakeBtn)
			{
				dispatchEvent(new Event("onMakeBtn"))
			}
			else if(btn == fTradeBtn)
			{
				dispatchEvent(new Event("onTradeBtn"))
			}
			else if(btn == fFriendBtn)
			{
				dispatchEvent(new Event("onFriendBtn"))
			}
			else if(btn == fSetBtn)
			{
				dispatchEvent(new Event("onSetBtn"))
			}
			else if(btn == fAboutBtn)
			{
				dispatchEvent(new Event("onAboutBtn"))
			}
		}
		public function removeAllListener():void
		{
			for(var i:int=0;i<arrBtn.length;++i)
			{
				arrBtn[i].removeEventListener(MouseEvent.CLICK,onBtnClick)
			}
			arrBtn = null;
		}
	}

}