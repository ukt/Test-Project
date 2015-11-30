package app.game.entities {
	import app.App;
	import app.App;
	import app.World;
	import app.accelerometer.AccelerometerVO;

	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.getTimer;

	public class BoxEntity implements Entity, Actioner, SquareGetter {
		private var _ani:MovieClip = new MovieClip();
		private var _speedX:Number = 0;
		private var _speedY:Number = 0;
		private var maxSpeed:Number;// = 20 + Math.random() * ;


		private var accelerometerVO:AccelerometerVO;
		private var _square:Number = 0;

		private var name:String;

		private var acceleration:Number;

		public var color:uint;
		private var _time:uint;

		public function BoxEntity(name:String, x:Number, y:Number, width:int = 20, height:int = 20) {
			this.name = name;
			width = width*App.appScale;
			height = height*App.appScale;
			maxSpeed = 60;
			_square = Math.sqrt(width * height);
			var gi:Number = 9.8 + Math.random()*5;
			acceleration = (gi * (1 / _square));
			var textField:TextField = new TextField();
			textField.text = name;
			textField.width = width - 1;
			textField.height = height - 1;
			textField.selectable = false;
			textField.cacheAsBitmap = true;
			textField.autoSize = TextFieldAutoSize.CENTER;
//						_ani.addChild(textField);
			_ani.x = x * width + x * 15;
			_ani.y = y * height + y * 15;
			trace(x, y);
			var graphics:Graphics = _ani.graphics;
			var colorArray:Array = [0xB03838,
				0xB038A2,
				0x7A38B0,
				0x3848B0,
				0x38AEB0,
				0x99CC33,
				0x38B06C,
				0xB09038,
				0xB03838
			];
			var randomColorID:Number = Math.floor(Math.random() * colorArray.length);
			color = colorArray[randomColorID];
			graphics.lineStyle(2, 0xcecece, 1, true);
			graphics.beginFill(color, 1);
			graphics.drawRoundRect(0, 0, width, height, 10);
			graphics.endFill();
			ani.cacheAsBitmap = true;
			_ani.addEventListener(MouseEvent.CLICK, onClick)
		}

		private function onClick(event:MouseEvent):void {
			App.world.updateAccelerometerData();
		}

		public function update():void {
			this.accelerometerVO = App.world.accelerometerVO;
			_speedX += calculateAccelerationByX();
			_speedY += calculateAccelerationByY();
			_speedX = Math.max(-maxSpeed, Math.min(_speedX, maxSpeed));
			_speedY = Math.max(-maxSpeed, Math.min(_speedY, maxSpeed));
			var maxWhileX:int = 5;
			var maxWhileY:int = 5;
			if (Math.abs(_speedX) > 1) {
				do {
					if (App.world.isCollided(this)) {
						_speedX *= .150;
						moveToPrevXPosition();
					}
					if(!setXPosition(ani.x + _speedX)){
						_speedX *= .150;
					}
				} while (App.world.isCollided(this) && maxWhileX-- > 0);
				if (App.world.isCollided(this)) {
					moveToPrevXPosition();
				}
			}
			if (Math.abs(_speedY) > 1) {
				do {
					if (App.world.isCollided(this)) {
						_speedY *= .150;
						moveToPrevYPosition();
					}

					if(!setYPosition(ani.y + _speedY)){
						_speedY *= .150;
					}
				} while (App.world.isCollided(this) && maxWhileY-- > 0);
				if (App.world.isCollided(this)) {
					moveToPrevYPosition();
				}
			}
		}

		private function calculateAccelerationByX():Number {
			return maxSpeed * accelerometerVO.accelerationX * -1 * acceleration;
		}

		private function calculateAccelerationByY():Number {
			return maxSpeed * accelerometerVO.accelerationY * acceleration;
		}

		public function action():void {
			var entity:BoxEntity;
			var timer:int = getTimer();
//			if(Math.abs(_speedX)>calculateAccelerationByX() || Math.abs(_speedY)>calculateAccelerationByY()){
			if(Math.abs(_speedX)>3 || Math.abs(_speedY)>3){
				_time = timer;
				return;
			} else if(timer - _time<2000){
				return;
			}
			var collideMove:int = 5;
			setXPosition(ani.x + collideMove);
			entity = App.world.collide(this) as BoxEntity;
			moveToPrevXPosition();
			if (entity && entity.color == color) {
				App.world.removeEntity(entity);
				App.world.removeEntity(this);
			}

			setXPosition(ani.x - collideMove);
			entity = App.world.collide(this) as BoxEntity;
			moveToPrevXPosition();
			if (entity && entity.color == color) {
				App.world.removeEntity(entity);
				App.world.removeEntity(this);
			}

			setYPosition(ani.y + collideMove);
			entity = App.world.collide(this) as BoxEntity;
			moveToPrevYPosition();
			if (entity && entity.color == color) {
				App.world.removeEntity(entity);
				App.world.removeEntity(this);
			}

			setYPosition(ani.y - collideMove);
			entity = App.world.collide(this) as BoxEntity;
			moveToPrevYPosition();
			if (entity && entity.color == color) {
				App.world.removeEntity(entity);
				App.world.removeEntity(this);
			}
		}

		public function collide(entity:Entity):Boolean {
			var ani2:MovieClip = entity.ani;
			if (entity === this) {
				return false;
			}
			var isAniInCubeByXAsLeft:Boolean = ani.x <= ani2.x && ani.x + ani.width >= ani2.x;
			var isAniInCubeByXAsRight:Boolean = ani.x >= ani2.x && ani.x <= ani2.x + ani2.width;
			var isAniInCubeByYAsTop:Boolean = ani.y >= ani2.y && ani.y <= ani2.y + ani2.height;
			var isAniInCubeByYAsBottom:Boolean = ani.y <= ani2.y && ani.y + ani.height >= ani2.y;

			var isCollided:Boolean = false;
			if (isAniInCubeByXAsLeft && isAniInCubeByYAsTop) {
				isCollided = true;
			}
			if (isAniInCubeByXAsLeft && isAniInCubeByYAsBottom) {
				isCollided = true;
			}
			if (isAniInCubeByXAsRight && isAniInCubeByYAsTop) {
				isCollided = true;
			}
			if (isAniInCubeByXAsRight && isAniInCubeByYAsBottom) {
				isCollided = true;
			}
			return isCollided;
		}

		private var _prevX:Number = 0;
		private var _prevY:Number = 0;

		private function moveToPrevXPosition():void {
			ani.x = _prevX;
		}

		private function moveToPrevYPosition():void {
			ani.y = _prevY;
		}

		private function setXPosition(newX:Number):Boolean {
			_prevX = ani.x;
			if (newX > 0 && newX + ani.width < App.deviceSize.width) {
				ani.x = newX;
				return true;
			} else if (newX < 0) {
				ani.x = 1;
			} else if (newX + ani.width > App.deviceSize.width) {
				ani.x = App.deviceSize.width - (ani.width + 1);
			}
			return false;
		}

		private function setYPosition(newY:Number):Boolean {
			_prevY = ani.y;
			if (newY > 0 && newY + ani.height < App.deviceSize.height) {
				ani.y = newY;
				return true;
			} else if (newY < 0) {
				ani.y = 1;
			} else if (newY + ani.width > App.deviceSize.height) {
				ani.y = App.deviceSize.height - (ani.height + 1);
			}
			return false;
		}

		public function get ani():MovieClip {
			return _ani;
		}

		public function dispose():void {
			if(_ani.parent){
				_ani.removeEventListener(MouseEvent.CLICK, onClick);
				_ani.parent.removeChild(_ani);
			}
		}

		public function get square():uint {
			return this._square;
		}
	}
}
