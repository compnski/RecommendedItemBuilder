package com.dreamofninjas.core.ui
{
	import com.dreamofninjas.core.ui.ContainerLayout;

	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class ScrollableGridLayout extends ContainerLayout {
			private var _xPadding:int = 0;
			private var _xOffset:int = 0;
			private var _yPadding:int = 0;
			private var _yOffset:int = 0;

			public function ScrollableGridLayout(spriteList:SpriteList) {
					super();
					_spriteList = spriteList;
					_spriteList.addEventListener(SpriteListEvent.UPDATED, spriteListUpdated);
					//_spriteList.addEventListener(SpriteListEvent.SPRITES_ADDED, spritesAdded);
					//_spriteList.addEventListener(SpriteListEvent.SPRITES_REMOVED, spritesRemoved;
			}

			public function withXOffset(d:int):ScrollableGridLayout {
					this._xOffset = d; return this;
			}
			public function withYOffset(d:int):ScrollableGridLayout {
					this._yOffset = d; return this;
			}
			public function withXPadding(d:int):ScrollableGridLayout {
					this._xPadding = d; return this;
			}
			public function withYPadding(d:int):ScrollableGridLayout {
					this._yPadding = d; return this;
			}
			protected function spriteListUpdated(ev:SpriteListEvent):void {
					//clear and reset the view when the underlying spritelist changes
					while(numChildren) {
							removeChildAt(0);
					}
					setupView();
			}
			protected function spritesRemoved(ev:SpriteListEvent):void {
			}
			protected function spritesAdded(ev:SpriteListEvent):void {
			}

			protected function spriteListUpdated(ev:SpriteListEvent):void {
					//clear and reset the view when the underlying spritelist changes
					while(numChildren) {
							removeChildAt(0);
					}
					buildSpriteGrid();
			}

			public function get maxPossibleHeight():int {
					var itemsPerRow:int = (this._width - xOffset) / (_itemW + xPadding);
					return (len(_spriteList) / itemsPerRow) * (_itemH + yPadding);
			}

			protected function onScrollHandler(ev:ScrollEvent):void {
					apply(function(sprite:Sprite) {
									sprite.x
											}
							);
			}

			protected override function setupView():void {
					buildScrollBar();
					buildSpriteGrid();
			}

			protected function buildSpriteGrid():void {
					var itemsPerRow:int = (this._width - xOffset) / (_itemW + xPadding);
					var spriteIdx:int = 0;

					for each(var sprite:Sprite in _spriteList) {
									sprite.width = _itemW;
									sprite.height = _itemH;
									sprite.x = (spriteIdx % itemsPerRow) * (_itemW + xPadding) + xOffset + xScrollOffset;
									sprite.y = int(spriteIdx / itemsPerRow) * (_itemH + yPadding) + yOffset;
									addChild(sprite);
									spriteIdx++;
							}
			}

			protected function get xScrollOffset() {
					return _vScrollBar.scrollPosition;
			}

			protected function buildScrollBar():void {
					_vScrollBar = new ScrollBar();
					_vScrollBar.height = height;
					_vScrollBar.x = width + 10;
					_vScrollBar.minScrollPosition = 0;
					_vScrollBar.maxScrollPosition = this.maxPossibleHeight;
					_vScrollBar.addEventListener(ScrollEvent.SCROLL, onScrollHandler);
			}
	}
}