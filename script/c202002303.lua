--Hozukimaru the Winter Cherry
Duel.LoadScript("bleach.lua")
local s,id=GetID()
function s.initial_effect(c)
	c:EnableUnsummonable()
	-- Equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_HAND+LOCATION_MZONE)
	e1:SetTarget(s.eqtg)
	e1:SetOperation(s.eqop)
	c:RegisterEffect(e1)
	--Double Piercing
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	local e3a=Effect.CreateEffect(c)
	e3a:SetDescription(aux.Stringid(id,0))
	e3a:SetCategory(CATEGORY_DESTROY)
	e3a:SetType(EFFECT_TYPE_TRIGGER_O)
	e3a:SetCode(EVENT_BATTLED)
	e3a:SetRange(LOCATION_MZONE)
	e3a:SetCountLimit(1,id^2)
	e3a:SetCondition(s.effcon)
	e3a:SetTarget(s.efftg)
	e3a:SetOperation(s.effop)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetTarget(s.effreg)
	e3:SetLabelObject(e3a)
	c:RegisterEffect(e3)
	
end
function s.eqfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x2010)
end
function s.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp)
		 and c~=chkc and s.filter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(s.filter,tp,LOCATION_MZONE,0,1,c) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,s.filter,tp,LOCATION_MZONE,0,1,1,c)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,c,1,0,0)
end
function s.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if c:IsLocation(LOCATION_MZONE) and c:IsFacedown() then return end
	local tc=Duel.GetFirstTarget()
	if Duel.GetLocationCount(tp,LOCATION_SZONE)>0 and tc
		and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.Equip(tp,c,tc,true)
		-- Equip limit
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetValue(function(e,c)return c==e:GetLabelObject()end)
		e1:SetLabelObject(tc)
		c:RegisterEffect(e1)
	else
		Duel.SendtoGrave(c,REASON_RULE)
	end
end






function s.effcon(e)
	local c=e:GetHandler()
	return (c:IsCode(202002041) or c:IsCode(id))
		and (Duel.GetAttacker()==c or Duel.GetAttackTarget()==c)
end
function s.efftg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	local tc=c:GetBattleTarget()
	if chk==0 then return tc and tc:IsControler(1-tp) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tc,1,0,0)

end
function s.effop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local tc=c:GetBattleTarget()
	if tc:IsRelateToBattle() then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function s.effreg(e,c)
	return e:GetHandler():GetEquipTarget()==c
end
