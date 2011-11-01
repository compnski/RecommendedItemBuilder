package com.dreamofninjas.core.util
{

	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.Event;

	public class BaseLoader  extends EventDispatcher implements ILoadable
	{

		 public function BaseLoader(target:IEventDispatcher=null)
		 {
			 super(target);
		 }

		 public function load():void
		 {
				loadComplete();
		}

		protected function loadComplete():void {
			dispatchEvent(new Event(Event.COMPLETE));
		}
	}
}