package app.game.entities {
	import flash.display.MovieClip;

	public interface Entity extends Disposer{
		function update():void;
		function initialize():void;
		function get ani():MovieClip

	}
}
