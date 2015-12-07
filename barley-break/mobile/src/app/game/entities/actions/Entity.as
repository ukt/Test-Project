package app.game.entities.actions {
	import flash.display.MovieClip;

	public interface Entity extends Disposer{
		function update():void;
		function initialize():void;
		function get ani():MovieClip

		function updateDT(dt:uint):void;
	}
}
