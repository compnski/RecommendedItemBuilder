package com.dreamofninjas.rib.sprites {
		class ItemSlotSprite extends Sprite {
				var _itemSlotClip:AnimatedClip = new AnimatedClip("ItemSlot");
				var _itemId:int;

				function ItemSlotSprite(){
						addChild(_itemSlotClip);
				}

				public function set itemId(itemId:int):void {
						_itemId = itemId;
				}

				public function get itemId():int {
						return _itemId;
				}

				public function toString(Void):String{

						return "ItemSlotSprite(" + itemId + ")";
				}

				private function loadItemImage(itemId:int):void {
						if (itemId == 0) {
								_itemSlotClip.content.anchor = null;
						} else {
								_itemSlotClip.content.anchor = ItemSpriteFactory.GetItemById(itemId);
						}
				}
		}
}