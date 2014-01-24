package managers
{
	public interface IManager
	{
		function add(value_:Object):void;
		function remove(value_:Object):void;
		function removeall():void;
		function dispose():void;
		function updata():void;
	}
}