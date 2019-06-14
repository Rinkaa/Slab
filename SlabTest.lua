--[[

MIT License

Copyright (c) 2019 Mitchell Davis <coding.jackalope@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

--]]

local Slab = require('Slab')
local SlabDebug = require(SLAB_PATH .. '.SlabDebug')

local SlabTest = {}

local function DrawOverview()
	Slab.Textf(
		"Slab is an immediate mode GUI toolkit for the Love 2D framework. This library " ..
		"is designed to allow users to easily add this library to their existing Love 2D projects and " ..
		"quickly create tools to enable them to iterate on their ideas quickly. The user should be able " ..
		"to utilize this library with minimal integration steps and is completely written in Lua and utilizes " ..
		"the Love 2D API. No compiled binaries are required and the user will have access to the source so " ..
		"that they may make adjustments that meet the needs of their own projects and tools. Refer to main.lua " ..
		"and SlabTest.lua for example usage of this library.\n\n" ..
		"This window will demonstrate the usage of the Slab library and give an overview of all the supported controls " ..
		"and features.\n\n" ..
		"The current version of Slab is: " .. Slab.GetVersion())
end

local DrawButtons_NumClicked = 0
local DrawButtons_NumClicked_Invisible = 0
local DrawButtons_Enabled = false
local DrawButtons_Hovered = false

local function DrawButtons()
	Slab.Textf("Buttons are simple controls which respond to a user's left mouse click. Buttons will simply return true when they are clicked.")

	Slab.NewLine()

	if Slab.Button("Button") then
		DrawButtons_NumClicked = DrawButtons_NumClicked + 1
	end

	Slab.SameLine()
	Slab.Text("You have clicked this button " .. DrawButtons_NumClicked .. " time(s).")

	Slab.NewLine()
	Slab.Separator()

	Slab.Textf("Buttons can be tested for mouse hover with the call to Slab.IsControlHovered right after declaring the button.")
	Slab.Button(DrawButtons_Hovered and "Hovered" or "Not Hovered", {W = 100})
	DrawButtons_Hovered = Slab.IsControlHovered()

	Slab.NewLine()
	Slab.Separator()

	Slab.Textf(
		"Buttons can be aligned to fit on the right side of the of window. When multiple buttons are declared with this " ..
		"option set along with Slab.SameLine call, each button will be moved over to make room for the new aligned button.")

	Slab.Button("Cancel", {AlignRight = true})
	Slab.SameLine()
	Slab.Button("OK", {AlignRight = true})

	Slab.NewLine()
	Slab.Separator()

	Slab.Textf("Buttons can be set to expand to the size of the window.")
	Slab.Button("Expanded Button", {ExpandW = true})

	Slab.NewLine()
	Slab.Separator()

	Slab.Textf("Buttons can have a custom width and height.")
	Slab.Button("Square", {W = 75, H = 75})

	Slab.NewLine()
	Slab.Separator()

	Slab.Textf(
		"Buttons can also be invisible. Below is a rectangle with an invisible button so that the designer can " ..
		"implement a custom button but still rely on the button behavior. Below is a custom rectangle drawn with an " ..
		"invisible button drawn at the same location.")
	local X, Y = Slab.GetCursorPos()
	Slab.Rectangle({Mode = 'line', W = 50.0, H = 50.0, Color = {1, 1, 1, 1}})
	Slab.SetCursorPos(X, Y)

	if Slab.Button("", {Invisible = true, W = 50.0, H = 50.0}) then
		DrawButtons_NumClicked_Invisible = DrawButtons_NumClicked_Invisible + 1
	end

	Slab.SameLine({CenterY = true})
	Slab.Text("Invisible button has been clicked " .. DrawButtons_NumClicked_Invisible .. " time(s).")

	Slab.NewLine()
	Slab.Separator()

	Slab.Textf("Buttons can also be disabled. Click the button below to toggle the status of the neighboring button.")

	if Slab.Button("Toggle") then
		DrawButtons_Enabled = not DrawButtons_Enabled
	end

	Slab.SameLine()
	Slab.Button(DrawButtons_Enabled and "Enabled" or "Disabled", {Disabled = not DrawButtons_Enabled})
end

local DrawText_Width = 450.0
local DrawText_Alignment = {'left', 'center', 'right', 'justify'}
local DrawText_Alignment_Selected = 'left'
local DrawText_NumClicked = 0
local DrawText_NumClicked_TextOnly = 0

