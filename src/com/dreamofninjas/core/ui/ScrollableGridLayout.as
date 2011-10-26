package com.dreamofninjas.core.ui
{
	import com.dreamofninjas.core.ui.ContainerLayout;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class ScrollableGridLayout extends ContainerLayout
	{
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
		
		protected override function setupView():void {
			var itemsPerRow:int = (this._width - _xOffset) / (_itemW + _xPadding);
			var spriteIdx:int = 0;
			
			for each(var sprite:Sprite in _spriteList) {
				trace(sprite);
				sprite.width = _itemW;
				sprite.height = _itemH;
				sprite.x = (spriteIdx % itemsPerRow) * (_itemW + _xPadding) + _xOffset;
				sprite.y = int(spriteIdx / itemsPerRow) * (_itemH + _yPadding) + _yOffset;
				addChild(sprite);
				spriteIdx++;
			}
		}
	}
}