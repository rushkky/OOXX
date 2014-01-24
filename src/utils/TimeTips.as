package utils
{
	public class TimeTips
	{
		public function TimeTips()
		{
		}
		/**
		 * 转换时间函数 天 时 分 秒
		 * @param time_ 秒
		 * @return 
		 * 
		 */		
		public static function getTimeTips(time_:int):String
		{
			var num1:int;
			var num2:int;
			//天
			if(time_ > 86400)
			{
				num1 = time_/86400;
				num2 = time_%86400;
				num2 = num2/3600;
				if(num2 == 0) return  num1+"天";
				return num1+"天"+num2+"小时";
			}
			//时
			else if(time_ > 3600)
			{
				num1 = time_/3600;
				num2 = time_%3600;
				num2 = num2/60;
				if(num2 == 0) return  num1+"小时";
				return num1+"小时"+num2+"分钟";
			}
			//分
			else if(time_ > 60)
			{
				num1 = time_/60;
				num2 = time_%60;
				if(num2 == 0) return  num1+"分钟";
				return num1+"分钟"+num2+"秒";
			}
			//秒
			else
			{
				return time_+"秒";
			}
			return "";
		}
	}
}