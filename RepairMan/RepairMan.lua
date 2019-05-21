local addonName, addon = ...
--[[SLASH_RELOADUI1 = "/rlui";
SlashCmdList.RELOADUI = ReloadUI;]]
local repairManFrame = CreateFrame("FRAME", "repairManFrame")
local isEnabled
repairManFrame:RegisterEvent("MERCHANT_SHOW")
local RMO = CreateFrame('Frame', nil, InterfaceOptionsFramePanelContainer)
local title = RMO:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
local check = CreateFrame('CheckButton', "RMOCheck", RMO, "InterfaceOptionsCheckButtonTemplate")
if(checked == nil) then checked = true end

local function merchantShowHandler()
    if(CanMerchantRepair() and checked) then
        RepairAllItems()
    end 
end

local function checkboxOnClick(self)
    checked = self:GetChecked()
    PlaySound(checked and SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON or SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF)
    self:SetChecked(checked)
end

local function checkBoxOnShow(self)
    self:SetChecked(checked)
end

RMO:Hide()
RMO:SetAllPoints()
RMO.name = addonName

title:SetPoint("TOPLEFT", 16, -16)
title:SetText(RMO.name)
InterfaceOptions_AddCategory(RMO, addonName)

check:SetScript('OnShow', checkBoxOnShow)
check:SetScript('OnClick', checkboxOnClick)
getglobal(check:GetName() .. 'Text'):SetText("Enable Auto Repair");
check.tooltipText = 'Enable Auto Repair'

check:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -4)

repairManFrame:SetScript("OnEvent", merchantShowHandler)
