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
		
		public function FileWriter(lolDataPath:File)
		{
			_lolDataPath = lolDataPath;

		}

		public function saveItemSet(itemSet:ItemSet):void {
			for each(var champ:String in itemSet.championList) {
				saveItemSetForChampion(champ, itemSet);
			}
		}
		
		public function saveItemSetForChampion(champion:String, itemSet:ItemSet):Boolean {
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
		
		protected function _getConfigFromItemSet(itemSet:ItemSet):String {
			var stringBuf:Array = ["[ItemSet1]\r\n", "SetName=", itemSet.name,"\r\n"];
			for (var i:int=1; i <= 6; i++) {
				stringBuf.push("RecItem", i.toString());
				stringBuf.push("=",itemSet.getItem(i-1),"\r\n");
			}
			return stringBuf.join("");
		}

	}
}
