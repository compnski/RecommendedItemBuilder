package com.dreamofninjas.core.ui {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public dynamic class SpriteList extends Array implements IEventDispatcher {
		private var _dispatcher:EventDispatcher = new EventDispatcher();
		
		public function SpriteList(...args) {
			var n:uint = args.length 
			for (var i:int=0; i < n; i++) 
			{ 
				// type check done in push()  
				this.push(args[i]) 
			} 
			length = this.length; 
		}
		
		public function remove(sprite:Sprite):void {
			
		}
		
		AS3 override function push(...args):uint
		{
			addedSprites(args);
			return super.push.apply(this,args);
		}
		
		AS3 override function splice(...values):* {
			var removedSpritesList:Array = super.splice.apply(this, values);
			if (removedSpritesList.length > 0) {
				removedSprites(removedSpritesList);
			}
			return removedSpritesList;
		}
		
		protected function addedSprites(updatedList:Array):void {
			dispatchEvent(new SpriteListEvent(SpriteListEvent.SPRITES_ADDED, updatedList));
			dispatchEvent(new SpriteListEvent(SpriteListEvent.UPDATED));
		}
		protected function removedSprites(updatedList:Array):void {
			dispatchEvent(new SpriteListEvent(SpriteListEvent.SPRITES_REMOVED, updatedList));
			dispatchEvent(new SpriteListEvent(SpriteListEvent.UPDATED));
		}


		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int=0, useWeakReference:Boolean=false):void
		{
			_dispatcher.addEventListener(type, listener, useCapture, priority);
		}
		public function dispatchEvent(e:Event):Boolean
		{
			return _dispatcher.dispatchEvent(e);
		}
		public function hasEventListener(type:String):Boolean
		{
			return _dispatcher.hasEventListener(type);
		}
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			_dispatcher.removeEventListener(type, listener, useCapture);
		}
		public function willTrigger(type:String):Boolean
		{
			return _dispatcher.willTrigger(type);
		}
	}
}