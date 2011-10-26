package com.dreamofninjas.core.ui
{
	import flash.display.Sprite;

	public class BaseLayout extends Sprite {
		protected var _width:int;
		protected var _height:int;

		public function withHeight(h:int):* {
			this._height = h;
			return this;
		}
		public function withWidth(w:int):* {
			this._width = w;
			return this;
		}
		public function draw():* {
			setupView();
			return this;
		}
		protected function setupView():void {
			// Implement this to build the view.
		}
	}
}
