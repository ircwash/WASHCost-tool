App.Router.map ->
  @resource "sections", ->
    @resource "section",
      path: ":section_id"
