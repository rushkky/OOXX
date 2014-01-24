package gtool
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	public class GDepthUtil
	{
		private static var _instance:GDepthUtil;
		
		public function GDepthUtil()
		{
			_instance = this;
		}
		/**
		 * 两显示对象深度差距
		 * @param aDisplay_
		 * @param bDisplay_
		 * @return 
		 * 不在一个容器  0
		 * a上  >0
		 * b上 <0
		 */		
		public function getDepthDistance(aDisplay_:DisplayObject,bDisplay_:DisplayObject):int
		{
			var aParent:DisplayObjectContainer = aDisplay_.parent;
			var bParent:DisplayObjectContainer = bDisplay_.parent;
			if(aParent==null) return 0;
			if(bParent==null) return 0;
			if(aParent != bParent) return 0;
			return aParent.getChildIndex(aDisplay_) - bParent.getChildIndex(bDisplay_);
		}
		public function swapDepth(aDisplay_:DisplayObject,bDisplay_:DisplayObject):void
		{
			var aParent:DisplayObjectContainer = aDisplay_.parent;
			var bParent:DisplayObjectContainer = bDisplay_.parent;
			if(aParent==null) return;
			if(bParent==null) return;
			if(aParent != bParent) return;
			var aDepth:int = aParent.getChildIndex(aDisplay_);
			var bDepth:int = bParent.getChildIndex(bDisplay_);
			aParent.addChildAt(aDisplay_,bDepth);
			bParent.addChildAt(bDisplay_,aDepth);
		}
		public function isAbove(aDisplay_:DisplayObject,bDisplay_:DisplayObject):Boolean
		{
			return getDepthDistance(aDisplay_,bDisplay_) > 0;
		}
		public function isBelow(aDisplay_:DisplayObject,bDisplay_:DisplayObject):Boolean
		{
			return getDepthDistance(aDisplay_,bDisplay_) < 0;
		}
		public function toTop(display_:DisplayObject):void
		{
			var parent:DisplayObjectContainer = display_.parent;
			if(parent==null) return;
			var maxIndex:int = parent.numChildren - 1;
			if(parent.getChildIndex(display_) == maxIndex) return;
			parent.setChildIndex(display_,maxIndex);
		}
		public function toBottom(display_:DisplayObject):void
		{
			var parent:DisplayObjectContainer = display_.parent;
			if(parent==null) return;
			if(parent.getChildIndex(display_) == 0) return;
			parent.setChildIndex(display_,0);
		}
		public function isTop(display_:DisplayObject):Boolean
		{
			var parent:DisplayObjectContainer = display_.parent;
			if(parent==null) return false;
			var maxIndex:int = parent.numChildren - 1;
			return parent.getChildIndex(display_) == maxIndex;
		}
		public function isBottom(display_:DisplayObject):Boolean
		{
			var parent:DisplayObjectContainer = display_.parent;
			if(parent==null) return false;
			return parent.getChildIndex(display_) == 0;
		}
		public static function GetInstance():GDepthUtil
		{
			if(!_instance) new GDepthUtil;
			return _instance;
		}
	}
}