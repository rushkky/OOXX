package utils
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;

	public class Time extends MovieClip
	{
		private var _bPaused:Boolean;
		private var _currentDelay:Number;
		private var _totalDelay:Number;
		private var _currentRepeatCount:int;
		private var _totalRepeatCount:int;
		private var _key:String;
		
		
		public function Time()
		{

		}

		public function get bPaused():Boolean
		{
			return _bPaused;
		}

		public function set bPaused(value_:Boolean):void
		{
			_bPaused = value_;
		}

		public function init(delay_:Number,repeatCount_:int,_key_:String):void
		{
			_currentDelay = 0;
			_totalDelay = delay_;
			_currentRepeatCount = 0;
			_totalRepeatCount = repeatCount_;
			_bPaused = false;
			_key = _key_;
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		private function onAddToStage(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			this.addEventListener(Event.ENTER_FRAME,onFrame);
		}
		public function reset():void
		{
			_currentDelay = 0;
			_currentRepeatCount = 0;
		}
		private function onFrame(e:Event):void
		{
			if(_bPaused) return;
			
			_currentDelay += 1000/stage.frameRate;
			
			if(_currentDelay >= _totalDelay)
			{
				_currentDelay = 0;
				_currentRepeatCount++;
				this.dispatchEvent(new TimerEvent(TimerEvent.TIMER));
			}
			
			if(_currentRepeatCount >= _totalRepeatCount)
			{
				this.dispatchEvent(new TimerEvent(TimerEvent.TIMER_COMPLETE));
				this.removeEventListener(Event.ENTER_FRAME,onFrame);
			}
			
		}
		public function dispose():void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			this.removeEventListener(Event.ENTER_FRAME,onFrame);
		}
	}
}