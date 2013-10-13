App.QuestionsRoute = Ember.Route.extend(model: ->

  # request all contacts from adapter
  App.Question.find()

)
