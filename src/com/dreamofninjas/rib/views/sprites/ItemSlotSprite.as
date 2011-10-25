package com.dreamofninjas.rib.views.sprites {
	import com.dreamofninjas.rib.AnimatedClip;
	import com.dreamofninjas.rib.ItemSprite;
	import com.dreamofninjas.rib.ItemSpriteFactory;
	import com.dreamofninjas.rib.RibStage;
	import com.dreamofninjas.rib.events.ItemSelectorEvent;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;

		public class ItemSlotSprite extends AnimatedClip {
				protected var _itemId:int;
				protected var _currentItemSprite:ItemSprite;
				protected const FRAME_EMPTY:String = "empty";
				protected const FRAME_HASITEM:String = "hasItem";
				function ItemSlotSprite(itemId:int = 0){
						super("ItemSlot");
						this.itemId = itemId;
						addEventListener(MouseEvent.CLICK, onClickHandler);
				}
				
				protected function onClickHandler(ev:MouseEvent):void {
					trace("CLICKIED");
					dispatchEvent(new ItemSelectorEvent(ItemSelectorEvent.SELECTED, _itemId));
				}

				public function set itemId(itemId:int):void {
						_itemId = itemId;
						loadItemImage(itemId);
				}

				public function get itemId():int {
						return _itemId;
				}

				public override function toString():String {
						return "ItemSlotSprite(" + itemId + ")";
				}

				private function loadItemImage(itemId:int):void {
						if (this.clip.anchor != null && _currentItemSprite != null) {
							this.clip.anchor.removeChild(_currentItemSprite);
						}
						if (itemId == 0) {
								this.show(FRAME_EMPTY);
						} else {
								this.show(FRAME_HASITEM);
								_currentItemSprite = ItemSpriteFactory.GetItemById(itemId);
								this.clip.anchor.addChild(_currentItemSprite);
						}
				}
		}
}