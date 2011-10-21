package com.dreamofninjas.rib
{
	public class ItemMetadata {
		public var name:String;
		public var id:String;
		public var description:String;
		public var cost:int;
		public var components:Array;
		public var componentOf:Array;
		
		function ItemMetadata(name:String, id:String, description:String, cost:int, components:Array, componentOf:Array) {
			this.name = name;
			this.id = id;
			this.description = description;
			this.cost = cost;
			this.components = components;
			this.componentOf = componentOf;
		}	
	}
}