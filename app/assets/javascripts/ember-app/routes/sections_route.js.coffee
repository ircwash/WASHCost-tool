App.SectionsRoute = Ember.Route.extend(model: ->

  # request all contacts from adapter
  App.Section.find()

)
