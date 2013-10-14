App.QuestionRoute = Ember.Route.extend({
  setupController: function(controller, model) {
    this._super.apply(this, arguments);
    // highlight this contact as active
    this.controllerFor('questions').set('activeContactId', model.get('id'));
  }
});
