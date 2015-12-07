package app {
	import app.accelerometer.AccelerometerVO;
	import app.collider.Collider;
	import app.game.entities.actions.Actioner;
	import app.game.entities.actions.Entity;
	import app.game.hitArea.HitArea;

	import flash.display.DisplayObjectContainer;
	import flash.events.AccelerometerEvent;
	import flash.events.Event;
	import flash.sensors.Accelerometer;
	import flash.utils.getTimer;

	public class World {
		private var main:DisplayObjectContainer;
		private var entities:Vector.<Entity> = new <Entity>[];
		private var functions:Vector.<Function> = new <Function>[];
		public var accelerometerVO:AccelerometerVO = new AccelerometerVO();
		public var collider:Collider = new Collider();
		private var accelerometer:Accelerometer = new Accelerometer();

		public function World() {
		}

		public function dispose():void {
			for each(var entity:Entity in entities) {
				removeEntity(entity);
			}
			onEnterFrame();
			if (this.main) {
				main.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				accelerometer.removeEventListener(AccelerometerEvent.UPDATE, updateAccelerometer);
				this.main = null;
			}

		}


		public function initialize(main:DisplayObjectContainer):void {
			dispose();
			this.main = main;
			main.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			accelerometer.addEventListener(AccelerometerEvent.UPDATE, updateAccelerometer);
			updateAccelerometerData();
//			initializeEntities();
			/*for each(var entity:Entity in entities) {
			 main.addChild(entity.ani);
			 entity.initialize();
			 /!*if (entity is entityClass) {
			 func.call(null, entity);
			 }*!/
			 }*/
		}

		/*private function initializeEntities():void {

		 }*/

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

		private var _collideTime:uint = 0;
		private var _collideCount:uint = 0;

		public function collide(entityToCollide:HitArea, limit:int = int.MAX_VALUE):Vector.<Entity> {
			var time:uint = getTimer();
			var collidedEntities:Vector.<Entity> = collider.getCollidedEntities(entityToCollide, limit);
			_collideTime += getTimer() - time;
			_collideCount++;
			return collidedEntities;
		}

		public function isCollided(entityToCollide:HitArea):Boolean {
			return collide(entityToCollide, 1).length > 0;
		}

		private var _timeToCollide:uint = 0;

		private function onEnterFrame(event:Event = null):void {
			var dt:int = getTimer() - _timeToCollide;
//			if (dt > 30) {
				for each(var entity:Entity in entities) {
					entity.updateDT(dt);
				}
				_timeToCollide = getTimer();
//			}
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
			trace("collideTime: ", _collideTime,_collideCount);
			_collideTime = 0;
			_collideCount=0;


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
