package gtool
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	public class GByte
	{
		private static var _instance:GByte;
		
		private static var tempBA:ByteArray = new ByteArray();
		private static var tempCharBA:ByteArray = new ByteArray();
		
		private var _clonBA:ByteArray;
		private var _zeroMap:Vector.<ByteArray>;
		
		public function GByte()
		{
			_instance = this;
			this.init();
		}
		private function init():void
		{
			this._clonBA = new ByteArray();
		}
		/**
		 *深度复制对象 
		 * @param obj_
		 * @return 
		 * 
		 */		
		public function clonObj(obj_:*):*
		{
			this._clonBA.writeObject(obj_);
			this._clonBA.position = 0;
			var newObj:* = this._clonBA.readObject();
			this._clonBA.clear();
			return newObj;
		}
		/**
		 *写入 ByteArray
		 * @return 
		 * 
		 */		
		public static function GetTempBA():ByteArray
		{
			tempBA.clear();
			tempBA.endian = Endian.LITTLE_ENDIAN;
			return tempBA;
		}
		/**
		 *得到一个 ByteArray
		 * @return 
		 * 
		 */		
		public static function GetBA():ByteArray
		{
			var ba:ByteArray = new ByteArray();
			ba.endian = Endian.LITTLE_ENDIAN;
			return ba;
		}
		/**
		 *得到某位的数据 
		 * @param value_
		 * @param index_
		 * @return 
		 * 
		 */		
		public function getByteValue(value_:int,index_:uint):Boolean
		{
			return ((value_ >> index_) & 1) == 1;
		}
		/**
		 *设置某位数据 
		 * @param value_
		 * @param index_
		 * @param setValue_
		 * @return 
		 * 
		 */		
		public function setByteValue(value_:int,index_:uint,setValue_:Boolean):int
		{
			var makeValue:int = 1 << index_;
			if(setValue_)
			{
				return value_ | makeValue;
			}
			else
			{
				makeValue = ~makeValue;
				return value_ & makeValue;
			}
		}
		//读操作////////////////////////////////////////////////////////////////////////////////////
		public function readOBJID(ba_:ByteArray):uint
		{
			return ba_.readUnsignedInt();
		}
		public function readDWORD(ba_:ByteArray):uint
		{
			return ba_.readUnsignedInt();
		}
		public function readLONG(ba_:ByteArray):int
		{
			return ba_.readInt();
		}
		public function readULONG(ba_:ByteArray):uint
		{
			return ba_.readUnsignedInt();
		}
		public function readINT(ba_:ByteArray):int
		{
			return ba_.readInt();
		}
		public function readINT32(ba_:ByteArray):int
		{
			return ba_.readInt();
		}
		public function readUINT32(ba_:ByteArray):uint
		{
			return ba_.readUnsignedInt();
		}
		public function readSHORT(ba_:ByteArray):int
		{
			return ba_.readShort();
		}
		public function readUSHORT(ba_:ByteArray):uint
		{
			return ba_.readUnsignedShort();
		}
		public function readCHAR(ba_:ByteArray):int
		{
			return ba_.readByte();
		}
		public function readUCHAR(ba_:ByteArray):uint
		{
			return ba_.readUnsignedByte();
		}
		public function readBOOLEAN(ba_:ByteArray):Boolean
		{
			return ba_.readBoolean();
		}
		public function readCHARS(ba_:ByteArray,len_:int):String
		{
			return ba_.readMultiByte(len_,"utf-8");
		}
		public function readI64(ba_:ByteArray):Number
		{
			var a:uint = ba_.readUnsignedInt();
			var b:int = ba_.readInt();
			return a + b * 0x100000000;
		}
		//写操作////////////////////////////////////////////////////////////////////////////////////
		public function writeOBJID(ba_:ByteArray,value_:uint):void
		{
			ba_.writeUnsignedInt(value_);
		}
		public function writeDWORD(ba_:ByteArray,value_:uint):void
		{
			ba_.writeUnsignedInt(value_);
		}
		public function writeLONG(ba_:ByteArray,value_:int):void
		{
			ba_.writeInt(value_);
		}
		public function writeULONG(ba_:ByteArray,value_:uint):void
		{
			ba_.writeUnsignedInt(value_);
		}
		public function writeINT(ba_:ByteArray,value_:int):void
		{
			ba_.writeInt(value_);
		}
		public function writeINT32(ba_:ByteArray,value_:int):void
		{
			ba_.writeInt(value_);
		}
		public function writeUINT32(ba_:ByteArray,value_:uint):void
		{
			ba_.writeUnsignedInt(value_);
		}
		public function writeSHORT(ba_:ByteArray,value_:int):void
		{
			ba_.writeShort(value_);
		}
		public function writeUSHORT(ba_:ByteArray,value_:int):void
		{
			ba_.writeShort(value_);
		}
		public function writeCHAR(ba_:ByteArray,value_:int):void
		{
			ba_.writeByte(value_);
		}
		public function writeUCHAR(ba_:ByteArray,value_:int):void
		{
			ba_.writeByte(value_);
		}
		public function writeBOOLEAN(ba_:ByteArray,value_:Boolean):void
		{
			ba_.writeBoolean(value_);
		}
		public function writeUTF(ba_:ByteArray,value_:String):void
		{
			ba_.writeUTF(value_);
		}
		/**
		 *写入值不能为负数 
		 * @param ba_
		 * @param value_
		 * 
		 */		
		public function writeI64(ba_:ByteArray,value_:Number):void
		{
			for(var i:int=0;i<8;++i)
			{
				ba_.writeByte(value_ & 0xff);
				value_ = value_ >>> 8
			}
		}
		/**
		 *写字符串 
		 * @param byte_
		 * @param str_
		 * @param byteLen_
		 * @return 	0	正好
		 * 			正数	多的0补
		 * 			负数	多的删除
		 * 
		 */		
		public function writeCHARS(byte_:ByteArray,str_:String,byteLen_:uint=0):int
		{
			var tempBA:ByteArray = new ByteArray();
			this._zeroMap = new Vector.<ByteArray>;
			for(var i:int=0;i<33;++i)
			{
				tempBA.writeByte(0);
				var newBA:ByteArray = new ByteArray();
				newBA.writeBytes(tempBA);
				this._zeroMap.push(newBA);
			}
			
			if(byteLen_ == 0)
			{
				byte_.writeMultiByte(str_,"utf-8");
				return 0;
			}
			tempCharBA.endian = Endian.LITTLE_ENDIAN;
			tempCharBA.writeMultiByte(str_,"utf-8");
			var offset:int = byteLen_ - tempCharBA.length;
			if(offset > 0)
			{
				tempCharBA.writeBytes(this._zeroMap[offset]);
			}
			byte_.writeBytes(tempCharBA,0,byteLen_);
			
			tempCharBA.position = 0;
			tempCharBA.length = 0;
			
			return offset;
		}
		
		public static function GetInstance():GByte
		{
			if(!_instance) new GByte;
			return _instance;
		}
	}
}
