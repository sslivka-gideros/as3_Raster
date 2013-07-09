package  
{
	import flash.display.BitmapData;
	
	public class UIBitmapData extends BitmapData
	{
		
		public function UIBitmapData(width:int, height:int, transparent:Boolean=true, fillColor:uint=4294967295) 
		{
			super(width, height, transparent, fillColor);
		}
		
		/*
		 * bmd.drawPixel(0, 0, 0x000000);
		 */
		public function drawPixel(x:int, y:int, c:Number, a:Number=1):void
		{
			var r:int = (c >> 16 & 0xFF);
			var g:int = (c >> 8 & 0xFF);
			var b:int = (c & 0xFF);
			this.setPixel32(x, y, ((a * 0xFF << 24) | (r << 16) | (g << 8) | b));
		}
		
		/*
		 * bmd.drawLine(0, 0, 100, 100, 0x000000);
		 */
		public function drawLine(x0:int, y0:int, x1:int, y1:int, c:Number, a:Number=1):void
		{
			var dx:int;
			var dy:int;
			var i:int;
			var xinc:int;
			var yinc:int;
			var cumul:int;
			var x:int;
			var y:int;
			x = x0;
			y = y0;
			dx = x1 - x0;
			dy = y1 - y0;
			xinc = (dx > 0) ? 1 : -1;
			yinc = (dy > 0) ? 1 : -1;
			dx = (dx < 0) ? -dx : dx;
			dy = (dy < 0) ? -dy : dy;
			this.drawPixel(x, y, c, a);
			if (dx > dy) {
				cumul = dx >> 1;
		  		for (i = 1; i <= dx; ++i) {
					x += xinc;
					cumul += dy;
					if (cumul >= dx) {
			  			cumul -= dx;
			  			y += yinc;
					}
					this.drawPixel(x, y, c, a);
				}
			} else {
		  		cumul = dy >> 1;
		  		for (i = 1; i <= dy; ++i) {
					y += yinc;
					cumul += dx;
					if (cumul >= dy) {
						cumul -= dy;
			  			x += xinc ;
					}
					this.drawPixel(x, y, c, a);
				}
			}
		}
		
		/*
		 * bmd.drawRect(0, 0, 90, 32, 0x000000);
		 */
		public function drawRect(x:int, y:int, width:int, height:int, c:Number, a:Number=1):void
		{
			this.drawLine(x, y, x + width, y, c, a);
			this.drawLine(x + width, y, x + width, y + height, c, a);
			this.drawLine(x + width, y + height, x, y + height, c, a);
			this.drawLine(x, y + height, x, y, c, a);
		}
		
		/*
		 * bmd.drawFillRect(0, 0, 90, 32, 0x000000, 0.5);
		 */
		public function drawFillRect(x:int, y:int, width:int, height:int, c:Number, a:Number=1):void
		{
			var i:int;
			var j:int;
			for (i = 0; i < width; i++) {
				for (j = 0; j < height; j++) {
					this.drawPixel(x + i, y + j, c, a);
				}
			}
		}
		
		/*
		 * bmd.drawArray(0, 0, [
		 * 	[1, 1, 1, 1, 1],
		 * 	[1, 2, 2, 2, 1],
		 * 	[1, 2, 0, 2, 1],
		 * 	[1, 2, 2, 2, 1],
		 * 	[1, 1, 1, 1, 1],
		 * 	], [
		 * 	false,
		 * 	{color:0xFF0000, alpha:0.5},
		 * 	{color:0x00FF00, alpha:1}]);
		 */
		public function drawArray(x:int, y:int, pixels:Array, colors:Array):void
		{
			var i:int;
			var j:int;
			var colorIndex:int;
			var color:Object;
			for (i = 0; i < pixels.length; i++) {
				for (j = 0; j < pixels[i].length; j++) {
					colorIndex = pixels[i][j];
					color = colors[colorIndex];
					if (color) {
						this.drawPixel(x + j, y + i, color.color, color.alpha);
					}
				}
			}
		}
		
		/*
		 * bmd.drawShadowBox(0, 32, 90, 10, 0.1, 0.0);
		 */
		public function drawShadowBox(x:int, y:int, width:int, height:int, a1:Number=0.0, a2:Number=1.0, c:Number=0x000000):void
		{
			var i:int;
			var j:int;
			var a:Number;
			var step:Number = (a2 - a1)/height;
			for (i = 0; i < width; i++) {
				a = a1;
				for (j = 0; j < height; j++) {
					this.drawPixel(x + i, y + j, c, a);
					a = a + step;
				}
			}
		}
		
	}

}