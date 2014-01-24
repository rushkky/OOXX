package enums
{
	public class EventType
	{
		//单个资源加载完
		public static var RES_LOAD:String = "RES_LOAD";
		//资源队列中资源全部加载完
		public static var RES_ALLLOAD:String = "RES_ALLLOAD";
		//资源加载过程
		public static var RES_PROGRESS:String = "RES_PROGRESS";
		//GM命令
		public static var EVENT_GM_SEND:String = "EVENT_GM_SEND";
		
		public function EventType()
		{
		}
	}
}