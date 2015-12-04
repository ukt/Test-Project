package app.game {
	import app.game.entities.actions.Disposer;

	public interface Game extends Disposer{
		function start():void;
	}
}
