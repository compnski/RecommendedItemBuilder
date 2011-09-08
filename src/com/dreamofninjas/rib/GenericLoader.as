package com.dreamofninjas.rib
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class GenericLoader extends EventDispatcher
	{
		protected var _loaderId:String;
		private static var _nextLoaderId:int = 0;
		
		public function GenericLoader(loaderId:String=null, target:IEventDispatcher=null)
		{
			super(target);
			if (loaderId == null) {
				loaderId = generateLoaderId();
			}
			_loaderId = loaderId;
		}
		
		public function get loaderId():String
		{
			return _loaderId;
		}

		public function set loaderId(value:String):void
		{
			_loaderId = value;
		}

		public function init():void {
			
		}
		
		protected function loadComplete():void {
			dispatchEvent(new LoadedEvent(LoadedEvent.COMPLETE, _loaderId));
		}
		
		public static function generateLoaderId(base:String="loader"):String {
			return base + String(_nextLoaderId++);
		}
	}
}