package com.dreamofninjas.rib.model {
		public class SqliteStore extends GenericLoader {
				// TODO(jason): Make SQL safe
				// sqlc is a variable we need to define the connection to our database
				private var sqlc:SQLConnection = new SQLConnection();
				// sqlc is an SQLStatment which we need to execute our sql commands
				private var sqls:SQLStatement = new SQLStatement();
				private var _callbackRegister = new Object();
				private static var _nextRequestId:int = 1;

				public function init():void {
						var db:File = File.applicationStorageDirectory.resolvePath("test.db");
						// after we set the file for our database we need to open it with our SQLConnection.
						sqlc.openAsync(db);
						// we need to set some event listeners so we know if we get an sql error, when the database is fully opened and to know when we recive a result from an sql statment. The last one is uset to read data out of database.
						sqlc.addEventListener(SQLEvent.OPEN, db_opened);
						sqlc.addEventListener(SQLErrorEvent.ERROR, error);
						sqls.addEventListener(SQLErrorEvent.ERROR, error);
						sqls.addEventListener(SQLEvent.RESULT, result);
				}

				protected function db_opened(e:SQLEvent):void
				{
						sqls.sqlConnection = sqlc;

						sqls.text = "CREATE TABLE IF NOT EXISTS Dual ( id INTEGER PRIMARY KEY )";
						sqls.execute();

						// Dummy table to allow us to always return the requestId with some LEFT JOIN magic.
						sqls.text = "REPLACE INTO Dual VALUES ( 1 )";
						sqls.execute();

						loadComplete();
				}

				protected function registerCallbacks(requestId:int, successCallback:Function, errorCallback:Function) {
						_callbackRegister[requestId + "_success"] = successCallback;
						_callbackRegister[requestId + "_error"] = errorCallback;
				}

				protected function clearCallbacks(requestId:int) {
						_callbackRegister[requestId + "_success"] = null;
						_callbackRegister[requestId + "_error"] = null;
						delete _callbackRegister[requestId + "_success"];
						delete _callbackRegister[requestId + "_error"];
				}

				protected function _generateRequestId():int {
						return _nextRequestId++;
				}

				// method that gets called if we recive some results from our sql commands.
				//this method would also get called for sql statments to insert item and to create table but in this case sqls.getResault().data would be null
				protected function result(e:SQLEvent):void {
						// with sqls.getResault().data we get the array of objects for each row out of our database
						var data:Array = sqls.getResult().data;
						if (data != null) {
								var requestId:String = data[0];
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
						}
				}
		}
}