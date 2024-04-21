Config = {}
Config.Debug = true
Config.AdminRole = 'admin'
Config.Logger = true
Config.LootDistance = 5.0

Config.CD = 60000 * 2 -- 2 minuti,
Config.Label = 'Apri'
Config.RewardsLoot = {
    Common = { 'water', 'money' },
    Rare = { 'weapon_pistol' },
    Custom = { '' }
}

Config.CommonProps = {
    { id = 'prop_rub_carwreck_2',  items = Config.RewardsLoot.Common, lucky = 8 },
    { id = 'prop_rub_carwreck_3',  items = Config.RewardsLoot.Common, lucky = 8 },
    { id = 'prop_rub_carwreck_5',  items = Config.RewardsLoot.Common, lucky = 8 },
    { id = 'prop_rub_carwreck_7',  items = Config.RewardsLoot.Common, lucky = 8 },
    { id = 'prop_rub_carwreck_8',  items = Config.RewardsLoot.Common, lucky = 8 },
    { id = 'prop_rub_carwreck_9',  items = Config.RewardsLoot.Common, lucky = 8 },
    { id = 'prop_rub_carwreck_10', items = Config.RewardsLoot.Common, lucky = 8 },
    { id = 'prop_rub_carwreck_11', items = Config.RewardsLoot.Common, lucky = 8 },
    { id = 'prop_rub_carwreck_12', items = Config.RewardsLoot.Common, lucky = 8 },
    { id = 'prop_rub_carwreck_13', items = Config.RewardsLoot.Common, lucky = 8 },
    { id = 'prop_rub_carwreck_14', items = Config.RewardsLoot.Common, lucky = 8 },
    { id = 'prop_rub_carwreck_15', items = Config.RewardsLoot.Common, lucky = 8 },
    { id = 'prop_rub_carwreck_16', items = Config.RewardsLoot.Common, lucky = 8 },
    { id = 'prop_rub_carwreck_17', items = Config.RewardsLoot.Common, lucky = 8 },
}

Config.SpecialProps = {
    { id = 'p_cargo_chute_s', items = Config.RewardsLoot.Rare, lucky = 8 },
}

Config.NoLoot = {
    title = 'Attenzione',
    description = 'Non c\'è niente..',
    type = 'info'
}

Config.Looted = {
    title = 'Attenzione',
    description = 'L\'oggetto è stato aperto',
    type = 'info'
}

Config.Scheduled = false
Config.ScheduledObj = {
    ['chest'] = { id = 'chest', cron = "0 * * * *" } --0 * * * *" -- ogni 5 minuti
}

Config.RemoveBlipsTime = 30000

Config.Objects = {
    ['chest'] = {
        blipSprite = 587,
        blipColor = 46,
        blipScale = 0.9,
        blipName = "Drop",
        model = "p_cargo_chute_s",
        coords = vector4(-118.5184, -912.9965, 29.3554, 165.2040),
        downspeed = -10.0,
        hight = 500.0,
        message = {
            title = 'Attenzione',
            description = 'Sta cadendo una chest dal cielo...',
            type = 'success'
        },
    }
}
