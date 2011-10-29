package com.dreamofninjas.rib.models {
	import com.dreamofninjas.core.util.Set;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;

		public class ItemSet extends EventDispatcher {

				public static const GAME_MODE_CLASSIC:String = "Classic";
			
				protected const MAX_ITEMS_PER_SET:int = 6;

				protected var _name:String;
				protected var _items:Array = [];
				protected var _tags:Set = new Set();
				protected var _champions:Set = new Set();
				public var gameMode:String = "Classic";

				public function ItemSet(name:String, items:Array = null, tags:Set = null, champions:Set = null) {
						_name = name;
						if (items != null && items.length <= 6) {
							_items = _items.concat(items);
						}
						if (tags != null) {
								_tags.update(tags);
						}
						if (champions != null) {
								_champions.update(champions);
						}
				}

				public function getItem(slotId:int):String {
						return _items[slotId];
				}

				public function setItem(slotId:int, itemId:int):void {
						if (slotId > MAX_ITEMS_PER_SET) {
								throw new Error("No item slot " + slotId);
						}
						_items[slotId] = itemId;
						_setUpdated(slotId);
				}
				
				public function clearChampions():void {
					_champions = new Set();
				}
				
				public function removeItem(slotId:int):void {
						if (slotId > MAX_ITEMS_PER_SET) {
								throw new Error("No item slot " + slotId);
						}
						_items[slotId] = null;
				}
				
				protected function _setUpdated(slotId:int):void {
					dispatchEvent(new Event("UPDATED"));
				}
				
				
				public function get championList():Set {
					return _champions;
				}

				public function get tagList():Set {
					return _tags;
				}

				public function addChampion(championId:String):void {
						_champions.add(championId);
				}
				public function removeChampion(championId:String):void {
						_champions.remove(championId);
				}

				public function addTag(tag:String):void {
						_tags.add(tag);
				}
				public function removeTag(tag:String):void {
						_tags.remove(tag)
								}
				public function get name():String {
					return _name;
				}
				public function set name(name:String):void {
						_name = name;
				}
		}
}