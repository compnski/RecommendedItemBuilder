package com.dreamofninjas.rib {
		public class ItemSlotView extends Sprite {

	   protected var _itemSet:ItemSet;
				protected var _itemSlotSprites:Array = new Array(6);

				public function ItemSlotView() {
						addChild(##LOAD_UI_ELEMENT##);
						//Add onclick for all slots
						//Add drag for all slots
						for (var i:int = 0; i < 6; i++) {
								_itemSlotSprites[i] = new ItemSlotSprite();
						}
				}

				public function set itemSet(newSet:ItemSet):void {
						//#remove ev listeners
						_itemSet = itemSet;
						_itemSet.addEventListener("UPDATED", itemSetUpdated);
						itemSetUpdated(null);
				}

				protected function itemSetUpdated(evt:Event):void {
						for (var i:int = 0; i < 6; i++) {
								_itemSlotSprites[i].itemId = _itemSet.getItem(i);
						}
				}
		}
}