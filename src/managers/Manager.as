package managers
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	public class Manager implements IManager
	{
		private var _container:Sprite;
		
		public function Manager(container_:Sprite)
		{
			_container = container_;
		}
		
		public function get container():Sprite
		{
			return _container;
		}

		public function add(value_:Object):void
		{
			
		}
		
		public function remove(value_:Object):void
		{
		}
		
		public function removeall():void
		{
		}
		
		public function updata():void
		{
			
		}
		
		public function dispose():void
		{
			var num:uint = this._container.numChildren;
			while(num > 0)
			{
				var display:DisplayObject = this._container.removeChildAt(0);
				num--;
				display = null;
			}
		}
	}
}