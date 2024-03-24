local function HasMagicShoes()
    local hasItem = ESX.SearchInventory(Ylean.Item.item_name, 1)
    if hasItem >= 1 then
        return true
    else
        return false
    end
  end

local isFalling = false
local startHeight = 0
local pressedSpace = false

local messageStates = {}

local function makeVulnerable()
    SetEntityInvincible(PlayerPedId(), false)
    SetPlayerInvincible(PlayerId(), false)
    SetPedCanRagdoll(PlayerPedId(), true)
    ClearPedLastWeaponDamage(PlayerPedId())
    SetEntityProofs(PlayerPedId(), false, false, false, false, false, false, false, false)
    SetEntityOnlyDamagedByPlayer(PlayerPedId(), false)
    SetEntityCanBeDamaged(PlayerPedId(), true)
end

local function makeInvicible()
    SetEntityInvincible(PlayerPedId(), true)
    SetPlayerInvincible(PlayerId(), true)
    SetPedCanRagdoll(PlayerPedId(), false)
    ClearPedBloodDamage(PlayerPedId())
    ResetPedVisibleDamage(PlayerPedId())
    ClearPedLastWeaponDamage(PlayerPedId())
    SetEntityProofs(PlayerPedId(), true, true, true, true, true, true, true, true)
    SetEntityOnlyDamagedByPlayer(PlayerPedId(), false)
    SetEntityCanBeDamaged(PlayerPedId(), false)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)

        local ped = PlayerPedId()
        if IsPedFalling(ped) then
            if not isFalling then
                isFalling = true
                startHeight = GetEntityHeightAboveGround(ped)
                pressedSpace = false

                if startHeight <= Ylean.MaximumHeight and startHeight > 10.0 then
                    if Ylean.Item.use_item and HasMagicShoes() then
                        makeInvicible()
                    elseif Ylean.Item.use_item and not HasMagicShoes() then
                        makeVulnerable()
                    else
                        makeInvicible()
                    end
                else
                    makeVulnerable()
                end
            elseif startHeight <= Ylean.MaximumHeight and startHeight > 7.0 then
                local currentHeight = GetEntityHeightAboveGround(ped)
                local remainingHeightPercentage = (currentHeight / startHeight) * 100

                if remainingHeightPercentage <= Ylean.FallActivationThresholdPercent and not pressedSpace then
                    if Ylean.Item.use_item and HasMagicShoes() or not Ylean.Item.use_item then
                        ShowTipOnScreen(1, "Press [SPACE] to cushion the fall!", 1500, 255, 0, 0, 255)
                        if IsControlJustPressed(1, 22) then
                            pressedSpace = true
                            CancelTipOnScreen(1)
                            ShowTipOnScreen(2, "You cushioned the fall", 1000, 0, 255, 68, 255)

                            if Ylean.Item.use_item and Ylean.Item.remove_item_after_cushion then
                                TriggerServerEvent('ylean:removeitem')
                            end
                        end
                    end
                end

                if remainingHeightPercentage <= Ylean.JumpCushionThresholdPercent and not pressedSpace then
                    makeVulnerable()
                    ApplyDamageToPed(ped, CalculateFallDamage(startHeight), false)
                end
            end
        else
            if isFalling then
                isFalling = false
                local endHeight = GetEntityHeightAboveGround(ped) - 1.0 
                local fallHeight = startHeight - endHeight

                if startHeight <= Ylean.MaximumHeight and startHeight > 10.0 then
                    if pressedSpace then
                        makeVulnerable()
                    end
                end
            end
        end 
    end
end)

function CalculateFallDamage(height)
    local minDamageHeight = 10.0
    local maxDamageHeight = Ylean.MaximumHeight
    local maxHealth = 200
    local damage = 0 

    if height > minDamageHeight then
        if height < maxDamageHeight then
            local damagePercentage = ((height - minDamageHeight) / (maxDamageHeight - minDamageHeight)) / 2
            damage = damagePercentage * maxHealth
        else
            damage = maxHealth
        end
    end

    return damage
end

function ShowTipOnScreen(messageId, message, displayTime, r, g, b, a)
    messageStates[messageId] = true

    Citizen.CreateThread(function()
        local endTime = GetGameTimer() + displayTime
        while GetGameTimer() < endTime and messageStates[messageId] do
            Citizen.Wait(0)
            SetTextFont(0)
            SetTextProportional(1)
            SetTextScale(0.0, 0.5)
            SetTextColour(r, g, b, a)
            SetTextDropshadow(0, 0, 0, 0, 255)
            SetTextEdge(1, 0, 0, 0, 255)
            SetTextDropShadow()
            SetTextOutline()
            SetTextCentre(true)
            SetTextEntry("STRING")
            AddTextComponentString(message)
            DrawText(0.5, 0.5)
        end

        messageStates[messageId] = nil
    end)
end

function CancelTipOnScreen(messageId)
    if messageStates[messageId] then
        messageStates[messageId] = false
    end
end