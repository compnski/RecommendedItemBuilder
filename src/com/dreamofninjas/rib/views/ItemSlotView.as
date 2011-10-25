package com.dreamofninjas.rib {
		public class ItemSlotView extends Sprite {

	   protected var _itemSet:ItemSet;
				protected var _itemSlotSprites:Array = new Array(6);
				private static final X_PADDING:int = 10;
				private static final X_OFFSET:int = 10;

				public function ItemSlotView() {
						//Add onclick for all slots
						//Add drag for all slots
						for (var i:int = 0; i < 6; i++) {
								_itemSlotSprites[i] = new ItemSlotSprite();
								_itemSlotSprites[i].x = ((_itemSlotSprites[i].width + X_PADDING) * i) + X_OFFSET;
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