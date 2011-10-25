package com.dreamofninjas.rib.models {
		public interface ItemSetStore {
			function getItemSetsForChampion(championId:String, successCallback:Function, errorCallback:Function):void;
			function getItemSetBysByTag(tag:String, successCallback:Function, errorCallback:Function):void;
			function getItemSetByName(name:String, successCallback:Function, errorCallback:Function):void;
			function getAllItemSets(successCallback:Function, errorCallback:Function):void;
			//for now, fire and forget
			function saveItemSet(itemSet:ItemSet):void;
		}
}
