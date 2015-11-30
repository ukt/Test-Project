package app.game.entities {
	import app.App;
	import app.accelerometer.AccelerometerVO;

	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	public class BoxEntity implements Entity {
		private var _ani:MovieClip = new MovieClip();
		private var _speedX:Number = 0;
		private var _speedY:Number = 0;
		private var maxSpeed:Number;// = 20 + Math.random() * ;


		private var accelerometerVO:AccelerometerVO;
		private var square:Number = 0;

		private var name:String;

		private var acceleration:Number;

		public function BoxEntity(name:String, x:Number, y:Number, width:int = 20, height:int = 20) {
			this.name = name;
			maxSpeed = 60;
			square = Math.sqrt(width * height);
			var gi:Number = 9.8 + Math.random();
			acceleration = (gi * (1 / square));
			var textField:TextField = new TextField();
			textField.text = name;
			textField.width = width - 1;
			textField.height = height - 1;
			textField.selectable = false;
			textField.cacheAsBitmap = true;
			textField.autoSize = TextFieldAutoSize.CENTER;
//			_ani.addChild(textField);
			_ani.x = x * width + x * 15;
			_ani.y = y * height + y * 15;
			trace(x, y);
			var graphics:Graphics = _ani.graphics;
			var colorArray:Array = [0xFFFF33, 0x79DCF4, 0x0000ff, 0xFF3333, 0xFFCC33, 0x99CC33];
			var randomColorID:Number = Math.floor(Math.random() * colorArray.length);
			var color:uint = colorArray[randomColorID];
			graphics.lineStyle(2, 0xcecece, 1, true);
			graphics.beginFill(color, 1);
			graphics.drawRoundRect(0, 0, width, height, 10);
			graphics.endFill();
			ani.cacheAsBitmap = true;
			_ani.addEventListener(MouseEvent.CLICK, onClick)
		}

		private function onClick(event:MouseEvent):void {
			App.world.updateAccelerometerData();
			setXPosition(ani.x - 2);
			//			ani.y -= 1;
		}

		public function update():void {
			this.accelerometerVO = App.world.accelerometerVO;
			_speedX += maxSpeed * accelerometerVO.accelerationX * -1 * acceleration;
			_speedY += maxSpeed * accelerometerVO.accelerationY * acceleration;
			_speedX = Math.max(-maxSpeed, Math.min(_speedX, maxSpeed));
			_speedY = Math.max(-maxSpeed, Math.min(_speedY, maxSpeed));
			var maxWhileX:int = 5;
			var maxWhileY:int = 5;

			do {
				if (App.world.isCollided(this)) {
					_speedX *= .150;
					moveToPrevXPosition();
				}
				setXPosition(ani.x + _speedX);
			} while (App.world.isCollided(this) && maxWhileX-- > 0);
			if (App.world.isCollided(this)) {
				moveToPrevXPosition();
			}
			do {
				if (App.world.isCollided(this)) {
					_speedY *= .150;
					moveToPrevYPosition();
				}
				setYPosition(ani.y + _speedY);
			} while (App.world.isCollided(this) && maxWhileY-- > 0);
			if (App.world.isCollided(this)) {
				moveToPrevYPosition();
			}
			/*
			 while (App.world.isCollided(this) && maxWhile-->0) {
			 moveToPrevPosition();
			 setXPosition(ani.x + Math.random()*_speedX-_speedX*.5);
			 setYPosition(ani.y + Math.random()*_speedY-_speedY*.5);
			 }
			 if (!isCollided /!*&& false*!/) {

			 }*/
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

		private function setXPosition(newX:Number):void {
			_prevX = ani.x;
			if (newX > 0 && newX + ani.width < App.deviceSize.width) {
				ani.x = newX;
			} else if (newX <= 0) {
				ani.x = 1;//Math.random();
			} else if (newX + ani.width >= App.deviceSize.width) {
				ani.x = App.deviceSize.width - (ani.width + /*Math.random() - 1*/1);
			}
		}

		private function setYPosition(newY:Number):void {
			_prevY = ani.y;
			if (newY > 0 && newY + ani.height < App.deviceSize.height) {
				ani.y = newY;
			} else if (newY <= 0) {
				ani.y = 1;//Math.random();
			} else if (newY + ani.width >= App.deviceSize.height) {
				ani.y = App.deviceSize.height - (ani.height + /*Math.random() - 1*/1);
			}
		}

		public function get ani():MovieClip {
			return _ani;
		}
	}
}
