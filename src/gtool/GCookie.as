package gtool
{
	import flash.net.SharedObject;

	public class GCookie
	{
		private var _time:uint;
		private var _name:String;
		private var _so:SharedObject;
		
		public function GCookie(name_:String = "tatagame",timeOut_:uint = 259200)
		{
			_name = name_;
			_time = timeOut_;
			_so = SharedObject.getLocal(_name,"/");
		}
		//清除超时内容
		public function clearTimeOut():void
		{
			var obj:* = _so.data.cookie;
			if(obj == undefined)
			{
				return;
			}
			for(var key:Object in obj)
			{
				if(obj[key] == undefined || obj[key].time == undefined || isTimeOut(obj[key].time))
				{
					delete obj[key];
				}
			}
			_so.data.cookie = obj;
			_so.flush();	
		}
		private function isTimeOut(time_:uint):Boolean
		{
			var today:Date = new Date();
			return time_ + _time * 1000 < today.getTime();
		}
		//获取超时值
		public function getTimeOut():uint
		{
			return _time;
		}
		//获取名称
		public function getName():String
		{
			return _name;
		}
		//清除Cookie所有值
		public function clear():void
		{
			_so.clear();
		}
		public function put(key_:String,value_:*):void
		{
			var today:Date = new Date();
			key_ = "key_" + key_;
			if(_so.data.cookie == undefined)
			{
				var obj:Object = {};
				obj[key_] = value_;
				_so.data.cookie = obj;
			}
			else
			{
				_so.data.cookie[key_] = value_;
			}
			//同时写会出错
			//_so.flush();
		}
		public function remove(key_:String):void
		{
			if(contains(key_))
			{
				delete _so.data.cookie["key_" + key_];
				//同时写会出错
				//_so.flush();
			}
		}
		public function get(key_:String):Object
		{
			return contains(key_)?_so.data.cookie["key_" + key_]:null;
		}
		public function contains(key_:String):Boolean
		{
			key_ = "key_" + key_;
			return _so.data.cookie != undefined && _so.data.cookie[key_] != undefined;
		}
	}
}