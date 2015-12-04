package app {
	import app.accelerometer.AccelerometerVO;
	import app.collider.Collider;
	import app.game.entities.actions.Actioner;
	import app.game.entities.actions.Entity;
	import app.game.hitArea.HitArea;

	import flash.display.Sprite;
	import flash.events.AccelerometerEvent;
	import flash.events.Event;
	import flash.sensors.Accelerometer;

	public class World {
		private var main:Sprite;
		private var entities:Vector.<Entity> = new <Entity>[];
		private var functions:Vector.<Function> = new <Function>[];
		public var accelerometerVO:AccelerometerVO = new AccelerometerVO();
		public var collider:Collider = new Collider();

		public function World() {
		}

		public function initialize(main:Sprite):void {
			this.main = main;
			main.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			var accelerometer:Accelerometer = new Accelerometer();
			accelerometer.addEventListener(AccelerometerEvent.UPDATE, updateAccelerometer);
			updateAccelerometerData();
		}

		public function updateAccelerometerData():void {
			var accelerometerEvent:AccelerometerEvent = new AccelerometerEvent(AccelerometerEvent.UPDATE);
			accelerometerEvent.accelerationX = Math.random() * 2 - 1;
			accelerometerEvent.accelerationY = Math.random() * 2 - 1;
			accelerometerEvent.accelerationZ = Math.random() * 2 - 1;
			updateAccelerometer(accelerometerEvent)
		}

		private function updateAccelerometer(event:AccelerometerEvent):void {
			accelerometerVO = new AccelerometerVO();
			accelerometerVO.accelerationX = event.accelerationX;
			accelerometerVO.accelerationY = event.accelerationY;
			accelerometerVO.accelerationZ = event.accelerationZ;
			App.tf.text = "accelerationX: " + accelerometerVO.accelerationX + "\n" + "accelerationY: " + accelerometerVO.accelerationY + "\n";

		}

		public function collide(entityToCollide:HitArea):Vector.<Entity> {
			return collider.getCollidedEntities(entityToCollide);
		}

		public function isCollided(entityToCollide:HitArea):Boolean {
			return collide(entityToCollide).length > 0;
		}

		private function onEnterFrame(event:Event):void {
			for each(var entity:Entity in entities) {
				entity.update();
			}
			for each(var action:Entity in entities) {
				if (action is Actioner) {
					Actioner(action).action();
				}
			}

			for each(var f:Function in functions) {
				f.call();
			}

		}

		public function getForEach(entityClass:Class):Array {
			var result:Array = [];
			for each(var entity:Entity in entities) {
				if (entity is entityClass) {
					result.push(entity);
				}
			}
			return result;
		}

		public function forEach(entityClass:Class, func:Function):void {
			for each(var entity:Entity in entities) {
				if (entity is entityClass) {
					func.call(null, entity);
				}
			}
		}

		public function addEntity(entity:Entity):void {
			entity.initialize();
			entities.push(entity);
			main.addChild(entity.ani);
		}

		public function removeEntity(entity:Entity):void {
			functions.push(function ():void {
				var indexOf:Number = entities.indexOf(entity);
				if (indexOf > 0) {
					entities.splice(indexOf, 1);
					entity.dispose();
				}
			});

		}
	}
}
