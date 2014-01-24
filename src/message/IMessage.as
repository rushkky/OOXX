package message
{
	import flash.utils.ByteArray;

	public interface IMessage
	{
		/**
		 *消息ID 
		 * @return 
		 * 
		 */		
		function get msgID():uint;
		/**
		 *获取该消息事件 
		 * @return 
		 * 
		 */		
		function get msgType():String;
		/**
		 *编码 
		 * @return 
		 * 
		 */		
		function encode():ByteArray;
		/**
		 *解码 
		 * @param value_
		 * 
		 */		
		function decode(value_:ByteArray):void;
		/**
		 *初始化 
		 * 
		 */		
		function init():void;
		/**
		 *输出消息数据 
		 * 
		 */		
		function toString():void;
	}
}