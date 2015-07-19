class window.CardView extends Backbone.View
  className: 'card-container'

  template: _.template '<div class="card flipped">
                        <img class="card-front" src="img/cards/<%= rankName %>-<%= suitName %>.png"/>
                        <img class="card-back" src="img/card-back.png"/>
                        </div>'

  initialize: -> @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
    # if not @model.get 'revealed'
    #   @$el.find('.card').toggleClass('flipped')
    # if not @model.get 'revealed' then $el.attr('src', 'img/card-back.png')