# Ember-Hobo -Demo

This is a small demo application that shows how to integrate the server side [Hobo](http://www.hobocentral.net/) application framework
(which is based and built on top of on Ruby On Rails) with the cvient side [Ember.js](http://emberjs.com/) framework.

Ember.js can help you in a Hobo app, if you want to move application logic to the client.
In this example it replaces the Hobo Dryml almost completely.

The Hobo app is restricted to one route in the Hobo application: /contracting/contracts i.e. it is in the
subsite named contracting at the index controller of ther contracts resource and model.
The amounts of inter dependencies between Hobo and Ember are minimized that way.

Ember specific Javascript and CSS is extracted by using a second layout which is hidden in the minimalist contracts index page.
The root files for javascript and css are named contracting2.js and contracting2.css to have complete seperation of concerns here.
This way [Bootstrap 3](http://getbootstrap.com/) could be introduced to the Ember.app while the Hobo part stil runs on
[Bootstrap 2.3.2](http://getbootstrap.com/2.3.2/).

The Ember applcation was created in a small side project based on and created by the [Ember Rails Gem](https://github.com/emberjs/ember-rails).
After this it was ported into an existing Hobo application. The demo app here is the Hobo application stripped down to the bare minimum
showcasing the integration and changes necessary for playing well with current Hobo (2.1).

## Structure

We have three Resources contracts, contractitems and consumableitems, both on the Ember as well as the Hobo side.
Contracts have many contract items, contractitems have many consumableitems. Attrubutes math to each other, that means demo_attribute in Rails would have a demoAttribute on the Ember side.

The ember data store uses [Ember Data](https://github.com/emberjs/data) and the [Active Model Adapter](http://emberjs.com/api/data/classes/DS.ActiveModelAdapter.html) for serializing and deserializing model data into json requests and data.

Sidenote: This is the easiest way to integrate from the Ember world, it could be worth looking inte [EPF](http://epf.io/) a.k.a.
Ember Persistance Framework for a deeper integration regarding syncing of data. Ember Datas concept of relations is quite loosem so some
of the heavy lifting of keeping associations in sync has to be done in the application.

Three gems are used on the Hobo side for introducing Ember:
* [Active_model_serializers](https://github.com/rails-api/active_model_serializers) cares for serializing and deserializing of data
* [Ember Rails](https://github.com/emberjs/ember-rails) provides Generators
* [Ember Source](https://rubygems.org/gems/ember-source) takes care for the assets