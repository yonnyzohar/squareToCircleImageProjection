package {
	import flash.events.*;
	import flash.display.*;


	public class Main extends MovieClip {
		var w: int = 400;
		var h: int = 400;
		var src: IMG = new IMG();
		var bd: BitmapData = new BitmapData(w, h, false, 0x000000);
		var bmp: Bitmap = new Bitmap(bd);

		var currStartCol: int = 0;
		var rotSpeed: int = 20;
		public function Main() {
			// constructor code
			stage.addChild(bmp);

			bmp.x = (stage.stageWidth - bmp.width) / 2;
			bmp.y = (stage.stageHeight - bmp.height) / 2;

			stage.addEventListener(Event.ENTER_FRAME, update);
		}



		function update(e: Event): void {
			bd.lock();
			render();
			currStartCol += rotSpeed;
			if (currStartCol >= src.width) {
				currStartCol -= src.width;
			}
			bd.unlock();
		}

		function getPixel(col: int, row: int): uint {
			var c: int = currStartCol + col;
			if (c >= src.width) {
				c = currStartCol + col - src.width;
			}
			return src.getPixel(c, row)
		}

		function render(): void {

			var cX: Number = bd.width / 2;
			var cY: Number = bd.height / 2;

			//top angle to paint from
			var startAngle: Number = (Math.PI * 2) * 0.75;
			//bottom angle of arc to paint to
			var endAngle: Number = (Math.PI * 0.5) + (Math.PI * 2);
			//angles to be covered from top to bottom
			var totalAngles: Number = endAngle - startAngle;

			//how many steps to take between start and finish
			//will affect how many rows we draw
			var angleIncrement: Number = (Math.PI * 2) / 1300;
			//the radius of the circle
			var rad: Number = w / 2;
			//the step increment from zero to radius, will affect how many colums we draw
			var stepIncrement: Number = 1;
			var totalSteps: Number = (rad / stepIncrement) * 2;
			var currLeftCol: Number = 0;
			var currRightCol: Number = totalSteps;


			for (var i: Number = 0; i < rad; i += stepIncrement) {
				var _i = i;
				var per: Number = 1 - (Number(_i) / rad);
				//move from top to bottom down the angles
				for (var j: Number = startAngle; j < endAngle; j += angleIncrement) {
					var _j = j;
					var currRow: Number = j - startAngle;

					//setTimeout(function (_j: Number): void {
					//y top to bottom right side
					var tX: Number = (Math.cos(_j) * (rad));
					var tY: Number = (Math.sin(_j) * (rad)) * per;
					//bd.setPixel(tX+cX, tY+cY, color);

					//x left to right right side
					var tX1: Number = (Math.cos(_j) * (rad)) * per;
					var tY1: Number = (Math.sin(_j) * (rad));
					//bd.setPixel(tX1+cX, tY1+cY, color);

					//y top to bottom left side
					//bd.setPixel(cX-tX, cY-tY, color);

					//x left to right left side
					//bd.setPixel(cX-tX1, cY-tY1, color);

					//////////////////////////////////////
					var currPointX: Number;
					var currPointY: Number;
					var xPer: Number;
					var yPer: Number;
					var origRow: int;
					var origCol: int;

					//current left, cols left to right
					currPointX = cX - tX1;
					currPointY = cY + tY1;

					xPer = currLeftCol / totalSteps;
					yPer = currRow / totalAngles;

					origRow = yPer * src.height;
					origCol = xPer * src.width;

					bd.setPixel(currPointX, currPointY, getPixel(origCol, origRow));

					//current right, cols left to right
					currPointX = tX1 + cX;
					currPointY = cY + tY1;

					xPer = currRightCol / totalSteps;
					yPer = currRow / totalAngles;

					origRow = yPer * src.height;
					origCol = xPer * src.width;
					bd.setPixel(currPointX, currPointY, getPixel(origCol, origRow));


					/////////////////////////




					/*
		this is redundent
		//current left, rows top to bottom
		currPointX = cX-tX;
		currPointY = cY-tY;
		
		origRow = yPer * src.height;
		origCol = xPer * src.width;
		bd.setPixel(int(currPointX), int(currPointY), src.getPixel(origCol, origRow));
		/////////////////////////
		//trace(int(tX), int(currPointX), int(absLX), xPer, int(tY),int(currPointY), int(absTY), yPer);
		
		//current right, rows top to bottom
		currPointX = tX + cX;
		currPointY = tY + cY;
		
		origRow = yPer * src.height;
		origCol = xPer * src.width;
		bd.setPixel(currPointX, currPointY, src.getPixel(origCol, origRow));
		/////////////////////////
		*/


				}
				currLeftCol++;
				currRightCol--;

			}
		}

	}

}