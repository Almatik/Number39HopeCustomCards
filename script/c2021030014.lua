--Blue-Eyes Maximum Dragon
local s,id=GetID()
function s.initial_effect(c)
	Maximum.AddProcedure(c,nil,s.filter1,s.filter2)
	c:AddMaximumAtkHandler()
	c:AddCenterToSideEffectHandler(e1)
end
s.MaximumAttack=4500
function s.filter1(c)
	return c:IsCode(89631145)
end
function s.filter2(c)
	return c:IsCode(57043986)
end