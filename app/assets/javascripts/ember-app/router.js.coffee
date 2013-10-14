App.Router.map ->
  @resource "questions", ->
    @resource "question",
      path: ":question_id"
