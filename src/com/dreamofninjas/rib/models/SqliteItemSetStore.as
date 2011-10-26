package com.dreamofninjas.rib.models {
	import com.dreamofninjas.core.util.Set;
	
	import flash.data.SQLStatement;
	import flash.events.SQLEvent;

		public class SqliteItemSetStore extends SqliteStore implements ItemSetStore {
						
				public function getItemSetsForChampion(championId:String, 
					successCallback:Function, errorCallback:Function):void {
						//_getItemSets("champions LIKE %'" + championId + "'%", successCallback, errorCallback);
				}

				public function getItemSetBysByTag(tag:String, successCallback:Function, errorCallback:Function):void {
						//_getItemSets("tags LIKE %'" + tag + "'%", successCallback, errorCallback);
				}

				public function getItemSetByName(name:String, successCallback:Function, 
											 	 errorCallback:Function):void{
						_getItemSets("name = '" + name + "'", successCallback, errorCallback);
				}

				public function getAllItemSets(successCallback:Function, errorCallback:Function):void{
					
				
				}
				protected override function db_opened(e:SQLEvent):void {
						trace("created item table!");
						execute("CREATE TABLE IF NOT EXISTS Dual ( id INTEGER PRIMARY KEY ); "
							+ "REPLACE INTO Dual VALUES ( 1 ); " +
							
							 "CREATE TABLE IF NOT EXISTS ItemSet "
							+ "( id INTEGER PRIMARY KEY "
							+ "AUTOINCREMENT, name TEXT, slot0 TEXT, slot1 TEXT, slot2 TEXT, "
							+ "slot3 TEXT, slot4 TEXT, slot5 TEXT, tags TEXT, champions TEXT);");
						
						
				}

				// For now, we save all item sets. id is rev. history. need a good way to only select the highest # id
				// Maybe get names, then always select by name
				public function _getItemSets(whereClause:String, successCallback:Function, errorCallback:Function):void {
						var query:String = "SELECT '{{REQUEST_ID}}' as requestId, name, slot0, "
							+ "slot1, slot2, slot3, slot4, slot5, tags, champions FROM Dual "
							+ "LEFT JOIN ItemSet WHERE " + whereClause + " ORDER BY id DESC LIMIT 1;";
						_doQuery(query, successCallback, errorCallback);
				}

				protected function _doQuery(query:String, successCallback:Function, 
											errorCallback:Function):void {
						var requestId:int = _generateRequestId();
						query = query.replace("{{REQUEST_ID}}", requestId);
						registerCallbacks(requestId, successCallback, errorCallback);
						sqls.text = query;
						sqls.execute();
				}

				public function saveItemSet(itemSet:ItemSet):void  {
						var champions:String = itemSet.championList.join(",");
						var tags:String = itemSet.tagList.join(",");
						sqls.text = "INSERT INTO ItemSet (name, slot0, slot1, slot2, slot3, slot4, slot5, tags, champions) "
								+ "VALUES ('" + itemSet.name + "','" + itemSet.getItem(0) + "', '" + itemSet.getItem(0) + "', '"
								+ itemSet.getItem(0) + "', '" +itemSet.getItem(0) + "', '" +itemSet.getItem(0) + "', '"
								+ itemSet.getItem(0) + "', '" + tags + "', '" + champions + "');";
						sqls.execute();
				}

				protected function _removeItem(name:String):void
				{
						// sql statment to delete from our test_table the row that has the same number in number column as our selected row from datagrid
						sqls.text = "DELETE FROM ItemSet WHERE name = '" + name + "'";
						sqls.execute();
				}

				// method that gets called if we recive some results from our sql commands.
				//this method would also get called for sql statments to insert item and to create table but in this case sqls.getResault().data would be null
				protected override function result(e:SQLEvent):void  {
						// with sqls.getResault().data we get the array of objects for each row out of our database
						if (sqls.getResult() == null) {
							return;
						}
						var data:Array = sqls.getResult().data;
						if (data != null) {
								var callback:Function;
								var requestId:int = int(data[0]);
								if (data[0][1] == null) {
										callback = _callbackRegister[requestId + "_error"];
										clearCallbacks(requestId);
										callback();
										return;
								}
								callback = _callbackRegister[requestId + "_success"];
								clearCallbacks(requestId);
								callback(data);
								return;

								var setList:Array = new Array();
								for (var row:Array in data) {
										setList.push(new ItemSet(data[1], data.splice(2,8), _toSet(data[9]), _toSet(data[10])));
								}
								callback = _callbackRegister[requestId + "_success"];
								clearCallbacks(requestId);
								callback(setList);
								return;
						}
				}
				
				protected function _toSet(data:String):Set {
					return new Set(data.split(","))
				}

		}
}