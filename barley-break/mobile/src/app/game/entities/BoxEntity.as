package app.game.entities {
	import app.App;
	import app.World;
	import app.accelerometer.AccelerometerVO;
	import app.game.entities.actions.Actioner;
	import app.game.entities.actions.Entity;
	import app.game.entities.actions.HittableEntity;
	import app.game.entities.actions.SpeedAdder;
	import app.game.entities.actions.SquareGetter;
	import app.game.hitArea.HitArea;
	import app.game.hitArea.HitSegment;

	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.system.Capabilities;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.getTimer;

	public class BoxEntity implements Entity, Actioner, SquareGetter, HittableEntity, SpeedAdder {
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
		private var _hitArea:HitArea;

		public function BoxEntity(name:String, x:Number, y:Number, width:int = 20, height:int = 20) {
			_hitArea = new HitArea(this);
			this.name = name;
			width = width * App.appScale;
			height = height * App.appScale;
			maxSpeed = 30;
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
			_hitArea = new HitArea(this);
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
			_speedX += calculateAccelerationByX();
			_speedY += calculateAccelerationByY();
			_speedX = Math.max(-maxSpeed, Math.min(_speedX, maxSpeed));
			_speedY = Math.max(-maxSpeed, Math.min(_speedY, maxSpeed));

			var speedCompensation:Number = .25;
			var entities:Vector.<Entity>;
			if(Math.abs(_speedX*(1-accelerometerVO.accelerationX))>1) {
				setXPosition(_speedX * (dt / 16));
				entities = world.collide(hitArea);
				if (entities.length > 0) {
					var speedXCompensation:Number = speedCompensation * entities.length;
					_speedX *= -speedXCompensation;
					for each(var entity:Entity in entities) {
						if (entity is SpeedAdder) {
							SpeedAdder(entity).addSpeed(this, speedXCompensation, 0)
						}
					}
					moveToPrevXPosition();
				}
			}
			if(Math.abs(_speedY*(1-accelerometerVO.accelerationY))>1) {
				setYPosition(_speedY * (dt / 16));
				entities = world.collide(hitArea);
				if (entities.length > 0) {
					var speedYCompensation:Number = speedCompensation * entities.length;
					_speedY *= -speedYCompensation;
					for each(var entity:Entity in entities) {
						if (entity is SpeedAdder) {
							SpeedAdder(entity).addSpeed(this, 0, speedYCompensation)
						}
					}
					moveToPrevYPosition();
				}
			}
		}
		public function update():void {
			if (hitArea.segments.length == 0) {
				return
			}
			_ani.x = hitArea.segments[0].point1.x;
			_ani.y = hitArea.segments[0].point1.y;
		}

		private function calculateAccelerationByX():Number {
			return maxSpeed * accelerometerVO.accelerationX * -1 * acceleration;
		}

		private function calculateAccelerationByY():Number {
			return maxSpeed * accelerometerVO.accelerationY * acceleration;
		}

		public function action():void {
			var timer:int = getTimer();
			return
			if (Math.abs(_speedX) > 3 || Math.abs(_speedY) > 3) {
				_time = timer;
				return;
			} else if (timer - _time < 2000) {
				return;
			}

			var collideMove:int = 5;
			setXPosition(collideMove);
			removeCollidedEntities();
			moveToPrevXPosition();
			setXPosition(-collideMove);
			removeCollidedEntities();
			moveToPrevXPosition();
			setYPosition(collideMove);
			removeCollidedEntities();
			moveToPrevYPosition();
			setYPosition(-collideMove);
			removeCollidedEntities();
			moveToPrevYPosition();
		}

		private function removeCollidedEntities():Vector.<Entity> {
			var world:World = App.world;
			var collidedEntities:Vector.<Entity> = world.collide(hitArea);
			for each(var collidedEntity:Entity in collidedEntities) {
				if (collidedEntity as BoxEntity && BoxEntity(collidedEntity).color == color) {
					world.removeEntity(collidedEntity);
					world.removeEntity(this);
				}
			}
			return collidedEntities;
		}

		private function moveToPrevXPosition():Boolean {
			hitArea.moveToPrevXPosition();
			return true;
		}

		private function moveToPrevYPosition():Boolean {
			hitArea.moveToPrevYPosition();
			return true;
		}

		private function setXPosition(xOffset:Number):Boolean {
			/*var possibleNewX:Number = hitArea.segments[0].point1.x + xOffset;
			 var deviceSize:Rectangle = App.deviceSize;
			 if (possibleNewX < 0) {
			 xOffset = xOffset - possibleNewX;
			 } else if (possibleNewX + ani.width > deviceSize.width) {
			 var possibleNewXPlusW:Number = possibleNewX + ani.width;
			 xOffset = xOffset + deviceSize.width - possibleNewXPlusW;
			 }*/
			hitArea.moveXPosition(xOffset);
			return false;
		}

		private function setYPosition(yOffset:Number):Boolean {
			/*var possibleNewY:Number = hitArea.segments[0].point1.y + yOffset;
			 var deviceSize:Rectangle = App.deviceSize;
			 if (possibleNewY < 0) {
			 yOffset = yOffset - possibleNewY;
			 } else if (possibleNewY + ani.height > deviceSize.height) {
			 var possibleNewYPlusH:Number = possibleNewY + ani.height;
			 yOffset = yOffset + deviceSize.height - possibleNewYPlusH;
			 }*/
			hitArea.moveYPosition(yOffset);
			return false;
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

		public function addSpeed(target:Entity, xSpeed:int, ySpeed:int):void {
			_speedX += xSpeed;
			_speedY += ySpeed;
		}
	}
}
