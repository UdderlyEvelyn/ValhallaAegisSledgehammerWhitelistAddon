local original = Valhalla.ContainerProtection["allowObjectDestruction"];

local function split(s, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={}
    for str in string.gmatch(s, "([^"..sep.."]+)") do
       table.insert(t, str)
    end
    return t
end

Valhalla.ContainerProtection["allowObjectDestruction"] = 
	function(self, object, player, mode)
		local objectName = object:getSprite():getName()				
		--print("[ValhallaAegis] Checking if \""..objectName.."\" is on the sledgehammer whitelist..")
		if SandboxVars.ValhallaAegis.SledgehammerWhitelist ~= nil and SandboxVars.ValhallaAegis.SledgehammerWhitelist ~= "" then
			local found = false
			for i,item in ipairs(split(SandboxVars.ValhallaAegis.SledgehammerWhitelist, ";")) do
				--print("[ValhallaAegis] Checking against whitelist item: \""..item.."\"..")
				if item == objectName then
					return true
				end
			end
			if not found then
				print("[ValhallaAegis] \""..objectName.."\" is not on the sledgehammer whitelist..")
				return false
			end
		end
		return original(self, object, player, mode)
	end