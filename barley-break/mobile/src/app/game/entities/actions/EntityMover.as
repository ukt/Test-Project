package app.game.entities.actions {
	public interface EntityMover extends Entity{
		function addSpeed(target:EntityMover, xSpeed:int, ySpeed:int):void;
		function get speedX():Number;
		function get speedY():Number;

		function moveBack():void;
	}
}
