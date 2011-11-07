# Recommended Item Builder
## Organize your recommended items into easy to change sets

### Features
* Update recommended items for your champion
* Create named item sets* 
* Attach any number of sets to a champion*
* Easily choose the active set for a champion*
* Share with friends *

 *coming soon



# DEV NOTES

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
