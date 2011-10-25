package com.dreamofninjas.rib.models
{
	public class ItemMetadata {
		public var name:String;
		public var itemId:int;
		public var description:String;
		public var cost:int;
		public var components:Array;
		public var componentOf:Array;
		
		function ItemMetadata(name:String, id:int, description:String, cost:int, components:Array, componentOf:Array) {
			this.name = name;
			this.itemId = id;
			this.description = description;
			this.cost = cost;
			this.components = components;
			this.componentOf = componentOf;
		}
		
		public function toString():String {
			return "ItemMetadata(" + name + ", " + itemId + ")";
		}
	}
}