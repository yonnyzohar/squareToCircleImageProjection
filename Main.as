﻿package {
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.display.Sprite;
	import flash.events.*;

	public class Main extends MovieClip {
		
		var zoomAmount: Number = 0.05;
		var currZoom: Number = 1;

		var mouseDown: Boolean = false;
		var origMouseX: Number = 0;
		var origMouseY: Number = 0;


		var layerS: Sprite = new Sprite();
		var layer0: Sprite = new Sprite();
		var layer05: Sprite = new Sprite();
		var layer1: Sprite = new Sprite();
		var debugLayer: Sprite = new Sprite();


		var layers: Array = [layerS, layer0, layer05, layer1, debugLayer];

		var gs = layerS.graphics;
		var g0 = layer0.graphics;
		var g05 = layer05.graphics;
		var g1 = layer1.graphics;
		var dg = debugLayer.graphics;

		var allPlanets: Array = [];
		var tweenTo: Object = null;

		/*
		Mercury - 0
		Venus - 0
		Earth - 1
		Mars - 2
		Jupiter - 79 (53 confirmed, 26 provisional)
		Saturn - 82 (53 confirmed, 29 provisional)
		Uranus - 27
		Neptune - 14
		
		
		*/

		/*
		var moon: Object = {
			radius: 8,
			color: 0xffffff * Math.random(),
			distanceFromParent: 20,
			angle: Math.random() * (Math.PI * 2),
			speed: getSpeed(true),
			name: "moon"
		}


		var marsMoon1: Object = {
			radius: 10,
			color: 0xffffff * Math.random(),
			distanceFromParent: 50,
			angle: Math.random() * (Math.PI * 2),
			speed: getSpeed(true),
			name: "europa"
		}

		var marsMoon2: Object = {
			radius: 7,
			color: 0xffffff * Math.random(),
			distanceFromParent: 80,
			angle: Math.random() * (Math.PI * 2),
			speed: getSpeed(true),
			name: "kallisto"
		}


		var marsMoon3: Object = {
			radius: 7,
			color: 0xffffff * Math.random(),
			distanceFromParent: 110,
			angle: Math.random() * (Math.PI * 2),
			speed: getSpeed(true),
			name: "io"
		}

		var marsMoon4: Object = {
			radius: 7,
			color: 0xffffff * Math.random(),
			distanceFromParent: 140,
			angle: Math.random() * (Math.PI * 2),
			speed: getSpeed(true),
			name: "x"
		}


		var marsMoon5: Object = {
			radius: 7,
			color: 0xffffff * Math.random(),
			distanceFromParent: 170,
			angle: Math.random() * (Math.PI * 2),
			speed: getSpeed(true),
			name: "p4573"
		}


		var marsMoon6: Object = {
			radius: 7,
			color: 0xffffff * Math.random(),
			distanceFromParent: 200,
			angle: Math.random() * (Math.PI * 2),
			speed: getSpeed(true),
			name: "p456873"
		}
		*/


		var mercury: Object = {
			radius: 15,
			color: 0xffffff * Math.random(),
			distanceFromParent: 300,
			angle: Math.random() * (Math.PI * 2),
			speed: getSpeed(),
			showOrbit : false,
			name: "mercury"
		}

		var venus: Object = {
			radius: 20,
			color: 0xffffff * Math.random(),
			distanceFromParent: 600,
			angle: Math.random() * (Math.PI * 2),
			speed: getSpeed(),
			showOrbit : false,
			name: "venus"
		}

		var earth: Object = {
			radius: 22,
			color: 0xffffff * Math.random(),
			distanceFromParent: 1000,
			angle: Math.random() * (Math.PI * 2),
			speed: getSpeed(),
			orbitingPlanets: [],
			showOrbit : false,
			numMoons: 1,
			name: "earth"
		}


		var mars: Object = {
			radius: 18,
			color: 0xffffff * Math.random(),
			distanceFromParent: 1500,
			angle: Math.random() * (Math.PI * 2),
			speed: getSpeed(),
			orbitingPlanets: [],
			showOrbit : false,
			numMoons: 2,
			name: "mars"
		}

		var jupiter: Object = {
			radius: 100,
			color: 0xffffff * Math.random(),
			distanceFromParent: 2500,
			angle: Math.random() * (Math.PI * 2),
			speed: getSpeed(),
			orbitingPlanets: [],
			showOrbit : false,
			numMoons: 53,
			name: "jupiter"
		}

		var saturn: Object = {
			radius: 120,
			color: 0xffffff * Math.random(),
			distanceFromParent: 5000,
			angle: Math.random() * (Math.PI * 2),
			speed: getSpeed(),
			rings: [Math.random() * 0xffffff, Math.random() * 0xffffff, Math.random() * 0xffffff, Math.random() * 0xffffff, Math.random() * 0xffffff],
			orbitingPlanets: [],
			showOrbit : false,
			numMoons: 53,
			name: "saturn"
		}

		var uranus: Object = {
			radius: 18,
			color: 0xffffff * Math.random(),
			distanceFromParent: 6000,
			angle: Math.random() * (Math.PI * 2),
			speed: getSpeed(),
			orbitingPlanets: [],
			numMoons: 27,
			showOrbit : false,
			name: "uranus"
		}

		var neptune: Object = {
			radius: 18,
			color: 0xffffff * Math.random(),
			distanceFromParent: 7000,
			angle: Math.random() * (Math.PI * 2),
			speed: getSpeed(),
			orbitingPlanets: [],
			showOrbit : false,
			numMoons: 14,
			name: "neptune"
		}


		var sun: Object = {
			radius: 200,
			color: 0xffff00,
			x: stage.stageWidth / 2,
			y: stage.stageHeight / 2,
			emitsLight: true,
			lightRad: 10000,
			//lightAngleDelta: 0.015, //0.03 is the smallest that still runs in normal fps
			orbitingPlanets: [
				duplicate(mercury),
				duplicate(venus),
				duplicate(earth),
				duplicate(mars),
				duplicate(jupiter),
				duplicate(saturn),
				duplicate(uranus),
				duplicate(neptune)
			],
			name: "sun"
		}


		public function Main() {
			// constructor code
			stage.align = "topLeft";
			stage.addChild(layerS);
			stage.addChild(layer0);
			stage.addChild(layer05);
			stage.addChild(layer1);
			stage.addChild(debugLayer);
			stage.addChild(txt);
			txt.text = "";


			for (var i: int = 0; i < layers.length; i++) {
				var l: Sprite = layers[0];
				l.mouseChildren = false;
				l.mouseEnabled = false;
			}


			populatePlanetsARrr(sun);
			addMoons();
			populateBGStars();


			stage.addEventListener(Event.ENTER_FRAME, update);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, onUp);
			stage.addEventListener(MouseEvent.CLICK, onClick);
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, zooom);
		}

		function addMoons(): void {
			for (var i: int = 0; i < allPlanets.length; i++) {
				var planet: Object = allPlanets[i];
				if (planet.numMoons) {
					var dist:Number = 20;
					for (var j: int = 0; j < planet.numMoons; j++) {
						
						var moon:Object = {
							radius: (Math.random() * 10) + 1,
							color: 0xffffff * Math.random(),
							distanceFromParent: dist,
							angle: Math.random() * (Math.PI * 2),
							speed: getSpeed(true),
							name: "moon"
						}
						
						dist += (moon.radius * 2);
						
						planet.orbitingPlanets.push(moon);
					}
				}

			}
		}

		function drawPlanet(planet: Object, parentObj: Object = null): void {
			g1.beginFill(planet.color, 1);

			if (parentObj) {


				var cos: Number = Math.cos(planet.angle) * (planet.distanceFromParent + parentObj.radius);
				var sin: Number = Math.sin(planet.angle) * (planet.distanceFromParent + parentObj.radius);
				cos += parentObj.x;
				sin += parentObj.y;

				planet.x = cos;
				planet.y = sin;

				planet.angle += planet.speed;
				planet.angle = fixAngle(planet.angle);

				if (planet.showOrbit || parentObj.showOrbit) {
					g05.lineStyle(0.1, 0xffffff, .5);
					g05.drawCircle(parentObj.x, parentObj.y, planet.distanceFromParent + parentObj.radius);
					g05.endFill();
				}


			}
			if (isInScreen(planet.x, planet.y) || 
				isInScreen(planet.x + planet.radius, planet.y) ||
				isInScreen(planet.x - planet.radius, planet.y) ||
				isInScreen(planet.x , planet.y+ planet.radius) ||
				isInScreen(planet.x , planet.y- planet.radius) 
			
			) 
			{
				g1.drawCircle(planet.x, planet.y, planet.radius); // Draw the circle, assigning it a x position, y position, raidius.
				g1.endFill();
			}
			

			var p: Object;
			if (planet.orbitingPlanets) {
				for (var i: int = 0; i < planet.orbitingPlanets.length; i++) {
					p = planet.orbitingPlanets[i];
					drawPlanet(p, planet);
				}
			}

			if (planet.emitsLight) {
				var lightLineThickness:Number = 2;
				if(lightLineThickness < 1)
				{
					lightLineThickness = 1;
				}
				var lightAngleDelta:Number = (Math.PI * 2)/(360/2 );
				
				
				g0.lineStyle(lightLineThickness, planet.color, 0.4);
				var angles: Array = [];

				for (var j: int = 0; j < allPlanets.length; j++) {
					p = allPlanets[j];

					if (p == planet) {
						continue;
					}
					var centerAngleToSun: Number = fixAngle(getAngle(p.x, p.y, planet.x, planet.y));
					var distanceToSun: Number = getDistance(planet.x, planet.y, p.x, p.y);

					var leftAngle: Number = centerAngleToSun + (Math.PI / 2);
					var leftPointX: Number = (Math.cos(leftAngle) * p.radius) + p.x;
					var leftPointY: Number = (Math.sin(leftAngle) * p.radius) + p.y;

					//drawCircle(leftPointX, leftPointY, 2);

					var rightAngleToSun: Number = fixAngle(getAngle(leftPointX, leftPointY, planet.x, planet.y));

					var rigtAngle: Number = centerAngleToSun - (Math.PI / 2);
					var rightPointX: Number = (Math.cos(rigtAngle) * p.radius) + p.x;
					var rightPointY: Number = (Math.sin(rigtAngle) * p.radius) + p.y;

					//drawCircle(rightPointX, rightPointY, 2);

					var leftAngleToSun: Number = fixAngle(getAngle(rightPointX, rightPointY, planet.x, planet.y));

					if (leftAngleToSun > rightAngleToSun) {
						rightAngleToSun += (Math.PI * 2);
					}


					//trace(leftAngleToSun, centerAngleToSun, rightAngleToSun);

					var obj: Object = {
						left: Math.min(leftAngleToSun, rightAngleToSun),
						right: Math.max(leftAngleToSun, rightAngleToSun),
						dist: distanceToSun
					}

					//addEntry(obj, angles)
					angles.push(obj);



				}

				addEntry1(angles)

				var baseLen: Number = planet.radius;

				angles.sortOn("left", Array.NUMERIC);

				var emptypSpaces: Array = [];
				var smallest: Number = 0;
				var biggest: Number = 0;
				var a: Object;
				
				//first emit to all the planets
				for (var h: int = 0; h < angles.length; h++) {
					a = angles[h];

					biggest = a.left;

					emptypSpaces.push({
						left: smallest,
						right: biggest
					});
					
					

					for (var l: Number = a.left; l <= a.right; l += lightAngleDelta) {
						var cos1: Number = Math.cos(l);
						var sin1: Number = Math.sin(l);
						var planetSurfaceX: Number = planet.x + (cos1 * baseLen);
						var planetSurfaceY: Number = planet.y + (sin1 * baseLen);

						//if (isInScreen(planetSurfaceX, planetSurfaceY)) 
						{

							emitLight(lightLineThickness, planetSurfaceX, planetSurfaceY, planet.x, planet.y, cos1, sin1, Math.min(a.dist, planet.lightRad), planet.lightRad, planet.color);

						}
					}

					smallest = a.right;
				}

				if (smallest < Math.PI * 2) {
					emptypSpaces.push({
						left: smallest,
						right: Math.PI * 2
					});
				}


				//then emit to empty space
				for (var k: int = 0; k < emptypSpaces.length; k++) {
					a = emptypSpaces[k];
					for (var ang: Number = a.left; ang < a.right; ang += lightAngleDelta) {
						var cos2: Number = Math.cos(ang);
						var sin2: Number = Math.sin(ang);
						var planetSurfaceX: Number = planet.x + (cos2 * baseLen);
						var planetSurfaceY: Number = planet.y + (sin2 * baseLen);

						//if (isInScreen(planetSurfaceX, planetSurfaceY)) 
						{

							emitLight(lightLineThickness, planetSurfaceX, planetSurfaceY, planet.x, planet.y, cos2, sin2, planet.lightRad, planet.lightRad, planet.color);
						}


					}
				}
			}

			if (planet.rings) {
				var startDist: Number = planet.radius + (planet.radius * 0.4);
				for (i = 0; i < planet.rings.length; i++) {
					var color: uint = planet.rings[i];
					g05.lineStyle(0.1, color, .5);

					for (j = 0; j < 15; j++) {
						g05.drawCircle(planet.x, planet.y, startDist + j);
						g05.endFill();
					}
					startDist += j;


				}


			}
		}

		function emitLight(lightLineThickness:Number, planetSurfaceX: Number, planetSurfaceY: Number, baseX: Number, baseY: Number, cos: Number, sin: Number, currentLightRad: Number, totalLightRad: Number, color: uint): void {

			g0.moveTo(planetSurfaceX, planetSurfaceY);
			var sections: Number = 20;
			var sectionLen: Number = totalLightRad / sections;
			for (var i: Number = sectionLen; i < totalLightRad; i += sectionLen) {
				var surpassed: Boolean = false;
				if (i >= currentLightRad) {
					i = currentLightRad;
					surpassed = true;
				}
				var per: Number = (1 - (i / totalLightRad));
				if (per * 0.6 <= 0) {
					break;
				}
				var dpX: Number = baseX + (cos * (i+lightLineThickness));
				var dpY: Number = baseY + (sin * (i+lightLineThickness));

				if (isInScreen(planetSurfaceX, planetSurfaceY) || isInScreen(dpX, dpY)) {
					g0.lineStyle(lightLineThickness, color, per * 0.6);
					g0.lineTo(dpX, dpY);


				}
				planetSurfaceX = dpX;
				planetSurfaceY = dpY;

				if (surpassed) {
					break;
				}
			}

		}


		function addEntry1(arr: Array): void {

			arr.sortOn("dist", Array.NUMERIC)

			var redo: Boolean = false;
			outer: for (var i: int = 0; i < arr.length; i++) {
				var closer: Object = arr[i];
				for (var j: int = 0; j < arr.length; j++) {
					var farther: Object = arr[j];
					if (i == j) {
						continue;
					}

					//if obj is smaller than curr
					if (closer.left >= farther.left && closer.right <= farther.right) {

						var fartherRight: Number = farther.right;
						//obj is closer and smaller
						//curr is now only the left part showing behind obj
						farther.right = closer.left; //curr is behind and ends in obj

						//this is for the right end of curr
						arr.push({
							left: closer.right,
							right: fartherRight,
							dist: farther.dist
						});
						redo = true;
						break outer;
					}

					//if obj is bigger than current
					if (closer.left <= farther.left && closer.right >= farther.right) {

						arr.splice(j, 1);
						redo = true;
						break outer;
					}
					//obj is to the left of cur and partially blocked
					if (closer.left <= farther.left && closer.right > farther.left && closer.right <= farther.right) {
						//farther.left = closer.right ;
						arr.push({
							left: closer.right,
							right: farther.right,
							dist: farther.dist
						});
						arr.splice(j, 1);
						redo = true;
						break outer;

					}
					if (closer.right >= farther.right && closer.left < farther.right && closer.left >= farther.left) {

						//closer.left = farther.left;
						arr.push({
							left: farther.left,
							right: closer.left,
							dist: farther.dist
						});
						arr.splice(j, 1);
						redo = true;
						break outer;
					}
				}
			}
			if (redo) {
				addEntry1(arr)
			}
		}

		function fixAngle(angle: Number): Number {
			if (angle > Math.PI * 2) {
				angle -= Math.PI * 2;
			} else if (angle < 0) {
				angle += Math.PI * 2;
			}
			return angle;
		}

		function drawCircle(_x: Number, _y: Number, rad: Number, color: uint = 0xffffff): void {
			dg.beginFill(color, 1);
			dg.drawCircle(_x, _y, rad); // Draw the circle, assigning it a x position, y position, raidius.
			dg.endFill();
		}


		function getDistance(p1X: Number, p1Y: Number, p2X: Number, p2Y: Number): Number {
			var dX: Number = p1X - p2X;
			var dY: Number = p1Y - p2Y;
			var dist: Number = Math.sqrt(dX * dX + dY * dY);
			return dist;
		}

		function getAngle(p1X: Number, p1Y: Number, p2X: Number, p2Y: Number): Number {
			var dX: Number = p1X - p2X;
			var dY: Number = p1Y - p2Y;
			return Math.atan2(dY, dX);
		}


		function isInScreen(p1X: Number, p1Y: Number): Boolean {
			var l: Sprite = layers[1];
			var localPos: Point = l.localToGlobal(new Point(p1X, p1Y));
			var w: Number = stage.stageWidth;
			var h: Number = stage.stageHeight;
			if (localPos.x > 0 && localPos.x < w && localPos.y > 0 && localPos.y < h) {
				return true;
			} else {
				return false;
			}

		}




		function populatePlanetsARrr(planet: Object): void {
			allPlanets.push(planet);
			if (planet.orbitingPlanets) {
				for (var i: int = 0; i < planet.orbitingPlanets.length; i++) {
					var p: Object = planet.orbitingPlanets[i];

					populatePlanetsARrr(p);
				}
			}
		}

		function update(e: Event): void {
			var i: int = 0;
			var l: Sprite;
			if (tweenTo != null) {

				if (tweenTo.firstTime) {
					l = layers[1];
					var dX: Number = ((tweenTo.x - l.x) / 2);
					var dY: Number = ((tweenTo.y - l.y) / 2);

					for (i = 0; i < layers.length; i++) {
						l = layers[i];
						if (i != 0) {

							l.x += dX;
							l.y += dY;

						}
					}

					if (getDistance(l.x, l.y, tweenTo.x, tweenTo.y) < 0.5) {
						setFollow(tweenTo.planet, false);
					}


				} else {
					var fX: Number = 0;
					var fY: Number = 0;

					fX -= (tweenTo.planet.x * currZoom);
					fY -= (tweenTo.planet.y * currZoom);
					fX += (stage.stageWidth / 2); //
					fY += (stage.stageHeight / 2); //
					for (i = 0; i < layers.length; i++) {
						l = layers[i];
						if (i != 0) {

							l.x = fX;
							l.y = fY;
						}
					}
				}

			} else {
				if (mouseDown) {
					var deltaX: Number = stage.mouseX - origMouseX;
					var deltaY: Number = stage.mouseY - origMouseY;

					for (i = 0; i < layers.length; i++) {
						l = layers[i];
						if (i == 0) {
							l.x -= deltaX * 0.1;
							l.y -= deltaY * 0.1;
						} else {
							l.x += deltaX;
							l.y += deltaY;
						}
					}

					origMouseX = stage.mouseX;
					origMouseY = stage.mouseY;


				}
			}

			g0.clear();
			g05.lineStyle(0.1, 0x000000);
			g05.clear();
			g1.clear();
			g1.lineStyle(0.1, 0x000000);
			drawPlanet(sun);
			//stage.removeEventListener(Event.ENTER_FRAME, update);
		}




		function duplicate(o: Object): Object {
			var newO: Object = {};
			for (var k: String in o) {
				newO[k] = o[k];
			}
			return newO;
		}





		function populateBGStars(): void {
			gs.lineStyle(0.1, 0x000000);

			for (var i: int = 0; i < 100; i++) {
				var _x: Number = stage.stageWidth * Math.random();
				var _y: Number = stage.stageHeight * Math.random();
				gs.beginFill(0xffffff, 1);
				gs.drawCircle(_x, _y, 1); // Draw the circle, assigning it a x position, y position, raidius.
				gs.endFill();
			}
		}





		function onClick(event: MouseEvent): void {
			var l: Sprite = layers[1];
			var localPos: Point = l.globalToLocal(new Point(stage.mouseX, stage.mouseY));
			var xPos: Number = localPos.x; //(  ((stage.mouseX* currZoom) - l.x)  ); // l.x + -
			var yPos: Number = localPos.y; //(  ((stage.mouseY* currZoom) - l.y) ); //l.y + -
			var p: Object;
			var found: Boolean = false;
			var i: int = 0;
			for (i = 0; i < allPlanets.length; i++) {
				p = allPlanets[i];
				if (getDistance(p.x, p.y, xPos, yPos) < p.radius) {
					found = true;
					break;
				}
			}
			if (found) {
				txt.text = p.name;
				setFollow(p, true);

			}

		}


		function setFollow(p: Object, firstTime: Boolean): void {
			var l: Sprite = layers[1];
			var i: int = 0;
			trace("hit ", p.name);
			for (i = 0; i < layers.length; i++) {
				l = layers[i];
				var fX: Number = 0;
				var fY: Number = 0;

				fX -= (p.x * currZoom);
				fY -= (p.y * currZoom);
				fX += (stage.stageWidth / 2); //
				fY += (stage.stageHeight / 2); //
				p.showOrbit = true;
				tweenTo = {
					planet: p,
					x: fX,
					y: fY,
					firstTime: firstTime
				};
			}
		}

		function onDown(event: MouseEvent): void {
			origMouseX = stage.mouseX;
			origMouseY = stage.mouseY;
			mouseDown = true;
			if(tweenTo)
			{
				tweenTo.planet.showOrbit = false;
			}
			
			tweenTo = null;
			txt.text = "";
		}

		function onUp(event: MouseEvent): void {
			mouseDown = false;
		}

		function getSpeed(isMoon: Boolean = false): Number {
			var speed: Number = (Math.random() * 0.005) + 0.001;
			if (isMoon) {
				speed += (Math.random() * 0.05) + 0.01;
			}
			return speed;
		}


		function zooom(event: MouseEvent): void {
			var l: Sprite = layers[1];
			var localPosPre: Point = l.globalToLocal(new Point(stage.mouseX, stage.mouseY));
			//drawCircle(localPosPre.x, localPosPre.y, 10, 0x00cc00);
			if(tweenTo)
			{
				tweenTo.planet.showOrbit = false;
			}
			
			tweenTo = null;
			txt.text = "";
			var proceed: Boolean = true;
			if (event.delta > 0) {
				currZoom += zoomAmount;
			} else {
				currZoom -= zoomAmount;
				if (currZoom <= 0.01) {
					currZoom = 0.01;
					proceed = false;
				}
			}

			if (!proceed) {
				return;
			}


			var i: int = 0;


			for (i = 0; i < layers.length; i++) {
				l = layers[i];

				if (i != 0) {
					l.scaleX = currZoom;
					l.scaleY = currZoom;


				}
			}

			var localPosPost: Point = l.globalToLocal(new Point(stage.mouseX, stage.mouseY));
			var xDiff: Number = (localPosPre.x - localPosPost.x) / 2;
			var yDiff: Number = (localPosPre.y - localPosPost.y) / 2;
			//trace(localPosPre, localPosPost, xDiff, yDiff);

			//drawCircle(localPosPost.x, localPosPost.y,10, 0x0099ff);

			var d: Number = Math.abs(event.delta);

			for (i = 0; i < layers.length; i++) {
				l = layers[i];

				if (i != 0) {
					if (event.delta > 0) {
						l.x -= ((localPosPre.x + xDiff) * (zoomAmount * d));
						l.y -= ((localPosPre.y + yDiff) * (zoomAmount * d));

					} else {
						l.x += ((localPosPre.x - xDiff) * (zoomAmount * d));
						l.y += ((localPosPre.y - yDiff) * (zoomAmount * d));

					}

				}
			}

		}

	}

}