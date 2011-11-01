package com.dreamofninjas.core.util
{
		import com.dreamofninjas.rib.events.LoadedEvent;

		import flash.events.IEventDispatcher;
		import flash.events.OutputProgressEvent;

		/**
		 * A loader that can take many ILoadables, call init() on them, and wait for all to load or error
		 *
		 * The loader will not return unless all loaders returns complete or error.
		 * TODO(jason): Add timeouts
		 */
		public class MultiLoader extends BaseLoader
		{
				private var _loaderMap:Object = new Object();
				private var _outstandingWaitCount:int = 0;
				private var _loadCalled:Boolean = false;

				public function MultiLoader(loaderList:Array=null) {
						super();
						for each(var loader:ILoadable in loaderList) {
										add(loader);
								}
				}

				public override function load():void {
						if (_loadCalled) {
								throw new Exception("Can't call load() twice.");
						}
						_loadCalled = true;
						for each(var loader:ILoadable in _loaderMap) {
										trace(loader);
										loader.load();
								}
				}

				public function add(loader:ILoadable):void {
						if (_loadCalled) {
								throw new Exception("Can't call add() after load()");
						}
						if (loader in _loaderMap) {
								if (_loaderMap[loader] == loader) {
										trace("Trying to add the same item twice... " + loader);
										return;
								}
								trace("collision (" + loader + ", " + loader.toString() + " != ",
											_loaderMap[loader] + ")");
								// TODO(jason): Throw exception and/or log
								return;
						}
						_outstandingWaitCount++;
						loader.addEventListener(Event.COMPLETE, childLoaded);
						_loaderMap[loader] = loader;
				}

				public function childLoaded(evt:Event):void {
						var loader:ILoadable = evt.target as ILoadable;
						trace("Loaded " + evt.target);
						var loader:ILoadable = _loaderMap[loader];
						loader.removeEventListener(Event.COMPLETE, childLoaded);
						_loaderMap[loader] = null;
						delete _loaderMap[loader];
						if (!--_outstandingWaitCount) {
								loadComplete();
						}
				}
		}
}