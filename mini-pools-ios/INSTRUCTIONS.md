#  Mini-Pools architecture challenge  

[ ] Home screen that shows all available pools.
    [ ] Shows delta between pools:
      [ ] If a pool is deleted, make it disappear with animation (fade or slide).
      [ ] If a pool is added, make it appear with animation (fade or slide).
      [ ] If a pool had a title or contribution amount change, make it highlighted with a bluish background color (#C5D7FF). This only happens when the change is __remote__ (if a user edit the pool details locally the cell doesn't change color). You can test it by sending requests through the postman collection (see below).
      [ ] If a pool had its goal reached, it'll be highlighted with a light-green background color (#DCFFD5). This overrides the bluish background color rule from above.
    
[ ] Pool form page that serves both create (empty fields) and edit (prefilled).
  [ ] Has a "create" or "save" button in the bottom that creates the pool via an API request.
    [ ] The user is automatically moved to the newly created pool page when the operation succeeds (removing the from screen from the navigation stack) - forward navigation.
  [ ] If the pool name is empty when the button is pressed, or the target goal is below the current total contribution amount - shake the relevant invalid field (using the UIView.shake extension - already in the code).
    
[ ] You should also write some tests to key components in order to check the architecture's Testability aspect.
