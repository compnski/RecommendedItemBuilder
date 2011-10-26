package com.dreamofninjas.core.ui
{
	import com.dreamofninjas.core.ui.SpriteList;

	public class ContainerLayout extends BaseLayout {

		protected var _spriteList:SpriteList;

		protected var _itemW:int;
		protected var _itemH:int;

		public function withItemHeight(h:int):* {
			this._itemH = h;
			return this;
		}

		public function withItemWidth(w:int):* {
			this._itemW = w;
			return this;
		}
		/**
		 * Runs a function on all sprites in the container
		 */
		public function apply(func:Function):void {
				for each(sprite:Sprite in updatedSpriteList) {
								func(sprite);
						}
		}
	}
}