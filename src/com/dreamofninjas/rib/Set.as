package com.dreamofninjas.rib {

	public class Set {
		protected var _collection:Object = new Object();
		protected var _count:int = 0;

		public function Set() {}

		public function update(set:Set) {
			for (obj:Object in set) {
				add(obj);
			}
		}

		public function add(obj:Object):void {
			if (has(obj)) {
				return;
			}
			_collection[obj] = obj;
			_count++;
		}

		public function remove(obj:Object):boolean{
			if (!has(obj)) {
				return false;
			}
			_collection[obj] = null;
			delete _collection[obj];
			_count--;
			return true;
		}

		public function has(obj:Object):boolean {
			return (obj in _collection);
		}

		public function hasOwnProperty(key:String):boolean {
			return has(key);
		}
	}
}