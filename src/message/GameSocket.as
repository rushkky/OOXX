package message
{
	import flash.events.ProgressEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.Endian;
	
	import gtool.GByte;
	import gtool.GMsg;
	
	import message.IMessage;

	public class GameSocket extends Socket
	{
		private static var _instance:GameSocket;
		private var _msgClsMap:Dictionary;
		//消息长度+消息ID 4字节
		private var _len:int = 4;
		//处理多包接收
		private var _isEnd:Boolean = true;
		
		
		public function GameSocket(host_:String=null,port_:uint=0,endian_:String=Endian.LITTLE_ENDIAN)
		{
			super(host_,port_);
			super.endian = endian_;
			_instance = this;
			this.init();
		}
		private function init():void
		{
			this._msgClsMap = new Dictionary();
			
			this.initListener();
		}
		public function getMsgObject(msgCls_:Class):IMessage
		{
			var msg:IMessage = this._msgClsMap[msgCls_] as IMessage;
			if(msg == null)
			{
				msg = new msgCls_();
				this._msgClsMap[msgCls_] = msg;
				this._msgClsMap[msg.msgID] = msg;
			}
			return msg;
		}
		public function send(msgCls_:IMessage):void
		{
			if(!this.connected) return;
			
			var data:ByteArray = msgCls_.encode();
			
			CONFIG::debugmsg
			{
				trace("向服务器发消息：消息ID："+msgCls_.msgID+" 消息长度："+data.length);
			}
			
			var dataLen:int = _len;
			if(data != null)
			{
				data.position = 0;
				dataLen += data.length;
			}
			
			super.writeShort(dataLen);
			super.writeShort(msgCls_.msgID);
			
			if(data != null && dataLen >0) super.writeBytes(data);
			
			super.flush();
			
		}
		private function initListener():void
		{
			this.addEventListener(ProgressEvent.SOCKET_DATA,onSocketDataHandle);
		}
		private function onSocketDataHandle(e:ProgressEvent):void
		{
			while(this.bytesAvailable >= this._len)
			{
				if(!this._isEnd)
				{
					this.readData(this._len);
					this._isEnd = true;
					this._len = 4;
					continue;
				}
				//消息长度
				var len:int = this.readUnsignedShort() - 2;
				if(len<0) throw new Error("消息长度不对");
				//多包续传
				if(this.bytesAvailable < len)
				{
					this._len = len;
					this._isEnd = false;
					return;
				}
				this.readData(len);
			}
		}
		private function readData(dataLen_:int):void
		{
			//消息ID
			dataLen_ -= 2;
			
			var msgID:int = this.readUnsignedShort();
			var data:ByteArray = GByte. GetBA();
			if(dataLen_ > 0)
			{
				this.readBytes(data,0,dataLen_);
			}
			CONFIG::debugmsg
			{
				trace("收到服务器消息：消息ID："+msgID+" 消息长度："+dataLen_);
			}
			GMsg.GetInstance().dispatchMsgEvent(String(msgID),data);
		}
		public static function GetInstance():GameSocket
		{
			if(!_instance) new GameSocket;
			return _instance;
		}
	}
}