App.Scheme = DS.Model.extend(
  type: DS.attr("string")
  question: DS.belongsTo('App.Question')
)
