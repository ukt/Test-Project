package app.game.entities.actions {
	import app.game.hitArea.HitArea;

	public interface HittableEntity {
		function get hitArea():HitArea;
	}
}
