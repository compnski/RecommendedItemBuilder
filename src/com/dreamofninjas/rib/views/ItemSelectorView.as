package com.dreamofninjas.rib.views
{
	import com.dreamofninjas.core.ui.BaseLayout;
	import com.dreamofninjas.core.ui.ScrollableGridLayout;
	import com.dreamofninjas.core.ui.SpriteList;
	import com.dreamofninjas.rib.views.sprites.ItemSprite;
	import com.dreamofninjas.rib.events.ItemSelectorEvent;
	import com.dreamofninjas.rib.models.ItemMetadata;
	import com.dreamofninjas.rib.views.sprites.ItemSlotSprite;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;


	public class ItemSelectorView extends BaseLayout
	{
			private static const X_PADDING:int = 5;
			private static const X_OFFSET:int = 10;
			private static const Y_PADDING:int = 5;
			private static const Y_OFFSET:int = 10;
			private static const GRID_HEIGHT:int = 480;
			private static const GRID_WIDTH:int = 640;

			private var _itemList:Object;
			private var _gridLayout:ScrollableGridLayout;
			private var _spriteList:SpriteList = new SpriteList();
			private var _spriteMap:Object = {};

			public function ItemSelectorView(itemList:Object) {
					super();
					_itemList = itemList;
			}

			protected override function setupView():void {
					var itemSlotSprite:Sprite = new ItemSlotSprite();
					var itemW:int = itemSlotSprite.width;
					var itemH:int = itemSlotSprite.height;
					buildSpriteList(_itemList, _spriteMap, _spriteList);
					
					_gridLayout = new ScrollableGridLayout(_spriteList)
							.withItemHeight(itemH)
							.withItemWidth(itemW)
							.withWidth(GRID_WIDTH)
							.withHeight(GRID_HEIGHT)
							.build() as ScrollableGridLayout; 

					_gridLayout.addEventListener(ItemSelectorEvent.SELECTED, itemSelected);
					addChild(_gridLayout);
			}

			protected function itemSelected(ev:ItemSelectorEvent):void {
					_spriteList.remove(_spriteMap[ev.itemId]);
			}

			private function buildSpriteList(itemList:Object, spriteMap:Object, spriteList:SpriteList):void {
					for each(var item:ItemMetadata in itemList) {
									const itemId:int = item.itemId;
									var sprite:ItemSlotSprite = new ItemSlotSprite(item.itemId);
									spriteList.push(sprite);
									spriteMap[item.itemId] = sprite;
							}
			}
	}
}