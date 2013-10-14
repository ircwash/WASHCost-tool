# http://emberjs.com/guides/models/defining-a-store/

#App.Store = DS.Store.extend
#  revision: 11
#  adapter: DS.RESTAdapter.extend(namespace: '/advanced/questionnaire/')

#App.Adapter = DS.RESTAdapter.extend(bulkCommit: false)

App.Adapter = DS.RESTAdapter.extend(namespace: 'advanced/questionnaire', bulkCommit: false)

App.Adapter.map "App.Section",
  questions:
    embedded: "always"

App.Store = DS.Store.extend(
  revision: 12
  adapter:  App.Adapter.create()
)

