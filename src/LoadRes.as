/**
 *by Tata
 */
package
{

	import enums.ResType;
	import gtool.GLoader;
	import gtool.GPath;



	public class LoadRes
	{
		public function LoadRes()
		{
			//加载配置
			GLoader.GetInstance().load(GPath.XmlPath+"panel.xml",ResType.TEXT,"panel.xml");
			GLoader.GetInstance().load(GPath.XmlPath+"skillinfo.xml",ResType.TEXT,"skillinfo.xml");
			
		}
	}
}