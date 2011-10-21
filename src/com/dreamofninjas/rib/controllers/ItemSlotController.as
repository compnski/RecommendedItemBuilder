package com.dreamofninjas.rib {
		public class ItemSlotController extends BaseController {

				protected var _view:ItemSlotView;
				protected var _itemSet:ItemSet;
				protected var _currentSelectionIdx:int = -1; // -1 is nothing selected
				protected var _dragSourceIdx:int = -1;

				public function ItemSlotController(view:ItemSlotView) {
						_view = view;
						view.addEventListener(ItemSlotViewEvent.SELECTED, itemSelected);
						view.addEventListener(ItemSlotViewEvent.DRAG_START, dragStart);
						view.addEventListener(ItemSlotViewEvent.DRAG_END, dragEnd);
				}

				public function set itemSet(itemSet:ItemSet):void {
						_itemSet = itemSet;
						_view.itemSet = itemSet;
				}

				public function changeSelectedItem(itemId:int):void {
						if (_currentSelectionIdx == -1) {
								return;
						}
						_itemSet.setItem(itemId, _currentSelectionIdx);
				}

				protected function itemSeleted(evt:ItemSlotViewEvent):void {
						_currentSelectionIdx = evt.slotId;
				}

				protected function dragStart(evt:ItemSlotViewEvent):void {
						_dragSourceIdx = evt.slotId;
				}

				protected function dragEnd(evt:ItemSlotViewEvent):void {
						//TODO(jason): figure out how to do drag from the item menu
						if (evt.slotId == -1) { // Drag target not on a slot.
								// TODO(jason): Decide if we should toss the item or snap back
						}
						var draggedItemId:int = _itemSet.getItem(_dragSourceIdx);
				}
		}
}
