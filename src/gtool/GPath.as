package gtool
{
	public class GPath
	{
		
		private static var _instance:GPath;
		
		public static var PanelPath:String = "assets/panel/"; 
		public static var XmlPath:String = "assets/xml/"; 
		public static var MapPath:String = "assets/map/";
		public static var OtherResPath:String = "assets/res/";
		public static var ObstaclePath:String = "assets/res/obstacle/";
		public static var MonsterPath:String = "assets/res/monster/";
		public static var TowerPath:String = "assets/res/tower/";
		public static var BulletPath:String = "assets/res/bullet/";
		public static var EffectPath:String = "assets/res/effect/";
		
		public function GPath()
		{
			_instance = this;
			this.init();
		}
		private function init():void
		{
			
		}
		public static function GetInstance():GPath
		{
			if(!_instance) new GPath;
			return _instance;
		}
	}
}