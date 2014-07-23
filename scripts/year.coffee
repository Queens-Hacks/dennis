# Description:
#   Dennis knows what year it is.
#
# Commands:
#   hubot what year is it - Reply back with the current year

module.exports = (robot) ->
  robot.respond /WHAT YEAR IS IT/i, (msg) ->
    year = new Date().getFullYear()
    msg.send "It is the year #{year}, silly."
