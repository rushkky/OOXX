package gtool
{
	import flash.utils.ByteArray;
		
	import message.IMessage;

	public class GMsg
	{
		private static var _instance:GMsg;

		private var _arrAddMsg:Array;
		
		public function GMsg()
		{
			_instance = this;
			this.init();
		}
		private function init():void
		{
			this._arrAddMsg = new Array();
		}
		public function addMsgListener(obj_:Object,eventType_:Object,callback_:Function):void
		{
			//判断事件是否添加过
			for(var i:int=0;i<this._arrAddMsg.length;++i)
			{
				if(this._arrAddMsg[i].object == obj_ && this._arrAddMsg[i].eventType == eventType_ && this._arrAddMsg[i].fun == callback_)
				{
					return;
				}
			}
			
			var md:MsgData = new MsgData();
			md.object = obj_;
			md.eventType = eventType_;
			md.fun = callback_;
			this._arrAddMsg.push(md);
		}
		public function removeMsgListener(obj_:Object,eventType_:Object,callback_:Function):void
		{
			for(var i:int=0;i<this._arrAddMsg.length;++i)
			{
				var md:MsgData = this._arrAddMsg[i] as MsgData;
				if(md.object == obj_ && md.eventType == eventType_ && md.fun == callback_)
				{
					this._arrAddMsg.splice(i,1);
					i--;
				}
			}
		}
		public function removeMsgListenerEx(obj_:Object):void
		{
			for(var i:int=0;i<this._arrAddMsg.length;++i)
			{
				var md:MsgData = this._arrAddMsg[i] as MsgData;
				if(md.object == obj_)
				{
					this._arrAddMsg.splice(i,1);
					i--;
				}
			}
			trace("当前自定义消息总数："+this._arrAddMsg.length);
		}
		public function dispatchMsgEvent(eventType_:String,...params_:Array):void
		{
			for(var i:int=0;i<this._arrAddMsg.length;++i)
			{
				var md:MsgData = this._arrAddMsg[i] as MsgData;
				//服务器消息
				if(md.eventType is Class)
				{
					var cls:Class = md.eventType as Class;
					var msg:IMessage = new cls();
					if(msg.msgType == eventType_)
					{
						var data:ByteArray = params_[0] as ByteArray;
						data.position = 0;
						msg.init();
						msg.decode(data);
						md.fun.apply(md.object,[msg]);
					}
				}
				//自定义消息
				else
				{
					if(md.eventType == eventType_)
					{
						md.fun.apply(md.object,params_);
					}
				}
			}
		}
		public function removeAllMsgListener():void
		{
			this._arrAddMsg.splice(0,this._arrAddMsg.length);
		}
		public static function GetInstance():GMsg
		{
			if(!_instance) new GMsg;
			return _instance;
		}
		
	}
}

class MsgData
{
	//对象
	public var object:Object;
	//事件类型
	public var eventType:Object;
	//回调函数
	public var fun:Function;
	
	public function MsgData()
	{
		
	}
}
