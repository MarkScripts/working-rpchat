ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('es:invalidCommandHandler', function(source, command_args, user)
  CancelEvent()
  TriggerClientEvent('chat:addMessage', source, {
    template = '<div style="padding-top: 0.22vw; padding-bottom: 0.37vw; padding-left: 1.35vw; padding-right: 0.35vw; margin: 0.5vw; background-color: rgba(205, 0, 0, 0.45); font-weight: 100; text-shadow: 0px 0 black, 0 0.3px black, 0.0px 0 black, 0 0px black; box-shadow: -0.5px 0 black, 0 0.5px black, 0.5px 0 black, 0 -1px black; border-radius: 3px;">             <font style="background-color:rgba(52, 52, 53, 1.0); font-size: 12px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 0px;"> <b> ERROR</b></font><font style=" font-weight: 800; font-size: 16px; margin-left: 5px; padding-bottom: 5.2px; border-radius: 0px;"><b> </b></font><font style=" font-weight: 500; font-size: 16px; border-radius: 0px;">Toto není platný příkaz </font></div>',
      args = {}
    })
end)


RegisterServerEvent('sendmetoall')
AddEventHandler('sendmetoall', function(message)
  local _source = source
  local name = GetCharacterName(_source)
  xPlayer = ESX.GetPlayerFromId(_source)

  TriggerClientEvent('esx_rpchat:sendProximityMessage', -1, xPlayer.source, name, message, { 186, 0, 255 })
  TriggerClientEvent('3dme:triggerDisplay', -1, message, xPlayer.source)
end)





AddEventHandler('chatMessage', function(source, name, message)
  if string.sub(message, 1, string.len('/')) ~= '/' then
    CancelEvent()

    if Config.EnableESXIdentity then name = GetCharacterName(source) end

    TriggerClientEvent('esx_rpchat:sendLocalOOC', -1, source, name, message, {30, 144, 255});
  end
end)

-- ME command
TriggerEvent('es:addCommand', 'me', function(source, args, rawCommand)
  if source == 0 then
    print('esx_rpchat: you can\'t use this command from rcon!')
    return
  end

  args = table.concat(args, ' ')
  local name = GetPlayerName(source)
  if Config.EnableESXIdentity then name = GetCharacterName(source) end

  TriggerClientEvent('esx_rpchat:sendMe', -1, source, name, args, { 196, 33, 246 })
  TriggerClientEvent('3dme:triggerDisplay', -1, args, source)
  --print(('%s: %s'):format(name, args))
end)


-- DO command
TriggerEvent('es:addCommand', 'do', function(source, args, rawCommand)
  if source == 0 then
    print('esx_rpchat: you can\'t use this command from rcon!')
    return
  end

  args = table.concat(args, ' ')
  local name = GetPlayerName(source)
  if Config.EnableESXIdentity then name = GetCharacterName(source) end

  TriggerClientEvent('esx_rpchat:sendDo', -1, source, name, args, { 255, 198, 0 })
  TriggerClientEvent('3ddo:triggerDisplay', -1, args, source)
  --print(('%s: %s'):format(name, args))
end)

TriggerEvent('es:addCommand', 'doc', function(source, args, rawCommand)
  if source == 0 then
    print('esx_rpchat: you can\'t use this command from rcon!')
    return
  end
  if args == nil then
  print('source .. args .. rawCommand')
  return
  end
  args = table.concat(args, ' ')
  local name = GetPlayerName(source)
  if Config.EnableESXIdentity then name = GetCharacterName(source) end
  local counter_doc = 0
  local pocetOpakovani = tonumber(args)
  if pocetOpakovani < 101 then
    while counter_doc < pocetOpakovani do
        counter_doc = counter_doc + 1 
        TriggerClientEvent('esx_rpchat:sendDo', -1, source, name, counter_doc .. "/" .. pocetOpakovani , { 255, 198, 0 })
        TriggerClientEvent('3ddoa:triggerDisplay', -1, counter_doc .. "/" .. pocetOpakovani, source)
        Citizen.Wait(2000)
    end 
  end
end)

