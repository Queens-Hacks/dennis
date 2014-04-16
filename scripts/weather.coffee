# Description:
#   Describe the weather, by us.
#
#   Hubot will remember weather conditions by descriptions provided by anyone.
#   When you ask for the weather, hubot will pick a description of similar
#   conditions to respond with.
#
#   Similarity of conditions is determined by finding the closest description
#   of the known conditions in a many-dimensional space (a dimension for each
#   property of the weather it tracks). These dimensions are scaled to ranges
#   that make sense and then fudged with constants to make some more important
#   than others.
#
#   The similarity is computed with something roughly like:
#
#       k1 * abs(currentTemp - descTemp)^2 +
#       k2 * abs(currentCloudCover - descCloudCover)^2 +
#       k3 * abs(currentDayOfYear - descDayOfYear)^2 +
#       ...and so on.
#
#   The kN constants are chosen pretty arbitrarily. I just made stuff up.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot <city> is at <lat>, <ln> - tell hubot about places.
#   hubot where have you been? - list all the places hubot knows about.
#   hubot move to <city> - teleport hubot around.
#   hubot where are you? - show hubot"s current location.
#   hubot how is the weather? - weather for the default location.
#   hubot how is the weather in <city>? - weather for any city hubot knows of.
#   hubot the weather is <description> - tell hubot about the current weather.
#   hubot the weather in <city> is <description> - the weather in some city.
#   hubot never go back to <city> - make hubot forget about a place.
#
# Author:
#   uniphil

module.exports = (robot) ->

  # Places

  learn_city = (name, lat, ln) ->
    "lalala"

  move_to = (city) ->
    "lalala"

  get_city = (city) ->
    "lalala"

  get_all_cities = () ->
    "lalala"

  get_current_city = () ->
    "lalala"

  # Weather

  # Responding to commands

  robot.respond /([\w\s]+) is at (-?\d+\.?\d*)\s*[,\s]\s*(-?\d+\.?\d*)/i, (msg) ->
    [_, city, lat, ln] = msg.match
    learn_city city, lat, ln
    # todo: warn about cities very near-by (likely the same)
    msg.reply "Got it. I love that place."

  robot.respond /where have you been/i, (msg) ->
    city_arr = get_all_cities()
    if city_arr.length == 0
      msg.reply "I have never left my home :("
    else
      cities = city_arr.join(", ")
      msg.reply "I've been to #{cities}."

  robot.respond /move to ([\w\s]+)/i, (msg) ->
    city = msg.match[1]
    moved = move_to city
    if moved
      msg.reply "On my way to #{city} woo!"
    else
      here = get_current_city()
      msg.reply "Where is that? How do I get there from #{here}?"

  robot.respond /where are you/i, (msg) ->
    here = get_current_city()
    msg.reply "I am #{here}"

  robot.respond /how is the weather/i, (msg) ->
    msg.reply "oh it is great"

  robot.respond /how is the weather in ([\w\s]+)/i, (msg) ->
    city = msg.match[1]
    there = get_city city
    if there?
      here = get_current_city()
      if there is here
        msg.reply "oh the weather here in #{here} is great"
      else
        msg.reply "the weather over in #{there} is great"
    else
      msg.reply "err... where is that?"

  robot.respond /the weather is (.+)/i, (msg) ->
    desc = msg.match[1]
    msg.reply "noted."

  robot.respond /the weather in ([\w\s]+) is (.+)/i, (msg) ->
    [_, city, desc] = msg.match
    msg.reply "noted."

  robot.respond /never go back to ([\w\s]+)/i, (msg) ->
    city = msg.match[1]
    there = get_city city
    if there?
      here = get_current_city()
      if here is there
        msg.reply "I'm so lost now..."
      else
        msg.reply "already forgotten it."
    else
      msg.reply "what? who is #{city}?"

