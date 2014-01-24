package datas
{
	public class SkillInfoData
	{
		public var id:int;
		public var type:int;
		public var name:String;
		public var icon:String;
		public var des:String;
		
		public function SkillInfoData(xml_:XML)
		{
			id = xml_.id;
			type = xml_.type;
			name = xml_.name;
			icon = xml_.icon;
			des = xml_.des;
		}

	}
}