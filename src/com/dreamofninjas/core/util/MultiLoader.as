package com.dreamofninjas.core.util
{
    import flash.events.ErrorEvent;
    import flash.events.Event;
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

	public override function load(timeout:uint=0):void {
		super.load(timeout);
	    if (_loadCalled) {
		throw new Error("Can't call load() twice.");
	    }
	    _loadCalled = true;
	    for each(var loader:ILoadable in _loaderMap) {
		    trace(loader);
		    loader.load();
		}
	}

	public function add(loader:ILoadable):void {
	    if (_loadCalled) {
		throw new Error("Can't call add() after load()");
	    }
	    if (loader in _loaderMap) {
		if (_loaderMap[loader] == loader) {
		    trace("Trying to add the same item twice... " + loader);
		    return;
		}
		// TODO(jason): Throw error and/or log
		return;
	    }
	    _outstandingWaitCount++;
	    loader.addEventListener(Event.COMPLETE, childLoaded);
		loader.addEventListener(ErrorEvent.ERROR, childFailed);
	    _loaderMap[loader] = loader;
	}

	protected function childFailed(evt:Event):void {
		dispatchEvent(evt);
	}
	
	protected function childLoaded(evt:Event):void {
	    var loader:ILoadable = evt.target as ILoadable;
	    trace("Loaded " + evt.target);
	    //var loader:ILoadable = _loaderMap[loader];
	    if (!(loader in _loaderMap)) {
		//raise error?
		trace("ERROR: loader not found in loaderMap");
	    }
	    loader.removeEventListener(Event.COMPLETE, childLoaded);
	    _loaderMap[loader] = null;
	    delete _loaderMap[loader];
	    if (!--_outstandingWaitCount) {
		loadComplete();
	    }
	}
    }
}