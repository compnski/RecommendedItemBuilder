package com.dreamofninjas.rib.views {
	import com.dreamofninjas.rib.models.ItemSet;
	import com.dreamofninjas.rib.views.sprites.ItemSlotSprite;
	import flash.display.Sprite;
	import flash.events.Event;

		public class ItemSlotView extends Sprite {

	   protected var _itemSet:ItemSet;
				protected var _itemSlotSprites:Array = new Array(6);
				private static const X_PADDING:int = 10;
				private static const X_OFFSET:int = 10;

				public function ItemSlotView() {
						//Add onclick for all slots
						//Add drag for all slots
						for (var i:int = 0; i < 6; i++) {
								var sprite:ItemSlotSprite = new ItemSlotSprite(0);
								sprite.x = ((sprite.width + X_PADDING) * i) + X_OFFSET;
								addChild(sprite);
								_itemSlotSprites[i] = sprite;
						}
				}

				public function set itemSet(newSet:ItemSet):void {
						//#remove ev listeners
						_itemSet = newSet;
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