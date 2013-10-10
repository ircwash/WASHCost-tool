App.IndexRoute = Ember.Route.extend(model: ->
  store = @get("store")
  store.find "question"
)
