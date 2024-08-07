local UIPrompt = {}
local promptGroup = GetRandomIntInRange(0, 0xffffff)

UIPrompt.activate = function(title)
    local label = CreateVarString(10, 'LITERAL_STRING', title)
    UiPromptSetActiveGroupThisFrame(promptGroup, label)
end

UIPrompt.initialize = function()
    local str = Translation[Config.Locale]['prompt_blowUp']
    BlowUp = UiPromptRegisterBegin()
    UiPromptSetControlAction(BlowUp, Config.Key)
    str = CreateVarString(10, 'LITERAL_STRING', str)
    UiPromptSetText(BlowUp, str)
    UiPromptSetEnabled(BlowUp, 1)
    UiPromptSetVisible(BlowUp, 1)
    UiPromptSetStandardMode(BlowUp, 1)
    UiPromptSetGroup(BlowUp, promptGroup)
    UiPromptSetUrgentPulsingEnabled(BlowUp, true)
    UiPromptRegisterEnd(BlowUp)
end

local function loadTrainCars(trainHash)
    local trainWagons = GetNumCarsFromTrainConfig(trainHash)
    for wagonIndex = 0, trainWagons - 1 do
        local trainWagonModel = GetTrainModelFromTrainConfigByCarIndex(trainHash, wagonIndex)
        RequestModel(trainWagonModel, 1)
        while not HasModelLoaded(trainWagonModel) do
            Citizen.Wait(100)
        end
    end
end

RegisterNetEvent('myBridge:client:BridgeFall', function()
    local ran = 0
    repeat
        local object = GetRayfireMapObject(GetEntityCoords(PlayerPedId()), 10000.0, 'des_trn3_bridge')
        SetStateOfRayfireMapObject(object, 4)
        Citizen.Wait(100)
        AddExplosion(521.13, 1754.46, 187.65, 28, 1.0, true, false, true)
        AddExplosion(507.28, 1762.3, 187.77, 28, 1.0, true, false, true)
        AddExplosion(527.21, 1748.86, 187.8, 28, 1.0, true, false, true)
        Citizen.Wait(100)
        SetStateOfRayfireMapObject(object, 6)
        ran = ran + 1
    until ran == 2

    Citizen.Wait(1000)
    local trainHash = joaat('engine_config')
    loadTrainCars(trainHash)
    local ghostTrain = CreateMissionTrain(trainHash, 499.69, 1768.78, 188.77, false, false, true, false)

    SetTrainSpeed(ghostTrain, 0.0)
    SetTrainCruiseSpeed(ghostTrain, 0.0)
    SetEntityVisible(ghostTrain, false)
    SetEntityCollision(ghostTrain, false, false)
end)

CreateThread(function()
    UIPrompt.initialize()
    while true do
        Citizen.Wait(0)
        local px, py, pz = table.unpack(GetEntityCoords(PlayerPedId()))
        if GetDistanceBetweenCoords(px, py, pz, Config.Setup.coords.x, Config.Setup.coords.y, Config.Setup.coords.z, true) < 2 then
            UIPrompt.activate(Translation[Config.Locale]['prompt_group'])
            if UiPromptHasStandardModeCompleted(BlowUp) then
                TriggerServerEvent('myBridge:server:BridgeFallHandler', false)
            end
        else
            Citizen.Wait(500)
        end
    end
end)