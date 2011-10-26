package com.dreamofninjas.rib.events
{
	import com.dreamofninjas.rib.views.sprites.ItemSlotSprite;
	
	import flash.events.Event;
	
	public class ItemSlotSpriteEvent extends Event
	{
		public static const SELECTED:String = "SELECTED";
		
		public var itemId:int;
		public var source:ItemSlotSprite;
		
		public function ItemSlotSpriteEvent(type:String, source:ItemSlotSprite, itemId:int, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.itemId = itemId;
			this.source = source;
		}
	}
}