package com.dreamofninjas.rib {
		public class AppController extends BaseController {
				protected var _championPickerController:ChampionPickerController;
				protected var _itemPickerController:ItemPickerController;
				protected var _itemSetPickerController:ItemPickerController;
				protected var _itemSlotController:ItemPickerController;

				public function AppController(appView:AppView) {
						_itemSlotController = new ItemSlotController(appView.itemSlotView);
						_itemSlotController.addEventListener(ItemEvent.ITEM_SELECTED);

						_itemSetPickerController = new ItemSetPickerController(appView.itemSetPickerView);
						_itemSetPickerController.addEventListener(ItemSetEvent.SET_SELECTED, itemSetChanged);

						_itemPickerController = new ItemPickerController(appView.itemPickerView);
						_itemPickerController.addEventListener(ItemEvent.ITEM_CHOSEN);

						_championPickerController = new ChampionPickerController(appView.championPickerView);
						_championPickerController.addEventListener(ChampionEvent.CHAMPION_CHOSEN, championChosen);
				}

				private function championChosen(ev:ChampionEvent) {
				}

				private function itemSelected(ev:ItemEvent) {
						_itemPickerController.itemSelected(ev.itemId);
				}

				private function itemChosen(ev:ItemEvent) {
						_itemSlotController.itemChosen(ev.itemId);
				}

				private function itemSetChanged(ev:ItemSetEvent) {
						_itemSlotController.itemSet = ev.itemSet;
				}
		}
}