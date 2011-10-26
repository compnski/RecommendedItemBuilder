package com.dreamofninjas.rib.views.sprites {
	import com.dreamofninjas.core.ui.AnimatedClip;
	import com.dreamofninjas.rib.ItemSpriteFactory;
	import com.dreamofninjas.rib.RibStage;
	import com.dreamofninjas.rib.events.ItemSlotSpriteEvent;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;

		public class ItemSlotSprite extends AnimatedClip {
				protected var _itemId:int;
				protected var _currentItemSprite:ItemSprite;
				protected var _selected:Boolean;
				
				protected const FRAME_EMPTY:String = "empty";
				protected const FRAME_HASITEM:String = "hasItem";
				protected const FRAME_EMPTY_SELECTED:String = "emptySelected";
				protected const FRAME_HASITEM_SELECTED:String = "hasItemSelected";

				function ItemSlotSprite(itemId:int = 0){
						super("ItemSlot");
						this.itemId = itemId;
						addEventListener(MouseEvent.CLICK, onClickHandler);
				}
				
				public function get selected():Boolean {
					return _selected;
				}

				public function set selected(value:Boolean):void {
					_selected = value;
					refreshView();
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

				public function valueOf():Object {
					return toString();
				}

				private function onClickHandler(ev:MouseEvent):void {
					dispatchEvent(new ItemSlotSpriteEvent(ItemSlotSpriteEvent.SELECTED, this, _itemId));
				}
				
				private function refreshView():void {
					loadItemImage(_itemId);
				}
				
				private function loadItemImage(itemId:int):void {
						if (this.clip.anchor != null && _currentItemSprite != null) {
							this.clip.anchor.removeChild(_currentItemSprite);
						}
						if (itemId == 0) {
								this.show(selected ? FRAME_EMPTY_SELECTED: FRAME_EMPTY);
						} else {
								this.show(selected ? FRAME_HASITEM_SELECTED : FRAME_HASITEM);
								_currentItemSprite = ItemSpriteFactory.GetItemById(itemId);
								this.clip.anchor.addChild(_currentItemSprite);
						}
				}
		}
}