package com.dreamofninjas.rib
{
	import com.dreamofninjas.rib.models.ItemSet;
	
	import flash.errors.IOError;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	public class FileWriter extends EventDispatcher
	{
		private static const CLASSIC_FILENAME:String = "RecItemsCLASSIC.ini";
		private static const DOMINION_FILENAME:String = "RecItemsODIN.ini";
		private static const RELATIVE_RELEASE_PATH:String = "RADS/solutions/lol_game_client_sln/releases/";
		private static const CHARACTER_DIR:String = "deploy/DATA/Characters/";
		
		private var _lolDataPath:File= null;
		
		public function FileWriter()
		{

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
		
		public function getLolDataDir(callback:Function):void {
			if (_lolDataPath != null && isValidLolDataPath(_lolDataPath))
				callback.apply(this, [_lolDataPath]);
			
			var file:File = new File();//File.applicationDirectory;
			file.nativePath = "C:/Program Files (x86)/Riot Games/League of Legends";
			
			file.addEventListener(Event.SELECT, dirSelected);
			file.browseForDirectory("Please browse to your LOL install folder.");
			function dirSelected(e:Event):void { 
				var path:File = buildDataPath(file);
				if (isValidLolDataPath(path)) {
					_lolDataPath = path;
					callback.apply(this, [path]);
				}
				else
					getLolDataDir(callback);
			}
			
		}
		
		public function saveItemSet(itemSet:ItemSet):void {
			if (_lolDataPath == null) {
				getLolDataDir(function(path:File):void{ _lolDataPath = path; saveItemSet(itemSet) });
				return;
			}
			
			for each(var champ:String in itemSet.championList) {
				saveItemSetForChampion(champ, itemSet);
			}
		}
		
		protected function _getConfigFromItemSet(itemSet:ItemSet):String {
			var stringBuf:Array = ["[ItemSet1]\r\n", "SetName=", itemSet.name,"\r\n"];
			for (var i:int=1; i <= 6; i++) {
				stringBuf.push("RecItem", i.toString());
				stringBuf.push("=",itemSet.getItem(i-1),"\r\n");
			}
			return stringBuf.join("");
		}
		
		protected function saveItemSetForChampion(champion:String, itemSet:ItemSet):Boolean {
			try {
				var champDir:File = _lolDataPath.resolvePath(champion);
				champDir.createDirectory();
				var fileName:File;
				if (itemSet.gameMode == ItemSet.GAME_MODE_CLASSIC){
					fileName = champDir.resolvePath(CLASSIC_FILENAME);
				} else {
					return false;
				}
				var fileStream:FileStream = new FileStream();
				fileStream.open(fileName, FileMode.WRITE);
				fileStream.writeUTFBytes(_getConfigFromItemSet(itemSet));
				fileStream.close();
			}catch(e:IOError) {
				trace(e);
				return false;
			}
			return true;
		}
	}
}
