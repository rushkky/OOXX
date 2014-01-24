package avatars
{

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	
	public class Avatar extends Bitmap implements IAvatar
	{
		public static var mapBitmap:Dictionary = new Dictionary;
		//当前动作当前帧
		private var _currentFrame:int = 1;
		//当前动作全部帧
		private var _totalFrame:int = 1;
		//当前动作关键帧
		private var _keyFrame:int = 1;
		//当前动作
		private var _action:int = 0;
		//全部动作
		private var _arrAction:Array = [null,null,null,null,null,null];
		//全部动作帧率
		private var _arrActionFrame:Array = [null,null,null,null,null,null];
		//全部动作攻击关键帧
		private var _arrKeyFrame:Array = [null,null,null,null,null,null];
		//是否正在播放动作
		private var _bPlay:Boolean = false;
		//是否循环播放
		private var _bLoop:Boolean = true;
		//当前delay
		private var _currentDelay:int;
		//上一次time
		private var _lastDelay:int;
		//总delay
		private var _totalDelay:int;
		//暂停继续
		private var _stoptime:int = 0;
		private var _goontime:int = 0;
		
		//裁剪图片
		private var _rect:Rectangle = new Rectangle;
		private var _point:Point = new Point;

		
		public function Avatar()
		{
			this.addEventListener(Event.ENTER_FRAME,onFrame);
		}
		/**
		 *注册一个动作 (默认播放速度25帧)
		 * @param action_ 动作类别
		 * @param bitmapData_ 
		 * @param xml_
		 * @param frame_ 帧率
		 * @param key_ 关键帧
		 */		
		public function registeerAction(action_:int,bitmapData_:BitmapData,xml_:XML,key_:int=0,frame_:int=25):void
		{
			if(_arrAction[action_] == null)
			{
				_arrAction[action_] = [];
				_arrActionFrame[action_] = [];
				_arrKeyFrame[action_] = [];
				
				for each (var subTexture:XML in xml_.SubTexture)
				{
					var name:String        = subTexture.attribute("name");
					var x:Number           = parseFloat(subTexture.attribute("x"));
					var y:Number           = parseFloat(subTexture.attribute("y"));
					var width:Number       = parseFloat(subTexture.attribute("width"));
					var height:Number      = parseFloat(subTexture.attribute("height"));
					var frameX:Number      = parseFloat(subTexture.attribute("frameX"));
					var frameY:Number      = parseFloat(subTexture.attribute("frameY"));
					var frameWidth:Number  = parseFloat(subTexture.attribute("frameWidth"));
					var frameHeight:Number = parseFloat(subTexture.attribute("frameHeight"));
					
					if(isNaN(frameX) == true || isNaN(frameY) == true || isNaN(frameWidth) == true || isNaN(frameHeight) == true)
					{
						frameX = 0;
						frameY = 0;
						frameWidth = width;
						frameHeight = height;
					}
					_rect.x = x;
					_rect.y = y;
					_rect.width = width;
					_rect.height = height;
					_point.x = Math.abs(frameX);
					_point.y = Math.abs(frameY);
					var bd:BitmapData = new BitmapData(frameWidth,frameHeight,true,0);
					bd.copyPixels(bitmapData_,_rect,_point);
					_arrAction[action_].push(bd);
				}	
				//默认最后一帧
				if(key_ == 0)
				{
					_arrKeyFrame[action_].push(_arrAction[action_].length);
				}
				else
				{
					_arrKeyFrame[action_].push(key_);
				}
				_arrActionFrame[action_].push(frame_);
			}
		}
		/**
		 *设置某个动作播放速度（25帧为标准攻击速度）
		 * @param action_
		 * @param speed_ 多少毫秒执行一次攻击
		 * 
		 */		
		public function setActionSpeed(action_:int,speed_:int):void
		{
			if(_arrActionFrame[action_])
			{
				var s:Number = speed_/1000;
				var frame:int = s>1?25:25/s;
				_arrActionFrame[action_][0] = frame;
			}	
			else
			{
				trace("动作:["+action_+"]未注册！")
			}
			
		}
		/**
		 *播放某个动作 
		 * @param action_
		 * @param loop_ 是否循环
		 * 
		 */		
		public function play(action_:int=1,loop_:Boolean=false):void
		{
			
			
			_bPlay = true;
			_bLoop = loop_;
			_currentFrame = 1;
			_action = action_;
			
			_totalFrame = _arrAction[action_].length;
			_keyFrame = _arrKeyFrame[action_];
			_currentDelay = 0;
			_totalDelay = 1000/_arrActionFrame[action_];
			
			
		}
		/**
		 *暂停 
		 * @param type_ 0第一帧 1当前帧 2最后一帧
		 * 
		 */		
		public function stop(type_:int=0):void	
		{
			_bPlay = false;	
			if(type_ == 0)
			{
				_currentFrame = 1;
			}
			else if(type_ == 1)
			{
				
			}
			else
			{
				_currentFrame = _arrAction[_action].length;
			}
			
			_stoptime = getTimer();
		}
		public function goon():void
		{
			_bPlay = true;
			_goontime = getTimer();
		}
		public function onFrame(e:Event):void
		{
			if(_bPlay) return;
			
			if(_stoptime != 0 && _goontime != 0)
			{
				_currentDelay += _goontime - _stoptime;
				_stoptime = 0;
				_goontime = 0;
			}

			var temp:int = getTimer();
			_currentDelay += temp - _lastDelay;
			_lastDelay = temp;
			if(_currentDelay >= _totalDelay)
			{
				_currentDelay = 0;
				
				this.bitmapData = _arrAction[_action][_currentFrame-1];
				this.smoothing = true;
				_currentFrame++;
				if(_currentFrame == _keyFrame)
				{
					dispatchEvent(new Event("onKeyFrame"));
				}
				if(_currentFrame > _totalFrame)
				{
					_currentFrame = 1;
					if(!_bLoop)
					{
						_bPlay = false;
						dispatchEvent(new Event("onFrameEnd"));
					}
				}
			}
			
		}

		public function dispose():void
		{
			_arrAction = null;
			_arrActionFrame = null;
			_arrKeyFrame = null;
			_rect = null;
			_point = null;
			this.removeEventListener(Event.ENTER_FRAME,onFrame);
		}
	}
}