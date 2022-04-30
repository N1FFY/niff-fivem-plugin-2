local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-drugdealing:server:ExchangeMoneyItems', function(item, amount, price)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        local hasItem = Player.Functions.GetItemByName(item)
        local amountNum = tonumber(amount)
        if hasItem.amount >= amountNum then
            local reward = price*amount
            Player.Functions.RemoveItem(item, amountNum)
			Player.Functions.AddMoney(Config.WashRewardType, reward, "sold-moneywash")
            TriggerClientEvent('QBCore:Notify', src, Config.CollectMessage)
        else
            TriggerClientEvent('QBCore:Notify', src, "You don't have the amount you specified.")
        end
    end
end)

RegisterServerEvent('qb-drugdealing:server:removeitem')
AddEventHandler('qb-drugdealing:server:removeitem', function(itemtoremove)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	Player.Functions.RemoveItem(itemtoremove, 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[itemtoremove], "remove")
end)

RegisterServerEvent('qb-drugdealing:server:HackFailed')
AddEventHandler('qb-drugdealing:server:HackFailed', function()
	TriggerClientEvent('QBCore:Notify', source, Config.HackFailed)
end)

RegisterServerEvent('qb-drugdealing:server:HackTimedOut')
AddEventHandler('qb-drugdealing:server:HackTimedOut', function()
	TriggerClientEvent('QBCore:Notify', source, Config.HackTimedOut)
end)

RegisterServerEvent('qb-drugdealing:server:HackError')
AddEventHandler('qb-drugdealing:server:HackError', function()
	TriggerClientEvent('QBCore:Notify', source, Config.HackError)
end)


QBCore.Functions.CreateCallback('qb-drugdealing:server:getInv', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local inventory = Player.PlayerData.items

    return cb(inventory)
end)

QBCore.Functions.CreateCallback('qb-drugdealing:server:CheckForItems', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local inventory = Player.PlayerData.items
    local ItemData = Player.Functions.GetItemByName(Config.NeededItem1)
    return cb(ItemData)
end)

QBCore.Functions.CreateCallback('qb-drugdealing:server:CheckForItemsSecond', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local inventory = Player.PlayerData.items
    local ItemData = Player.Functions.GetItemByName(Config.NeededItem2)
    return cb(ItemData)
end)

QBCore.Functions.CreateCallback('qb-drugdealing:server:CheckForItemsThird', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local inventory = Player.PlayerData.items
    local ItemData = Player.Functions.GetItemByName(Config.NeededItem3)
    return cb(ItemData)
end)