package avatars
{
	public interface IAvatar
	{
		function play(action_:int=1,loop_:Boolean=false):void
		function stop(type_:int=0):void
		function dispose():void
	}
}