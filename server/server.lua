local VORPcore = exports.vorp_core:GetCore()
local VORPInv = exports.vorp_inventory:vorp_inventoryApi()
local BridgeDestroyed = false

RegisterServerEvent('myBridge:server:BridgeFallHandler', function(freshJoin)
    local src = source
    if not freshJoin and not BridgeDestroyed then
        local itemCount = VORPInv.getItemCount(src, Config.Setup.item)
        if itemCount >= Config.Setup.amount then
            VORPInv.subItem(src, Config.Setup.item, Config.Setup.amount)
            BridgeDestroyed = true
            VORPcore.NotifyAvanced(src, Translation[Config.Locale]['notify_timerStarts'], 'INVENTORY_ITEMS', 'ammo_dynamite_normal', 'COLOR_PURE_WHITE', 5000)
            Citizen.Wait(Config.Setup.timer)
            TriggerClientEvent('myBridge:client:BridgeFall', -1)
        else
            VORPcore.NotifyAvanced(src, Translation[Config.Locale]['notify_noDynamite'], 'INVENTORY_ITEMS', 'ammo_dynamite_normal', 'COLOR_PURE_WHITE', 5000)
        end
    elseif BridgeDestroyed then
        TriggerClientEvent('myBridge:client:BridgeFall', src)
    end
end)