RibState
-ItemSetSelectorView
-- Set icon
-- Set name
-- Tags (v2?)
-- Attached Champions
-ItemSelectorView
-- Item chooser
-- Upgrade tree
-- Stats box (maybe)


Basic MVC idea:
Model reads ItemSet, ItemSet dispatches UPDATED events when it changes, view should refresh
Controller hooks click/drag events and update the ItemSet model, causing the view to update.

SlotSelectedEvent(slotId:int, itemId:int); #0 for no item

class ItemSlotViewEvent extends Event {

	  // Fired when a slot is selected
	  public static final SELECTED:String = "selected";

	  // Fired when someone starts dragging
	  public static final DRAG_START:String = "drag_start";

	  // Fired when someone stops dragging
	  public static final DRAG_END:String = "drag_end";

	  public var slotId:int;

	  public function SlotSelectedEvent(type:String, slotId:int) {
	  	  	 super(type);
	  		 this.slotId = slotId;
	}
}

public class MainViewController extends EventDispatcher {

	// Handles input and interactions for the item slots
	protected var _itemSlotController:ItemSlotController;
	// Handles input and interactions for the item picker
	protected var _itemPickerController:ItemPickerController;
	// Handles input and interactions for the item set picker
	protected var _itemSetPickerController:ItemSetPickerController;
	protected var _championPickerController:ChapmionPickerController;
}

public class BaseController extends EventDispatcher {

}

public class AppView extends Sprite {
	protected var _itemSlotView:ItemSlotView;
	protected var _itemSetPickerView:ItemSetPickerView;
	protected var _championPickerView:ChampionPickerView;
	protected var _itemPickerView:ItemPickerView;

	public function AppView() {

	}

}

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


public class ChapmionPickerController extends BaseController { }
public class ItemPickerController extends BaseController { }
public class ItemSetPickerController extends BaseController { }

public class ItemSetPickerView extends Sprite { }
public class ChampionPickerView extends Sprite { }
public class ItemPickerView extends Sprite { }


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

/**
 * Basic wrapper around the ItemSlot sprite. Translates click events into SlotSelected events, Handles drag 'n drop.
 *
 */
public class ItemSlotView extends Sprite {

	   protected var _itemSet:ItemSet;
	   protected var _itemSlotSprites:Array = new Array(6);

	   public function ItemSlotView() {
	   		  addChild(##LOAD_UI_ELEMENT##);
			  //Add onclick for all slots
			  //Add drag for all slots
			  for (var i:int = 0; i < 6; i++) {
			      _itemSlotSprites[i] = new ItemSlotSprite();
              }
	   }

	   public function set itemSet(newSet:ItemSet):void {
	   		  #remove ev listeners
	   		  _itemSet = itemSet;
			  _itemSet.addEventListener("UPDATED", itemSetUpdated);
			  itemSetUpdated(null);
	   }

	   protected function itemSetUpdated(evt:Event):void {
			  for (var i:int = 0; i < 6; i++) {
			      _itemSlotSprites[i].itemId = _itemSet.getItem(i);
              }
	   }
}