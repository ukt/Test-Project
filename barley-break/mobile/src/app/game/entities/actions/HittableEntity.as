package app.game.entities.actions {
	import app.game.hitArea.HitArea;

	public interface HittableEntity extends Entity{
		function get hitArea():HitArea;
	}
}
