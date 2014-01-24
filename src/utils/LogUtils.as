/*
2011.11.7 tata 89313912
*/
package utils
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	public class LogUtils extends Sprite
	{
		private var tf : TextField;
		private var input : TextField;
		private var square : Sprite;
		private var back : Sprite;

		private var backcolor:int;
		private var fontcolor:int;
		
		private var w:int;
		private var h:int;

		public function LogUtils(w:int = 550, h:int = 400, fontcolor:int = 0xffffff, backcolor:int = 0x000000, alpha:Number = 0.5)
		{
			this.backcolor = backcolor;
			this.fontcolor = fontcolor;
			this.w = w;
			this.h = h;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		private function onAddToStage(e:Event):void
		{
			//背景
			back = new Sprite();
			back.graphics.beginFill(backcolor);
			back.graphics.drawRect(0, 0, w, h);
			back.alpha = alpha;
			addChild(back);
			//遮罩
			square = new Sprite();
			square.graphics.beginFill(0x000000);
			square.graphics.drawRect(0, 0, w, h);
			addChild(square);
			
			//字体格式
			var fmt:TextFormat = new TextFormat();
			fmt.align = TextFormatAlign.LEFT;			//左对齐	
			fmt.color = fontcolor;						//颜色
			fmt.size = 36;								//大小
			fmt.bold = true;							//粗体
			fmt.font = "微软雅黑";
			
			//输出文本
			tf = new TextField;
			tf.selectable = true;    					//可选
			tf.wordWrap = true;							//换行
			tf.width = w;
			tf.height = h-100;
			tf.defaultTextFormat = fmt;
			tf.y = 100;
			tf.text = "调试信息输出:\n"
			addChild(tf);
			//输入文本
			input = new TextField;
			input.type = TextFieldType.INPUT;
			input.width = w;
			input.defaultTextFormat = fmt;
			input.x = 70;
			input.text = "GM命令输入:";
			addChild(input)
			input.addEventListener(FocusEvent.FOCUS_IN,onInput);
			
			tf.mask = square;
			
			this.visible = false;
		}
			
		private function onInput(e:FocusEvent):void
		{
			input.text = "";
		}
		public function getGM():String
		{
			return input.text;
		}
		public function clearGM():void
		{
			input.text = "GM命令输入:";
		}
		public function out(strInfo : String):void
		{
			tf.appendText(strInfo);
			tf.appendText("\n");
			trace(strInfo);
		}
		public function resize(w:int, h:int):void
		{
			tf.width = w;
			tf.height = h;
			back.width = w;
			back.height = h;
			square.width = w;
			square.height = h;
		}

		
	}
}