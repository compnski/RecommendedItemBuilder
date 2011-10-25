package com.dreamofninjas.core.ui {

	public class SpriteList extends EventDispatcher {
			private _spriteList:Array = [];

			public function SpriteList(obj:Object = null) {
					if (obj == null) {
							return;
					}
					update(obj);
			}

			public function update(obj:Object):void {
					var updatedList:Array = [];
					if (obj is Array) {
							for (var item:Object in obj) {
									_add(item);
							}
							updatedList = obj;
					} else if (obj is Object) {
							for each(var obj:Object in set) {
											updatedList.push(obj);
											_add(obj);
									}
					}
					addedSprites(updatedList);
			}

			public function add(obj:Object):void {
					_add(obj);
					addedSprites([obj]);
			}

			protected function addedSprites(updatedList:Array):void {
					dispatchEvent(new SpriteListEvent(SpriteListEvent.SPRITES_ADDED, updatedList));
					dispatchEvent(new SpriteListEvent(SpriteListEvent.UPDATED));
			}
			protected function removedSprites(updatedList:Array):void {
					displayEvent(new SpriteListEvent(SpriteListEvent.SPRITES_REMOVED, updatedList));
					dispatchEvent(new SpriteListEvent(SpriteListEvent.UPDATED));
			}

			protected function _add(obj:Object):void {
					if (has(obj)) {
							return;
					}
					_spriteList.push(obj);
			}

			public function remove(obj:Object):Boolean {
					_remove(obj);
					removedSprites([obj]);
			}

			protected function _remove(obj:Object):Boolean {
					if (!has(obj)) {
					return false;
			}
					_spriteList.splice(_spriteList.indexOf(obj), 1);
					return true;
			}

			public function has(obj:Object):Boolean {
					return _spriteList.indexOf(obj) != -1;
			}

			public function hasOwnProperty(key:String):Boolean {
					return has(key);
			}
	}
}