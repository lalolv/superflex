package im.lalo.superflex.util
{
	import mx.formatters.DateFormatter;

	public class DateUtil
	{
		public static function getNow():String
		{
			var dateFormatter:DateFormatter = new DateFormatter(); 
			dateFormatter.formatString = "YYYY-MM-DD JJ:NN:SS"; 
			var now:String = dateFormatter.format(new Date());
			
			return now;
		}
		
		public static function getNowUTC():Number
		{
			return new Date().time / 1000;
		}
		
		public static function formatDateTime(date:Date):String
		{
			var dateFormatter:DateFormatter = new DateFormatter(); 
			dateFormatter.formatString = "YYYY-MM-DD JJ:NN:SS"; 
			var now:String = dateFormatter.format(date);
			
			return now;
		}
		
		public static function formatDate1(date:Date):String
		{
			var dateFormatter:DateFormatter = new DateFormatter(); 
			dateFormatter.formatString = "MM/DD/YYYY"; 
			var now:String = dateFormatter.format(date);
			
			return now;
		}
		
		public static function getNowDate():String
		{
			var dateFormatter:DateFormatter = new DateFormatter(); 
			dateFormatter.formatString = "YYYY-MM-DD"; 
			var now:String = dateFormatter.format(new Date());
			
			return now;
		}
		
		public static function getNowTime():String
		{
			var dateFormatter:DateFormatter = new DateFormatter();
			dateFormatter.formatString = "JJ:NN:SS"; 
			var now:String = dateFormatter.format(new Date());
			
			return now;
		}
		
		public static function genFileName():String
		{
			var dateFormatter:DateFormatter = new DateFormatter();
			dateFormatter.formatString = "YYYYMMDDJJNN"; 
			var now:String = dateFormatter.format(new Date());
			
			return now;
		}
		
		public static function formatTime(time:Number, insertHout:String = ":", insertMinute:String = ":"):String
		{
			var hour:uint = time / 60 / 60 >> 0;
			var minute:uint = (time / 60) % 60;
			var second:uint = time % 60;
			
			var timeTxt:String = "";
			
			timeTxt += ((hour > 100) ? hour.toString() : (100 + hour).toString().substr(1))+insertHout;
			timeTxt += ((minute < 10)?("0" + minute.toString()):minute.toString()) + insertMinute;
			timeTxt += (second < 10)?("0" + second.toString()):second.toString();            
			
			return timeTxt;
		}
		
		// 时间戳转换为日期类型
		public static function unix2date(val:int):Date
		{
			var d:Date = new Date(val * 1000);
			
			return d;
		}
	}
}