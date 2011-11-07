package com.dreamofninjas.core.util
{
	public class ASLog extends Object
	{
		public static const ERROR:String = "LogLevelError";
		public static const WARNING:String = "LogLevelWarning";
		public static const DEBUG:String = "LogLevelDebug";
		public static const INFO:String = "LogLevelInfo";
		protected static const logLevels:Array = [ERROR, WARNING, DEBUG, INFO];
		
		protected static var _instance:ASLog;
		
		protected var _logLevel:String;
		
		public function ASLog(enforcer:Enforcer)
		{
			super();
			_logLevel = WARNING;
		}

		protected static function get instance():ASLog
		{
			if (_instance == null)
			{
				_instance = new ASLog(new Enforcer());
			}
			return _instance;
		}
		
		public static function logLevel():String
		{
			return instance.logLevel;
		}
		
		public static function setLogLevel(logLevel:String):void
		{
			if (logLevels.indexOf(logLevel) == -1)
			{
				instance.logLevel = WARNING;
				log(ERROR, "Invalid Log Level Specified (Defaulting to Warning)");
			}
			else
			{
				instance.logLevel = logLevel;
				log(INFO, "Log Level set to " + logLevel);
			}
		}
		
		public static function error(message:*):void
		{
			log(ERROR, message);
		}
		
		public static function warning(message:*):void
		{
			log(WARNING, message);
		}
		
		public static function debug(message:*):void
		{
			log(DEBUG, message);
		}
		
		public static function info(message:*):void
		{
			log(INFO, message);
		}
		
		protected static function log(logLevel:String, message:*):void
		{
			message = message as String;
			if (logLevels.indexOf(logLevel) > logLevels.indexOf(instance.logLevel))
				return;
			
			var prefix:String;
			switch(logLevel)
			{
				case ERROR:
					prefix = "[ERROR] ";
					break;
				case WARNING:
					prefix = "[WARNING] ";
					break;
				case DEBUG:
					prefix = "[DEBUG] ";
					break;
				case INFO:
					prefix = "[INFO] ";
					break;
				default:
					prefix = "FIX THE LOGGER SON. ";
					break;
			}
			var time:String = "[" + new Date().toUTCString() + "] ";
			trace(prefix + time + message);
		}

		public function get logLevel():String
		{
			return _logLevel;
		}

		public function set logLevel(value:String):void
		{
			_logLevel = value;
		}

	}
}
internal class Enforcer {}