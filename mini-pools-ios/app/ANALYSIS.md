# What did I do?

## Why MVP?

- Presenter as mediator between View and Model. Updates the model and the view accordingly.
- Prevents fat-view controllers/controllers that have all logic.
- Views are dumb.
- View and businness unowlogic are separated - testable.
- Presenter has nothing to do with the life cycle of the view controller.
- View can be mocked easily.
- There is no layout code in the Presenter at all - it is responsible for updating the View with data and state.

```
     owns and sends events   owns and updates
            ----->-----        ----->----
            |         |        |        |
            |       -------------       |
            |       | Presenter |       |
            |       -------------       |
      -------------   |       |    -------------
      | View + VC |   |       |    |   Model   |
      -------------   |       |    -------------
            |         |       |         |
            -----<-----       -----<-----
              updates           notifies
```


## So what did I do

- Started with basic MVC and refactored from it (since I felt that presenters are not well-defined when dealing with some iOS shticks so I had to wrap my head around the whole solution).
- View layer is View + UIViewController (life-cycle hooks for example are part of visual logic/events).
- Presenter that contains both view (by protocol) and model.
- API requests in Presenter layer.
- `HomeDataSource` - so the View layer won't hold a shared state of the pools.
- Started with not very dumb views, made them dumber and generic.

## Analysis

### Pros / What I liked

- Obvious separation of conerns between View and Model. duh.
- Presenter doesn't necessary know the concept of a "View", but rather an abstract protocol (good for testing).
- The view controller manages all visual logic, which is great since already in iOS there's a thin boundary between VC's and views. No need to create a separate "view" entity that makes code hard to read (as it's separated from the VC).

### Cons / What I didn't like

- Presenter is not "pure" - it's coupled to the view and models and can modify both (side-effects).
- Usage with UIKit's DataSources - oh boy. It makes the architecture be a ugly IMHO, since the View layer now holds state, rather than relying on the presenter itself to provide the data to the View.
- `HomeModel` - because I can't mutate the model if it's a collection...
- Immutability ?? (TODO).
- Some of the flow logic still remains in the VC (who initiates the first call to the presenter?) SOLVEABLE? TODO
- The VC/View layer are not actually dumb since the VC contains the model.

### Things which the architecture doesn't really solve.

- Navigation?

### Testability

- Since the presenter doesn't need to know an actual "View", it's easy to mock one using the protocol and test the presenter.
- However, you still rely on checking the corresponding methods on the protocol are being called since the presenter is coupled to it, rather than returning pure values.

### Readability

### Simplicity

- Double the code compared to Vanilla MVC (yet prevents fat controllers).

### Scalability

- Navigation, lots of data sources.
- Doesn't solve shared state.


// need router - so i can navigate from presenter rather then vc's (since vc needs to know stack).
// basic view component
// merge data source
// who initialized? refreshPools via view or "viewDidAppear" call to presenter that initiates refresh
// cyclic depedency between view and presenter , argh. (need view in order to init presenter, need presenter in order to init view)
// PresetnedViewController
/ kvo for presenter? model doesn't notify
// which kind of cell is presentation logic? maybe? felt weird about it
// generic presenters / vcs
// protocols defined in separate classes 
// extending models - do you need a "view model" for each one?
