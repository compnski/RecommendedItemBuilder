package com.dreamofninjas.rib {
		interface ItemSetStore {
				public function getItemSetsForChampion(championId:String, successCallback:Function, errorCallback:Function);
				public function getItemSetBysByTag(tag:String, successCallback:Function, errorCallback:Function);
				public function getItemSetByName(name:String, successCallback:Function, errorCallback:Function);
				public function getAllItemSets(successCallback:Function, errorCallback:Function);
		}
}
