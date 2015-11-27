package app.game.entities {
	import app.App;
	import app.accelerometer.AccelerometerVO;

	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	public class BoxEntity implements Entity {
		private var _ani:MovieClip = new MovieClip();
		private var _speedX:Number = 0;
		private var _speedY:Number = 0;
		private var maxSpeed:Number = 10 + Math.random() * 2;

		private var _aniXOffset:Number = 0;
		private var _aniYOffset:Number = 0;

		public function BoxEntity(name:String, x:Number, y:Number) {
			var textField:TextField = new TextField();
			textField.text = name;
			//			_ani.addChild(textField);
			_ani.x = x * 20;
			_ani.y = y * 20;
			trace(x, y);
			var graphics:Graphics = _ani.graphics;
			graphics.beginFill(0x0000FF + Math.random() * 10000, .3);
			graphics.drawRect(0, 0, 20, 20);
			graphics.endFill();
			ani.cacheAsBitmap = true;
			_ani.addEventListener(MouseEvent.CLICK, onClick)
		}

		private function onClick(event:MouseEvent):void {
			var accelerometerVO:AccelerometerVO = App.world.accelerometerVO;
			accelerometerVO.accelerationX += (Math.random()-.5)*.05;
			accelerometerVO.accelerationY += (Math.random()-.5)*.05;
		}

		private var accelerometerVO:AccelerometerVO;

		public function update():void {
			this.accelerometerVO = App.world.accelerometerVO;
			_speedX += maxSpeed * accelerometerVO.accelerationX;
			_speedY += maxSpeed * accelerometerVO.accelerationY;
			_speedX =Math.max(-maxSpeed, Math.min(_speedX, maxSpeed));
			_speedY =Math.max(-maxSpeed, Math.min(_speedY, maxSpeed));
			if (_ani.x >= 0 && _ani.x + 20 <= ani.stage.stageWidth) {
				_ani.x += _speedX;
			}
			if(_ani.x <= 0){
				_ani.x = 1;
			} else if(_ani.x + 20 >= ani.stage.stageWidth){
				_ani.x = ani.stage.stageWidth - 21;
			}
			if (_ani.y >= 0 && _ani.y + 20 <= ani.stage.stageHeight) {
				_ani.y += _speedY;
			}
			if(_ani.y <= 0){
				_ani.y = 1;
			} else if(_ani.y + 20 >= ani.stage.stageHeight){
				_ani.y = ani.stage.stageHeight - 21;
			}
		}

		public function collide(entity:Entity):void {
			var isAniInCubeByX:Boolean = ani.x - entity.ani.x < 0 && ani.x + 20 - entity.ani.x > 0;
			var isAniInCubeByY:Boolean = ani.y - entity.ani.y < 0 && ani.y + 20 - entity.ani.y > 0;
			if (isAniInCubeByX && isAniInCubeByY) {
				if(isAniInCubeByX ) {
					ani.x -= 1 + Math.random() * .2;
					ani.x += 1 + Math.random() * .2;
				}

				if(isAniInCubeByX ) {
					ani.x -= 1 + Math.random() * .2;
					ani.x += 1 + Math.random() * .2;
				}
			} else if(ani.x - entity.ani.x > 0){
				ani.x += 1 + Math.random()*.2;
			}
			if (ani.y - entity.ani.y < 0) {
				ani.y -= 1 + Math.random()*.2;
			} else if(ani.y - entity.ani.y > 0){
				ani.y += 1 + Math.random()*.2;
			}
			if(_ani.x <= 0){
				_ani.x = 1;
			} else if(_ani.x + 20 >= ani.stage.stageWidth){
				_ani.x = ani.stage.stageWidth - 21;
			}
			if(_ani.y <= 0){
				_ani.y = 1;
			} else if(_ani.y + 20 >= ani.stage.stageHeight){
				_ani.y = ani.stage.stageHeight - 21;
			}
		}

		public function get ani():MovieClip {
			return _ani;
		}
	}
}
