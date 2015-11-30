package app.game.entities {
	import app.accelerometer.AccelerometerVO;

	import flash.display.MovieClip;

	public interface Entity {
		function update():void;

		function collide(entity:Entity):Boolean;

		function get ani():MovieClip
	}
}
