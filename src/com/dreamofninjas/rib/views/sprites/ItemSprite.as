package com.dreamofninjas.rib.views.sprites
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	public class ItemSprite extends Sprite
	{
		protected var _id:int;
		protected var _image:Bitmap;
		
		public function ItemSprite(id:int, image:Bitmap)
		{
			super();
			_id = id;
			_image = image;
			addChild(image);
		}
		
		public override function toString():String {
			return "[ItemSprite "  + _id + "]";
		}
	}
}