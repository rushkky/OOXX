package enums
{
	import flash.events.Event;
	
	public class MyEvent extends Event
	{
		//key
		public var key:String;
		//携带数据
		public var value:Object;
		
		public function MyEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}