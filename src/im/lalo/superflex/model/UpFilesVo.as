package im.lalo.superflex.model
{
	import flash.filesystem.File;

	public class UpFilesVo
	{
		public var file:File;
		public var name:String;
        public var token:String;
		
		public function UpFilesVo(_file:File, _name:String, _token:String):void
		{
			this.file = _file;
			this.name = _name;
			this.token = _token;
		}
	}
}