ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(5000)
	end
end)

local mainMenu = RageUI.CreateMenu("Barber Shop", "MENU", 0, 0, "commonmenu", "interaction_bgd", 0, 0, 0, 0)

local barber = false
mainMenu.EnableMouse = true
mainMenu.Closed = function() 
    barber = false
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        TriggerEvent('skinchanger:loadSkin', skin)
    end)
    FreezeEntityPosition(PlayerPedId(), false)
    RenderScriptCams(0, true, 1000)
    DestroyAllCams(true) 
    DestroyCam(cam, false)
end

function Barber()
    if barber then barber = false RageUI.Visible(mainMenu, false) return else barber = true RageUI.Visible(mainMenu, true)
        CreateThread(function()
		    while barber do
                Load()                    
                RageUI.IsVisible(mainMenu,function()
                    RageUI.List("Cheveux", G_Barber.List.Hair, G_Barber.Index.HI, nil, {}, true, {
                        onListChange = function(Index)
                            G_Barber.Index.HI = Index
                            TriggerEvent("skinchanger:change", "hair_1", G_Barber.Index.HI-1)
                        end
                    })
                    RageUI.List("Barbe", G_Barber.List.Beard, G_Barber.Index.BI, nil, {}, true, {
                        onListChange = function(Index)
                            G_Barber.Index.BI = Index
                            TriggerEvent("skinchanger:change", "beard_1", G_Barber.Index.BI-1)
                        end
                    })
                    RageUI.List("Sourcil", G_Barber.List.Eyebrows, G_Barber.Index.EI, nil, {}, true, {
                        onListChange = function(Index)
                            G_Barber.Index.EI = Index
                            TriggerEvent("skinchanger:change", "eyebrows_1", G_Barber.Index.EI-1)
                        end
                    })       
                    RageUI.List("Bouche", G_Barber.List.Lipstick, G_Barber.Index.LI, nil, {}, true, {
                        onListChange = function(Index)
                            G_Barber.Index.LI = Index
                            TriggerEvent("skinchanger:change", "lipstick_1", G_Barber.Index.LI-1)
                        end
                    })  
                    RageUI.List("Maquillage", G_Barber.List.Makeup, G_Barber.Index.MI, nil, {}, true, {
                        onListChange = function(Index)
                            G_Barber.Index.MI = Index
                            TriggerEvent("skinchanger:change", "makeup_1", G_Barber.Index.MI-1)
                        end
                    })      
                    RageUI.Button("Valider mon achat pour ~g~"..G_Barber.Price.."$", false, {RightLabel = "→", Color = {BackgroundColor = {0,150,0,150}}}, true, {
                        onSelected = function()
                            TriggerEvent('skinchanger:getSkin', function(skin)
                                TriggerServerEvent('esx_skin:save', skin)
                            end)
                            FreezeEntityPosition(PlayerPedId(), false)
                            RenderScriptCams(0, true, 1000)
                            DestroyAllCams(true) 
                            DestroyCam(cam, false)
                            TriggerServerEvent("G_Barber:buy", G_Barber.Price)
                            RageUI.CloseAll()
                            barber = false
                        end
                    })
                    RageUI.ColourPanel("Couleur Cheveux", RageUI.PanelColour.HairCut, G_Barber.Index.CHP[1], G_Barber.Index.CHP[2], {
                        onColorChange = function(MinimumIndex, CurrentIndex)                          
                            G_Barber.Index.CHP[1] = MinimumIndex
                            G_Barber.Index.CHP[2] = CurrentIndex
                            TriggerEvent("skinchanger:change", "hair_color_1",  G_Barber.Index.CHP[2]-1)
                        end
                    }, 1);
                    RageUI.ColourPanel("Nacrage Cheveux", RageUI.PanelColour.HairCut, G_Barber.Index.CHS[1], G_Barber.Index.CHS[2], {
                        onColorChange = function(MinimumIndex, CurrentIndex)                       
                            G_Barber.Index.CHS[1] = MinimumIndex
                            G_Barber.Index.CHS[2] = CurrentIndex
                            TriggerEvent("skinchanger:change", "hair_color_2", G_Barber.Index.CHS[2]-1)
                        end
                    }, 1);
                    RageUI.PercentagePanel(G_Barber.Index.BOI, 'Opacité', '0%', '100%', {
                        onProgressChange = function(i)                          
                            G_Barber.Index.BOI = i
                            TriggerEvent('skinchanger:change', 'beard_2', i*10)
                        end
                    }, 2);
                    RageUI.ColourPanel("Couleur Barbe", RageUI.PanelColour.HairCut, G_Barber.Index.CBP[1], G_Barber.Index.CBP[2], {
                        onColorChange = function(MinimumIndex, CurrentIndex)                           
                            G_Barber.Index.CBP[1] = MinimumIndex
                            G_Barber.Index.CBP[2] = CurrentIndex
                            TriggerEvent("skinchanger:change", "beard_3", G_Barber.Index.CBP[2]-1)
                        end
                    }, 2);
                    RageUI.ColourPanel("Nacrage Barbe", RageUI.PanelColour.HairCut, G_Barber.Index.CBS[1], G_Barber.Index.CBS[2], {
                        onColorChange = function(MinimumIndex, CurrentIndex)                       
                            G_Barber.Index.CBS[1] = MinimumIndex
                            G_Barber.Index.CBS[2] = CurrentIndex
                            TriggerEvent("skinchanger:change", "beard_4", G_Barber.Index.CBS[2]-1)
                        end
                    }, 2);
                    RageUI.PercentagePanel(G_Barber.Index.EOI, 'Opacité', '0%', '100%', {
                        onProgressChange = function(i)                        
                            G_Barber.Index.EOI = i
                            TriggerEvent('skinchanger:change', 'eyebrows_2', i*10)
                        end
                    }, 3);
                    RageUI.ColourPanel("Couleur Sourcil", RageUI.PanelColour.HairCut, G_Barber.Index.CEP[1], G_Barber.Index.CEP[2], {
                        onColorChange = function(MinimumIndex, CurrentIndex)                           
                            G_Barber.Index.CEP[1] = MinimumIndex
                            G_Barber.Index.CEP[2] = CurrentIndex 
                            TriggerEvent("skinchanger:change", "eyebrows_3", G_Barber.Index.CEP[2]-1)                  
                        end
                    }, 3);
                    RageUI.ColourPanel("Nacrage Sourcil", RageUI.PanelColour.HairCut, G_Barber.Index.CES[1], G_Barber.Index.CES[2], {
                        onColorChange = function(MinimumIndex, CurrentIndex)                        
                            G_Barber.Index.CES[1] = MinimumIndex
                            G_Barber.Index.CES[2] = CurrentIndex
                            TriggerEvent("skinchanger:change", "eyebrows_4", G_Barber.Index.CES[2]-1) 
                        end
                    }, 3);
                    RageUI.PercentagePanel(G_Barber.Index.LOI, 'Opacité', '0%', '100%', {
                        onProgressChange = function(i)                        
                            G_Barber.Index.LOI = i
                            TriggerEvent('skinchanger:change', 'lipstick_2', i*10)
                        end
                    }, 4);
                    RageUI.ColourPanel("Couleur Bouche", RageUI.PanelColour.HairCut, G_Barber.Index.CLP[1], G_Barber.Index.CLP[2], {
                        onColorChange = function(MinimumIndex, CurrentIndex)                         
                            G_Barber.Index.CLP[1] = MinimumIndex
                            G_Barber.Index.CLP[2] = CurrentIndex
                            TriggerEvent("skinchanger:change", "lipstick_3", G_Barber.Index.CLP[2]-1)
                        end
                    }, 4);
                    RageUI.ColourPanel("Nacrage Bouche", RageUI.PanelColour.HairCut, G_Barber.Index.CLS[1], G_Barber.Index.CLS[2], {
                        onColorChange = function(MinimumIndex, CurrentIndex)                        
                            G_Barber.Index.CLS[1] = MinimumIndex
                            G_Barber.Index.CLS[2] = CurrentIndex
                            TriggerEvent("skinchanger:change", "lipstick_4", G_Barber.Index.CLS[2]-1)
                        end                           
                    }, 4);
                    RageUI.PercentagePanel(G_Barber.Index.MOI, 'Opacité', '0%', '100%', {
                        onProgressChange = function(i)                  
                            G_Barber.Index.MOI = i                            
                            TriggerEvent('skinchanger:change', 'makeup_2', i*10)
                        end
                    }, 5);
                    RageUI.ColourPanel("Couleur Maquillage", RageUI.PanelColour.HairCut, G_Barber.Index.CMP[1], G_Barber.Index.CMP[2], {
                        onColorChange = function(MinimumIndex, CurrentIndex)                           
                            G_Barber.Index.CMP[1] = MinimumIndex
                            G_Barber.Index.CMP[2] = CurrentIndex
                            TriggerEvent('skinchanger:change', 'makeup_3', G_Barber.Index.CMP[2]-1)
                        end
                    }, 5);
                    RageUI.ColourPanel("Nacrage Maquillage", RageUI.PanelColour.HairCut, G_Barber.Index.CMS[1], G_Barber.Index.CMS[2], {
                        onColorChange = function(MinimumIndex, CurrentIndex)                         
                            G_Barber.Index.CMS[1] = MinimumIndex
                            G_Barber.Index.CMS[2] = CurrentIndex
                            TriggerEvent('skinchanger:change', 'makeup_4', G_Barber.Index.CMS[2]-1)
                        end
                    }, 5);
                end)
            Wait(0)
            end
        end)
    end
