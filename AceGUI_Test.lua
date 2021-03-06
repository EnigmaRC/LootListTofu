--local AceGUI = LibStub("AceGUI-3.0");

--
--local frame = AceGUI:Create("Frame");
--frame:SetTitle("Example Frame");
--frame:SetStatusText("AceGUI-3.0 Example Container Frame");
--print("hi");

WelcomeHome = LibStub("AceAddon-3.0"):NewAddon("WelcomeHome", "AceConsole-3.0", "AceEvent-3.0");

local options = {
    name = "WelcomeHome",
    handler = WelcomeHome,
    type = 'group',
    args = {
        msg = {
            type = "input",
            name = "Message",
            desc = "The message to be displayed when you get home.",
            usage = "<Your message>",
            get = "GetMessage",
            set = "SetMessage",
        },
        showInChat = {
            type = "toggle",
            name = "Show in Chat",
            desc = "Toggles the display of the messages in the chat window.",
            get = "IsShowInChat",
            set = "ToggleShowInChat",
        },
        showOnScreen = {
            type = "toggle",
            name = "Show on Screen",
            desc = "Toggles the display of the messages on the screen.",
            get = "IsShowOnScreen",
            set = "ToggleShowOnScreen",
        }
    },
}

local defaults = {
    profile = {
        message = "Welcome Home!",
        showInChat = true,
        showOnScreen = true,
    },
}

function WelcomeHome:OnInitialize()
    -- Called when the addon is loaded
    self.db = LibStub("AceDB-3.0"):New("LootListTofuDB", defaults, true)

    LibStub("AceConfig-3.0"):RegisterOptionsTable("WelcomeHome", options)
    self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("WelcomeHome", "WelcomeHome")
    self:RegisterChatCommand("wh", "ChatCommand")
    self:RegisterChatCommand("welcomehome", "ChatCommand")
end

function WelcomeHome:OnEnable()
    -- Called when the addon is enabled
    self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
end

function WelcomeHome:ZONE_CHANGED_NEW_AREA()
    if GetBindLocation() == GetZoneText() then
        if self.db.profile.showInChat then
            self:Print(self.db.profile.message)
            self:Print(self.db.profile.showInChat)
            self:Print(self.db.profile.showOnScreen)
        end

        if self.db.profile.showOnScreen then
            UIErrorsFrame:AddMessage(self.db.profile.message, 1.0, 1.0, 1.0, 5.0)
        end
    end
end

function WelcomeHome:ChatCommand(input)
    if not input or input:trim() == "" then
        InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
        InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
    else
        LibStub("AceConfigCmd-3.0"):HandleCommand("wh", "WelcomeHome", input)
    end
end

function WelcomeHome:GetMessage(info)
    return self.db.profile.message
end

function WelcomeHome:SetMessage(info, newValue)
    self.db.profile.message = newValue
end

function WelcomeHome:IsShowInChat(info)
    return self.db.profile.showInChat
end

function WelcomeHome:ToggleShowInChat(info, value)
    self.db.profile.showInChat = value
end

function WelcomeHome:IsShowOnScreen(info)
    return self.db.profile.showOnScreen
end

function WelcomeHome:ToggleShowOnScreen(info, value)
    self.db.profile.showOnScreen = value
end





