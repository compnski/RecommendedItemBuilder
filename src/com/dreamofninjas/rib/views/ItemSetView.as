package com.dreamofninjas.rib.views {
	import com.dreamofninjas.rib.events.ItemSlotSpriteEvent;
	import com.dreamofninjas.rib.models.ItemSet;
	import com.dreamofninjas.rib.views.sprites.ItemSlotSprite;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class ItemSetView extends Sprite {
		
		protected var _itemSet:ItemSet;
		protected var _itemSlotSprites:Array = new Array(6);
		private static const X_PADDING:int = 10;
		private static const X_OFFSET:int = 10;
		private var _selectedSlotId:int = 0;
		
		public function get selectedSlotId():int {
			return _selectedSlotId;
		}
		
		public function ItemSetView() {
			//Add onclick for all slots
			//Add drag for all slots
			for (var i:int = 0; i < 6; i++) {
				var sprite:ItemSlotSprite = new ItemSlotSprite(0);
				sprite.x = ((sprite.width + X_PADDING) * i) + X_OFFSET;
				addChild(sprite);
				_itemSlotSprites[i] = sprite;
			}
			selectedIdx = 0;
			addEventListener(ItemSlotSpriteEvent.SELECTED, itemSelected);
		}
		
		private function itemSelected(ev:ItemSlotSpriteEvent):void {
			ev.stopPropagation();
			var slotId:int = _itemSlotSprites.indexOf(ev.target);
			selectedIdx = slotId;
		}
		
		private function set selectedIdx(idx:int):void {
			_itemSlotSprites[_selectedSlotId].selected = false;
			_itemSlotSprites[idx].selected = true;
			_selectedSlotId = idx;
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