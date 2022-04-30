local QBCore = exports['qb-core']:GetCoreObject()
local percentage = 0
local PriceReward = 0
local interact = 1
local itemtoremove = nil

exports['qb-target']:AddBoxZone("qb-drugdealing:moneywash", Config.WashLocation, 0.4, 2.5, {
	name = "qb-drugdealing:moneywash",
	heading = 160 ,
	debugPoly = false,
	minZ = 0,
	maxZ = 255,
}, {
	options = {
		{
            type = "client",
            event = "qb-drugdealing:client:openMoneyWashMenu",
			icon = "fas fa-circle",
			label = "Start Moneywashing",
            canInteract = function()
                if interact == 1 then return true else return false end 
            end
		},
		{
            type = "client",
            event = "qb-drugdealing:client:firststage",
			icon = "fas fa-circle",
			label = "Apply Acetone to Wash",
            canInteract = function()
                if interact == 2 then return true else return false end 
            end
		},
		{
            type = "client",
            event = "qb-drugdealing:client:secondstage",
			icon = "fas fa-circle",
			label = "Apply Cleaning Agent",
            canInteract = function()
                if interact == 3 then return true else return false end 
            end
		},
		{
            type = "client",
            event = "qb-drugdealing:client:thirdstage",
			icon = "fas fa-circle",
			label = "Apply Primer",
            canInteract = function()
                if interact == 4 then return true else return false end 
            end
		},
	},
	distance = 2.5
})

function playerAnim()
	loadAnimDict( "anim@gangops@facility@servers@" )
    TaskPlayAnim( PlayerPedId(), "anim@gangops@facility@servers@", "hotwire", -1, 1.0, -1, 49, 0, 0, 0, 0 )
end

function Minigame()
    local success = exports['qb-lock']:StartLockPickCircle(3, 15)
    if success then 
        QBCore.Functions.Notify("You successfully placed the item into the washer", 'error')
        percentage = percentage + 33
        interact = interact + 1
        itemtoremove = Config.NeededItem1
        TriggerServerEvent('qb-drugdealing:server:removeitem', itemtoremove)
        QBCore.Functions.Notify(Config.MoneyWashMessage3, 'error')
    else 
        QBCore.Functions.Notify("Your hand slipped and you spilt the item a bit.", 'error')
        percentage = percentage + 16
        interact = interact + 1
        itemtoremove = Config.NeededItem1
        TriggerServerEvent('qb-drugdealing:server:removeitem', itemtoremove)
        QBCore.Functions.Notify(Config.MoneyWashMessage3, 'error')
    end
end

function SecondMinigame()
    local success = exports['qb-lock']:StartLockPickCircle(3, 15)
    if success then 
        QBCore.Functions.Notify("You successfully used the item", 'error')
        percentage = percentage + 33
        interact = interact + 1
        itemtoremove = Config.NeededItem2
        TriggerServerEvent('qb-drugdealing:server:removeitem', itemtoremove)
        QBCore.Functions.Notify(Config.MoneyWashMessage4, 'error')
    else 
        QBCore.Functions.Notify("Your hand slipped and you spilt the item a bit.", 'error')
        percentage = percentage + 16
        interact = interact + 1
        itemtoremove = Config.NeededItem2
        TriggerServerEvent('qb-drugdealing:server:removeitem', itemtoremove)
        QBCore.Functions.Notify(Config.MoneyWashMessage4, 'error')
    end
end

function ThirdMinigame()
    local success = exports['qb-lock']:StartLockPickCircle(3, 15)
    if success then 
        QBCore.Functions.Notify("You successfully used the item", 'error')
        percentage = percentage + 34
        interact = interact + 1
        itemtoremove = Config.NeededItem3
        TriggerServerEvent('qb-drugdealing:server:removeitem', itemtoremove)
        TriggerEvent('qb-drugdealing:client:washdone')    
    else 
        QBCore.Functions.Notify("Your hand slipped and you spilt the item a bit.", 'error')
        percentage = percentage + 18
        interact = interact + 1
        itemtoremove = Config.NeededItem3
        TriggerServerEvent('qb-drugdealing:server:removeitem', itemtoremove)
        TriggerEvent('qb-drugdealing:client:washdone')
    end
end

RegisterNetEvent('qb-drugdealing:client:openMoneyWashMenu', function()
        local WashMenu = {
            {
                header = "Laundry Simulator 9000",
                isMenuHeader = true,
            },
            {
                header = "Wash your cash",
                txt = "Wash it!",
                params = {
                    event = "qb-drugdealing:client:openWash",
                    args = {
                        items = Config.WashList
                    }
                }
            }
        }
        exports['qb-menu']:openMenu(WashMenu)
end)

