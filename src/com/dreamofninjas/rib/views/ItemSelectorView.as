package com.dreamofninjas.rib.views
{
	import com.dreamofninjas.rib.ItemSprite;
	import com.dreamofninjas.rib.events.ItemSelectorEvent;
	import com.dreamofninjas.rib.models.ItemMetadata;
	import com.dreamofninjas.rib.views.sprites.ItemSlotSprite;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class ItemSelectorView extends Sprite
	{
		protected var _itemList:Object;
		private static const X_PADDING:int = 5;
		private static const X_OFFSET:int = 10;
		private static const Y_PADDING:int = 5;
		private static const Y_OFFSET:int = 10;
		private var _itemW:int;
		private var _itemH:int;
		private var _width:int;
		private var _height:int;
		private var _itemSprites:Array = [];
		
		public function ItemSelectorView(itemList:Object, width:int, height:int) {
			super();
			_itemList = itemList;
			this._width = width;
			this._height = height;
			var itemSlotSprite:Sprite = new ItemSlotSprite();
			_itemW = itemSlotSprite.width;
			_itemH = itemSlotSprite.height;
			trace("ITEM SIZES");
			trace(_itemW);
			trace(_itemH);
			
			setupView();
		}
		
		private function setupView():void {
			trace("THIS WIDTH = " + this._width);
			var itemsPerRow:int = (this._width - X_OFFSET) / (_itemW + X_PADDING);
			trace("ITEMS PER ROW = " + itemsPerRow);
			var itemIdx:int = 0;
			
			for each(var item:ItemMetadata in _itemList) {
				const itemId:int = item.itemId;
				var sprite:ItemSlotSprite = new ItemSlotSprite(item.itemId);
				sprite.width = _itemW;
				sprite.height = _itemH;
				sprite.x = (itemIdx % itemsPerRow) * (_itemW + X_PADDING) + X_OFFSET;
				sprite.y = int(itemIdx / itemsPerRow) * (_itemH + Y_PADDING) + Y_OFFSET;
				addChild(sprite);
				itemIdx++;
			}
		}
	}
}