Ember.Handlebars.helper "formatDate", (value, options) ->
  moment.lang "en"
  formatted_date = moment(value).format("DD.MM.YYYY")
  new Ember.Handlebars.SafeString(formatted_date)
