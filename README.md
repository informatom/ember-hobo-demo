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

We have three resources: contracts, contractitems and consumableitems, both on the Ember as well as the Hobo side.
Contracts have many contract items, contractitems have many consumableitems. Attrubutes math to each other, that means demo_attribute in Rails would have a demoAttribute on the Ember side.

The ember data store uses [Ember Data](https://github.com/emberjs/data) and the [Active Model Adapter](http://emberjs.com/api/data/classes/DS.ActiveModelAdapter.html) for serializing and deserializing model data into json requests and data.

Sidenote: This is the easiest way to integrate from the Ember world, it could be worth looking inte [EPF](http://epf.io/) a.k.a.
Ember Persistance Framework for a deeper integration regarding syncing of data. Ember Datas concept of relations is quite loosem so some
of the heavy lifting of keeping associations in sync has to be done in the application.

Three gems are used on the Hobo side for introducing Ember:
* [Active_model_serializers](https://github.com/rails-api/active_model_serializers) cares for serializing and deserializing of data
* [Ember Rails](https://github.com/emberjs/ember-rails) provides Generators
* [Ember Source](https://rubygems.org/gems/ember-source) takes care for the assets

## Changes in the Hobo app

There are some changes necassary in a Hobo app to be consumed by a Ember app.
Data has to be serialized e certain way: For each item, the ids of the assolciated items are included in the json payload.
This is done in the serialzer, which also gives us the opportunity to decide which attributes should be transfered to the clients and
which information on which relationships should be provided.

```ruby
class ContractitemSerializer < ActiveModel::Serializer
  embed :ids

  attributes :id, :position, :term, :startdate, :product_number,
             :description, :amount, :unit, :volume_bw,
             :volume_color, :marge, :vat, :discount_abs, :monitoring_rate,
             :created_at, :updated_at

  has_many :consumableitems
  has_one :contract
end
```

The controller has to be changed as well (probably due to my ignorance).
If we only tell the controller to also respond to json, we get an error message, that the render methods are private.
As we don't care about the html answers here, we override them:

```ruby
class Contracting::ContractitemsController < Contracting::ContractingSiteController
  hobo_model_controller
  auto_actions :all
  respond_to :html, :json

  def index
    hobo_index do
      render json: this
    end
  end

  def show
    hobo_show do
      render json: this
    end
  end

  def create
    hobo_create do
      render json: this
    end
  end

  def update
    hobo_update do
      render json: this
    end
  end

  def destroy
    hobo_destroy do
      render json: nil
    end
  end
end
```

in case we want the regular answer as well, an action looks like this:

```ruby
  def index
    hobo_index do |format|
      format.json { render json: this }
      format.html { hobo_index }
    end
  end
```

## Improvements and suggestions

As this is my first Hobo / Ember app, it won't be porfect, probably there are even errors in stil.
If you hive feedback for me, please open a ticket to this repo und let's start the discussion.