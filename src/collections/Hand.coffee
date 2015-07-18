class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->
    @checkBlackJack()

  checkBlackJack: ->
    # if @bestScore() is 21
    a = 5
    @trigger 'blackJack'

  hit: ->
    @add(@deck.pop())
    if @isDealer then @checkScore()
    else @hasBusted()

  # function for testing purposes
  addCard: (card)->
    @add card;

  stand: -> 
    @trigger 'stand'

  bust: ->
    @trigger 'bust'

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  hasBusted: ->
    if @minScore() > 21 
      @bust()
      true
  
  checkScore: ->
    if @hasBusted()
    else if @bestScore() > 16 then @stand()
    else @hit()

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]

  bestScore: ->
    scores = _.filter @scores(), (value) -> 
      value <= 21
    if !scores.length then scores = [-1];
    Math.max.apply null , scores