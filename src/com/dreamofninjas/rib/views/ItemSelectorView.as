package com.dreamofninjas.rib.views
{
	import com.dreamofninjas.rib.ItemSprite;
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
			private var _spriteList:Spritelist;

			public function ItemSelectorView(itemList:Object) {
					super();
					_itemList = itemList;
			}

			protected function setupView():void {
					var itemSlotSprite:Sprite = new ItemSlotSprite();
					var itemW:int = itemSlotSprite.width;
					var itemH:int = itemSlotSprite.height;
					_spriteList = buildSpriteList(_itemList);

					_gridLayout = new ScrollableGridLayout(spriteList)
							.withWidth(GRID_WIDTH)
							.withHeight(GRID_HEIGHT)
							.withItemHeight(itemH)
							.withItemWidth(itemW)
							.build();

					_gridLayout.addEventListener(ItemSelectorEvent.SELECTED, itemSelected);
			}

			protected function itemSelected(ev:ItemSelectorEvent):void {
					spriteList.remove(new ItemSlot(ev.itemId));
			}

			private function buildSpriteList(itemList:Object):SpriteList {
					var spriteList:SpriteList = new SpriteList();

					for each(var item:ItemMetadata in itemList) {
									const itemId:int = item.itemId;
									var sprite:ItemSlotSprite = new ItemSlotSprite(item.itemId);
									spriteList.add(sprite);
							}
			}
	}
}