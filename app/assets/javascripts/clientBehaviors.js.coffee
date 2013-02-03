#
# Attach a client behavior to any DOM element which specifies a
# data-client-behavior attribute
#
class @ClientBehaviors
  constructor: (@behaviors) ->

  createBehavior: ($el, context) ->
    behaviorName = $el.data('client-behavior')
    behavior = @behaviors[behaviorName]
    new behavior($el, context)

  attach: (scope = $(window), context = {}) ->
    for el in $('*[data-client-behavior]')
      @createBehavior($(el), context)
