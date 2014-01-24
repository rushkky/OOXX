package 
{

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;


	public class SkillPanelRes extends MovieClip
	{


		public function SkillPanelRes()
		{
			fReturnBtn.addEventListener(MouseEvent.CLICK,onReturnBtnClick)
		}
		private function onReturnBtnClick(e:MouseEvent):void
		{
			dispatchEvent(new Event("onReturnBtnClick"))
		}
		public function removeAllListener():void
		{
			fReturnBtn.removeEventListener(MouseEvent.CLICK,onReturnBtnClick)
		}
	}

}