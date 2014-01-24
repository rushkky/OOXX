package managers.DataManager
{
	import flash.utils.Dictionary;
	
	import datas.SkillInfoData;
	
	import gtool.GLoader;
	

	public class DataManager
	{
		private static var _instance:DataManager;
		
		private var dataMap:Dictionary = new Dictionary();
		
		public function DataManager()
		{
			_instance = this;
		}
		public function init():void
		{

			var xml:XML;
			//面板数据
			var skill_xml:XML = GLoader.GetInstance().getRes("skillinfo.xml");
			var skill_arr:Array = [];
			for each(xml in skill_xml.content)
			{
				var pid:SkillInfoData = new SkillInfoData(xml);
				skill_arr.push(pid);
			}
			dataMap["skillinfo"] = skill_arr;

			
		}
		/**
		 *根据id获取pve信息 
		 * @param id_
		 * @return 
		 * 
		 */		
		public function getSkillInfo(id_:int):SkillInfoData
		{
			var arr:Array = dataMap["pveinfo"];
			for(var i:int=0;i<arr.length;++i)
			{
				var pid:SkillInfoData = arr[i];
				if(pid.id == id_)
				{
					return pid;
				}
			}
			return null;
		}
		/**
		 *根据键获取数据 
		 * @param key_
		 * @return 
		 * 
		 */		
		public function getData(key_:String):Object
		{
			return dataMap[key_];
		}
		public static function GetInstance():DataManager
		{
			if(!_instance) new DataManager;
			return _instance;
		}
	}
}