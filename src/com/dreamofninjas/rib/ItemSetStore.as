class ItemSet {

	const MAX_ITEMS_PER_SET:int = 6;

	var _items:Array = new Array(MAX_ITEMS_PER_SET);
	var _tags:Array = new Array();
	var _champions:Array = new Array();
	var _name:String;

	function ItemSet(name:String) {
		_name = name;
	}

	function addItem(itemId:String, slotId:int){
	}
	function removeItem(slotId:int){
	}

	function attachChampion(championId:String):void {
	}
	function removeChampion(championId:String):void {
	}

	function addTag(tag:String):void {
	}
	function removeTag(tag:String):void {
	}

	function set name(name:String):void {
		_name = name;
	}

}


class ItemSetStore {


}