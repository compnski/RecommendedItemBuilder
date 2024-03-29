package com.dreamofninjas.core.util {
	import flash.net.dns.ARecord;

	public dynamic class Set extends Object {
		//protected var _collection:Object = new Object();
		protected var _count:int = 0;

		public function Set(obj:Object = null) {
			if (obj == null) {
				return;
			}
			if (obj is Array) { 
				for (var item:Object in obj) {
					add(item);
				}
			}
	}

		public function update(set:Set):void {
			for each(var obj:Object in set) {
				add(obj);
			}
		}

		public function add(obj:Object):void {
			if (has(obj)) {
				return;
			}
			this[obj] = obj;
			_count++;
		}

		public function remove(obj:Object):Boolean{
			if (!has(obj)) {
				return false;
			}
			this[obj] = null;
			delete this[obj];
			_count--;
			return true;
		}

		public function has(obj:Object):Boolean {
			return (obj in this);
		}

		public function hasOwnProperty(key:String):Boolean {
			return has(key);
		}

		/**
		 * @return A string of the elements of the set, separated by sep
		 */
		public function join(sep:String):String {
			var buf:Array = [];
			for each(var obj:Object in this) {
				buf.push(obj.toString());
			}
			return buf.join(sep);
		}
	}
}