local function DrawText()
	Slab.Textf("Text controls displays text on the current window. Slab currently offers three ways to control the text.")

	Slab.NewLine()
	Slab.Separator()

	Slab.Text("The most basic text control is Slab.Text.")
	Slab.Text("The color of the text can be controlled with the 'Color' option.", {Color = {0, 1, 0, 1}})

	Slab.NewLine()
	Slab.Separator()

	Slab.Textf(
		"Text can be formatted using the Slab.Textf API. Formatted text will wrap the text based on the 'W' option. " ..
		"If the 'W' option is not specified, the window's width will be used as the width. Formatted text also has an " ..
		"alignment option.")

	Slab.NewLine()
	Slab.Text("Width")
	Slab.SameLine()
	if Slab.Input('DrawText_Width', {Text = tostring(DrawText_Width), NumbersOnly = true, ReturnOnText = false}) then
		DrawText_Width = Slab.GetInputNumber()
	end

	Slab.SameLine()
	Slab.Text("Alignment")
	Slab.SameLine()
	if Slab.BeginComboBox('DrawText_Alignment', {Selected = DrawText_Alignment_Selected}) then
		for I, V in ipairs(DrawText_Alignment) do
			if Slab.TextSelectable(V) then
				DrawText_Alignment_Selected = V
			end
		end

		Slab.EndComboBox()
	end

	Slab.Textf(
		"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore " ..
		"et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut " ..
		"aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum " ..
		"dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui " ..
		"officia deserunt mollit anim id est laborum.", {W = DrawText_Width, Align = DrawText_Alignment_Selected})

	Slab.NewLine()
	Slab.Separator()

	Slab.Textf(
		"Text can also be interacted with using the Slab.TextSelectable function. A background will be " ..
		"rendered when the mouse is hovered over the text and the function will return true when clicked on. " ..
		"The selectable area expands to the width of the window by default. This can be changed to just the text " ..
		"with the 'IsSelectableTextOnly' option.")

	Slab.NewLine()
	if Slab.TextSelectable("This text has been clicked " .. DrawText_NumClicked .. " time(s).") then
		DrawText_NumClicked = DrawText_NumClicked + 1
	end

	Slab.NewLine()
	if Slab.TextSelectable("This text has been clicked " .. DrawText_NumClicked_TextOnly .. " time(s).", {IsSelectableTextOnly = true}) then
		DrawText_NumClicked_TextOnly = DrawText_NumClicked_TextOnly + 1
	end

	Slab.NewLine()
	Slab.Separator()

	Slab.Textf("Text can also be centered horizontally within the bounds of the window.")

	Slab.NewLine()
	Slab.Text("Centered Text", {CenterX = true})
end

local DrawCheckBox_Checked = false
local DrawCheckBox_Checked_NoLabel = false

local function DrawCheckBox()
	Slab.Textf(
		"Check boxes are controls that will display an empty box with an optional label. The function will " ..
		"return true if the user has clicked on the box. The code is then responsible for updating the checked " ..
		"flag to be passed back into the function.")

	Slab.NewLine()
	if Slab.CheckBox(DrawCheckBox_Checked, "Check Box") then
		DrawCheckBox_Checked = not DrawCheckBox_Checked
	end

	Slab.NewLine()
	Slab.Text("A check box with no label.")
	if Slab.CheckBox(DrawCheckBox_Checked_NoLabel) then
		DrawCheckBox_Checked_NoLabel = not DrawCheckBox_Checked_NoLabel
	end
end

function SlabTest.MainMenuBar()
	if Slab.BeginMainMenuBar() then
		if Slab.BeginMenu("File") then
			if Slab.MenuItem("Quit") then
				love.event.quit()
			end

			Slab.EndMenu()
		end

		SlabDebug.Menu()

		Slab.EndMainMenuBar()
	end
end

local Categories = {
	{"Overview", DrawOverview},
	{"Buttons", DrawButtons},
	{"Text", DrawText},
	{"Check Box", DrawCheckBox}
}

local Selected = nil

function SlabTest.Begin()
	SlabTest.MainMenuBar()

	if Selected == nil then
		Selected = Categories[1]
	end

	Slab.BeginWindow('Main', {Title = "Slab", AutoSizeWindow = false, W = 800.0, H = 600.0})

	local W, H = Slab.GetWindowActiveSize()

	if Slab.BeginComboBox('Categories', {Selected = Selected[1], W = W}) then
		for I, V in ipairs(Categories) do
			if Slab.TextSelectable(V[1]) then
				Selected = Categories[I]
			end
		end

		Slab.EndComboBox()
	end

	Slab.Separator()

	if Selected ~= nil and Selected[2] ~= nil then
		Selected[2]()
	end

	Slab.EndWindow()

	SlabDebug.Begin()
end

return SlabTest
