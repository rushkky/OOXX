package 
{

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;


	public class LoginPanelRes extends MovieClip
	{

		public var _account:String;
		public var _password:String;
		public function LoginPanelRes()
		{
			fBtn.addEventListener(MouseEvent.CLICK,onBtnClick)
		}
		private function onBtnClick(e:MouseEvent):void
		{
			_account = fAccount.text;
			_password = fPassword.text;
			dispatchEvent(new Event("onBtnClick"))
		}
		public function removeAllListener():void
		{
			fBtn.removeEventListener(MouseEvent.CLICK,onBtnClick)
		}
	}

}