--[=[
Give VIP players additional weapons of the profession, if they are in the profession.
Documentation:
1. Configure the VIP groups below or use the link to your own meta table.
2. Add vipweapons = {"weapon_one", "weapon_two"} to job in jobs.lua
Example:
TEAM_CITIZEN = DarkRP.createJob("Citizen", {
    color = Color(20, 150, 20, 255),
    model = {
        "models/player/Group01/Female_01.mdl",
        "models/player/Group01/Female_02.mdl",
        "models/player/Group01/Female_03.mdl",
        "models/player/Group01/Female_04.mdl",
        "models/player/Group01/Female_06.mdl",
        "models/player/group01/male_01.mdl",
        "models/player/Group01/Male_02.mdl",
        "models/player/Group01/male_03.mdl",
        "models/player/Group01/Male_04.mdl",
        "models/player/Group01/Male_05.mdl",
        "models/player/Group01/Male_06.mdl",
        "models/player/Group01/Male_07.mdl",
        "models/player/Group01/Male_08.mdl",
        "models/player/Group01/Male_09.mdl"
    },
    description = [[The Citizen is the most basic level of society you can hold besides being a hobo. You have no specific role in city life.]],
    weapons = {},
    vipweapons = {"weapon_rpg", "weapon_pistol"},
    command = "citizen",
    max = 0,
    salary = GAMEMODE.Config.normalsalary,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Citizens",
})
]=]

-- Setting, set VIP group here.
local vips = {
    ["superadmin"] = true,
    ["vip"] = true,
}

local plymeta = FindMetaTable("Player")

-- Check player is VIP or not.
function plymeta:IsVIPtoWeapons()
    if vips[self:GetUserGroup()] then return true end
end

-- Give weapon to player after player spawn.
hook.Add("PlayerLoadout", "PlayerLoadoutVIP", function(ply)
    -- You can use another meta.
    -- https://wiki.facepunch.com/gmod/Player:IsAdmin
    if ply:IsVIPtoWeapons() then
        local jobTable = ply:getJobTable()

        for _, v in pairs(jobTable.vipweapons or {}) do
            ply:Give(v)
            -- Set current properties weapon to nodrop.
            ply:GetWeapon(v).fromvip = true
        end
    end
end)

-- Break drop weapon when is a vip.
hook.Add("canDropWeapon", "CanDropWeaponVIP", function(ply, wep)
    if wep.fromvip then return false end
end)
