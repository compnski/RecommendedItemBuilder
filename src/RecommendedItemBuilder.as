package
{
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.getDefinitionByName;
	import com.dreamofninjas.rib.RibStage;

	[SWF(width="800", height="600")]
	
	public class RecommendedItemBuilder extends Sprite
	{
		public function RecommendedItemBuilder() {
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		protected var _swfLoader:Loader;
		protected var _swfLoaderInfo:LoaderInfo;
		protected var _swfLoaderCompleteCallback:Function;
		protected var _swfLoaderProgressCallback:Function;

		private function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

			_swfLoader = new Loader();
			addChild(_swfLoader);

			loadSwf("assets/assets.swf", initApp);
		}

		private function initApp():void
		{
			var ribStage:RibStage = RibStage.Get();
			addChild(ribStage);
		}

		private function loadSwf(swfPath:String, loadingCompleteCallback:Function, loadingProgressCallback:Function=null):void
		{
			_swfLoaderCompleteCallback = loadingCompleteCallback;
			_swfLoaderProgressCallback = loadingProgressCallback;

			_swfLoaderInfo = _swfLoader.contentLoaderInfo;

			_swfLoaderInfo.addEventListener(Event.COMPLETE, loadSwfCompleteHandler);
			if (_swfLoaderProgressCallback != null)
				_swfLoaderInfo.addEventListener(ProgressEvent.PROGRESS, _swfLoaderProgressCallback);

			var request:URLRequest = new URLRequest(swfPath);
			var loaderContext:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
			loaderContext.checkPolicyFile = true;
			_swfLoader.load(request, loaderContext);
		}

		private function loadSwfCompleteHandler(event:Event):void
		{
			_swfLoaderInfo.removeEventListener(Event.COMPLETE, loadSwfCompleteHandler);
			if (_swfLoaderProgressCallback != null)
				_swfLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, _swfLoaderProgressCallback);

			addChild(_swfLoader);

			_swfLoaderCompleteCallback();
		}
	}
}