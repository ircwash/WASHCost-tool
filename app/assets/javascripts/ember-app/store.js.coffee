App.Adapter = DS.RESTAdapter.extend(
  namespace: "advanced/questionnaire"
)

# Registering Object attr type, witht his attr will be enable to receive raw Json from server
DS.RESTAdapter.registerTransform "object",
  serialize: (value) ->
    value
  deserialize: (value) ->
    value

# Agree that questions are embeds in section model
App.Adapter.map "App.Section",
  questions:
    embedded: "always"

#App.Adapter.map "App.Question",
#  scheme:
#    embedded: "always"

App.Store = DS.Store.extend(
  revision: 12
  adapter:  App.Adapter.create()
)

