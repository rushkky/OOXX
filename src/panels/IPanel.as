package panels
{
	public interface IPanel
	{
		function show():void;
		function hide():void;
		function hideAndClose():void;
		function setData(data_:Object=null):void;
		function init():void;
	}
}