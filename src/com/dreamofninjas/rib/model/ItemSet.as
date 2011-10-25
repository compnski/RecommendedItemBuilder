package com.dreamofninjas.rib.model {
		class ItemSet {

				const MAX_ITEMS_PER_SET:int = 6;

				protected var _name:String;
				protected var _items:Array = new Array(MAX_ITEMS_PER_SET);
				protected var _tags:Set = new Set();
				protected var _champions:Set = new Set();

				public function ItemSet(name:String, items:Array = null, tags:Set = null, champions:Set = null) {
						_name = name;
						if (items != null && items.length <= 6) {
								_items.splice(0, 0, items);
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

				public function setItem(itemId:String, slotId:int):void {
						if (slotId > MAX_ITEMS_PER_SET) {
								throw new Error("No item slot " + slotId);
						}
						_items[slotId] = itemId;
				}
				public function removeItem(slotId:int):void {
						if (slotId > MAX_ITEMS_PER_SET) {
								throw new Error("No item slot " + slotId);
						}
						_items[slotId] = null;
				}

				function addChampion(championId:String):void {
						_champions.add(championId);
				}
				function removeChampion(championId:String):void {
						_champions.remove(championId);
				}

				function addTag(tag:String):void {
						_tags.add(tag);
				}
				function removeTag(tag:String):void {
						_tags.remove(tag)
								}

				function set name(name:String):void {
						_name = name;
				}
		}
}