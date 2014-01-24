package 
{

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;


	public class AboutPanelRes extends MovieClip
	{


		public function AboutPanelRes()
		{
			fBtn.addEventListener(MouseEvent.CLICK,onBtnClick)
		}
		private function onBtnClick(e:MouseEvent):void
		{
			dispatchEvent(new Event("onBtnClick"))
		}
		public function removeAllListener():void
		{
			fBtn.removeEventListener(MouseEvent.CLICK,onBtnClick)
		}
	}

}