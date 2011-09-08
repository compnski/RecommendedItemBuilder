package com.dreamofninjas.rib
{
	import avmplus.getQualifiedClassName;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.utils.getDefinitionByName;
	
	public class AnimatedClip extends Sprite {
		
		protected var _clip:MovieClip;
		
		
		
		public function AnimatedClip(initializer:Object) {
			super();
			if (initializer is String) {
				_clip = getMovieClip(initializer as String);
			} else if (initializer is MovieClip) {
				_clip = initializer as MovieClip;
			} 
			
			if (_clip == null) {
				throw new Error("AnimatedClip can only init from Strings and MovieClips, not type" + getQualifiedClassName(initializer));
			}
			_clip.stop();
			addChild(_clip);
		}
		
		public function get clip():MovieClip
		{
			return _clip;
		}

		public function show(frame:String):void {
			_clip.gotoAndStop(frame);
		}
			
		public function animate(startFrame:String, endFrame:String=null):void {
			if (endFrame == null) {
				
			}
			
		}
			
		protected function getMovieClip(className:String):MovieClip {
			var mcClassDefinition:Class = getDefinitionByName(className) as Class;
			return new mcClassDefinition() as MovieClip;
		}					
	}
}