/**
 * Stats
 * 
 * Released under MIT license:
 * http://www.opensource.org/licenses/mit-license.php
 *
 * How to use:
 * 
 *	addChild( new Stats() );
 *	
 *	or
 *	
 *	addChild( new Stats( { bg: 0xffffff } );
 * 
 * version log:
 *
 *	09.10.22		2.2		Mr.doob			+ FlipX of graph to be more logic.
 *											+ Destroy on Event.REMOVED_FROM_STAGE (thx joshtynjala)
 *	09.03.28		2.1		Mr.doob			+ Theme support.
 *	09.02.21		2.0		Mr.doob			+ Removed Player version, until I know if it's really needed.
 *											+ Added MAX value (shows Max memory used, useful to spot memory leaks)
 *											+ Reworked text system / no memory leak (original reason unknown)
 *											+ Simplified				
 *	09.02.07		1.5		Mr.doob			+ onRemovedFromStage() (thx huihuicn.xu)
 *	08.12.14		1.4		Mr.doob			+ Code optimisations and version info on MOUSE_OVER
 *	08.07.12		1.3		Mr.doob			+ Some speed and code optimisations
 *	08.02.15		1.2		Mr.doob			+ Class renamed to Stats (previously FPS)
 *	08.01.05		1.2		Mr.doob			+ Click changes the fps of flash (half up increases, half down decreases)
 *	08.01.04		1.1		Mr.doob			+ Shameless ripoff of Alternativa's FPS look :P
 *							Theo			+ Log shape for MEM
 *											+ More room for MS
 * 	07.12.13		1.0		Mr.doob			+ First version
 **/

package utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.system.System;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.utils.getTimer;
	
	import enums.EventType;
	
	import gtool.GMsg;

	public class Stats extends Sprite
	{	
		protected const _WIDTH : uint = 70;
		protected const _HEIGHT : uint = 100;
		
		protected var xml : XML;

		protected var text : TextField;
		protected var style : StyleSheet;

		protected var timer : uint;
		protected var fps : uint;
		protected var ms : uint;
		protected var ms_prev : uint;
		protected var mem : Number;
		protected var mem_max : Number;
		
		protected var graph : Bitmap;
		protected var rectangle : Rectangle;
		
		protected var fps_graph : uint;
		protected var mem_graph : uint;
		protected var mem_max_graph : uint;
		
		protected var theme : Object = { bg: 0x000033, fps: 0xffff00, ms: 0x00ff00, mem: 0x00ffff, memmax: 0xff0070 }; 
		
		private var _currentFps:uint;
		
		private var shift_down : Boolean = false;
		
		private var _log:LogUtils;

		/**
		 * <b>Stats</b> FPS, MS and MEM, all in one.
		 * 
		 * @param _theme         Example: { bg: 0x202020, fps: 0xC0C0C0, ms: 0x505050, mem: 0x707070, memmax: 0xA0A0A0 } 
		 */
		public function Stats( _theme : Object = null ) : void
		{
			if (_theme)
			{
				if (_theme.bg != null) theme.bg = _theme.bg;
				if (_theme.fps != null) theme.fps = _theme.fps;
				if (_theme.ms != null) theme.ms = _theme.ms;
				if (_theme.mem != null) theme.mem = _theme.mem;
				if (_theme.memmax != null) theme.memmax = _theme.memmax;
			}

			this.addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		public function get log():LogUtils
		{
			return _log;
		}

		private function onAddToStage(e : Event) : void
		{
			mem_max = 0;
			
			xml = <xml><fps>FPS:</fps><ms>MS:</ms><mem>MEM:</mem><memMax>MAX:</memMax></xml>;
			
			style = new StyleSheet();
			style.setStyle("xml", {fontSize:'9px', fontFamily:'_sans', leading:'-2px'});
			style.setStyle("fps", {color: hex2css(theme.fps)});
			style.setStyle("ms", {color: hex2css(theme.ms)});
			style.setStyle("mem", {color: hex2css(theme.mem)});
			style.setStyle("memMax", {color: hex2css(theme.memmax)});
			
			text = new TextField();
			text.width = _WIDTH;
			text.height = 50;
			text.styleSheet = style;
			text.condenseWhite = true;
			text.selectable = false;
			text.mouseEnabled = false;
			
			graph = new Bitmap();
			graph.y = 50;
			
			rectangle = new Rectangle( _WIDTH - 1, 0, 1, _HEIGHT - 50 );	
			
			graphics.beginFill(theme.bg);
			graphics.drawRect(0, 0, _WIDTH, _HEIGHT);
			graphics.endFill();

			addChild(text);
			
			graph.bitmapData = new BitmapData(_WIDTH, _HEIGHT - 50, false, theme.bg);
			addChild(graph);
			
			_log = new LogUtils(960,640,0xffffff,0x000000);
			_log.visible = false;
			this.addChild(_log);
			
			
			this.addEventListener(MouseEvent.CLICK, onClick);
			this.addEventListener(Event.ENTER_FRAME, update);
			
			this.addEventListener(KeyboardEvent.KEY_DOWN,keydown)
			this.addEventListener(KeyboardEvent.KEY_UP,keyup)
		}
		
		public function out(strInfo : String):void
		{
			_log.out(strInfo);
		}
				
		private function keydown(e:KeyboardEvent):void
		{
			if(e.keyCode == 16)			//shift
			{
				shift_down = true;
			}
			if(shift_down)
			{
				if(e.keyCode == 80)		//p
				{
					if(this.visible)
					{
						this.visible = false;
					}
					else
					{
						this.visible = true;
					}
				}
			}
		}
		private function keyup(e:KeyboardEvent):void
		{
			if(e.keyCode == 16)
			{
				shift_down = false;
			}
		}
		
		private function update(e : Event) : void
		{
			timer = getTimer();
			
			if( timer - 1000 > ms_prev )
			{
				ms_prev = timer;
				mem = Number((System.totalMemory * 0.000000954).toFixed(3));
				mem_max = mem_max > mem ? mem_max : mem;
				
				fps_graph = Math.min( graph.height, ( fps / stage.frameRate ) * graph.height );
				mem_graph =  Math.min( graph.height, Math.sqrt( Math.sqrt( mem * 5000 ) ) ) - 2;
				mem_max_graph =  Math.min( graph.height, Math.sqrt( Math.sqrt( mem_max * 5000 ) ) ) - 2;
				
				graph.bitmapData.scroll( -1, 0 );
				
				graph.bitmapData.fillRect( rectangle , theme.bg );
				graph.bitmapData.setPixel( graph.width - 1, graph.height - fps_graph, theme.fps);
				graph.bitmapData.setPixel( graph.width - 1, graph.height - ( ( timer - ms ) >> 1 ), theme.ms );
				graph.bitmapData.setPixel( graph.width - 1, graph.height - mem_graph, theme.mem);
				graph.bitmapData.setPixel( graph.width - 1, graph.height - mem_max_graph, theme.memmax);
				
				xml.fps = "FPS: " + fps + " / " + stage.frameRate;
				xml.mem = "MEM: " + mem;
				xml.memMax = "MAX: " + mem_max;
				_currentFps = fps;
				fps = 0;
			}

			fps++;
			
			xml.ms = "MS: " + (timer - ms);
			ms = timer;
			
			text.htmlText = xml;
		}
		
		private function onClick(e : MouseEvent) : void
		{
			if(_log.visible == false)
			{
				_log.visible = true;
			}
			else
			{
				if(e.stageX > stage.stageWidth/2)
				{
					_log.visible = false;
					var gm:String = _log.getGM();
					if(gm != "GM命令输入:")
					{
						//发送命令
						trace("发送GM命令:"+_log.getGM());
						GMsg.GetInstance().dispatchMsgEvent(EventType.EVENT_GM_SEND,_log.getGM());
						_log.clearGM();
					}
				}
			}
		}
	
		private function hex2css( color : int ) : String
		{
			return "#" + color.toString(16);
		}
	}
}