end

Citizen.CreateThread(function()
    while true do
        local wait = 900
        for k,v in pairs(G_Barber.Coords) do
            local coords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(coords.x, coords.y, coords.z, v.x, v.y, v.z)
            if dist <= 2.0 then 
                wait = 0
                DrawMarker(6, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.5, 0.5, 0.5, 220, 120, 0, 255, false, false, p19, false) 
                if dist <= 1.5 then 
                    wait = 0 
                    ESX.ShowHelpNotification("~INPUT_TALK~ pour ouvrir le ~b~Menu Coiffeur")
                    if IsControlJustPressed(1,51) then 
                        CreateCam() 
                        Barber()
                    end
                end
            end
        end
    Citizen.Wait(wait)
    end
end)

Citizen.CreateThread(function()
    for k,v in pairs(G_Barber.Coords) do
        local blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(blip, 71)
        SetBlipScale (blip, 0.7)
        SetBlipColour(blip, 17)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName('Coiffeur')
        EndTextCommandSetBlipName(blip)
    end
end)

function CreateCam()
	local coords = GetEntityCoords(GetPlayerPed(-1))
    cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', coords.x-0.8, coords.y-0.4, coords.z+0.7, 0.0, 0.0, 0.0, 40.0, true, true)
    PointCamAtCoord(cam, coords.x, coords.y, coords.z+0.6)
    RenderScriptCams(true, false, false, true, true)
end

function Load()
    FreezeEntityPosition(PlayerPedId(), true) 
    EnableControlAction(0, 47, true)   
    if IsDisabledControlPressed(0, 23) then
        SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId())-1.5)
    elseif IsDisabledControlPressed(0, 47) then
        SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId())+1.5)
    elseif IsDisabledControlPressed(0, 11) then
        SetCamFov(cam, GetCamFov(cam)+0.2)
    elseif IsDisabledControlPressed(0, 10) then
        SetCamFov(cam, GetCamFov(cam)-0.2)
    end
    mainMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 47, 0), [2] = "Tourner à Gauche"})
    mainMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 23, 0), [2] = "Tourner à Droite"}) 
    mainMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 11, 0), [2] = "Dézoom"})
    mainMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 10, 0), [2] = "Zoom"})
end
