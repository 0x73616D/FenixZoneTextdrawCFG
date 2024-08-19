/*  ____     ____                        _                                    _    ___     ___     ___          
 |  _ \   / ___|  _      ___    __ _  | |__     ___   ____   ___    _ __   / |  / _ \   ( _ )   / _ \         
 | | | | | |     (_)    / __|  / _` | | '_ \   / _ \ |_  /  / _ \  | '_ \  | | | (_) |  / _ \  | (_) |        
 | |_| | | |___   _    | (__  | (_| | | |_) | |  __/  / /  | (_) | | | | | | |  \__, | | (_) |  \__, |        
 |____/   \____| (_)    \___|  \__,_| |_.__/   \___| /___|  \___/  |_| |_| |_|    /_/   \___/     /_/   _____ 
                                                                                                       |_____|
DISCORD: cabezon1989_																									   
*/
local imgui = require "imgui"
local encoding = require 'encoding'
local sampev = require 'lib.samp.events'
encoding.default = 'CP1252'
u8 = encoding.UTF8
local inicfg = require 'inicfg'
local directIni = 'txd.ini'
local mainIni = inicfg.load(inicfg.load({
    letra = {
        x = 500,
        y = 500,
        xs = 1,
        ys = 0.25
    },
}, directIni))
inicfg.save(mainIni, directIni)

local move = false
local guardado = false
local window = imgui.ImBool(false)
local sizex = imgui.ImFloat(mainIni.letra.xs)
local sizey = imgui.ImFloat(mainIni.letra.ys)

function main()
    while not isSampAvailable() do wait(0) end
   
    sampRegisterChatCommand('txdc', function()
		window.v = not window.v
		imgui.Process = window.v
	end)

	sampRegisterChatCommand('txdp', function()
		move = not move
	end)
    
    while true do
        wait(0)

        imgui.Process = 0        
		imgui.Process = window.v
	
		if not window.v then
			imgui.ShowCursor = false
		end        

        if sampIsLocalPlayerSpawned() and sampTextdrawIsExists(12) then
            guardado = true
            if guardado == true then        
                sampTextdrawSetPos(62, mainIni.letra.x, mainIni.letra.y)
                sampTextdrawSetLetterSizeAndColor(62 , sizex.v, sizey.v, -1)
                guardado = false
            end
        end

        if move == true then
            cursor()
            repeat
            wait(0)
            cursorx, cursory = getCursorPos()
            sampToggleCursor(1)
            mainIni.letra.x = cursorx
            mainIni.letra.y = cursory
            printStringNow(u8"Presiona ESPACIO para guardar la posicion.", 100)
            sampTextdrawSetPos(62, cursorx, cursory)
            if isKeyDown(27) then move = 0 end
            until isKeyDown(32)
            addOneOffSound(0, 0, 0, 1083)
            sampToggleCursor(0)
            sampSetCursorMode(0)                
            move = false            
            mainIni.letra.x = cursorx
            mainIni.letra.y = cursory
            inicfg.save(mainIni, directIni)
        end
    end
end

