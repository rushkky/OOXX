package datas
{
	import enums.AttributeType;

	public class RoleData
	{
		public var atrributeData:Array = [];
		
		public function RoleData(data_:RoleData = null)
		{
			atrributeData[AttributeType.Hp] = 500;
			atrributeData[AttributeType.Mp] = 200;
			atrributeData[AttributeType.Atk] = 10;
			atrributeData[AttributeType.Def] = 5;
			atrributeData[AttributeType.Hit] = 0;
			atrributeData[AttributeType.Dodge] = 0; 
			atrributeData[AttributeType.Crit] = 0;
			atrributeData[AttributeType.MoveSpeed] = 0.5; 
			atrributeData[AttributeType.AtkSpeed] = 0.5;
			atrributeData[AttributeType.MagicAtk] = 100;
			atrributeData[AttributeType.MagicDef] = 50;
			atrributeData[AttributeType.Fire] = 0;
			atrributeData[AttributeType.Ice] = 0;
			atrributeData[AttributeType.Thunder] = 0; 
			atrributeData[AttributeType.Res] = 1;
			if(data_ != null)
			{
				atrributeData[AttributeType.Hp] = data_[AttributeType.Hp];
				atrributeData[AttributeType.Mp] = data_[AttributeType.Mp];
				atrributeData[AttributeType.Atk] = data_[AttributeType.Atk];
				atrributeData[AttributeType.Def] = data_[AttributeType.Def];
				atrributeData[AttributeType.Hit] = data_[AttributeType.Hit];
				atrributeData[AttributeType.Dodge] = data_[AttributeType.Dodge]; 
				atrributeData[AttributeType.Crit] = data_[AttributeType.Crit];
				atrributeData[AttributeType.MoveSpeed] = data_[AttributeType.MoveSpeed]; 
				atrributeData[AttributeType.AtkSpeed] = data_[AttributeType.AtkSpeed];
				atrributeData[AttributeType.MagicAtk] = data_[AttributeType.MagicAtk];
				atrributeData[AttributeType.MagicDef] = data_[AttributeType.MagicDef];
				atrributeData[AttributeType.Fire] = data_[AttributeType.Fire];
				atrributeData[AttributeType.Ice] = data_[AttributeType.Ice];
				atrributeData[AttributeType.Thunder] = data_[AttributeType.Thunder]; 
				atrributeData[AttributeType.Res] = data_[AttributeType.Res];
			}
		}
	}
}