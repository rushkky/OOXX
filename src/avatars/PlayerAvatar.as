package avatars
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	import datas.RoleData;
	
	import enums.ActionType;
	import enums.AttributeType;
	
	import gtool.GLoader;
	
	public class PlayerAvatar extends Sprite
	{
		private var _data:RoleData;
		private var _templateData:RoleData;
		private var _box:Sprite;
		private var _avatar:Avatar;
		
		public function PlayerAvatar()
		{
			super();
		}
		public function setData(data_:Object):void
		{
			_data = data_ as RoleData;
			_templateData = new RoleData(_data);
			
			var id:int = _data.atrributeData[AttributeType.Res];
			var arr:Array = ["player_"+id+"_"+ActionType.Idle,"player_"+id+"_"+ActionType.Move,"player_"+id+"_"+ActionType.Magic,"player_"+id+"_"+ActionType.Dead,"player_"+id+"_"+ActionType.Attack1,"player_"+id+"_"+ActionType.Attack2];
			for(var i:int=0;i<arr.length;++i)
			{
				_avatar = new Avatar();
				var bd:BitmapData = GLoader.GetInstance().getTempRes(arr[i]) as BitmapData;
				var xml:XML = GLoader.GetInstance().getTempRes(arr[i]+".xml") as XML;
				if(bd != null && xml != null)
				{
					_avatar.registeerAction(i,bd,xml);
				}
				else
				{
					trace("角色资源没有找到！");
				}
			}
			_avatar.x = -_avatar.width/2;
			_avatar.y = -_avatar.height;
			this.addChild(_avatar);
		}
	}
}