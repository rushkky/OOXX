package gtool
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.Dictionary;
	
	import enums.EventType;
	import enums.MyEvent;
	import enums.ResType;
	

	public class GLoader extends EventDispatcher
	{
		private static var _instance:GLoader;
		private static var PrePath:String="";
		private static var Ver:String="";
		
		
		private var _loadList:Array;
		private var _dataMap:Dictionary;
		
		private var _tempDataMap:Dictionary;
		
		private var _loader:Loader;
		private var _urlloader:URLLoader;
		private var _req:URLRequest;
		private var _loadercontext:LoaderContext;
		
		private var _isLoading:Boolean = false;
		

		public function GLoader()
		{
			_instance = this;
			this.init();
			this.initListener();
		}
		private function init():void
		{
			this._loadList = new Array();
			this._dataMap = new Dictionary();
			
			this._loader = new Loader();
			this._urlloader = new URLLoader();
			this._req = new URLRequest();
			this._loadercontext = new LoaderContext(false, ApplicationDomain.currentDomain, null);
			this._loadercontext.allowCodeImport = true;
			
		}
		private function initListener():void
		{
			this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onComplete);
			this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onError);
			this._loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onError);
			this._loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,onProgress);
			
			this._urlloader.addEventListener(Event.COMPLETE,onComplete);
			this._urlloader.addEventListener(IOErrorEvent.IO_ERROR,onError);
			this._urlloader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onError);
			this._urlloader.addEventListener(ProgressEvent.PROGRESS,onProgress);
		}
		public function addTempRes(key_:String,data_:Object):void
		{
			if(_tempDataMap == null)
			{
				_tempDataMap = new Dictionary;
			}
			_tempDataMap[key_] = data_;
		}
		public function clearTempRes():void
		{
			for each(var key:String in _tempDataMap)
			{
				_tempDataMap[key] = null;
				delete _tempDataMap[key];
			}
		}
		public function getTempRes(key_:String):Object
		{
			return _tempDataMap[key_];
		}
			
		public static function setPathVer(prePath_:String,ver_:String):void
		{
			var endPos:int = prePath_.length - 1;
			if(prePath_.charAt(endPos) == "/")
			{
				prePath_ = prePath_.substring(0,endPos);
			}
			PrePath = prePath_;
			Ver = ver_;
		}
		public function getRes(key_:String):*
		{
			return this._dataMap[key_];
		}
		public function getClass(key_:String,cls_:String):Class
		{
			var obj:DisplayObject = this._dataMap[key_] as DisplayObject;
			if(obj != null)
			{
				if(obj.loaderInfo.applicationDomain.hasDefinition(cls_))
				{
					var cls:Class = obj.loaderInfo.applicationDomain.getDefinition(cls_) as Class;
					return cls;
				}
				else
				{
					return null;
				}
			}
			return null;
		}
		public function load(url_:String,type_:int,key_:String):void
		{
			if(this._dataMap[key_]==null)
			{
				var ld:LoadData = new LoadData();
				ld.url = url_;
				ld.type = type_;
				ld.key = key_;
				this._loadList.push(ld);
			}
			else
			{
				var event:MyEvent = new MyEvent(EventType.RES_LOAD);
				event.key = key_;
				event.value = this._dataMap[key_];
				if(type_ == ResType.BYE)
				{
					this._dataMap[key_].position = 0;
				}
				this.dispatchEvent(event);
				
				GMsg.GetInstance().dispatchMsgEvent(EventType.RES_LOAD,event);
				trace(key_+"加载成功");
				
				this.checkLoad();
				return;
			}
			//没有加载过
			if(!this._isLoading)
			{
				startLoad();
			}
		}
		public function remove(key_:String):void
		{
			this._dataMap[key_] = null;
			delete this._dataMap[key_];
		}
		private function onComplete(e:Event):void
		{	
			this._isLoading = false;
			var ld:LoadData = this._loadList.shift();
			switch(ld.type)
			{
				case ResType.SWF:
				case ResType.IMAGE:
					this._dataMap[ld.key] = this._loader.content;
					break;
				case ResType.TEXT:
					this._dataMap[ld.key] = XML(this._urlloader.data);
					break;
				case ResType.BYE:
					this._dataMap[ld.key] = this._urlloader.data;
					this._dataMap[ld.key].inflate();
					break;
			}
			
			var event:MyEvent = new MyEvent(EventType.RES_LOAD);
			event.key = ld.key;
			event.value = this._dataMap[ld.key];
			this.dispatchEvent(event);
			
			GMsg.GetInstance().dispatchMsgEvent(EventType.RES_LOAD,event);
			trace(ld.key+"加载成功");
			
			this.checkLoad();
		}
		private function onError(e:Event):void
		{
			this._isLoading = false;
			var ld:LoadData = this._loadList.shift();
			
			trace(ld.key+"加载失败:"+ld.url);
			this.checkLoad();
		}
		private function onProgress(e:ProgressEvent):void
		{
			var ld:LoadData = this._loadList[0];
			var event:MyEvent = new MyEvent(EventType.RES_PROGRESS);
			event.key = ld.key;
			event.value = [ld,e];
			this.dispatchEvent(event);
		}
		private function startLoad():void
		{
			var ld:LoadData = this._loadList[0] as LoadData;
			//处理URL
			var url1:String = ld.url;
			var url2:String = ld.url;
			var reqIndex:int = url2.lastIndexOf("?");
			if(reqIndex < 0)
			{
				url2 = url1 + Ver;
			}
			else
			{
				if(url2.lastIndexOf(Ver) != reqIndex)
				{
					url2 = url2 + "&" + Ver.substring(1);
				}
			}
			
			if(url2.charAt(0) == "/")
			{
				if(PrePath == "")
				{
					url2 = url2.substring(1);
				}
				else
				{
					url2 = PrePath + url2;
				}
						
			}
			
			switch(ld.type)
			{
				case ResType.SWF:
				case ResType.IMAGE:
					this._req.url = url2;
					this._loader.load(this._req,_loadercontext);
					break;
				case ResType.TEXT:
				case ResType.BYE:
					this._urlloader.dataFormat = URLLoaderDataFormat.BINARY;
					this._req.url = url2;
					this._urlloader.load(this._req);
					break;
			}
			this._isLoading = true;
	
		}
		private function checkLoad():void
		{
			if(this._loadList.length>0)
			{
				this.startLoad();	
			}
			else
			{
				this.dispatchEvent(new MyEvent(EventType.RES_ALLLOAD));
				GMsg.GetInstance().dispatchMsgEvent(EventType.RES_ALLLOAD);
				trace("全部加载完");
			}
		}

		public static function GetInstance():GLoader
		{
			if(!_instance) new GLoader();
			return _instance;
		}
	}
}


class LoadData
{
	//路径
	public var url:String;
	//key
	public var key:String;
	//类型
	public var type:int;
	
	public function LoadData():void
	{
		
	}
}

