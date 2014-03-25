package im.lalo.superflex.util
{
	public class MathUtil
	{
		public static function randRangeFloor(min:Number, max:Number):Number
		{
			var randomNum:Number = Math.floor(Math.random() * (max - min + 1)) + min;
			return randomNum;
		}
		
		public static function randRangeRound(min:Number, max:Number):int
		{
			var randomNum:int = Math.round(Math.random() * (max - min + 1)) + min;
			return randomNum;
		}
	}
}