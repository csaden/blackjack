class window.HandView extends Backbone.View
  tagName: 'span'
  className: 'hand'

  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    @collection.on 'add remove change', => @render()
    @render()
    @collection.checkBlackJack();

  render: ->
    @$el.children().remove()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    @$el.find('.card').toggleClass('flipped');
    scores = @collection.scores()
    if scores[0] is scores[1] 
      @$('.score').text scores[0]
    else
      @$('.score').text scores[0]+'/'+scores[1]