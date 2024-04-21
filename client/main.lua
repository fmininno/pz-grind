Grind = {
    Looted = {},
    GloabalCD = Config.CD,
    ServerID = {}
}

CreateThread(function()
    for _, prop in pairs(Config.CommonProps) do
        exports.ox_target:addModel(prop.id,
            {
                {
                    name = Config.Label,
                    icon = 'fa-solid fa-hand fa-bounce',
                    label = Config.Label,
                    onSelect = function(data)
                        Grind.Loot(data, prop.items, prop.lucky, false)
                    end,
                    canInteract = function(entity, distance, coords, name, bone)
                        return IsPedDeadOrDying(entity, true) and distance < Config.LootDistance
                    end
                }
            })
    end
    for _, prop in pairs(Config.SpecialProps) do
        exports.ox_target:addModel(prop.id,
            {
                {
                    name = Config.Label,
                    icon = 'fa-solid fa-hand fa-bounce',
                    label = Config.Label,
                    onSelect = function(data)
                        Grind.Loot(data, prop.items, prop.lucky, true)
                    end,
                    canInteract = function(entity, distance, coords, name, bone)
                        return IsPedDeadOrDying(entity, true) and distance < Config.LootDistance
                    end
                }
            })
    end
end)

function Grind.Loot(data, items, lucky, delete)
    if DoesEntityExist(data.entity) then
        if lib.table.contains(Grind.Looted, data.entity) then
            lib.notify(Config.NoLoot)
        else
            TriggerServerEvent('pz-grind:additems', items, lucky, delete, data.entity)
            if not delete then
                table.insert(Grind.Looted, data.entity)
                StartCdThread()
            else
                TriggerServerEvent('pz-grind:store:delete', data.entity, Grind.ServerID[data.entity])
                Wait(200)
                Grind.ServerID[data.entity] = nil
            end
        end
    end
end

RegisterNetEvent("pz-grind:spawnchest:client", function(ID, obj)
    local prop = obj
    ESX.Streaming.RequestModel(GetHashKey(prop.model))
    Wait(100)
    while not HasModelLoaded(prop.model) do
        Wait(1)
    end
    local created_object = CreateObject(GetHashKey(prop.model), prop.coords.x, prop.coords.y,
        prop.coords.z,
        0,
        0, true)
    SetEntityCoords(created_object, prop.coords.x, prop.coords.y, prop.coords.z + prop.hight,
        true, true, true, false)
    SetEntityVelocity(created_object, 0.0, 0.0, prop.downspeed)
    Grind.ServerID[created_object] = ID
    TriggerServerEvent('pz-grind:store:add', created_object, ID)
end)

RegisterNetEvent("pz-grind:notify:client", function(obj)
    local prop = obj
    local blip = AddBlipForCoord(prop.coords.x, prop.coords.y, prop.coords.z)
    SetBlipSprite(blip, prop.blipSprite)
    SetBlipColour(blip, prop.blipColor)
    SetBlipScale(blip, prop.blipScale)
    SetBlipAsShortRange(blip, true)
    SetBlipDisplay(blip, 4)
    SetBlipShowCone(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(prop.blipName)
    EndTextCommandSetBlipName(blip)
    lib.notify(prop.message)
    SetTimeout(Config.RemoveBlipsTime, function()
        RemoveBlip(blip)
    end)
end)

RegisterNetEvent("pz-grind:delete:client", function(obj)
    if DoesEntityExist(obj) then
        lib.notify(Config.Looted)
        DeleteEntityGrind(obj)
    end
end)

-- utils
function StartCdThread()
    CreateThread(function()
        Wait(Grind.GloabalCD)
        table.remove(Grind.Looted)
    end)
end

function DeleteEntityGrind(entity)
    if DoesEntityExist(entity) then
        SetEntityAsMissionEntity(entity, false, true)
        DeleteEntity(entity)
    end
end
