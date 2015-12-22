package app.game.worldListener {
	import app.App;
	import app.game.entities.actions.Entity;
	import app.game.entities.actions.EntityMover;
	import app.game.entities.actions.HittableEntity;
	import app.game.hitArea.PhysicalHitArea;
	import app.world.IWorldListener;
	import app.world.World;

	public class CollideWorldListener2 implements IWorldListener {
		private var world:World;

		public function CollideWorldListener2() {
		}

		public function updateDtComplete(dt:int):void {
			collide();
		}

		private function collide():void {
			var world:World = App.world;
			world.forEach(EntityMover, function (entityMover:EntityMover):void {
				var entities:Vector.<Entity> = world.collide(HittableEntity(entityMover).hitArea);
				for each (var entity:Entity in entities) {
					if (HittableEntity(entity).hitArea is PhysicalHitArea && HittableEntity(entityMover).hitArea is PhysicalHitArea) {

						var physicalHitArea1:PhysicalHitArea = PhysicalHitArea(HittableEntity(entity).hitArea);
						var physicalHitArea2:PhysicalHitArea = PhysicalHitArea(HittableEntity(entityMover).hitArea);

						var speedXSum1:Number = physicalHitArea2.speedX - physicalHitArea1.speedX;
						var speedXSum2:Number = physicalHitArea1.speedX - physicalHitArea2.speedX;
						var needAddSpeedXToEntity1:Number = speedXSum1 / (physicalHitArea1.weight);
						var needAddSpeedXToEntity2:Number = speedXSum2 / (physicalHitArea2.weight);
						physicalHitArea1.moveToPrevXPosition();
						physicalHitArea2.moveToPrevXPosition();
						physicalHitArea1.speedX = needAddSpeedXToEntity1*.5;
						physicalHitArea2.speedX = needAddSpeedXToEntity2*.5;

						var speedYSum1:Number = physicalHitArea2.speedY - physicalHitArea1.speedY;
						var speedYSum2:Number = physicalHitArea1.speedY - physicalHitArea2.speedY;
						var needAddSpeedYToEntity1:Number = speedYSum1 / (physicalHitArea1.weight);
						var needAddSpeedYToEntity2:Number = speedYSum2 / (physicalHitArea2.weight);
						physicalHitArea1.moveToPrevYPosition();
						physicalHitArea2.moveToPrevYPosition();
						physicalHitArea1.speedY = needAddSpeedYToEntity1*.5;
						physicalHitArea2.speedY = needAddSpeedYToEntity2*.5;
					}
				}
			})
		}

		public function updateComplete():void {
//			collide();
		}

		public function entityAdded(entity:Entity):void {
		}

		public function entityRemoved(entity:Entity):void {
		}

		public function initialize(world:World):void {
			this.world = world
		}
	}
}
