package com.dreamofninjas.rib {
import com.dreamofninjas.core.util.GenericLoader;
import com.dreamofninjas.rib.models.ItemMetadata;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.net.URLLoader;
import flash.net.URLRequest;
import com.dreamofninjas.core.util.GenericLoader;

public class ItemMetadataLoader extends GenericLoader {

	protected var _xmlString:URLRequest;
	protected var _xmlLoader:URLLoader;
	protected var _xml:XML;
	protected var _itemList:Object;
	
	function ItemMetadataLoader() {
		super();
	}
	
	public function get itemList():Object
	{
		return _itemList;
	}

	public override function init():void {
		_xmlString = new URLRequest("assets/items.xml");
		_xmlLoader = new URLLoader(_xmlString);
		_xmlLoader.addEventListener(Event.COMPLETE, xmlLoaded);
	}

	protected function xmlLoaded(evt:Event):void {
		_xml = new XML(evt.currentTarget.data);
		_itemList = parseItemXML(_xml);
		loadComplete();
	}

	protected function parseItemXML(xml:XML):Object {
		var itemList:Object = new Object();

		for each(var item:XML in xml.descendants("item")) {
			itemList[item.id.toString()] = new ItemMetadata(item.name.toString(),
															int(item.id.toString()),
															item.description.toString(),
															int(item.cost.toString()),
															_toStrList(item..components),
															_toStrList(item..componentOf)
															);
		}
		return itemList;
	}

	protected function _toStrList(nodeList:XMLList):Array {
		var ret:Array = new Array();
		var node:XML;
		for each(node in nodeList) {
			ret.push(node.toString());
		}
		return ret;
	}
	
	public override function toString():String {
		var ret:String = "";
		for each(var item:ItemMetadata in _itemList) {
			ret += item.name + ", ";
		}
		return ret;
	}
}
}