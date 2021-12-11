--Deck Random: Almatik Hope
local s,id=GetID()
function s.initial_effect(c)
	--skill
	local e1=Effect.CreateEffect(c) 
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_STARTUP)
	e1:SetRange(0x5f)
	e1:SetOperation(s.operation)
	c:RegisterEffect(e1)
end
function s.operation(e,tp,eg,ep,ev,re,r,rp)
	--Delete Your Cards
	local c=e:GetHandler()
	Duel.SendtoDeck(c,tp,-2,REASON_RULE)
	local g=Duel.GetFieldGroup(tp,LOCATION_ALL,0)
	Duel.SendtoDeck(g,tp,-2,REASON_RULE)

	--Add Random Deck
	local decknum=Duel.GetRandomNumber(1,#s.deck)
	local deck=s.deck[decknum]
	for idx,code in ipairs(deck) do
		Debug.AddCard(code,tp,tp,LOCATION_DECK,1,POS_FACEDOWN)
	end
	Debug.ReloadFieldEnd()

	--Add Covers
	local dg=Duel.GetFieldGroup(tp,LOCATION_ALL,0)
	local tc=dg:GetFirst()
	local coverid=Duel.GetRandomNumber(1,2)+2021020000
	while tc do
		--generate a cover for a card
		tc:Cover(coverid)
		tc=gd:GetNext()
	end
	Duel.ConfirmCards(tp,dg)
	Duel.ShuffleDeck(tp)
	Duel.ShuffleExtra(tp)
end

s.deck={}
	--Albuz Dogmatik
	s.deck[1]={
			--"Main Deck"
	22073844,69680031,69680031,69680031,13694209,95679145,68468459,68468459,45484331,45484331,45484331,55273560,55273560,60303688,60303688,60303688,14558127,14558127,14558127,40352445,40352445,48654323,48654323,1984618,1984618,1984618,34995106,44362883,31002402,31002402,60921537,24224830,65589010,10045474,10045474,10045474,29354228,82956214,82956214,82956214,
			--"Extra Deck"
	44146295,44146295,34848821,41373230,41373230,41373230,87746184,87746184,80532587,80532587,80532587,79606837,79606837,79606837,70369116}


	--Albuz Springans
	s.deck[2]={
			--"Main Deck"
	25451383,29601381,29601381,29601381,83203672,83203672,20424878,20424878,68468459,68468459,45484331,45484331,45484331,55273560,67436768,67436768,67436768,56818977,14558127,14558127,14558127,23499963,23499963,23499963,34995106,44362883,73628505,29948294,29948294,29948294,7496001,7496001,7496001,60884672,60884672,60884672,25415161,25415161,25415161,17751597,
			--"Extra Deck"
	44146295,44146295,70534340,1906812,1906812,1906812,41373230,87746184,90448279,62941499,62941499,62941499,48285768,48285768,70369116}
	