function imgui.OnDrawFrame()
	imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local icol = imgui.Col
    local ImVec4 = imgui.ImVec4
    local ImVec2 = imgui.ImVec2
  
    style.WindowPadding = ImVec2(15, 15)
    style.WindowRounding = 15.0
    style.FramePadding = ImVec2(5, 5)
    style.FrameRounding = 6.0
    style.ItemSpacing = ImVec2(7, 6)
    style.ItemInnerSpacing = ImVec2(8, 6)
    style.IndentSpacing = 25.0
    style.ScrollbarSize = 15.0
    style.ScrollbarRounding = 15.0
    style.GrabMinSize = 15.0
    style.GrabRounding = 7.0
    style.ChildWindowRounding = 8.0
    style.WindowTitleAlign = ImVec2(0.5, 0.5)
    style.ButtonTextAlign = ImVec2(0.5, 0.5)

	colors[icol.Text] = ImVec4(0.95, 0.96, 0.98, 1.00);
	colors[icol.TextDisabled] = ImVec4(0.65, 0.68, 0.70, 1.00);
	colors[icol.WindowBg] = ImVec4(0.07, 0.08, 0.09, 1.00);
	colors[icol.ChildWindowBg] = ImVec4(0.13, 0.15, 0.17, 1.00);
	colors[icol.PopupBg] = ImVec4(0.05, 0.06, 0.07, 0.94);
	colors[icol.Border] = ImVec4(0.25, 0.26, 0.27, 0.50);
	colors[icol.BorderShadow] = ImVec4(0.00, 0.00, 0.00, 0.00);
	colors[icol.FrameBg] = ImVec4(0.13, 0.15, 0.17, 1.00);
	colors[icol.FrameBgHovered] = ImVec4(0.25, 0.26, 0.27, 1.00);
	colors[icol.FrameBgActive] = ImVec4(0.29, 0.31, 0.33, 1.00);
	colors[icol.TitleBg] = ImVec4(0.09, 0.10, 0.11, 0.65);
	colors[icol.TitleBgCollapsed] = ImVec4(0.00, 0.00, 0.00, 0.51);
	colors[icol.TitleBgActive] = ImVec4(0.07, 0.08, 0.09, 1.00);
	colors[icol.MenuBarBg] = ImVec4(0.13, 0.15, 0.17, 1.00);
	colors[icol.ScrollbarBg] = ImVec4(0.05, 0.06, 0.07, 0.39);
	colors[icol.ScrollbarGrab] = ImVec4(0.25, 0.26, 0.27, 1.00);
	colors[icol.ScrollbarGrabHovered] = ImVec4(0.29, 0.31, 0.33, 1.00);
	colors[icol.ScrollbarGrabActive] = ImVec4(0.26, 0.51, 0.70, 1.00);
	colors[icol.ComboBg] = ImVec4(0.12, 0.14, 0.15, 1.00);
	colors[icol.CheckMark] = ImVec4(0.32, 0.69, 0.96, 1.00);
	colors[icol.SliderGrab] = ImVec4(0.32, 0.69, 0.96, 1.00);
	colors[icol.SliderGrabActive] = ImVec4(0.24, 0.51, 0.73, 1.00);
	colors[icol.Button] = ImVec4(0.12, 0.14, 0.15, 1.00);
	colors[icol.ButtonHovered] = ImVec4(0.32, 0.69, 0.96, 1.00);
	colors[icol.ButtonActive] = ImVec4(0.05, 0.42, 0.75, 1.00);
	colors[icol.Header] = ImVec4(0.12, 0.14, 0.15, 0.55);
	colors[icol.HeaderHovered] = ImVec4(0.24, 0.53, 0.77, 0.80);
	colors[icol.HeaderActive] = ImVec4(0.24, 0.53, 0.77, 1.00);
	colors[icol.ResizeGrip] = ImVec4(0.24, 0.53, 0.77, 0.25);
	colors[icol.ResizeGripHovered] = ImVec4(0.24, 0.53, 0.77, 0.67);
	colors[icol.ResizeGripActive] = ImVec4(0.06, 0.05, 0.07, 1.00);
	colors[icol.CloseButton] = ImVec4(0.29, 0.29, 0.29, 0.16);
	colors[icol.CloseButtonHovered] = ImVec4(0.29, 0.29, 0.29, 0.39);
	colors[icol.CloseButtonActive] = ImVec4(0.29, 0.29, 0.29, 1.00);
	colors[icol.PlotLines] = ImVec4(0.61, 0.61, 0.61, 1.00);
	colors[icol.PlotLinesHovered] = ImVec4(0.96, 0.32, 0.21, 1.00);
	colors[icol.PlotHistogram] = ImVec4(0.87, 0.67, 0.00, 1.00);
	colors[icol.PlotHistogramHovered] = ImVec4(0.98, 0.56, 0.00, 1.00);
	colors[icol.TextSelectedBg] = ImVec4(0.16, 0.72, 0.38, 0.43);
	colors[icol.ModalWindowDarkening] = ImVec4(0.12, 0.12, 0.12, 0.73);

	if not window.v then
        imgui.Process = false
    end

    if window.v then        
        sampSetChatInputEnabled(true)            
        imgui.ShowCursor = false
        local sw, sh = getScreenResolution()
		imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.4, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(600, 450), imgui.Cond.FirstUseEver)
		imgui.Begin('Tamaño Textdraw || By: cabezon1989_', window, imgui.WindowFlags.AlwaysAutoResize + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
		
		imgui.Text(u8"Tamaño X del textdraw")
		
		imgui.SameLine()

        if imgui.SliderFloat("##v", sizex, 0.10, 1)  then
            mainIni.letra.xs = round(sizex.v, 3)
            sampTextdrawSetLetterSizeAndColor(62 , sizex.v, sizey.v, -1)
            sampTextdrawSetProportional(12, 1)
            inicfg.save(mainIni, directIni)                
        end
        
        imgui.Separator() 
        imgui.Spacing() 
        
        imgui.Text(u8"Tamaño Y del textdraw")
        imgui.SameLine()
        
        if imgui.SliderFloat(u8"", sizey, 0.10, 1)  then
            mainIni.letra.ys = round(sizey.v, 3)
            sampTextdrawSetLetterSizeAndColor(62 , sizex.v, sizey.v, -1)
            sampTextdrawSetProportional(12, 1)
            inicfg.save(mainIni, directIni)                
        end 
		
		imgui.Separator()  
		imgui.End()
	end
end

function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

function cursor()
	local x, y = getScreenResolution()
	local x = x / 2
	local y = x / 2
	local y = y - -70
	local result, lib = loadDynamicLibrary("user32.dll")
	if result then
	local result, proc = getDynamicLibraryProcedure("SetCursorPos", lib)
	local a = callFunction(proc, 2, 0, x,y)
	freeDynamicLibrary(lib)
end
end

/*  ____     ____                        _                                    _    ___     ___     ___          
 |  _ \   / ___|  _      ___    __ _  | |__     ___   ____   ___    _ __   / |  / _ \   ( _ )   / _ \         
 | | | | | |     (_)    / __|  / _` | | '_ \   / _ \ |_  /  / _ \  | '_ \  | | | (_) |  / _ \  | (_) |        
 | |_| | | |___   _    | (__  | (_| | | |_) | |  __/  / /  | (_) | | | | | | |  \__, | | (_) |  \__, |        
 |____/   \____| (_)    \___|  \__,_| |_.__/   \___| /___|  \___/  |_| |_| |_|    /_/   \___/     /_/   _____ 
                                                                                                       |_____|
DISCORD: cabezon1989_																									   
*/