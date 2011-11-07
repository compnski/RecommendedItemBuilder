package com.dreamofninjas.rib
{
	import com.dreamofninjas.core.ui.AnimatedClip;
	import com.dreamofninjas.core.util.ASLog;
	import com.dreamofninjas.core.util.MultiLoader;
	import com.dreamofninjas.rib.events.ItemSlotSpriteEvent;
	import com.dreamofninjas.rib.events.LoadedEvent;
	import com.dreamofninjas.rib.models.ItemMetadata;
	import com.dreamofninjas.rib.models.ItemSet;
	import com.dreamofninjas.rib.models.SqliteItemSetStore;
	import com.dreamofninjas.rib.views.ItemSelectorView;
	import com.dreamofninjas.rib.views.ItemSetView;
	
	import fl.controls.LabelButton;
	import fl.controls.TextInput;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.utils.getDefinitionByName;
		
	public class RibStage extends Sprite
	{
		protected var itemSlot:AnimatedClip;
		protected var itemStore:SqliteItemSetStore = new SqliteItemSetStore();
		protected var itemMetadataLoader:ItemMetadataLoader = new ItemMetadataLoader();
		protected var initialAssetLoader:MultiLoader = new MultiLoader();
		protected var lolDataPathLoader:LolDataPathLoader = new LolDataPathLoader();
		
		protected var isv:ItemSetView
		private var items:ItemSet ;
		private var champName:TextInput = new TextInput();
		private var itemFilter:TextInput = new TextInput();
		private static var _instance:RibStage = null;
		private var iselview:ItemSelectorView;
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
			initialAssetLoader.addEventListener(Event.COMPLETE, allLoaded);
			initialAssetLoader.addEventListener(ErrorEvent.ERROR, loadFailed);
			initialAssetLoader.add(itemMetadataLoader);
			initialAssetLoader.add(itemStore);
			initialAssetLoader.add(lolDataPathLoader);
			
			initialAssetLoader.load();
		}
		
		protected function loadFailed(evt:ErrorEvent):void {
			trace(evt.text);
		}
		
		protected function allLoaded(evt:Event):void {
			trace("loaded!");			
			
			items= new ItemSet("TriforceAtmogs", [2003, 3096, 3078, 3083, 3005, 0]);
			isv = new ItemSetView();
			isv.y = 10;
			addChild(isv);			
			isv.itemSet = items;
			//isv.width = isv.width/2;
			//isv.height= isv.height/2;
			iselview = new ItemSelectorView(itemMetadataLoader.itemList)
				.withHeight(480)
				.withWidth(640)
				.draw() as ItemSelectorView;
			iselview.x = 20;
			iselview.y = 120;
			addChild(iselview);
			ASLog.warning(this.width);
			addEventListener(ItemSlotSpriteEvent.SELECTED, setItems);
			var button:Sprite = createButton("<p align='center'><font size='28' face='Helvetica, Arial'>Save</font></p>", 0xEEaa22, 100, 35);
			
			button.x = isv.width + 10;
			button.y = 40;
			champName.text= "Irelia";
			champName.y = 10;
			champName.x = button.x;
			addChild(champName);

			addChild(button);
			button.addEventListener(MouseEvent.CLICK, function(ev:MouseEvent):void {
				var fw:FileWriter = new FileWriter(lolDataPathLoader.lolDataDir);
				items.clearChampions();
				items.championList.add(champName.text);
				fw.saveItemSet(items);
			});

			itemFilter = new TextInput();
			itemFilter.x = 40;
			itemFilter.y = 90;
			itemFilter.width = 150;

			var itemFilterLbl:TextField = new TextField();
			itemFilterLbl.htmlText = "Filter:";
			itemFilterLbl.x = itemFilter.x - 35;
			itemFilterLbl.y = itemFilter.y;

			addChild(itemFilterLbl);
			addChild(itemFilter);

			itemFilter.addEventListener(Event.CHANGE, itemFilterChangeHandler);	
		}
		
		protected function itemFilterChangeHandler(ev:Event):void {
			if (itemFilter.text != "") {
				iselview.addFilter(function(item:ItemMetadata):Boolean {
					return item.name.toLowerCase().indexOf(itemFilter.text.toLowerCase()) >= 0;
				}, "name");
			}
			else {
				iselview.removeFilter("name");
			}
		}
		
		

		protected function createButton(text:String, color:uint, width:uint, height:uint):Sprite {
			var button:Sprite= new Sprite();
			button.graphics.beginFill(color);
			button.graphics.drawRoundRect(0, 0, width, height, 10, 10);
			button.graphics.endFill();
			var label:TextField = new TextField();
			label.htmlText = text;
			label.width = width;

			button.addChild(label);		

			return button;
		}
		
		
		protected function setItems(ev:ItemSlotSpriteEvent):void {
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