--announce
TriggerEvent("es:addGroupCommand", "announce", "admin", function(source, args, rawCommand)
  local playerName = GetPlayerName(source)
 --  local msg = rawCommand:sub(6)
    local toSay = ''
       for i=1,#args do
    toSay = toSay .. args[i] .. ' ' -- Concats two strings together
  end  

  TriggerClientEvent('chat:addMessage', -1, {
    template = '<div style="padding-top: 0.22vw; padding-bottom: 0.37vw; padding-left: 1.35vw; padding-right: 0.35vw; margin: 0.5vw; background-color: rgba(204, 0, 0, 0.45); font-weight: 100; text-shadow: 0px 0 black, 0 0.3px black, 0.0px 0 black, 0 0px black; box-shadow: -0.5px 0 black, 0 0.5px black, 0.5px 0 black, 0 -1px black; border-radius: 3px;">             <font style="background-color:rgba(52, 52, 53, 1.0); font-size: 12px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 0px;"> <b> OZNÁMENÍ</b></font><font style=" font-weight: 800; font-size: 16px; margin-left: 5px; padding-bottom: 5.2px; border-radius: 0px;"><b> </b></font><font style=" font-weight: 500; font-size: 16px; border-radius: 0px;">   {0}</font></div>',
      args = { toSay }
  })


end, false)


-- TWEET
RegisterCommand('tweet', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(6)
    fal = GetCharacterName(source)

    TriggerClientEvent('chat:addMessage', -1, {
      template = '<div style="padding-top: 0.22vw; padding-bottom: 0.37vw; padding-left: 1.35vw; padding-right: 0.35vw; margin: 0.5vw; background-color: rgba(28, 160, 242, 0.65); font-weight: 100; text-shadow: 0px 0 black, 0 0.3px black, 0.0px 0 black, 0 0px black; box-shadow: -0.5px 0 black, 0 0.5px black, 0.5px 0 black, 0 -1px black; border-radius: 3px;">             <font style="background-color:rgba(52, 52, 53, 1.0); font-size: 12px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 0px;"> <b> TWITTER</b></font><font style=" font-weight: 800; font-size: 16px; margin-left: 5px; padding-bottom: 5.2px; border-radius: 0px;"><b>  @{0} |</b></font><font style=" font-weight: 500; font-size: 16px; border-radius: 0px;"> {1}</font></div>',

        args = { fal, msg }
    })
end, false)

-- TEQUILALA
TriggerEvent('es:addCommand', 'tequilala', function(source, args, rawCommand)
  local playerName = GetPlayerName(source)
--    local msg = rawCommand:sub(7)
  local xPlayer = ESX.GetPlayerFromId(source)
  local toSay = ''
     for i=1,#args do
  toSay = toSay .. args[i] .. ' ' -- Concats two strings together
end

  if xPlayer.job.name == 'tequilala' then 
  TriggerClientEvent('chat:addMessage', -1, {
    template = '<div style="padding-top: 0.22vw; padding-bottom: 0.37vw; padding-left: 1.35vw; padding-right: 0.35vw; margin: 0.5vw; background-color: rgba(255, 194, 0, 1); font-weight: 100; text-shadow: 0px 0 black, 0 0.3px black, 0.0px 0 black, 0 0px black; box-shadow: -0.5px 0 black, 0 0.5px black, 0.5px 0 black, 0 -1px black; border-radius: 3px;">             <font style="background-color:rgba(52, 52, 53, 1.0); font-size: 12px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 0px;"> <b> TEQUILALA</b></font><font style=" font-weight: 800; font-size: 16px; margin-left: 5px; padding-bottom: 5.2px; border-radius: 0px;"><b></b></font><font style=" font-weight: 500; font-size: 16px; border-radius: 0px;"> {0}</font></div>',
  
        args = {toSay}
    })
else 
  TriggerClientEvent('chat:addMessage', source, {
    template = '<div style="padding-top: 0.22vw; padding-bottom: 0.37vw; padding-left: 1.35vw; padding-right: 0.35vw; margin: 0.5vw; background-color: rgba(255, 0, 0, 0.45); font-weight: 100; text-shadow: 0px 0 black, 0 0.3px black, 0.0px 0 black, 0 0px black; box-shadow: -0.5px 0 black, 0 0.5px black, 0.5px 0 black, 0 -1px black; border-radius: 3px;">             <font style="background-color:rgba(52, 52, 53, 1.0); font-size: 12px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 0px;"> <b> ERROR</b></font><font style=" font-weight: 800; font-size: 16px; margin-left: 5px; padding-bottom: 5.2px; border-radius: 0px;"><b></b></font><font style=" font-weight: 500; font-size: 16px; border-radius: 0px;"> neplatné zaměstnání</font></div>',
   
    args = {}
  })
end
end, false)

