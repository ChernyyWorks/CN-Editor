function notification(text)
    BeginTextCommandThefeedPost('STRING')
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandThefeedPostTicker(0,1)
end

local RockstarEditorMenu = RageUI.CreateMenu("", "Options", nil, nil, "rageui_banner", "banner_editor")
RockstarEditorMenu.EnableMouse = false;
local EditorRecording = false

function RageUI.PoolMenus:MenuRockstarEditor()
    RockstarEditorMenu:IsVisible(function(Items)
        if EditorRecording then
            Items:AddButton(Translation["StopAndSave"], nil, { IsDisabled = false, RightLabel = "" }, function(onSelected)
                if (onSelected) then
                    StopRecordingAndSaveClip()
                    notification(Translation["ClipSave"])
                    EditorRecording = not(EditorRecording)
                    Items:CloseAllMenu()
                end
            end)
            Items:AddButton(Translation["StopAndDiscard"], nil, { IsDisabled = false, RightLabel = "" }, function(onSelected)
                if (onSelected) then
                    StopRecordingAndDiscardClip()
                    notification(Translation["ClipDiscard"])
                    EditorRecording = not(EditorRecording)
                    Items:CloseAllMenu()
                end
            end)
        elseif EditorRecording == false then
            Items:AddButton(Translation["StartRecording"], nil, { IsDisabled = false, RightLabel = "→" }, function(onSelected)
                if (onSelected) then
                    EditorRecording = not(EditorRecording)
                    StartRecording(1)
                    Items:CloseAllMenu()
                end
            end)
            Items:AddLine()
            Items:AddButton(Translation["Editor"], Translation["EditYourClip"], { IsDisabled = false, RightLabel = "" }, function(onSelected)
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
    else
        notification(Translation["CantOpen"])
    end
end)

if AllowKeymapping then
    if oxlib then
        local keybind = lib.addKeybind({
            name = 'cn_editor:recording',
            description = 'Recording',
            defaultKey = '',
            onReleased = function(self)
                if EditorRecording then
                    -- Stop and Save
                    StopRecordingAndSaveClip()
                    notification(Translation["ClipSave"])
                    EditorRecording = not(EditorRecording)
                else
                    EditorRecording = not(EditorRecording)
                    StartRecording(1)
                end
            end,
        })
    end
end