(function(Notification) {

  var app = k12.app;

  Notification.Model = Backbone.Model.extend({ });

	Notification.Collection = Backbone.Collection.extend({
    model: Notification.Model,
		url: '/api/notifications',
    parse: function(response) {
      return response;
    }
	});

  Notification.Views.List = Backbone.View.extend({
  	
  	template: 'notifications',
  	serialize: function() {
  		return { notifications: this.collection.toJSON() };
  	},
    beforeRender: function() {
      this.collection.each(function(m) {
          this.insertView('.notification_type', new Notification.Views.Type({notification_type: m}));
        }, this);
    }
  });

  Notification.Views.Type = Backbone.View.extend({
    
    template: 'notification_type',
    serialize: function() {
      return { notification_type: this.notification_type.toJSON() };
    },
    beforeRender: function() {
      console.log(this.model);
      this.notification_type.notifications.each(function(m) {
          this.insertView('.notification_items', new Notification.Views.Detail({model: m}));
        }, this);
    }
  });

  Notification.Views.Detail = Backbone.View.extend({
  	
  	template: 'notification_item',
  	serialize: function() {
  		return { notification: this.model.toJSON() };
  	}

  });

})(k12.module("notification"));