-- TWEET
RegisterCommand('twt', function(source, args, rawCommand)
  local playerName = GetPlayerName(source)
  local msg = rawCommand:sub(4)
  fal = GetCharacterName(source)

  TriggerClientEvent('chat:addMessage', -1, {
    template = '<div style="padding-top: 0.22vw; padding-bottom: 0.37vw; padding-left: 1.35vw; padding-right: 0.35vw; margin: 0.5vw; background-color: rgba(28, 160, 242, 0.65); font-weight: 100; text-shadow: 0px 0 black, 0 0.3px black, 0.0px 0 black, 0 0px black; box-shadow: -0.5px 0 black, 0 0.5px black, 0.5px 0 black, 0 -1px black; border-radius: 3px;">             <font style="background-color:rgba(52, 52, 53, 1.0); font-size: 12px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 0px;"> <b> TWITTER</b></font><font style=" font-weight: 800; font-size: 16px; margin-left: 5px; padding-bottom: 5.2px; border-radius: 0px;"><b>  @{0} |</b></font><font style=" font-weight: 500; font-size: 16px; border-radius: 0px;"> {1}</font></div>',
      args = { fal, msg }
  })

end, false)



-- Anontwt
RegisterCommand('Anontwt', function(source, args, rawCommand)
  local playerName = GetPlayerName(source)
  local msg = rawCommand:sub(8)
  fal = GetCharacterName(source)

  TriggerClientEvent('chat:addMessage', -1, {
    template = '<div style="padding-top: 0.22vw; padding-bottom: 0.37vw; padding-left: 1.35vw; padding-right: 0.35vw; margin: 0.5vw; background-color: rgba(28, 160, 242, 0.65); font-weight: 100; text-shadow: 0px 0 black, 0 0.3px black, 0.0px 0 black, 0 0px black; box-shadow: -0.5px 0 black, 0 0.5px black, 0.5px 0 black, 0 -1px black; border-radius: 3px;">             <font style="background-color:rgba(52, 52, 53, 1.0); font-size: 12px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 0px;"> <b> TWITTER</b></font><font style=" font-weight: 800; font-size: 16px; margin-left: 5px; padding-bottom: 5.2px; border-radius: 0px;"><b>  @anonym |</b></font><font style=" font-weight: 500; font-size: 16px; border-radius: 0px;"> {1}</font></div>',
      args = { fal, msg }
  })
end, false)

