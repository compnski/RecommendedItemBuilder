package com.dreamofninjas.core.ui {
	import flash.events.Event;
	
	public class SpriteListEvent extends Event {
		public static const UPDATED:String = "UPDATED";
		public static const SPRITES_ADDED:String = "SPRITES_ADDED";
		public static const SPRITES_REMOVED:String = "SPRITES_REMOVED";
		
		public var updatedSpriteList:Array;
		
		/**
		 * thoughts - dispatch add/removed events with a list of updated sprites, maybe a generic updated event with every change?
		 *
		 *
		 */
		public function SpriteListEvent(type:String, updatedSprites:Array=null, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			this.updatedSpriteList = updatedSprites;
		}
	}
}