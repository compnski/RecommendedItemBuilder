package com.dreamofninjas.core.ui
{
	import com.dreamofninjas.core.ui.ContainerLayout;
	
	import fl.controls.ScrollBar;
	import fl.events.ScrollEvent;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class ScrollableGridLayout extends ContainerLayout {
		private var _xPadding:int = 0;
		private var _xOffset:int = 0;
		private var _yPadding:int = 0;
		private var _yOffset:int = 0;
		private var _vScrollBar:ScrollBar;
		private var _childMask:Sprite = new Sprite();
		
		
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
			addChild(_childMask);
		}
		
		public function get itemsPerRow():uint {
			return (_width - _xOffset) / (_itemW + _xPadding);
		}
		
		public function get maxWidth():int {
			return itemsPerRow * _itemW;
		}
		public function get maxHeight():int {
			return (_spriteList.length / itemsPerRow) * (_itemH + _yPadding);
		}
		
		protected function onScrollHandler(ev:ScrollEvent):void {
			buildSpriteGrid();	
		}
		
		protected override function setupView():void {
			this.mask = new Sprite();
			(this.mask as Sprite).graphics.beginFill(0xFF0000);
			(this.mask as Sprite).graphics.drawRect(0, 0, _width, _height);
			(this.mask as Sprite).visible = false;
			addChild(this.mask);
			_vScrollBar = buildScrollBar();
			_vScrollBar.addEventListener(ScrollEvent.SCROLL, onScrollHandler);
			addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler);
			addChild(_vScrollBar);
			buildSpriteGrid();
		}
		
		protected function mouseWheelHandler(ev:MouseEvent):void {
			_vScrollBar.scrollPosition -= ev.delta * _vScrollBar.pageScrollSize;	
		}
		
		protected function buildSpriteGrid():void {
			var spriteIdx:int = 0;
			_childMask.graphics.beginFill(0xFF0000);
			_childMask.graphics.clear();
			_childMask.graphics.drawRect(0, 0, _itemW, -_yScrollOffset % _itemH);
			
			for each(var sprite:Sprite in _spriteList) {
				sprite.width = _itemW;
				sprite.height = _itemH;
				sprite.x = (spriteIdx % itemsPerRow) * (_itemW + _xPadding) + _xOffset + _xScrollOffset;
				sprite.y = int(spriteIdx / itemsPerRow) * (_itemH + _yPadding) + _yOffset + _yScrollOffset;
				sprite.visible = (sprite.y + _itemW) > 0;
				addChild(sprite);
				spriteIdx++;
			}
		}
		
		protected function get _xScrollOffset():int {
			return 0;
		}
		protected function get _yScrollOffset():int {
			return -_vScrollBar.scrollPosition;
		}
		
		protected function buildScrollBar():ScrollBar {
			var scrollBar:ScrollBar = new ScrollBar();
			scrollBar.height = _height;
			scrollBar.x = _width - scrollBar.width;
			scrollBar.minScrollPosition = 0;
			scrollBar.maxScrollPosition = this.maxHeight - _height - _xOffset;
			return scrollBar;
		}
	}
}