-- BLACKMARKET
TriggerEvent('es:addCommand', 'bm', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
--   local msg = rawCommand:sub(3)
    fal = GetCharacterName(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local toSay = ''
       for i=1,#args do
    toSay = toSay .. args[i] .. ' ' -- Concats two strings together
  end

  if xPlayer.job.name ~= 'police' then
    TriggerClientEvent('chat:addMessage', -1, {
      template = '<div style="padding-top: 0.22vw; padding-bottom: 0.37vw; padding-left: 1.35vw; padding-right: 0.35vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.55); font-weight: 100; text-shadow: 0px 0 black, 0 0.3px black, 0.0px 0 black, 0 0px black; box-shadow: -0.5px 0 black, 0 0.5px black, 0.5px 0 black, 0 -1px black; border-radius: 3px;">             <font style="background-color:rgba(52, 52, 53, 1.0); font-size: 12px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 0px;"> <b> BM</b></font><font style=" font-weight: 800; font-size: 16px; margin-left: 5px; padding-bottom: 5.2px; border-radius: 0px;"><b>  @anonym |</b></font><font style=" font-weight: 500; font-size: 16px; border-radius: 0px;"> {0}</font></div>',
     
        args = {toSay}
    })
  end
end, false)




-- POLICE
TriggerEvent('es:addCommand', 'police', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
--    local msg = rawCommand:sub(7)
    local xPlayer = ESX.GetPlayerFromId(source)
    local toSay = ''
       for i=1,#args do
    toSay = toSay .. args[i] .. ' ' -- Concats two strings together
  end

    if xPlayer.job.name == 'police' then 
    TriggerClientEvent('chat:addMessage', -1, {
      template = '<div style="padding-top: 0.22vw; padding-bottom: 0.37vw; padding-left: 1.35vw; padding-right: 0.35vw; margin: 0.5vw; background-color: rgba(50, 71, 202, 0.45); font-weight: 100; text-shadow: 0px 0 black, 0 0.3px black, 0.0px 0 black, 0 0px black; box-shadow: -0.5px 0 black, 0 0.5px black, 0.5px 0 black, 0 -1px black; border-radius: 3px;">             <font style="background-color:rgba(52, 52, 53, 1.0); font-size: 12px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 0px;"> <b> PD</b></font><font style=" font-weight: 800; font-size: 16px; margin-left: 5px; padding-bottom: 5.2px; border-radius: 0px;"><b></b></font><font style=" font-weight: 500; font-size: 16px; border-radius: 0px;"> {0}</font></div>',
    
          args = {toSay}
      })
  else 
    TriggerClientEvent('chat:addMessage', source, {
      template = '<div style="padding-top: 0.22vw; padding-bottom: 0.37vw; padding-left: 1.35vw; padding-right: 0.35vw; margin: 0.5vw; background-color: rgba(255, 0, 0, 0.45); font-weight: 100; text-shadow: 0px 0 black, 0 0.3px black, 0.0px 0 black, 0 0px black; box-shadow: -0.5px 0 black, 0 0.5px black, 0.5px 0 black, 0 -1px black; border-radius: 3px;">             <font style="background-color:rgba(52, 52, 53, 1.0); font-size: 12px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 0px;"> <b> ERROR</b></font><font style=" font-weight: 800; font-size: 16px; margin-left: 5px; padding-bottom: 5.2px; border-radius: 0px;"><b></b></font><font style=" font-weight: 500; font-size: 16px; border-radius: 0px;"> neplatné zaměstnání</font></div>',
     
      args = {}
    })
  end
end, false)


-- Ambulance
TriggerEvent('es:addCommand', 'ems', function(source, args, rawCommand)
  local playerName = GetPlayerName(source)
--    local msg = rawCommand:sub(7)
  local xPlayer = ESX.GetPlayerFromId(source)
  local toSay = ''
     for i=1,#args do
  toSay = toSay .. args[i] .. ' ' -- Concats two strings together
end

  if xPlayer.job.name == 'ambulance' then 
  TriggerClientEvent('chat:addMessage', -1, {
    template = '<div style="padding-top: 0.22vw; padding-bottom: 0.37vw; padding-left: 1.35vw; padding-right: 0.35vw; margin: 0.5vw; background-color: rgba(186, 8, 10, 0.45); font-weight: 100; text-shadow: 0px 0 black, 0 0.3px black, 0.0px 0 black, 0 0px black; box-shadow: -0.5px 0 black, 0 0.5px black, 0.5px 0 black, 0 -1px black; border-radius: 3px;">             <font style="background-color:rgba(52, 52, 53, 1.0); font-size: 12px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 0px;"> <b> EMS</b></font><font style=" font-weight: 800; font-size: 16px; margin-left: 5px; padding-bottom: 5.2px; border-radius: 0px;"><b></b></font><font style=" font-weight: 500; font-size: 16px; border-radius: 0px;"> {0}</font></div>',
        args = {toSay}
    })
else 
  TriggerClientEvent('chat:addMessage', source, {
    template = '<div style="padding-top: 0.22vw; padding-bottom: 0.37vw; padding-left: 1.35vw; padding-right: 0.35vw; margin: 0.5vw; background-color: rgba(255, 0, 0, 0.45); font-weight: 100; text-shadow: 0px 0 black, 0 0.3px black, 0.0px 0 black, 0 0px black; box-shadow: -0.5px 0 black, 0 0.5px black, 0.5px 0 black, 0 -1px black; border-radius: 3px;">             <font style="background-color:rgba(52, 52, 53, 1.0); font-size: 12px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 0px;"> <b> ERROR</b></font><font style=" font-weight: 800; font-size: 16px; margin-left: 5px; padding-bottom: 5.2px; border-radius: 0px;"><b></b></font><font style=" font-weight: 500; font-size: 16px; border-radius: 0px;"> neplatné zaměstnání</font></div>',
    args = {}
  })
end
end, false)

-- INZERAT
TriggerEvent('es:addCommand', 'reklama', function(source, args, rawCommand)
  local characterName = GetCharacterName(source)
--  local msg = rawCommand:sub(8)
  local xPlayer = ESX.GetPlayerFromId(source)
  local characterName = GetCharacterName(source)
  local playerName = GetPlayerName(source)
  fal = GetCharacterName(source)
  local toSay = ''
       for i=1,#args do
    toSay = toSay .. args[i] .. ' ' -- Concats two strings together
  end

  if xPlayer.get('money') >= 250 then
    TriggerClientEvent('chat:addMessage', -1, {
      template = '<div style="padding-top: 0.22vw; padding-bottom: 0.37vw; padding-left: 1.35vw; padding-right: 0.35vw; margin: 0.5vw; background-color: rgba(255 , 225, 0, 0.45); font-weight: 100; text-shadow: 0px 0 black, 0 0.3px black, 0.0px 0 black, 0 0px black; box-shadow: -0.5px 0 black, 0 0.5px black, 0.5px 0 black, 0 -1px black; border-radius: 3px;">             <font style="background-color:rgba(52, 52, 53, 1.0); font-size: 12px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 0px;"> <b> REKLAMA</b></font><font style=" font-weight: 800; font-size: 16px; margin-left: 5px; padding-bottom: 5.2px; border-radius: 0px;"><b> {0} |</b></font><font style=" font-weight: 500; font-size: 16px; border-radius: 0px;"> {1}</font></div>',
      
     
        args = { fal, toSay }
      })

    xPlayer.removeMoney(250)

    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Reklama zakoupena! Za 250 USD' })

  else 
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Nemáte dostatek peněz na zaplacení'})

  end
end, false)--]]