RegisterNetEvent('qb-drugdealing:client:openWash', function(data)
    QBCore.Functions.TriggerCallback('qb-drugdealing:server:getInv', function(inventory)
        local PlyInv = inventory
        local washMenu = {
            {
                header = "Laundry Washer 9000",
                isMenuHeader = true,
            }
        }

        for k,v in pairs(PlyInv) do
            for i = 1, #data.items do
                if v.name == data.items[i].item then
                    washMenu[#washMenu +1] = {
                        header = QBCore.Shared.Items[v.name].label,
                        txt = "Wash your dirty cash!",{value = data.items[i].price},
                        params = {
                            event = "qb-drugdealing:client:washitems",
                            args = {
                                label = QBCore.Shared.Items[v.name].label,
                                price = data.items[i].price,
                                name = v.name,
                                amount = v.amount
                            }
                        }
                    }
                end
            end
        end

        washMenu[#washMenu+1] = {
            header = "Go Back",
            params = {
                event = "qb-drugdealing:client:openMoneyWashMenu"
            }
        }
        exports['qb-menu']:openMenu(washMenu)
    end)
end)

RegisterNetEvent("qb-drugdealing:client:washitems", function(item)
    local sellingItem = exports['qb-input']:ShowInput({
        header = "Laundrymat Simulator 9000",
        submitText = "Wash your cash!",
        inputs = {
            {
                type = 'number',
                isRequired = false,
                name = 'amount',
                text = "Amount to wash", {value = item.amount}
            }
        }
    })

    if sellingItem then
        if not sellingItem.amount then
            return
        end

        if tonumber(sellingItem.amount) > 0 then
            TriggerEvent('qb-drugdealing:client:startMoneyWash', item.name, sellingItem.amount, item.price)
        else
            QBCore.Functions.Notify("You do not have that amount.", 'error')
        end
    end
end)


RegisterNetEvent('qb-drugdealing:client:startMoneyWash')
AddEventHandler('qb-drugdealing:client:startMoneyWash', function(item, amount, price)
    ItemReward = item
    AmountReward = amount
    PriceReward = price
    if Config.Minigame == "on" then
        playerAnim()
        QBCore.Functions.Progressbar("Moneywash", Config.MoneyWashMessage, Config.MinigameWaitTime*1000, false, true, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = true,
            disableCombat = true,
            }, {}, {}, {}, function()
                interact = interact + 1
                QBCore.Functions.Notify(Config.MoneyWashMessage2, 'error')
            end)
    elseif Config.Minigame == "off" then
        local player = PlayerPedId()
        playerAnim()
        QBCore.Functions.Progressbar("Moneywash", Config.MoneyWashMessage, Config.MinigameOffWaitTime*1000, false, true, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = true,
            disableCombat = true,
            }, {}, {}, {}, function()
            TriggerServerEvent('qb-drugdealing:server:ExchangeMoneyItems', item, amount, price)
            ClearPedTasksImmediately(player)
        end)
    end
end)


RegisterNetEvent('qb-drugdealing:client:firststage')
AddEventHandler('qb-drugdealing:client:firststage', function()
    QBCore.Functions.TriggerCallback('qb-drugdealing:server:CheckForItems', function(ItemData)
        if ItemData ~= nil then
            playerAnim()
            QBCore.Functions.Progressbar("Moneywash", Config.MoneyWashInteractonMessage, Config.MinigameWaitTime*1000, false, true, {
                disableMovement = true,
                disableCarMovement = false,
                disableMouse = true,
                disableCombat = true,
                }, {}, {}, {}, function()
                    Minigame()
                end)
        else
            QBCore.Functions.Notify("You do not have the correct items.", 'error')
        end
    end)
end)


RegisterNetEvent('qb-drugdealing:client:secondstage')
AddEventHandler('qb-drugdealing:client:secondstage', function()
    QBCore.Functions.TriggerCallback('qb-drugdealing:server:CheckForItemsSecond', function(ItemData)
        if ItemData ~= nil then
            playerAnim()
            QBCore.Functions.Progressbar("Moneywash", Config.MoneyWashInteractonMessage2, Config.MinigameWaitTime*1000, false, true, {
                disableMovement = true,
                disableCarMovement = false,
                disableMouse = true,
                disableCombat = true,
                }, {}, {}, {}, function()
                    SecondMinigame()
                end)
        else
            QBCore.Functions.Notify("You do not have the correct items.", 'error')
        end
    end)
end)

RegisterNetEvent('qb-drugdealing:client:thirdstage')
AddEventHandler('qb-drugdealing:client:thirdstage', function()
    QBCore.Functions.TriggerCallback('qb-drugdealing:server:CheckForItemsThird', function(ItemData)
        if ItemData ~= nil then
            playerAnim()
            QBCore.Functions.Progressbar("Moneywash", Config.MoneyWashInteractonMessage3, Config.MinigameWaitTime*1000, false, true, {
                disableMovement = true,
                disableCarMovement = false,
                disableMouse = true,
                disableCombat = true,
                }, {}, {}, {}, function()
                    ThirdMinigame()
                end)
        else
            QBCore.Functions.Notify("You do not have the correct items.", 'error')
        end
    end)
end)


RegisterNetEvent('qb-drugdealing:client:washdone')
AddEventHandler('qb-drugdealing:client:washdone', function()
    local rewardtogive = PriceReward/100
    local pricegiven = rewardtogive*percentage
    interact = 1
    TriggerServerEvent('qb-drugdealing:server:ExchangeMoneyItems', ItemReward, AmountReward, pricegiven)
end)