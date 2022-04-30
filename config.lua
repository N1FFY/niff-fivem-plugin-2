Config = {}

-------- MONEY WASHING CONFIG --------
Config.Minigame = "on" -- For if you want to stop AFK idling washing. 5 minigames will pop up and they get 20% per game. [on or off]
Config.WashLocation = vector3(1135.97, -989.41, 46.11)
Config.WashRewardType = "bank"


-------- MINIGAME CONFIG --------
Config.HackTime = 60
Config.MinigameWaitTime = 15
Config.MinigameOffWaitTime = 300 -- If the minigame is disabled, make people wait 5 minutes in order to wash
Config.MoneyWashMessage = "Placing cash into washer."
Config.MoneyWashMessage2 = "You need to place the Acetone into the washer."
Config.MoneyWashMessage3 = "You need to dilute the acetone."
Config.MoneyWashMessage4 = "You need to add the final primer."

Config.MoneyWashInteractonMessage = "Pouring Acetone into the washer"
Config.MoneyWashInteractonMessage2 = "Diluting the Acetone"
Config.MoneyWashInteractonMessage3 = "Pouring Primer into the washer"

Config.NeededItem1 = "acetone"
Config.NeededItem2 = "water_bottle"
Config.NeededItem3 = "primer"
------- MONEY WASHING MESSAGES --------
Config.CollectMessage = "You collected your dirty laundry"


----- MONEY WASH ITEMS AND VALUES ------
Config.WashList = {
    [1] = {
        item = "markedbills",
        price = 1000
    },
    [2] = {
        item = "stackofnotes",
        price = 5000
    },
    [3] = {
        item = "inkedbills",
        price = 10000
    },
}
