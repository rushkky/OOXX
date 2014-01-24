package panels
{
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.system.System;
	
	import enums.EventType;
	import enums.MyEvent;
	import enums.ResType;
	
	import gtool.GLoader;
	import gtool.GMsg;
	import gtool.GPath;
	

	public class Panel extends MovieClip implements IPanel
	{
		private var _name:String;
		private var _resname:String;
		private var _panel:*;
		private var _data:Object;

		public function Panel(data_:Object=null)
		{
			//this.cacheAsBitmap = true;
			_data = data_;
		}

		public function get data():Object
		{
			return _data;
		}

		public function get panel():*
		{
			return _panel;
		}

		/**
		 *加载面板 
		 * @param key_
		 * @param callback_
		 * 
		 */		
		public function load(key_:String):void
		{
			this._name = key_;
			this._resname = key_ + "Res";
			GMsg.GetInstance().addMsgListener(this,EventType.RES_LOAD,onResLoad);
			GLoader.GetInstance().load(GPath.PanelPath+this._resname+".swf",ResType.SWF,this._resname);
			function onResLoad(e:MyEvent):void
			{
				var cls:Class = GLoader.GetInstance().getClass(this._resname,this._resname);
				if(cls != null)
				{
					GMsg.GetInstance().removeMsgListenerEx(this);
					_panel = new cls();
					addChild(_panel);
					init();
				}
			}
		}
		/**
		 *面板初始化 
		 * 
		 */		
		public function init():void
		{
			
		}
		/**
		 *显示面板 
		 * 
		 */		
		public function show():void
		{
			this.visible = true;
		}
		/**
		 *隐藏面板 
		 * 
		 */		
		public function hide():void
		{
			this.visible = false;
		}
		/**
		 *隐藏关闭面板 
		 * 
		 */		
		public function hideAndClose():void
		{
			this.hide();
			this.close();
		}
		/**
		 *销毁面板 
		 * 
		 */		
		protected function dispose():void
		{
			GMsg.GetInstance().dispatchMsgEvent("onPanelHideAndClose",this._name);
		}
		/**
		 *关闭面板 
		 * 
		 */		
		public function close():void
		{
			if(this._panel)
			{
				GLoader.GetInstance().remove(this._resname);
				
				var num:uint = this._panel.numChildren;
				while(num > 0)
				{
					var display:DisplayObject = this._panel.removeChildAt(0);
					num--;
					display = null;
				}

				this._panel.parent.removeChild(this._panel);
				this._panel.removeAllListener();
				this._panel = null;
			}
			System.gc();
		}
		/**
		 *设置数据 
		 * @param data_
		 * 
		 */		
		public function setData(data_:Object=null):void
		{
			this._data = data_;
		}
	}
}