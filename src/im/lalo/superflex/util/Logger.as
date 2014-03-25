package im.lalo.superflex.util
{
	import mx.logging.ILogger;
	import mx.logging.Log;

	public class Logger
	{
		private static var logger:ILogger;
		
		public function Logger()
		{
		}
		
		public static function info(msg:String, category:String = "Main"):void
		{
			logger = Log.getLogger(category);
			logger.info(msg);
		}
		
		public static function log(msg:String, category:String = "Main"):void
		{
			logger = Log.getLogger(category);
			logger.error(msg);
		}
		
		public static function error(msg:String, category:String = "Main"):void
		{
			logger = Log.getLogger(category);
			logger.error(msg);
		}
		
		public static function fatal(msg:String, category:String = "Main"):void
		{
			logger = Log.getLogger(category);
			logger.fatal(msg);
		}
	}
}