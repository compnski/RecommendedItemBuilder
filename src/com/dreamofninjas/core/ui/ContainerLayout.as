package com.dreamofninjas.core.ui
{
	import com.dreamofninjas.core.ui.SpriteList;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	public class ContainerLayout extends BaseLayout {

		protected var _spriteList:SpriteList;
		protected var _panel:Sprite;

		protected var _itemW:int;
		protected var _itemH:int;

		public function ContainerLayout() {
			super();
			_panel = new Sprite();
			addChild(_panel);
		}
		
		public function removeFromPanelAt(index:int):DisplayObject {
			return _panel.removeChildAt(index);
		}
		
		public function addToPanel(sprite:DisplayObject):DisplayObject {
			return _panel.addChild(sprite);
		}

		public function withItemHeight(h:int):ContainerLayout {
			this._itemH = h;
			return this;
		}

		public function withItemWidth(w:int):ContainerLayout {
			this._itemW = w;
			return this;
		}
		/**
		 * Runs a function on all sprites in the container
		 */
		public function apply(func:Function):void {
				for each(var sprite:Sprite in _spriteList) {
								func(sprite);
						}
		}
	}
}