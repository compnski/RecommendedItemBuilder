package com.dreamofninjas.rib.events
{
	import flash.events.Event;
	
	public class ItemSlotViewEvent extends Event {
		
		// Fired when a slot is selected
		public static const SELECTED:String = "selected";
		
		// Fired when someone starts dragging
		public static const DRAG_START:String = "drag_start";
		
		// Fired when someone stops dragging
		public static const DRAG_END:String = "drag_end";
		
		public var slotId:int;
		
		public function SlotSelectedEvent(type:String, slotId:int) {
			super(type);
			this.slotId = slotId;
		}
	}
}
