package im.lalo.superflex.util
{
	public class StrUtil
	{
		public function StrUtil()
		{
		}
		
		/** 
		 * StringReplaceAll 
		 * @param source:String 源数据 
		 * @param find:String 替换对象 
		 * @param replacement:Sring 替换内容 
		 * @return String 
		 * **/ 
		public static function StringReplaceAll(source:String, find:String, replacement:String):String
		{ 
			return source.split(find).join(replacement);
		}
	}
}