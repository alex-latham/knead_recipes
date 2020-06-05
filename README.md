
![Knead Recipies Logo](https://i.imgur.com/QFrJuy4.png)

 
<p align="center">
 Live App Available At
  <a href="https://knead-recipes.herokuapp.com">Knead Recipes App</a>
 </p>
 
# Quick Links

- [About](#about)
- [Features](#features)
- [Installing](#Installing)
- [Setup](#Setup)
- [Developers](#developers)


# About
Knead Recipes is an app designed to take the hassle and confusion out of what’s for dinner. All you need to do is enter the ingredients you have on hand, and our app will return a list of recipes you can make using what you have on hand, or only need a few more ingredients for. Knead Recipes is built to account for many dietary restrictions such as vegetarian, vegan, ketogenic, gluten free, and dairy free. This web app is built on Rails 5.1.7 and ruby 2.5.0p0. All API calls are encapsulated in a Sinatra based micro service that communicates with the main rails app. Front end design created using Bootstrap 3.

### Schema
![DBSchema](https://i.imgur.com/NGjyawb.png)

# Features

## Sign in using Google
![Landing Page](https://i.imgur.com/igWKviA.jpg)
![Google Sign in](https://i.imgur.com/U6g4wqf.png)
---
## Set up user profile
![Profile Edit](https://i.imgur.com/9cdQ3kf.jpg)
---
## Enter Ingredients and other Parameters 
![Search Page](https://i.imgur.com/Ts7scHx.jpg)
---
## Recipe Index
![Recipe Index](https://i.imgur.com/3DA6mdA.jpg)
---
## Recipe Show
![Recipe Show](https://i.imgur.com/xvc28FA.jpg)
---
## Favorite Recipies
![Favorite Index](https://i.imgur.com/mgOaasD.jpg)
---
## Add Friends and Share Recepies 
![Friends Index](https://i.imgur.com/Ar55ccd.jpg)
![Friends Show](https://i.imgur.com/m7NjPGO.jpg)
--

# Installing
#### Clone Main repository:
```shell
$ git clone https://github.com/alex-latham/knead_recipes
```
#### Clone Microservice repository:
```shell
$ git clone https://github.com/alex-latham/knead_recipes_microservice.git
```
# Setup
#### Navigate into directories seperatly:
```shell
$ cd knead_recipes
$ cd knead_recipes_microservice
```
#### Install gems in microservice and main app:
Run on each
```shell
$ bundle install
```
#### Configure Main App
```shell
$ rake db:{create,migrate,seed}
$ bundle exec figaro install
$ bundle exec sidekiq -C config/sidekiq.yml
$ redis-server
```

Insert into config/application.yml
```shell
MICROSERVICE_URL: http://localhost:9393
GOOGLE_CLIENT_ID: YOUR GOOGLE CLIENT UD
GOOGLE_CLIENT_SECRET: YOUR GOOGLE CLIENT SECRET ID
```
#### Configure Microservice:
Create var.env in root microservice directory
Insert Spoonacular API key into var.env
```shell
SPOONACULAR_KEY= YOUR API KEY
```
#### Run test suite in main app:
```shell
$ rspec
```
#### Run test suite in microservice:
```shell
$ ruby spec/requests/spoonacular_spec.rb
```
#### Launch Microservice:
```shell
$ bundle exec shotgun
```
#### Launch Main app:
```shell
$ rails s
```
#### Enjoy App Locally:
Visit localhost in your Browser
```shell
localhost:3000
```

# Developers
<p>
  <a href="https://github.com/fredrondina96">Fred Rondina</a>
 </p>
 <p>
  <a href="https://github.com/alex-latham">Alex Latham</a>
 </p>
 <p>
  <a href="https://github.com/mikez321">Mike Hernandez</a>
 </p>
 <p>
  <a href="https://github.com/DavidTTran">David Tran</a>
 </p>

