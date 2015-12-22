package app.game.hitArea {
	import app.game.entities.actions.Entity;

	public class PhysicalHitArea extends HitArea {

		private var _speedX:Number = 0;
		private var _speedY:Number = 0;
		private var _weight:Number = 1;
		private var _speedYToCollect:Number;
		private var _speedXToCollect:Number;

		public function PhysicalHitArea(entity:Entity) {
			super(entity);
		}

		public function update(dt:uint):void {
			moveXPosition(_speedX * dt / 1000);
			moveYPosition(_speedY * dt / 1000);
		}

		public function get speedX():Number {
			return _speedX;
		}

		public function set speedX(value:Number):void {
			_speedX = value;
			if(Math.abs(value)>1) {
				_speedX = value;
				_speedXToCollect = 0;
			} else if(Math.abs(_speedXToCollect)>1){
				_speedX = _speedXToCollect;
			} else {
				_speedXToCollect +=value
			}
		}

		public function get speedY():Number {
			return _speedY;
		}

		public function set speedY(value:Number):void {
			if(Math.abs(value)>1) {
				_speedY = value;
				_speedYToCollect = 0;
			} else if(Math.abs(_speedYToCollect)>1){
				_speedY = _speedYToCollect;
			} else {
				_speedYToCollect +=value
			}
		}

		public function get weight():Number {
			return _weight;
		}

		public function set weight(value:Number):void {
			_weight = value;
		}
	}
}
