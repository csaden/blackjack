assert = chai.assert

describe 'hand', ->
  deck = null
  card1 = null
  card2 = null
  card3 = null
  playerHand = null
  dealerHand = null
  dealerHitSpy = null
  dealerStandSpy = null
  dealerBust = null

  beforeEach ->
    deck = new Deck()
    card1 = new Card {rank: 10, suit: 0}
    card2 = new Card {rank: 6, suit: 0} 
    card3 = new Card {rank: 9, suit: 0}
    playerHand = new Hand [], deck
    dealerHand = new Hand [card1], deck, true
    dealerHitSpy = sinon.spy(Hand.prototype, 'hit')
    dealerStandSpy = sinon.spy(Hand.prototype, 'stand')
    dealerBust = sinon.spy(Hand.prototype, 'bust')
  afterEach ->
    Hand.prototype.hit.restore()
    Hand.prototype.stand.restore()
    Hand.prototype.bust.restore()
  describe 'dealer', ->
    it 'should hit on less than 17', ->
      # dealerHand.addCard(card1)
      dealerHand.addCard(card2)
      expect(dealerHitSpy).to.have.been.called
    it 'should stand on 17 or greater', ->
      # dealerHand.addCard(card1)
      dealerHand.addCard(card3)
      expect(dealerStandSpy).to.have.been.called
      expect(dealerHitSpy).to.have.not.been.called
    it 'should bust on over 21', ->
      # dealerHand.addCard(card1)
      dealerHand.addCard(card2)
      dealerHand.addCard(card3)
      expect(dealerBust).to.have.been.called
    