package app.game.entities {
	import app.accelerometer.AccelerometerVO;

	import flash.display.MovieClip;

	public interface Entity {
		function update(accelerometerVO:AccelerometerVO):void;

		function collide(entity:Entity):void;

		function get ani():MovieClip
	}
}
