package app.game.entities {
	import app.App;
	import app.accelerometer.AccelerometerVO;
	import app.game.Acceleration;
	import app.game.entities.actions.Actioner;
	import app.game.entities.actions.Entity;
	import app.game.entities.actions.EntityMover;
	import app.game.entities.actions.HittableEntity;
	import app.game.entities.actions.SquareGetter;
	import app.game.hitArea.HitArea;
	import app.game.hitArea.HitSegment;
	import app.game.hitArea.PhysicalHitArea;
	import app.world.World;

	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.system.Capabilities;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	public class BoxEntity implements Entity, Actioner, SquareGetter, HittableEntity, EntityMover {
		private var _ani:MovieClip = new MovieClip();
		private var _speedX:Number = 0;
		private var _speedY:Number = 0;
		private var maxSpeed:Number;

		private var accelerometerVO:AccelerometerVO;
		private var _square:Number = 0;

		private var name:String;

		private var acceleration:Number;

		public var color:uint;
		private var _time:uint;
		private var _hitArea:PhysicalHitArea;

		public function BoxEntity(name:String, x:Number, y:Number, width:int = 20, height:int = 20) {
			_hitArea = new PhysicalHitArea(this);
			this.name = name;
			width = width * App.appScale;
			height = height * App.appScale;
			maxSpeed = 10;
			_square = Math.sqrt(width * height);
			var gi:Number = 9.8 + Math.random() * 5;
			acceleration = (gi * (1 / _square));
			var textField:TextField = new TextField();
			textField.text = name;
			textField.width = width - 1;
			textField.height = height - 1;
			textField.selectable = false;
			textField.cacheAsBitmap = true;
			textField.autoSize = TextFieldAutoSize.CENTER;
			if (Capabilities.isDebugger) {
//				_ani.addChild(textField);
			}
			_ani.x = x * width + x * 5 - width + 15;
			_ani.y = y * height + y * 5 - height + 45;
			trace(x, y);
			var graphics:Graphics = _ani.graphics;
			var colorArray:Array = [0xB03838, 0xB038A2, 0x7A38B0, 0x3848B0, 0x000, 0xfff, 0xcecece, 0x888888, 0x38AEB0, 0x99CC33, 0x38B06C, 0xB09038, 0xB03838];
			var randomColorID:Number = Math.floor(Math.random() * colorArray.length);
			color = colorArray[randomColorID];
			graphics.lineStyle(2, 0xcecece, 1, true);
			graphics.beginFill(color, 1);
			graphics.drawRoundRect(0, 0, width, height, 10);
			graphics.endFill();
			ani.cacheAsBitmap = true;
			_ani.addEventListener(MouseEvent.CLICK, onClick)
		}

		public function initialize():void {
			_hitArea = new PhysicalHitArea(this);
			_hitArea.addSegment(new HitSegment(new Point(_ani.x, _ani.y), new Point(_ani.x, _ani.y + _ani.height), 2));
			_hitArea.addSegment(new HitSegment(new Point(_ani.x, _ani.y), new Point(_ani.x + _ani.width, _ani.y), 2));
			_hitArea.addSegment(new HitSegment(new Point(_ani.x + _ani.width, _ani.y), new Point(_ani.x + _ani.width, _ani.y + _ani.height), 2));
			_hitArea.addSegment(new HitSegment(new Point(_ani.x, _ani.y + _ani.height), new Point(_ani.x + _ani.width, _ani.y + _ani.height), 2));
		}

		private static function onClick(event:MouseEvent):void {
			App.world.updateAccelerometerData();
		}

		public function updateDT(dt:uint):void {
			if (hitArea.segments.length == 0) {
				return
			}
			var world:World = App.world;
			this.accelerometerVO = world.accelerometerVO;
			_hitArea.update(dt);
			_hitArea.speedX -= Acceleration.G * accelerometerVO.accelerationX;
			_hitArea.speedY += Acceleration.G * accelerometerVO.accelerationY;
		}
		public function update():void {
			if (hitArea.segments.length == 0) {
				return
			}
			_ani.x = hitArea.centralCircle.point.x - _ani.width/2;
			_ani.y = hitArea.centralCircle.point.y - _ani.height/2;
		}

		public function action():void {
		}

		private function moveToPrevXPosition():Boolean {
			hitArea.moveToPrevXPosition();
			return true;
		}

		private function moveToPrevYPosition():Boolean {
			hitArea.moveToPrevYPosition();
			return true;
		}

		public function get ani():MovieClip {
			return _ani;
		}

		public function dispose():void {
			if (_ani.parent) {
				_ani.removeEventListener(MouseEvent.CLICK, onClick);
				_ani.parent.removeChild(_ani);
			}
		}

		public function get square():uint {
			return this._square;
		}

		public function get hitArea():HitArea {
			return _hitArea;
		}

		public function addSpeed(target:EntityMover, xSpeed:int, ySpeed:int):void {
			_speedX += xSpeed;
			_speedY += ySpeed;
		}

		public function get speedX():Number {
			return _speedX;
		}

		public function get speedY():Number {
			return _speedY;
		}

		public function moveBack():void {
			moveToPrevXPosition();
			moveToPrevYPosition();
		}
	}
}
