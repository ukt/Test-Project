package app.game.entities {
	import app.App;
	import app.accelerometer.AccelerometerVO;
	import app.game.entities.actions.Entity;

	import flash.display.Graphics;
	import flash.display.MovieClip;

	public class AccelerometerShower implements Entity{
		private var _ani:MovieClip = new MovieClip();

		private var name:String;

		private var _width:int;

		private var _height:int;

		public function AccelerometerShower(name:String, x:Number, y:Number, width:int = 20, height:int = 20) {
			_width = width = width * App.appScale;
			_height = height = height * App.appScale;
			this.name = name + x + "_" + y;
			_ani.x = x * width + x * 5;
			_ani.y = y * height + y * 5;
			trace(x, y);

			ani.cacheAsBitmap = true;
		}

		public function initialize():void {

		}

		public function updateDT(dt:uint):void {

		}

		public function update():void {
			var accelerometerVO:AccelerometerVO = App.world.accelerometerVO;

			var graphics:Graphics = _ani.graphics;
			var colorArray:Array = [0xEEEEEE];
			var randomColorID:Number = Math.floor(Math.random() * colorArray.length);
			var color:uint = colorArray[randomColorID];
			graphics.clear();
			graphics.lineStyle(4, 0xbebebe, 1, true);
			graphics.beginFill(color, 1);
			graphics.drawRoundRect(0, 0, _width, _height, 10);
			graphics.endFill();
			graphics.moveTo(_width*.5, _height*.5);
			graphics.lineTo(
					_width*.5 + -accelerometerVO.accelerationX * _width*.5,
					_height*.5 + accelerometerVO.accelerationY * _height*.5);
		}

		public function get ani():MovieClip {
			return _ani;
		}

		public function dispose():void {
			if (_ani.parent) {
				_ani.parent.removeChild(_ani);
			}
		}
	}
}
