browserDescription = ->
  navigator.userAgent

operatingSystemDescription = ->
  navigator.platform

decorateMailToHref = (href) ->
  argPosition = href.indexOf('?')
  if argPosition?
    query = $.deparam(href.substring(argPosition + 1))
    query.body = query.body.replace(/(Browser version:\s*).*/, '$1' + browserDescription())
    query.body = query.body.replace(/(Operating system:\s*).*/, '$1' + operatingSystemDescription())

    href.substring(0, argPosition + 1) + encodeParams(query)

encodeParams = (object) ->
  params = []
  for key, value of object
    params.push(encodeURIComponent(key) + "=" + encodeURIComponent(value))
  params.join('&')

$ ->
  helpLink = $('#help')
  if helpLink?
    href = helpLink.attr('href')
    helpLink.attr('href', decorateMailToHref(href))
