App.Question = DS.Model.extend(
  caption: DS.attr("string")
  information: DS.attr("string")
  numeric_reference: DS.attr("number")
  section: DS.belongsTo('App.Section')
  scheme: DS.attr("string")
)
