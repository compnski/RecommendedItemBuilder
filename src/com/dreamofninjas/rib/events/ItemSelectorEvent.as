package com.dreamofninjas.rib.events
{
	import flash.events.Event;
	
	public class ItemSelectorEvent extends Event
	{
		public static const SELECTED:String = "SELECTED";
		
		public var itemId:int;
		
		public function ItemSelectorEvent(type:String, itemId:int, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.itemId = itemId;
		}
	}
}