package app.game.entities {
	import app.accelerometer.AccelerometerVO;

	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.text.TextField;

	public class BoxEntity implements Entity {
		private var _ani:MovieClip = new MovieClip();

		public function BoxEntity(name:String, x:Number, y:Number) {
			var textField:TextField = new TextField();
			textField.text = name;
			//			_ani.addChild(textField);
			_ani.x = x * 20;
			_ani.y = y * 20;
			trace(x, y);
			var graphics:Graphics = _ani.graphics;
			graphics.beginFill(0x0000FF + Math.random() * 10000, 1);
			graphics.drawRect(0, 0, 20, 20);
			graphics.endFill();
		}

		private var accelerometerVO:AccelerometerVO;

		public function update(accelerometerVO:AccelerometerVO):void {
			this.accelerometerVO = accelerometerVO;
			_ani.x += accelerometerVO.accelerationX + Math.random()*2-1;
			_ani.y += accelerometerVO.accelerationY + Math.random()*2-1;
		}

		public function collide(entity:Entity):void {
			if (entity.ani.x < ani.x + 20) {

			}
		}

		public function get ani():MovieClip {
			return _ani;
		}
	}
}
