App.Question = DS.Model.extend(
  caption: DS.attr("string")
  information: DS.attr("string")
  numeric_reference: DS.attr("number")
  section: DS.belongsTo('App.Section')
  scheme: DS.attr("object")
  properties: (->
    scheme = @get("scheme")
    scheme[scheme.type]
  ).property("scheme")
  type: (->
    scheme = @get("scheme")
    scheme.type
  ).property("scheme")
)
