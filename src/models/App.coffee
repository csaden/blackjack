# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    # @on 'bust', @gameOver 
    @get('playerHand').on('stand', @dealerGo, @)
    @get('dealerHand').on('stand', @gameOver)

  events:
    'bust': -> @gameOver
  
  dealerGo: ->
    @get('dealerHand').at(0).flip()
    @get('dealerHand').checkScore()

  gameOver: ->
    playerScore = @get('playerHand').bestScore()
    dealerScore = @get('dealerHand').bestScore()
    if playerScore > dealerScore then @trigger 'playerWin' 
    else if dealerScore > playerScore then @trigger 'dealerWin'
    else @trigger 'push'

    # on (get dealer hand) add checkscore

