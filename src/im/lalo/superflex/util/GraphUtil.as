package im.lalo.superflex.util
{
	import mx.core.UIComponent;

	public class GraphUtil
	{
		/**
		 * 绘制扇形
		 */
		public static function DrawSector(ui:UIComponent, x:Number = 32, y:Number = 32, 
									r:Number = 29, angle:Number = 360, 
									startFrom:Number = 270, color:Number = 0x87A331):void 
		{
			ui.graphics.clear();
			ui.graphics.beginFill(color);
			//remove this line to unfill the sector
			/* the border of the secetor with color 0xff0000 (red) , you could replace it with any color 
			* you want like 0x00ff00(green) or 0x0000ff (blue).
			*/
			//progressSector.graphics.lineStyle(0,0xff0000);
			ui.graphics.moveTo(x, y);
			angle = (Math.abs(angle) > 360) ? 360 : angle;
			var n:Number = Math.ceil(Math.abs(angle)/45);
			var angleA:Number = angle/n;
			angleA = angleA*Math.PI/180;
			startFrom = startFrom*Math.PI/180;
			ui.graphics.lineTo(x+r*Math.cos(startFrom), y+r*Math.sin(startFrom));
			for (var i:int=1; i<=n; i++) 
			{
				startFrom += angleA;
				var angleMid:Number = startFrom - angleA / 2;
				var bx:Number = x+r/Math.cos(angleA/2)*Math.cos(angleMid);
				var by:Number = y+r/Math.cos(angleA/2)*Math.sin(angleMid);
				var cx:Number = x+r*Math.cos(startFrom);
				var cy:Number = y+r*Math.sin(startFrom);
				ui.graphics.curveTo(bx, by, cx, cy);
			}
			
			if(angle != 360) 
			{
				ui.graphics.lineTo(x,y);
			}
			
			ui.graphics.endFill();
		}
		
		/**
		 * 绘制三角形
		 * @param direction top bottom left right
		 */
		public static function DrawTriangle(ui:UIComponent, direction:String, color:uint, 
											outWidth:Number, outHeight:Number):void
		{
			ui.graphics.beginFill(color);
			
			switch(direction)
			{
				case "top":
					ui.graphics.moveTo(outWidth/2, 0);
					ui.graphics.lineTo(0, outHeight);
					ui.graphics.lineTo(outWidth, outHeight);
					ui.graphics.lineTo(outWidth/2, 0);
					break;
				case "bottom":
					ui.graphics.moveTo(outWidth/2, outHeight);
					ui.graphics.lineTo(0, 0);
					ui.graphics.lineTo(outWidth, 0);
					ui.graphics.lineTo(outWidth/2, outHeight);
					break;
				case "left":
					ui.graphics.moveTo(0, outHeight/2);
					ui.graphics.lineTo(outWidth, 0);
					ui.graphics.lineTo(outWidth, outHeight);
					ui.graphics.lineTo(0, outHeight/2);
					break;
				case "right":
					ui.graphics.moveTo(outWidth, outHeight/2);
					ui.graphics.lineTo(0, 0);
					ui.graphics.lineTo(0, outHeight);
					ui.graphics.lineTo(outWidth, outHeight/2);
					break;
			}
			
			ui.graphics.endFill();
		}
	}
}