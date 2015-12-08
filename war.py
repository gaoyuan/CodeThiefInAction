import random
import time

def donothing():
    return

#13 cards per suite
#Define cards in deck
temp_fulldeck = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13,
                1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13,
                1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13,
                1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]

#Define player 1 deck values
player1deck = []
player1curcard = 0
player1bufcards = []

#Define player 2 deck values
player2deck = []
player2curcard = 0
player2bufcards = []

#Random variables
roundcount = 1

#Shuffle half the cards to player 1
for count in range(1,27):
    print count
    cardval = random.sample(temp_fulldeck, 1)[0]
    print "card: " + str(cardval)
    temp_fulldeck.remove(cardval)
    player1deck.append(cardval)

#Give the rest of the cards to player 2
player2deck = temp_fulldeck
temp_fulldeck = []

#Debug message
print "----------------------------------"
print "           GAME START             "
print "----------------------------------"

while len(player1deck) != 0 or len(player1deck) != 52:
    print "Round " + str(roundcount)
    print "-----====================-----"
    #Get first card from each players deck and put it in hand
    if(len(player1deck) != 0):
        player1curcard = player1deck[0]
    else:
        break
    if(len(player2deck) != 0):
        player2curcard = player2deck[0]
    else:
        break

    #Remove first card from the players deck (The card is in hand now)
    player1deck.pop(0)
    player2deck.pop(0)

    print str(player1curcard) + " vs " + str(player2curcard)

    #Check if the cards are equal and if so place them in the card buffer,
    #otherwise give both cards to the player with the highest value.
    if player1curcard == player2curcard:
        #TODO: Make the logic here
        print "Both players have tied."
        #Put player 1's current hand card into the buffer and clear the hand
        if(player1deck == 1):
            #do nothing
            donothing()
        else:
            player1bufcards.append(player1curcard)
            player1curcard = 0
        #Take 3 of player 1's card and put them into the buffer
        if(len(player1deck) < 4):
            if(player2deck == 1):
                #do nothing
                donothing()
            else:
                for cardnum in range(1,len(player1deck)):
                    player1bufcards.append(player1deck[0])
                    player1deck.pop(0)
        else:
            for cardnum in range(1,4):
                player1bufcards.append(player1deck[0])
                player1deck.pop(0)
        #Put player 2's current hand card into the buffer and clear the hand
        if(player2deck == 1):
            #do nothing
            donothing()
        else:
            player2bufcards.append(player2curcard)
            player2curcard = 0
        #Take 3 of player 1's card and put them into the buffer
        if(len(player2deck) < 4):
            if(player2deck == 1):
                #do nothing
                donothing()
            else:
                for cardnum in range(1,len(player2deck)):
                    player2bufcards.append(player2deck[0])
                    player2deck.pop(0)
        else:
            for cardnum in range(1,4):
                player2bufcards.append(player2deck[0])
                player2deck.pop(0)
        #Take a card from each players deck and put it in their hand
        player1curcard = player1deck[0]
        player2curcard = player2deck[0]
        player1deck.pop(0)
        player2deck.pop(0)
        print str(player1curcard) + " vs " + str(player2curcard)

        #time.sleep(10)

    #Check whos card won and give both deck cards to them.
    #TODO: Give winning player the cards in the card buffers.
    if player1curcard > player2curcard:
        #Debug message
        print "Player 1 won this round"
        #Add both players hand card to player 1's deck
        player1deck.append(player1curcard)
        player1deck.append(player2curcard)
        #Clear each players hand
        player1curcard = 0
        player2curcard = 0
        #Get cards from player 1's buffer and give them to player 1
        for card in player1bufcards:
            player1deck.append(card)
        #Get cards from player 2's buffer and give them to player 1
        for card in player2bufcards:
            player1deck.append(card)
        #Clear cards from each players buffer
        player1bufcards = []
        player2bufcards = []
    else:
        #Debug message
        print "Player 2 won this round"
        #Add both players hand card to player 2's deck
        player2deck.append(player1curcard)
        player2deck.append(player2curcard)
        #Clear each players hand
        player1curcard = 0
        player2curcard = 0
        #Get cards from player 1's buffer and give them to player 2
        for card in player1bufcards:
            player2deck.append(card)
        #Get cards from player 2's buffer and give them to player 2
        for card in player2bufcards:
            player2deck.append(card)
        #Clear cards from each players buffer
        player1bufcards = []
        player2bufcards = []

    print((player1deck))
    print((player2deck))

    print str(len(player1deck)) + "/52"
    print str(len(player1deck) + len(player2deck))

    print "-----====================-----"

    roundcount += 1

    time.sleep(1)