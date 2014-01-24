package 
{

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;


	public class CreateRolePanelRes extends MovieClip
	{

		private var arrRole:Array;
		
		private var names:Array;
		private var boy:Array;
		private var girl:Array;
		
		public var _name:String;
		public var _role:int = 0;
		
		private var loader:URLLoader = new URLLoader;
		private var req:URLRequest = new URLRequest("NameLib.xml");
		
		public function CreateRolePanelRes()
		{
			arrRole = [fRole1,fRole2,fRole3,fRole4,fRole5,fRole6,fRole7,fRole8];
			for (var i:int=0; i<arrRole.length; ++i)
			{
				arrRole[i].addEventListener(MouseEvent.CLICK,onRoleClick);
			}
			fRandomBtn.addEventListener(MouseEvent.CLICK,onRandomClick);
			fBtn.addEventListener(MouseEvent.CLICK,onBtnClick);
			
			loader.addEventListener(Event.COMPLETE,onLoadCompleted)
			loader.load(req);
			
			fRole1.gotoAndStop(2);
			this.setChildIndex(fRole1,this.numChildren-1);
		}
		private function onLoadCompleted(e:Event):void
		{
			var xml:XML = new XML(loader.data)
			var str1:String = xml.name.@info;
			var str2:String = xml.boy.@info;
			var str3:String = xml.girl.@info;
			names = str1.split(",");
			boy = str2.split(",");
			girl = str3.split(",");
			for(var i:int=0;i<girl.length;++i)
			{
				boy.push(girl[i]);
			}
			onRandomClick(null)
			
			xml = null;

			//trace(names.length*boy.length+names.length*girl.length)
		}
		private function onRandomClick(e:MouseEvent):void
		{
			var min:int = 1;
			var max:int = names.length;
			var index:int = Math.floor(Math.random()*max)+min;
			var txt1:String = names[index-1];
			var txt2:String = "";
			var min1:int = 1;
			var max1:int = boy.length;
			var index1:int = Math.floor(Math.random()*max1)+min1;
			txt2 = boy[index1-1];
			txt1 += txt2;
			_name = txt1;
			fName.text = _name;
		}
		private function onBtnClick(e:MouseEvent):void
		{
			dispatchEvent(new Event("onBtnClick"))
		}
		private function onRoleClick(e:MouseEvent):void
		{
			var mc:* = e.currentTarget;
			var i:int = 0;
			for (i=0; i<arrRole.length; ++i)
			{
				arrRole[i].gotoAndStop(1);
				if (mc == arrRole[i])
				{
					arrRole[i].gotoAndStop(2);
					this.setChildIndex(arrRole[i],this.numChildren-1);
					_role = i;
				}
			}
		}
		public function removeAllListener():void
		{
			loader = null;
			req = null;
			names = null;
			boy = null;
			girl = null;
			for (var i:int=0; i<arrRole.length; ++i)
			{
				arrRole[i].removeEventListener(MouseEvent.CLICK,onRoleClick);
			}
			fRandomBtn.removeEventListener(MouseEvent.CLICK,onRandomClick);
			fBtn.removeEventListener(MouseEvent.CLICK,onBtnClick);
		}

	}

}