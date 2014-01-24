package modules
{
	public interface IModule
	{
		function begin(...params:Array):void;
		function end():void;
	}
}