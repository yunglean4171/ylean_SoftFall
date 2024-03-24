RegisterNetEvent('ylean:removeitem')
AddEventHandler('ylean:removeitem', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    xPlayer.removeInventoryItem(Ylean.Item.item_name, 1)
end)