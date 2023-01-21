function notification(text)
    BeginTextCommandThefeedPost('STRING')
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandThefeedPostTicker(0,1)
end

local RockstarEditorMenu = RageUI.CreateMenu("", "Options", nil, nil, "rageui_banner", "banner_editor") --"TeapotBanner"
RockstarEditorMenu.EnableMouse = false;
local EditorRecording = false

function RageUI.PoolMenus:MenuRockstarEditor()
    RockstarEditorMenu:IsVisible(function(Items)
        if EditorRecording then
            Items:AddButton("Arrêter et ~g~sauvegarder~s~", nil, { IsDisabled = false, RightLabel = "" }, function(onSelected)
                if (onSelected) then
                    StopRecordingAndSaveClip()
                    EditorRecording = not(EditorRecording)
                    Items:CloseAllMenu()
                end
            end)
            Items:AddButton("Arrêter et ~r~supprimer~s~", nil, { IsDisabled = false, RightLabel = "" }, function(onSelected)
                if (onSelected) then
                    StopRecordingAndDiscardClip()
                    notification("~p~Editeur~s~\nL'enregistrement à bien été ~r~supprimé~s~ !")
                    EditorRecording = not(EditorRecording)
                    Items:CloseAllMenu()
                end
            end)
        elseif EditorRecording == false then
            Items:AddButton("Commencer l'enregistrement", nil, { IsDisabled = false, RightLabel = "→" }, function(onSelected)
                if (onSelected) then
                    EditorRecording = not(EditorRecording)
                    StartRecording(1)
                    Items:CloseAllMenu()
                end
            end)
            Items:AddLine()
            Items:AddButton("Editeur", "Voir et éditer les enregistrements sauvegardés !", { IsDisabled = false, RightLabel = "" }, function(onSelected)
                if (onSelected) then
                    NetworkSessionLeaveSinglePlayer()
                    ActivateRockstarEditor()
                    Items:CloseAllMenu()
                end
            end)
        end
    end, function()
    end)
end

RegisterCommand("editor",function()
    if not(IsEntityDead(PlayerPedId())) then
        RageUI.Visible(RockstarEditorMenu, not RageUI.Visible(RockstarEditorMenu))
    end
end)