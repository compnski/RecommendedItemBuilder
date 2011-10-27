package com.dreamofninjas.rib
{
	import com.dreamofninjas.core.ui.AnimatedClip;
	import com.dreamofninjas.core.util.MultiLoader;
	import com.dreamofninjas.rib.events.ItemSlotSpriteEvent;
	import com.dreamofninjas.rib.events.LoadedEvent;
	import com.dreamofninjas.rib.models.ItemSet;
	import com.dreamofninjas.rib.models.SqliteItemSetStore;
	import com.dreamofninjas.rib.views.ItemSelectorView;
	import com.dreamofninjas.rib.views.ItemSetView;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.getDefinitionByName;
	
	public class RibStage extends Sprite
	{
		protected var itemSlot:AnimatedClip;
		protected var itemStore:SqliteItemSetStore = new SqliteItemSetStore();
		protected var itemMetadataLoader:ItemMetadataLoader = new ItemMetadataLoader();
		protected var initialAssetLoader:MultiLoader = new MultiLoader();
		protected var isv:ItemSetView
		private var items:ItemSet ;
		private static var _instance:RibStage = null;
		
		public static function Get():RibStage {
			if (_instance == null) {
				_instance = new RibStage(new ENFORCER());
			}
			return _instance;
		}
		
		public function RibStage(singletonEnforcer:ENFORCER)
		{
			super();
			//this.width = 1024;
			//this.height = 768;
			trace("RibStage");
			initialAssetLoader.addEventListener(LoadedEvent.COMPLETE, allLoaded);
			initialAssetLoader.add(itemMetadataLoader);
			initialAssetLoader.add(itemStore);
			
			initialAssetLoader.init();
		}
		
		protected function allLoaded(evt:Event):void {
			trace("loaded!");
			trace(itemMetadataLoader);
			
			items= new ItemSet("TriforceAtmogs", [2003, 3096, 3078, 3083, 3005, 0]);
			isv = new ItemSetView();
			isv.y = 10;
			addChild(isv);			
			isv.itemSet = items;
			//isv.width = isv.width/2;
			//isv.height= isv.height/2;
			
			var iselview:ItemSelectorView = new ItemSelectorView(itemMetadataLoader.itemList)
				.withHeight(480)
				.withWidth(640)
				.draw() as ItemSelectorView; 
			iselview.y = 90;
			addChild(iselview);
			trace(this.width);
			addEventListener(ItemSlotSpriteEvent.SELECTED, setItems);
			var button:Sprite = new Sprite();
			button.graphics.beginFill(0xEEaa22);
			button.graphics.drawRoundRect(0, 0, 100, 35, 10, 10);
			button.x = isv.width + 10;
			button.y = 20;
			addChild(button);
			button.addEventListener(MouseEvent.CLICK, function(ev:MouseEvent) {
				var fw:FileWriter = new FileWriter();
				items.championList.add("Irelia");
				fw.saveItemSet(items);
			});
		}
		
		protected function setItems(ev:ItemSlotSpriteEvent):void {
				trace("im a thing");
				items.setItem(isv.selectedSlotId, ev.itemId)
			}

			//itemStore.saveItemSet(items);
			/*
			itemStore.getItemSetByName("TriforceAtmogs", function(items:Array):void {
				trace(items[0]);
			}, function(obj:Object):void {
				trace(obj);
			});
			*/

		
			
		protected function mouseClickHandler(event:MouseEvent):void {
		//	itemSlot.clip.slot0.anchor.addChild(ItemSpriteFactory.getItemById(3005));
		}
	
	}
}
internal class ENFORCER {};