-- INZERAT
TriggerEvent('es:addCommand', 'ad', function(source, args, rawCommand)
  local characterName = GetCharacterName(source)
--  local msg = rawCommand:sub(8)
  local xPlayer = ESX.GetPlayerFromId(source)
  local characterName = GetCharacterName(source)
  local playerName = GetPlayerName(source)
  fal = GetCharacterName(source)
  local toSay = ''
       for i=1,#args do
    toSay = toSay .. args[i] .. ' ' -- Concats two strings together
  end

  if xPlayer.get('money') >= 250 then
    TriggerClientEvent('chat:addMessage', -1, {
      template = '<div style="padding-top: 0.22vw; padding-bottom: 0.37vw; padding-left: 1.35vw; padding-right: 0.35vw; margin: 0.5vw; background-color: rgba(255 , 225, 0, 0.45); font-weight: 100; text-shadow: 0px 0 black, 0 0.3px black, 0.0px 0 black, 0 0px black; box-shadow: -0.5px 0 black, 0 0.5px black, 0.5px 0 black, 0 -1px black; border-radius: 3px;">             <font style="background-color:rgba(52, 52, 53, 1.0); font-size: 12px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 0px;"> <b> REKLAMA</b></font><font style=" font-weight: 800; font-size: 16px; margin-left: 5px; padding-bottom: 5.2px; border-radius: 0px;"><b>{0} |</b></font><font style=" font-weight: 500; font-size: 16px; border-radius: 0px;"> {1}</font></div>',
      
        args = { fal, toSay }
      })

    xPlayer.removeMoney(250)

    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Reklama zakoupena! Za 250 USD' })

  else 
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Nemáte dostatek peněz na zaplacení'})

  end
end, false)--]]

-- Get Character name
function GetCharacterName(source)
  local result = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
    ['@identifier'] = GetPlayerIdentifiers(source)[1]
  })

  if result[1] and result[1].firstname and result[1].lastname then
    if Config.OnlyFirstname then
      return result[1].firstname
    else
      return ('%s %s'):format(result[1].firstname, result[1].lastname)
    end
  else
    return GetPlayerName(source)
  end
end

function GetCharacterJobName(source) 
  local result = MySQL.Sync.fetchAll('SELECT job FROM users WHERE identifier = @identifier', {
    ['@identifier'] = GetPlayerIdentifiers(source)[1]
  })

  if result[1] and result[1].job then
    return result[1].job
  end

  return nil
end

function GetCharacterPhoneNumber(source)
  local result = MySQL.Sync.fetchAll('SELECT phone_number FROM users WHERE identifier = @identifier', {
    ['@identifier'] = GetPlayerIdentifiers(source)[1]
  })

  if result[1] and result[1].phone_number then
    return result[1].phone_number
  end

  return nil
end
