package app.game.entities {
	import app.game.hitArea.HitArea;

	import flash.display.MovieClip;

	public interface Entity extends Disposer{
		function update():void;

		function collide(entity:Entity):Boolean;

		function get ani():MovieClip
		function get hitArea():HitArea
	}
}
