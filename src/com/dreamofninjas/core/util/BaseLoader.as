package com.dreamofninjas.core.util
{
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class BaseLoader extends EventDispatcher implements ILoadable
	{
		private var _timer:Timer;
		
		public function BaseLoader(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function load(timeout:uint=0):void
		{
			if (timeout > 0) {
				_timer = new Timer(timeout, 1); 
				_timer.addEventListener(TimerEvent.TIMER_COMPLETE, timeoutHandler);
				_timer.start();
			}
		}
		
		protected function timeoutHandler(ev:TimerEvent):void {
			
		}
		
		protected function loadComplete():void {
			dispatchEvent(new Event(Event.COMPLETE));
		}
	}
}