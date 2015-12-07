package app.world {
	import app.game.entities.actions.Entity;

	public interface IWorldListener {
		function initialize(world:World):void;
		function updateDtComplete(dt:int):void;
		function updateComplete():void;
		function entityAdded(entity:Entity):void;
		function entityRemoved(entity:Entity):void;
	}
}
