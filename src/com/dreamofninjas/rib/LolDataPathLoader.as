package com.dreamofninjas.rib
{
	import com.dreamofninjas.core.util.BaseLoader;
	
	import flash.events.IEventDispatcher;
	import flash.errors.IOError;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;

	public class LolDataPathLoader extends BaseLoader
	{
		private static const CLASSIC_FILENAME:String = "RecItemsCLASSIC.ini";
		private static const DOMINION_FILENAME:String = "RecItemsODIN.ini";
		private static const RELATIVE_RELEASE_PATH:String = "RADS/solutions/lol_game_client_sln/releases/";
		private static const CHARACTER_DIR:String = "deploy/DATA/Characters/";

		private var _lolDataPath:File = null;
		
		public function LolDataPathLoader(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function get lolDataDir():File
		{
			return _lolDataPath;
		}

		public override function load(timeout:uint=0):void {
			super.load(timeout);
			getLolDataDir();
		}
		
		
		private function isValidLolDataPath(path:File):Boolean {
			if (!path.nativePath.search(CHARACTER_DIR))
				return false;
			return path.exists && path.isDirectory;
		}
		
		private function buildDataPath(basePath:File):File{
			var file:File = basePath.resolvePath(RELATIVE_RELEASE_PATH);
			var releases:Array = file.getDirectoryListing();
			releases.sortOn('nativePath', Array.NUMERIC | Array.DESCENDING);
			file = releases[0].resolvePath(CHARACTER_DIR);
			if (!file.exists) {
				try {
					file.createDirectory();
				}catch(e:*) {
					dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR,false, false, "Failed to create directory"));
					return null; 
				}
			}
			return file
		}
		
		public function getLolDataDir():void {
			var file:File = new File();//File.applicationDirectory;
			file.nativePath = "C:/Program Files (x86)/Riot Games/League of Legends";
			
			file.addEventListener(Event.SELECT, dirSelected);
			file.browseForDirectory("Please browse to your LOL install folder.");
			function dirSelected(e:Event):void { 
				var path:File = buildDataPath(file);
				if (isValidLolDataPath(path)) {
					_lolDataPath = path;
					loadComplete();
				}
				else
					loadFailed("Could not find LOL data directory.");
			}
			
		}
	}
}