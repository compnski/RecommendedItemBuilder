package com.dreamofninjas.core.util
{
	import flash.events.IEventDispatcher;

	public interface ILoadable extends IEventDispatcher	{
			public function load():void;
	}
}