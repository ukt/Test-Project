package app.game.entities {
	import app.game.hitArea.HitArea;

	public interface HittableEntity {
		function get hitArea():HitArea;
	}
}
