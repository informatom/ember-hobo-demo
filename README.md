# Ember-Hobo-Demo

This is a small demo application, that shows how to integrate the server-side [Hobo](http://www.hobocentral.net/) application framework
(which is based and built on top of on Ruby On Rails) with the client-side [Ember.js](http://emberjs.com/) framework.

Ember.js can help you in a Hobo app, if you want to move application logic to the client.
In this example it replaces the Hobo Dryml view code almost completely. The Ember app here is a 1:1 port from an Excel calculation spreadsheet,
that should be ported into a web application.

The Hobo app is restricted to one route in the Hobo application: `/contracting/contracts`, i.e. it is in the
subsite named `contracting` at the index controller of ther contracts resource and model.
The amounts of inter dependencies between Hobo and Ember are minimized that way.

Ember specific Javascript and CSS is extracted by using a second layout, which is hidden in the minimalist contracts index page.
The root files for Javascript and CSS I have named `contracting2.js` and `contracting2.css` to have complete seperation of concerns here.
This way [Bootstrap 3](http://getbootstrap.com/) could be introduced to the Ember.app, while the Hobo part stil runs on
[Bootstrap 2.3.2](http://getbootstrap.com/2.3.2/).

The Ember applcation was created in a small side project based on and created by the [Ember Rails Gem](https://github.com/emberjs/ember-rails).
After development of a minimal Ruby On Rails and Ember application this it was ported into an existing Hobo application. The demo app here
is the Hobo application stripped down to the bare minimum.
It is showcasing the integration and changes necessary for playing well with current Hobo (2.1).


## Installation

Installation is quite easy, as we are using SQLite for this demo.
The classical steps:
* `bundle install`
* `rails s`
spins up a [Puma](http://puma.io/) web server that listens to (http://localhost:3000) where you will find a link to the Ember app that is located at
(http://localhost:3000/contracting/contracts/#). (A minimal database is included in the repo, in case you wonder.)


## Structure

We have three resources: `contract`, `contractitem` and `consumableitem`, both on the Ember as well as the Hobo side.
Contracts have many contract items, contract items have many consumable items. Attributes match each other, that means an `example_attribute`
in Rails would have an `exampleAttribute` on the Ember side.

The ember uses [Ember Data](https://github.com/emberjs/data) as it's data store and the [Active Model Adapter](http://emberjs.com/api/data/classes/DS.ActiveModelAdapter.html) for serializing and deserializing model data into JSON requests and data.

Sidenote: This is the easiest way to integrate from the Ember world, it could be worth looking inte [EPF](http://epf.io/) a.k.a.
Ember Persistance Framework for a deeper integration regarding syncing of data. Ember Data's concept of relations is quite loose, so some
of the heavy lifting of keeping associations in sync has to be done in the application manually. Further more there is no error handling
in this demo application.

Three gems are used on the Hobo appplication side for introducing Ember:
* [Active Model Serializers](https://github.com/rails-api/active_model_serializers) cares for serializing and deserializing of data
* [Ember Rails](https://github.com/emberjs/ember-rails) provides Generators
* [Ember Source](https://rubygems.org/gems/ember-source) takes care for the assets of Ember.js, Ember Data and Handlebars

## Changes in the Hobo app

There were some changes necassary in a Hobo app to be consumed by a Ember app.
Data has to be serialized e certain way: For each item, the id's of the assolciated items are included in the JSON payload.
This is done in the serialzer, which also gives us the opportunity to decide which attributes should be transfered to the clients and
information on which relationships should be provided.

Let's look at the contract items because they have relationships of both kinds:
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
If we only tell the controller to also respond to JSON, we get an error message, that the render methods are private.
As we don't care about the html answers here, we simply override them using brute force:

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

In case we want the regular HTML answer as well, that is case for the contracts, an action looks like this:

```ruby
  def index
    hobo_index do |format|
      format.json { render json: this }
      format.html { hobo_index }
    end
  end
```

To customize the asset handling we include in `development.rb`:
```ruby
config.ember.variant = :development
```

and in in `production.rb`:
```ruby
config.ember.variant = :production
```

Environment unspecific settings go into `application.rb`:
```ruby
config.ember.app_name = "Contracting"
config.handlebars.templates_root = "contracting/templates"
config.handlebars.precompile = true
```

The second line moves / namespaces all Javascript files of the Ember app in their own directory.

## And what about Ember ?

To go into the details of the Ember app could maybe fill a book in itself ;-), but there isn't really anything Hobo specific there.

Just have a look into the application yourself, it is created at
[contracting2.js.coffee](https://github.com/informatom/ember-hobo-demo/blob/master/app/assets/javascripts/contracting2.js.coffee).
All the application files are in it's own Javascript directory
[contracting](https://github.com/informatom/ember-hobo-demo/tree/master/app/assets/javascripts/contracting) in the assets as mentioned before.

Yes, everything is written in [Coffeescript](http://coffeescript.org/) instead of plain Javascript. I got into Coffeescript with this project
and I quite like it because it looks way more Ruby'esque than plain Javascript. I haven't used [Ember Script](http://emberscript.com/) in
this project, which could be the next step to go to reduce the amount of code even more.

If you are new to Ember and I have teased you enough:
The best place to start learning Ember is the [Ember Guides](http://emberjs.com/guides/).


## Improvements and suggestions

As this is my first Hobo / Ember app, it is far from perfect, probably there are errors in.
If you have feedback or questions for me, please feel free to open a ticket to this repo und let's start the discussion.

Besides that, have fun with Ember and Hobo!