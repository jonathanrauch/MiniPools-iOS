#  Mini-Pools architecture challenge  

[ ] Home screen that shows all available pools.
  [x] Each cell shows the pool's title, it's contribution amount (e.g. $0), and if there's a goal, shows it as well (e.g $0 / $50).  Amounts should be integers.
    [x] Fetches all pools from the server on `viewWillAppear` and shows the top-bar activity indicator while it does.
    [x] No need to do pull-to-refresh.
    [ ] Shows delta between pools:
      [ ] If a pool is deleted, make it disappear with animation (fade or slide).
      [ ] If a pool is added, make it appear with animation (fade or slide).
      [ ] If a pool had a title or contribution amount change, make it highlighted with a bluish background color (#C5D7FF). This only happens when the change is __remote__ (if a user edit the pool details locally the cell doesn't change color). You can test it by sending requests through the postman collection (see below).
      [ ] If a pool had its goal reached, it'll be highlighted with a light-green background color (#DCFFD5). This overrides the bluish background color rule from above.
    [x] Clicking a pool opens its pool page.
    [x] First cell is a "create new pool button". Clicking it takes the use to a "create pool" page.
    
[x] Pool page that shows details for selected pool. 
  [x] Its title is the pool name.
  [x] Details:
    [x] Name of the pool.
    [x] Total contribution amount (e.g $0).
    [x] Goal amount if available (show it as part of the amount field in a $0 / $50 format). Amounts should be integers.
  [x] There are also 2 available actions:
    [x] Delete - deletes the pool using the API request. 
      [ ] The user is automatically moved to the home page (forward transition) when the operation succeeds. 
      [x] Show top-bar activity indicator while delete is underway. 
      [x] Delete button, edit button and nav-bar back button should be disabled while operation is underway.
    [x] Edit - takes the user to the edit pool screen (by push).
  
[ ] Pool form page that serves both create (empty fields) and edit (prefilled).
  [ ] Its title is either "create new pool" or "edit <pool name>".
  [ ] Has labels and corresponding text fields for:
    [ ] Pool name (required).
    [ ] Target goal amount (optional).
  [ ] Has a "create" or "save" button in the bottom that creates the pool via an API request.
    [ ] The user is automatically moved to the newly created pool page when the operation succeeds (removing the from screen from the navigation stack).
    [ ] Show top-bar activity indicator while create/edit is underway. 
    [ ] Back button, the text fields and the action button should be disabled while the request is underway.
  [ ] If the pool name is empty when the button is pressed, or the target goal is below the current total contribution amount - shake the relevant invalid field (using the UIView.shake extension - already in the code).
    
[ ] You should also write some tests to key components in order to check the architecture's Testability aspect.
