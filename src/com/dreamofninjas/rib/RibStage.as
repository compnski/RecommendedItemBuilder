package com.dreamofninjas.rib
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.getDefinitionByName;
	
	public class RibStage extends Sprite
	{
		protected var itemSlot:AnimatedClip;
		protected var itemMetadataLoader:ItemMetadataLoader = new ItemMetadataLoader();
		protected var initialAssetLoader:MultiLoader = new MultiLoader();
		
		public function RibStage()
		{
			super();
			trace("RibStage");
			itemSlot = new AnimatedClip("ItemSlot");
			addChild(itemSlot);
			itemSlot.x = 200;
			itemSlot.y = 200;
			//itemSlot.clip.slot0.addEventListener(MouseEvent.CLICK, mouseClickHandler);	
			initialAssetLoader.addEventListener(LoadedEvent.COMPLETE, allLoaded);
			initialAssetLoader.add(itemMetadataLoader);
			initialAssetLoader.init();
		}
		
		protected function allLoaded(evt:Event):void {
			trace(itemMetadataLoader);
		}
		
		protected function mouseClickHandler(event:MouseEvent):void {
		//	itemSlot.clip.slot0.anchor.addChild(ItemSpriteFactory.getItemById(3005));
		}
	
	}
}