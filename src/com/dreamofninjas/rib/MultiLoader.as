package com.dreamofninjas.rib
{
	import flash.events.IEventDispatcher;
	import flash.events.OutputProgressEvent;
	
	/**
	 * A loader that can take many GenericLoaders, call init() on them, and wait for all to load or error
	 * 
	 * The loader will not return unless all loaders returns complete or error.
	 * TODO(jason): Add timeouts
	 */
	public class MultiLoader extends GenericLoader
	{
	 	private var _loaderMap:Object = new Object();
		private var _outstandingWaitCount:int = 0;
		
		public function MultiLoader(loaderList:Array=null) {
		 	super();
			for each(var loader:GenericLoader in loaderList) {
				add(loader);
			}
		}
		
		public override function init():void {
			for each(var loader:GenericLoader in _loaderMap) {
				trace(loader.loaderId);
				loader.init();
			}
		}
		
		public function add(loader:GenericLoader):void {
			if (loader.loaderId in _loaderMap) {
				if (_loaderMap[loader.loaderId] == loader) {
					trace("Trying to add the same item twice... " + loader.loaderId);
					return;
				}
				trace("Can't loaderId collision (" + loader.loaderId + ", " + loader.toString() + " != ", 
					_loaderMap[loader.loaderId] + ")");
				// TODO(jason): Throw exception and/or log
				return;
			}
			_outstandingWaitCount++;
			loader.addEventListener(LoadedEvent.COMPLETE, childLoaded);
			_loaderMap[loader.loaderId] = loader;
		}
		
		public function childLoaded(evt:LoadedEvent):void {
			trace("Loaded " + evt.loaderId);
			var loader:GenericLoader = _loaderMap[evt.loaderId];
			loader.removeEventListener(LoadedEvent.COMPLETE, childLoaded);
			_loaderMap[loader.loaderId] = null;
			delete _loaderMap[loader.loaderId];
			if (!--_outstandingWaitCount) {
				loadComplete();
			}
		}
	}
}