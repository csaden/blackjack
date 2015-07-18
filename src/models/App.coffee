# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on('stand', @dealerGo, @)
    @get('playerHand').on('blackJack', @gameOver, @)
      # () =>
      # alert('BlackJack!')
      # @gameOver.call(@))
    @get('playerHand').on('bust', () => 
      @get('dealerHand').at(0).flip()
      @gameOver.call(@))
    @get('dealerHand').on('bust stand', @gameOver, @)

  dealerGo: ->
    @get('dealerHand').at(0).flip()
    @get('dealerHand').checkScore()

  gameOver: ->
    playerScore = @get('playerHand').bestScore()
    dealerScore = @get('dealerHand').bestScore()
    console.log('game over')
    if playerScore > dealerScore then @trigger 'playerWin' 
    else if dealerScore > playerScore then @trigger 'dealerWin'
    else @trigger 'push'

    # on (get dealer hand) add checkscore

