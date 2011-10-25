package com.dreamofninjas.rib.events
{
	import flash.events.Event;
	/**
	 * Generic Event objects can throw when they have completed loading and are ready for use.
	 */
	public class LoadedEvent extends Event
	{
		public static const COMPLETE:String = "complete";
		protected var _loaderId:String;
		
		public function LoadedEvent(type:String, loaderId:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_loaderId = loaderId;
		}

		public function get loaderId():String
		{
			return _loaderId;
		}
	}
}