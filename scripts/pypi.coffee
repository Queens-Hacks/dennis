# Description:
#   Simple Python Package Index querying using XMLRPC API.
#
# Dependencies:
#   none
#
# Configuration:
#   HUBOT_PYPI_URL (defaults to https://pypi.python.org/pypi)
#
# Commands:
#   hubot import venvgit2 -- get details from pypi about venvgit2
#
# Authors:
#   lukaszb
#   uniphil


createClient = ->


module.exports = (robot) ->
  pypi_url = process.env.HUBOT_PYPI_URL or "https://pypi.python.org/pypi/"

  getSummary = (msg, pkg, cb) ->
    msg.http(pypi_url + pkg + '/json').get() (err, res, body) ->
      stuff = JSON.parse body
      name = stuff.info.name
      author = stuff.info.author
      latestVersion = stuff.info.version
      latestReleaseDate = stuff.urls[0].upload_time
      shortDescription = stuff.info.summary
      link = stuff.info.home_page or stuff.info.package_url
      cb "#{name} by #{author}, latest: #{latestVersion}/#{latestReleaseDate}\n#{shortDescription}\n#{link}"

  robot.hear /(?:import|pypi|python|pip install) ([\w_.-]+)/i, (msg) ->
    pkg = msg.match[1]
    getSummary msg, pkg, (summary) ->
      msg.send summary
