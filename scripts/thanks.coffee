# Description:
#   Dennis should be gracious
#
# Commands:
#   hubot thanks - Respond to the user
 
module.exports = (robot) ->
  robot.respond /thanks/i, (msg) ->
    msg.send "You are quite welcome #{msg.message.user}"
