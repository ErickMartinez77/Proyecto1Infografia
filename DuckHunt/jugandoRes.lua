local composer = require( "composer" )
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local grupo_fondo, grupo_intermedio,grupo_intermedio2 ,grupo_delantero,grupo_delantero2

-- IMAGENES
local cielo_fondo 
local arbol1
local arbol2
local cesped 
local mira
local miraX = CW*0.50
local miraY = CH*0.50
local arma
local radio_mira = 50
local perroConPatos
-- VARIABLES
local patos = {}
local total_patos = 5
local kills = 0
local total_balas = 6
local balas = 6
local score = 0

-- AUDIOS
local shot = audio.loadSound("disparo.mp3")
local empty_shot = audio.loadSound( "empty.mp3" )
local pato_volando = audio.loadSound("pato_volando.mp3")

local destello
--TEXTO
local texto_balas
local texto_kills
local texto_score


local moverPatosI
local moverMiraI
local moverArmaI
local moverPatoMuertoI
local subirPerroConPatosI
local bajarPerroConPatosI
 

function crear_patos()
    for i = 1, total_patos,1 do
        patos[i] = display.newImageRect( grupo_intermedio,"pato.png", 100, 100 )
        patos[i].x = math.random( 40, CW-40)
        patos[i].y = CH-50
        --patos[i].x = CW/2
        --patos[i].y = CH/2
        patos[i].id = i
        patos[i]:scale( -1, 1 )
    end
end

function moverPatos(event)
    for i = 1, total_patos,1 do
        transition.to(patos[i],{x = math.random(0,CW), y = math.random(0,CH), time = 1100})
    end
end

function moverMira(event)
    transition.to( mira, {x = math.random(0,CW), y = math.random(0,CH),time = 1100} )
end

function calcularAng()
    local h = math.sqrt((math.pow(mira.x - arma.x,2) + math.pow(mira.y - arma.y,2)))
    local co = mira.x - arma.x 
    local angulo = math.asin(co/h)
    return ((angulo * 180) / math.pi)
end

function moverArma(event)
    arma.rotation = calcularAng()
end

Runtime:addEventListener("enterFrame", moverArma)

function subirPerro()
    transition.to( perroConPatos, {y = CH*0.60} )
end

function bajarPerro()
    transition.to( perroConPatos, {y = CH*0.95} )
end

function win()
    audio.pause( pato_volando )
    composer.gotoScene( "win" , {
        effect = "slideLeft",
        time = 2000
        })
    return true
end

function finDelJuego()
    audio.pause( pato_volando )
    composer.gotoScene( "fin" , {
        effect = "slideRight",
        time = 2000
        })
    return true
end

function disparar(event)
    if event.phase == "ended" then
        --print("ESTOY DISPARANDO")
        --print("Radio mira= ",mira.ratio)
        if balas > 0 then
            audio.play( shot )
            destello = display.newImageRect( grupo_delantero2, "destello.jpg", CW+200 , CH )
            destello.x = CW/2
            destello.y = CH/2
            transition.to( destello, {alpha=0.01} )

            -- for
            -- if pato ~=nil

            --for i =1,#patos do
                --if patos[i] ~= nil then
                    --patos[i]:removeSelf( )
                    --patos[i] = nil
                --end
            --end
            --Verifica que el pato este dentro de la mira
            local d1 = math.sqrt( math.pow( patos[1].x-mira.x,2) + math.pow( patos[1].y-mira.y, 2 ))
            local d2 = math.sqrt( math.pow( patos[2].x-mira.x,2) + math.pow( patos[2].y-mira.y, 2 ))
            local d3 = math.sqrt( math.pow( patos[3].x-mira.x,2) + math.pow( patos[3].y-mira.y, 2 ))
            local d4 = math.sqrt( math.pow( patos[4].x-mira.x,2) + math.pow( patos[4].y-mira.y, 2 ))
            local d5 = math.sqrt( math.pow( patos[5].x-mira.x,2) + math.pow( patos[5].y-mira.y, 2 ))
            --print("D1:",d1)
            if d1 < mira.ratio then 
                score = score + 500
                texto_score.text = "SCORE: "..score
                balas = balas-1
                texto_balas.text = "BALAS: "..balas
                kills = kills+1
                texto_kills.text = "KILLS: "..kills
                patos[1]:removeSelf( )
                --patos[1] = nil
                print("Pato 1 muerto")
                subirPerroConPatosI = timer.performWithDelay( 500, subirPerro, 2)
                bajarPerroConPatosI = timer.performWithDelay( 500, bajarPerro, 2)
            elseif d2 < mira.ratio then
                score = score + 500
                texto_score.text = "SCORE: "..score
                balas = balas-1
                texto_balas.text = "BALAS: "..balas
                kills = kills+1
                texto_kills.text = "KILLS: "..kills
                patos[2]:removeSelf( )
                --patos[2] = nil
                print("Pato 2 muerto")
                subirPerroConPatosI = timer.performWithDelay( 500, subirPerro, 2)
                bajarPerroConPatosI = timer.performWithDelay( 500, bajarPerro, 2)
            elseif d3 < mira.ratio then 
                score = score + 500
                texto_score.text = "SCORE: "..score
                balas = balas-1
                texto_balas.text = "BALAS: "..balas
                kills = kills+1
                texto_kills.text = "KILLS: "..kills
                patos[3]:removeSelf( )
                --patos[3] = nil  
                print("Pato 3 muerto") 
                subirPerroConPatosI = timer.performWithDelay( 500, subirPerro, 2)
                bajarPerroConPatosI = timer.performWithDelay( 500, bajarPerro, 2)
            elseif d4 < mira.ratio then
                score = score + 500
                texto_score.text = "SCORE: "..score
                balas = balas-1
                texto_balas.text = "BALAS: "..balas
                kills = kills+1
                texto_kills.text = "KILLS: "..kills
                patos[4]:removeSelf( ) 
                --patos[4] = nil
                print("Pato 4 muerto")
                subirPerroConPatosI = timer.performWithDelay( 500, subirPerro, 2)
                bajarPerroConPatosI = timer.performWithDelay( 500, bajarPerro, 2)
            elseif d5 < mira.ratio then
                score = score + 500
                texto_score.text = "SCORE: "..score
                balas = balas-1
                texto_balas.text = "BALAS: "..balas
                kills = kills+1
                texto_kills.text = "KILLS: "..kills
                patos[5]:removeSelf( )
                --patos[5] = nil
                print("Pato 5 muerto")
                subirPerroConPatosI = timer.performWithDelay( 500, subirPerro, 2)
                bajarPerroConPatosI = timer.performWithDelay( 500, bajarPerro, 2)
            else 
                balas = balas-1
                texto_balas.text = "BALAS: "..balas
            end

            if score == 2500 then
                win()
            end
        else 
            audio.play(empty_shot)
            transition.to( patos[i], {alpha=0.5} )
            transition.cancel( patos[i] )
            transition.to( cielo_fondo, {alpha=0.5} )
            finDelJuego() 
        end

    end
