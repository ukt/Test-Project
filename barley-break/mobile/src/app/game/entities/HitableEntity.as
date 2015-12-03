package app.game.entities {
	import app.game.hitArea.HitArea;

	public interface HitableEntity {
		function get hitArea():HitArea;
	}
}
