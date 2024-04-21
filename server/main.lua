Grind = {}

Grind.Store = {}
Grind.ID = 0

RegisterServerEvent('pz-grind:additems')
AddEventHandler('pz-grind:additems', function(items, lucky, delete, entity)
    local src = source
    for _, value in pairs(items) do
        local luck = math.random(1, 10)
        local qt = 1
        if luck > lucky then
            qt = 3
        end
        if exports.ox_inventory:CanCarryItem(src, value, qt) then
            exports.ox_inventory:AddItem(src, value, qt)
        end
    end
end)

RegisterCommand('startdrop', function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == Config.AdminRole then
        local prop_name = args[1]
        local obj = Config.Objects[prop_name]
        Grind.Spawn(obj)
    end
end, true)

function Grind.Spawn(obj)
    Grind.Store[Grind.ID] = {}
    TriggerClientEvent('pz-grind:spawnchest:client', -1, Grind.ID, obj)
    Wait(500)
    TriggerClientEvent('pz-grind:notify:client', -1, obj)
    Grind.ID = Grind.ID + 1
end

RegisterServerEvent('pz-grind:spawnchest')
AddEventHandler('pz-grind:spawnchest', function()
    TriggerClientEvent('pz-grind:spawnchest:client', -1)
end)

RegisterServerEvent('pz-grind:store:add')
AddEventHandler('pz-grind:store:add', function(object, id)
    table.insert(Grind.Store[id], object)
    if Config.Debug then print("[PZ-GRIND] Added obj: ", json.encode(Grind.Store[id])) end
end)

RegisterServerEvent('pz-grind:store:delete')
AddEventHandler('pz-grind:store:delete', function(object, serverID)
    if Config.Debug then print('[PZ-GRIND] Objet to Delete: [ENTITY] :' .. object .. ' | [SERVER_ID] : ' .. serverID) end
    for _, clientID in pairs(Grind.Store[serverID]) do
        TriggerClientEvent('pz-grind:delete:client', -1, clientID)
    end
    Grind.Store[serverID] = nil
end)

function Grind.ScheduleSpawnChest(obj)
    if Config.Debug then print('[PZ-GRIND] Job scheduled: ', json.encode(obj)) end
    lib.cron.new(obj.cron, function()
        if Config.Debug then print('[PZ-GRIND] Start Job: ', json.encode(obj.id)) end
        local obj = Config.Objects[obj.id]
        Grind.Spawn(obj)
    end)
end

function Grind.Logger()
    CreateThread(function()
        while true do
            if Config.Debug then print('[PZ-GRIND] STORE: ', json.encode(Grind.Store)) end
            Wait(5000)
        end
    end)
end

function Grind.StartSchedule()
    CreateThread(function()
        if Config.Debug then print('[PZ-GRIND] SPAWNCHEST => Scheduled') end
        for _, obj in pairs(Config.ScheduledObj) do
            print(json.encode(obj))
            Grind.ScheduleSpawnChest(obj)
            Wait(200)
        end
    end)
end

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then
        return
    end
    print('[PZ-GRIND] Resource Started')
    Wait(500)
    if Config.Scheduled then
        Grind.StartSchedule()
    end
    if Config.Logger then
        Grind.Logger()
    end
end)
