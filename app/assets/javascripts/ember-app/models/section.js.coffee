App.Section = DS.Model.extend(
  name: DS.attr("string")
  questions: DS.hasMany('App.Question')
)
