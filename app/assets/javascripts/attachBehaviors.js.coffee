class HelpMailerBehavior
  constructor: (@$el, @context) ->
    new HelpMailer(@$el)

class AffixBehavior
  constructor: (@$el, @context) ->
    @$el.affix()

class TooltipBehavior
  constructor: (@$el, @context) ->
    @$el.tooltip()

class PopoverBehavior
  constructor: (@$el, @context) ->
    @$el.popover()

$ ->
  window.clientBehaviors = new ClientBehaviors(affix: AffixBehavior, help_mailer: HelpMailerBehavior)
  window.clientBehaviors.attach()
