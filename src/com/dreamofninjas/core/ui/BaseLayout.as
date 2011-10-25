package com.dreamofninjas.core.ui
{
	import flash.display.Sprite;

	public class BaseLayout extends Sprite {
			protected var _width:int;
			protected var _height:int;

			public function withHeight(h:int):BaseLayout {
					this._height = h;
					return this;
			}
			public function withWidth(w:int):BaseLayout {
					this._width = w;
					return this;
			}
			public function build():BaseLayout {
					setupView();
					return this;
			}

			protected override function setupView():void {
					// Implement this to build the view.
			}

	}
}
