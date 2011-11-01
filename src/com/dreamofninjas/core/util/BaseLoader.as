package com.dreamofninjas.core.util
{

	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	public class BaseLoader implements ILoadable extends EventDispatcher
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