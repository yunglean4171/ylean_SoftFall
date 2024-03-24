local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('ylean:removeitem')
AddEventHandler('ylean:removeitem', function()
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    player.Functions.RemoveItem(Ylean.Item.item_name, 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Ylean.Item.item_name], 'remove', 1)
end)