end
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------



-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    grupo_fondo = display.newGroup( )
    grupo_intermedio = display.newGroup( )
    grupo_intermedio2 = display.newGroup( )
    grupo_delantero = display.newGroup( )
    grupo_delantero2 = display.newGroup( )

    sceneGroup:insert( grupo_fondo)
    sceneGroup:insert( grupo_intermedio)
    sceneGroup:insert( grupo_intermedio2)
    sceneGroup:insert( grupo_delantero)
    sceneGroup:insert( grupo_delantero2)

    -- Code here runs when the scene is first created but has not yet appeared on screen
    cielo_fondo = display.newImageRect(grupo_fondo ,"cielo.jpg",CW+100,CH )
    cielo_fondo.anchorX = 0.09 
    cielo_fondo.anchorY = 0

    arbol1 = display.newImageRect( grupo_intermedio2, "arbol.png", CW-100, CH )
    arbol1.anchorY = -1

    --arbol2 = display.newImageRect( grupo_intermedio2, "arbol.png", CW-100, CH )
    --arbol2.anchorX = 0
    --arbol2.anchorY = -1 

    cesped = display.newImageRect( grupo_intermedio2,"cesped.png", CW+100, CH+40)
    cesped.anchorX = 0.09
    cesped.anchorY = -1

    arma = display.newImageRect( grupo_delantero, "sniper.png", CW-300, CH-200 )
    arma.x = CW/2
    arma.y = CH*0.85

    texto_balas = display.newText(grupo_delantero2,"BALAS: "..balas,60,290,"times new roman", 24)
    texto_kills = display.newText(grupo_delantero2,"KILLS: "..kills, 250,290, "times new roman", 24 )
    texto_score = display.newText(grupo_delantero2,"SCORE: "..score, 450,290, "times new roman", 24 )

    mira = display.newImageRect( grupo_delantero, "mira.png", CW-300,CH-200)
    mira.x = miraX
    mira.y = miraY

    perroConPatos = display.newImageRect( grupo_intermedio, "dog_patos.png", CW-300, CH-200 )
    perroConPatos.x = CW/2
    perroConPatos.y = CH*0.95

    -- Se crean los patos
    crear_patos()
       
end


 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        mira.ratio = radio_mira
        cielo_fondo.isVisible = true
        moverPatosI = timer.performWithDelay( 1000, moverPatos, -1)
        moverMiraI = timer.performWithDelay( 1000, moverMira, -1 )
        moverArmaI = timer.performWithDelay( 1000, moverArma, -1)
        audio.play(pato_volando)
        cielo_fondo:addEventListener( "touch", disparar )
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)

        timer.cancel( moverPatosI )
        timer.cancel(moverMiraI)
        timer.cancel(moverArmaI)
        Runtime:removeEventListener( "enterFrame", moverArma )
        cielo_fondo.isVisible = true
        --arbol1.isVisible = false

    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
        composer.removeScene( "jugando" )
    end
end
 

 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
return scene
