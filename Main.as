package {
	import flash.events.*;
	import flash.display.*;
	import flash.geom.Rectangle;


	public class Main extends MovieClip {
		
		private static const PI_M2:Number = Math.PI*2;
		private static const PI_D2:Number = Math.PI/2;
		
		var w: int = stage.stageWidth;
		var h: int = stage.stageHeight;
		
		var imagesArr:Array = [new Earth(), new Jupiter(),  new Moon(), new Mars()];
		var currImg:int = 0;
		var counter:int = 1;
		
		var bd: BitmapData = new BitmapData(w, h, false, 0x000000);
		var bmp: Bitmap = new Bitmap(bd);
		var src:BitmapData;

		var currStartCol: int = 0;
		var rotSpeed: int = 1;
		var mouseClicked:Boolean = false;
		public function Main() {
			// constructor code
			stage.addChild(bmp);
			setUpStars();

			bmp.x = (stage.stageWidth - bmp.width) / 2;
			bmp.y = (stage.stageHeight - bmp.height) / 2;
			src = imagesArr[currImg];

			stage.addEventListener(Event.ENTER_FRAME, update);
			stage.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		function onClick(e:MouseEvent):void
		{
			mouseClicked = !mouseClicked;
		}
		
		
		function setUpStars():void
		{
			var numStars:int = 400;
			
			for(var i:int = 0; i < numStars; i++)
			{
				bd.setPixel(Math.random() * bd.width, Math.random() * bd.height, 0xcccccc); 
			}
		}



		function update(e: Event): void {
			
			counter++;
			if (false)//counter % 200 == 0
			{
				currImg++;
				if(currImg >= imagesArr.length)
				{
					currImg = 0;
				}
				src = imagesArr[currImg];
			}
			
			bd.lock();
			bd.fillRect(new Rectangle(0,0,bd.width, bd.height),0x000000);
			
			if (mouseClicked)
				{
					render(); //60 thousand iterations
				}
				else
				{
					render1(); //16 thousand iterations
				}
			
			//
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
		


		function render1(): void {

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
			var rad: Number = w / 3;
			//the step increment from zero to radius, will affect how many colums we draw
			var stepIncrement: Number = 1;
			var totalSteps: Number = (rad / stepIncrement) * 2;
			//var numIterations:int = 0;
			var arr: Array = [];
			for (var j: Number = startAngle; j < endAngle; j += angleIncrement) {
				var currRow: Number = j - startAngle;

				var tX1: Number = (Math.cos(j) * (rad));
				var tY1: Number = (Math.sin(j) * (rad));

				//////////////////////////////////////
				var currPointY: Number;
				var xPer: Number;
				var yPer: Number;
				var origRow: int;
				var origCol: int;

				//current left, cols left to right
				var leftX: Number = cX - tX1;

				//current right, cols left to right
				var rightX: Number = tX1 + cX;
				currPointY = cY + tY1;

				if (arr[leftX] && arr[leftX][currPointY]) {
					continue;
				}

				if (!arr[leftX]) {
					arr[leftX] = [];
					arr[leftX][currPointY] = true;
				} else {
					if (!arr[leftX][currPointY]) {
						arr[leftX][currPointY] = true;
					}
				}

				yPer = currRow / totalAngles;

				/**/
				var cols: int = rightX - leftX;
				for (var i: int = 0; i < cols; i++) {
					xPer = i / cols;
					
					// t: current time, b: begInnIng value, c: change In value, d: duration
					//xPer = easeInOutQuint (xPer, 0, 1, 1);
					
					origRow = yPer * src.height ;
					origCol = xPer * (src.width / 2);

					bd.setPixel(leftX + i, currPointY, getPixel(origCol, origRow));
					//numIterations++;
				}

			}
			//trace(numIterations);
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
			var angleIncrement: Number = (Math.PI * 2) / 2000;
			//the radius of the circle
			var rad: Number = w / 3;
			//the step increment from zero to radius, will affect how many colums we draw
			var stepIncrement: Number = 1;
			var totalSteps: Number = (rad / stepIncrement) * 2;
			var currLeftCol: Number = 0;
			var currRightCol: Number = totalSteps;
			var arr: Array = [];

			for (var i: Number = 0; i < rad; i += stepIncrement) {
				var _i = i;
				var per: Number = (Number(_i) / rad);
				
				

				//move from top to bottom down the angles
				for (var j: Number = startAngle; j < endAngle; j += angleIncrement) {
					var _j = j;
					var currRow: Number = j - startAngle;

					//x left to right right side
					var tX1: Number = (Math.cos(_j) * (rad)) * per;
					var tY1: Number = (Math.sin(_j) * (rad));

					//////////////////////////////////////
					var currPointX: int;
					var currPointY: int;
					var xPer: Number;
					var yPer: Number;
					var origRow: int;
					var origCol: int;

					//current left, cols left to right
					currPointX = cX - tX1;
					currPointY = cY + tY1;
					if (arr[currPointX] && arr[currPointX][currPointY]) {
						continue;
					}

					if (!arr[currPointX]) {
						arr[currPointX] = [];
						arr[currPointX][currPointY] = true;
					} else {
						if (!arr[currPointX][currPointY]) {
							arr[currPointX][currPointY] = true;
						}
					}

					xPer = (1-per)/2;//currLeftCol / totalSteps;
					if(xPer <= 0)
					{
						xPer = xPer+0.5;
					}
					yPer = currRow / totalAngles;

					origRow = yPer * src.height ;
					origCol = xPer * (src.width / 2);

					bd.setPixel(currPointX, currPointY, getPixel(origCol, origRow));

					//current right, cols left to right
					currPointX = tX1 + cX;
					currPointY = cY + tY1;

					xPer = (per/2)+0.5;//xPer = currRightCol / totalSteps;
					yPer = currRow / totalAngles;

					origRow = yPer * src.height ;
					origCol = xPer * (src.width / 2);
					bd.setPixel(currPointX, currPointY, getPixel(origCol, origRow));

				}
				currLeftCol++;
				currRightCol--;

			}
		}
		
		// t: current time, b: begInnIng value, c: change In value, d: duration
		public static function easeInSine (t:Number, b:Number, c:Number, d:Number):Number
		{
			return -c * Math.cos(t/d * PI_D2) + c + b;
		}
		public static function easeOutSine (t:Number, b:Number, c:Number, d:Number):Number
		{
			return c * Math.sin(t/d * PI_D2) + b;
		}
		public static function easeInOutSine (t:Number, b:Number, c:Number, d:Number):Number
		{
			return -c/2 * (Math.cos(Math.PI*t/d) - 1) + b;
		}
		public static function easeInQuint (t:Number, b:Number, c:Number, d:Number):Number
		{
			return c*(t/=d)*t*t*t*t + b;
		}
		public static function easeOutQuint (t:Number, b:Number, c:Number, d:Number):Number
		{
			return c*((t=t/d-1)*t*t*t*t + 1) + b;
		}
		public static function easeInOutQuint (t:Number, b:Number, c:Number, d:Number):Number
		{
			if ((t/=d/2) < 1) return c/2*t*t*t*t*t + b;
			return c/2*((t-=2)*t*t*t*t + 2) + b;
		}

	}

}


/*

		*/