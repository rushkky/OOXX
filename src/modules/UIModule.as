package modules
{
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	import enums.DepthType;
	
	import gtool.GLoader;
	import gtool.GMsg;
	
	import panels.Panel;
	import panels.AboutPanel.AboutPanel;
	import panels.CreateRolePanel.CreateRolePanel;
	import panels.LoginPanel.LoginPanel;
	import panels.MainPanel.MainPanel;
	import panels.SkillPanel.SkillPanel;
	
	public class UIModule implements IModule
	{
		private static var _instance:UIModule;
		
		private var _uiContainer:Sprite;
		
		private var _topContainer:Sprite;
		private var _midContainer:Sprite;
		private var _bottomContainer:Sprite;
		
		private var _lc:LayerContainer;
		
		private var _pdMap:Dictionary = new Dictionary();
		private var _arrPanelData:Array = [];
		
		public function UIModule()
		{
			_instance = this;
			
			//面板数据
			var xml:XML;
			var panel_xml:XML = GLoader.GetInstance().getRes("panel.xml");
			var panel_arr:Array = [];
			for each(xml in panel_xml.panel)
			{
				var pd:PanelData = new PanelData(xml.@name,xml.@des,xml.@depth);
				_arrPanelData.push(pd);
			}
			
			GMsg.GetInstance().addMsgListener(this,"onPanelHideAndClose",onPanelHideAndClose);
			GMsg.GetInstance().addMsgListener(this,"onShowCreateRolePanel",onShowCreateRolePanel);
			GMsg.GetInstance().addMsgListener(this,"onShowMainPanel",onShowMainPanel);
			GMsg.GetInstance().addMsgListener(this,"onShowAboutPanel",onShowAboutPanel);
			GMsg.GetInstance().addMsgListener(this,"onShowSkillPanel",onShowSkillPanel);
	
		}
		private function onShowSkillPanel():void
		{
			this.show(SkillPanel.NAME);
		}
		private function onShowAboutPanel():void
		{
			this.show(AboutPanel.NAME);
		}
		private function onShowMainPanel():void
		{
			this.show(MainPanel.NAME);
		}
		private function onShowCreateRolePanel():void
		{
			this.show(CreateRolePanel.NAME);
		}
		private function onPanelHideAndClose(name_:String):void
		{
			this.hideAndClose(name_);
		}
		/**
		 *显示面板 
		 * @param name_
		 * @param data_
		 * 
		 */		
		public function show(name_:String,data_:Object=null):void
		{
			var panel:Panel;
			var pd:PanelData;
			if(_pdMap[name_])
			{
				panel = _pdMap[name_];
				panel.show();
			}
			else
			{
				for(var i:int=0;i<this._arrPanelData.length;++i)
				{
					pd = this._arrPanelData[i];
					if(name_ == pd.name)
					{
						var cls:Object = getDefinitionByName("panels."+name_+"."+name_);
						panel = new cls(data_);	
						panel.show();
						_pdMap[name_] = panel;
						break;
					}
				}
				
				switch(pd.depth)
				{
					case DepthType.BOTTOM:
						this._bottomContainer.addChild(panel);
						break;
					case DepthType.MID:
						this._midContainer.addChild(panel);
						break;
					case DepthType.TOP:
						this._topContainer.addChild(panel);
						break;
				}
			}
		}
		/**
		 *隐藏面板 
		 * @param name_
		 * 
		 */		
		public function hide(name_:String):void
		{
			_pdMap[name_].hide();
		}
		/**
		 *隐藏并且关闭 
		 * @param cls_
		 * 
		 */		
		public function hideAndClose(name_:String):void
		{
			_pdMap[name_].hideAndClose();
			_pdMap[name_].parent.removeChild(_pdMap[name_]);
			_pdMap[name_] = null;
			delete _pdMap[name_];
		}
		/**
		 *得到一个面板 
		 * @param cls_
		 * @return 
		 * 
		 */		
		public function getPanel(name_:String):Panel
		{
			return this._pdMap[name_];
		}
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		public function begin(...params:Array):void
		{
			this._uiContainer = params[0];
			
			this._topContainer = new Sprite();
			this._midContainer = new Sprite();
			this._bottomContainer = new Sprite();
			
			this._uiContainer.addChild(this._bottomContainer);
			this._uiContainer.addChild(this._midContainer);
			this._uiContainer.addChild(this._topContainer);
			
			this.show(LoginPanel.NAME,{ob:21});
				
		}
		public function end():void
		{
			var num:uint = this._topContainer.numChildren;
			var panel:*;
			while(num > 0)
			{
				panel = this._topContainer.removeChildAt(0);
				num--;
				panel.dispose();
				panel = null;
			}
			num = this._midContainer.numChildren;
			while(num > 0)
			{
				panel = this._midContainer.removeChildAt(0);
				num--;
				panel.dispose();
				panel = null;
			}
			num = this._bottomContainer.numChildren;
			while(num > 0)
			{
				panel = this._bottomContainer.removeChildAt(0);
				num--;
				panel.dispose();
				panel = null;
			}
			
			if(this._topContainer)
			{
				if(this._topContainer.parent)
				{
					this._topContainer.parent.removeChild(this._topContainer);
					this._topContainer = null;
				}
			}
			else
			{
				this._topContainer = null;
			}
			
			if(this._midContainer)
			{
				if(this._midContainer.parent)
				{
					this._midContainer.parent.removeChild(this._midContainer);
					this._midContainer = null;
				}
			}
			else
			{
				this._midContainer = null;
			}
			
			if(this._bottomContainer)
			{
				if(this._bottomContainer.parent)
				{
					this._bottomContainer.parent.removeChild(this._bottomContainer);
					this._bottomContainer = null;
				}
			}
			else
			{
				this._bottomContainer = null;
			}
			
			this._pdMap = null;
			this._arrPanelData = null;
			
		}
		public static function GetInstance():UIModule
		{
			if(!_instance) new UIModule();
			return _instance;
		}
	}
}

class PanelData
{
	public var name:String;
	public var des:String;
	public var depth:String;
	
	public function PanelData(name_:String,des_:String,depth_:String="MID")
	{
		this.name = name_;
		this.des = des_;
		this.depth = depth_;
	}
}