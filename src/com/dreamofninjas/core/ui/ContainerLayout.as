package com.dreamofninjas.core.ui
{
	import com.dreamofninjas.core.ui.SpriteList;

	public class ContainerLayout extends BaseLayout {
			protected var _spriteList:SpriteList;

			protected var _itemW:int;
			protected var _itemH:int;

			public function withItemHeight(h:int):ContainerLayout {
					this._itemH = h;
					return this;
			}
			public function withItemWidth(w:int):ContainerLayout {
					this._itemW = w;
					return this;
			}
	}
}