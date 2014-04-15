-- ################################################## --
-- ##                                              ## --
-- ##                 Constants                    ## --
-- ##                                              ## --
-- ################################################## --

REQUESTURL = 'http://localhost:8080/'

-- ################################################## --
-- ##                                              ## --
-- ##             Global functions                 ## --
-- ##                                              ## --
-- ################################################## --

function addSensorMapping(list, sensorId)
  local containsSensorId = false
  for k,v in pairs(list) do
    if k.value == sensorId then
      containsSensorId = true
      break
    end
  end
  
  if containsSensorId then
    print('sensor: '..sensorId..' is already registred')
  else
    for k,v in pairs(list) do
      if k.value == 0 then
        k.value = sensorId
        v.value = 1
        print('adding sensor: '..sensorId..' to global list')
        break
      end
    end
  end  
end

function sendRequest(sensorId, sensorStatus)
  http.request {
    method = 'GET',
    url = REQUESTURL..sensorId..'/'..(sensorStatus == 1 and 'true' or 'false')
  }
end

sensor_ud = ME.AV100_Present_Value.value or 10 -- Sensor Unoccupancy Delay (minutes) - Default is 10 minutes
sensorMappingList = sensorMappingList or {}

print(os.date())
if next(sensorMappingList) == nil then
  print('\tstart initializing slots')
  sensorMappingList[ME.AV1_Present_Value] = ME.BV1_Present_Value
  sensorMappingList[ME.AV2_Present_Value] = ME.BV2_Present_Value
  sensorMappingList[ME.AV3_Present_Value] = ME.BV3_Present_Value
  sensorMappingList[ME.AV4_Present_Value] = ME.BV4_Present_Value
  sensorMappingList[ME.AV5_Present_Value] = ME.BV5_Present_Value
  sensorMappingList[ME.AV6_Present_Value] = ME.BV6_Present_Value
  sensorMappingList[ME.AV7_Present_Value] = ME.BV7_Present_Value
  sensorMappingList[ME.AV8_Present_Value] = ME.BV8_Present_Value
  sensorMappingList[ME.AV9_Present_Value] = ME.BV9_Present_Value
  sensorMappingList[ME.AV10_Present_Value] = ME.BV10_Present_Value
  print('\t10 slots successfully initialized')
else
  print('\tlooking for registred sensors')

  -- try evaluating all registred sensors
  knownSensors = {}
  for k, v in pairs(sensorMappingList) do
    if k.value ~= 0 then -- Search for all registred sensors:
      if next(knownSensors) == nil then
        print('\tOK, I found those sensors:')
        print('\t------------------------------------------')
        print('\t|   SensorId   |  Last known status  |')
        print('\t------------------------------------------')
      end
      knownSensors[k.value] = k
      print('\t|    ' .. k.value .. '    | ' .. (v.value == 1 and '        occupied          ' or '      unoccupied        ')..'|')
      print('\t------------------------------------------')
    end
  end
  
  if next(knownSensors) ~= nil then
    for k, v in pairs(knownSensors) do
      -- Check if a valid packet for the given sensor was received:
      print('\r\n['..k..']\n\r\t checking for new packages')
      local eo_packet = vm.eo_read(k)
      if eo_packet ~= nil then
        print('\t ATTENTION: I got a new package')
        -- A sensor value was received, keep it:
        if eo_packet.bytes[7] <= 127 then -- DB1 0...127 PIR off
          sensorMappingList[v].value = 0
          sendRequest(k, 0)
          print('\t\t package says: I am alone')
        else -- DB1 128...255 PIR on
          sensorMappingList[v].value = 1
          sensor_tm = os.time() -- Keep movement time
          sendRequest(k, 1)
          print('\t\t package says: Some crowd is around')
        end
      else
        print('\t no new packages for known devices recieved... nothing to do yet!')
      end
    end
  else
     print('\tno sensors registred yet\n\r')
  end
  print('checking for sensors in lerning mode...')
  local eo_packet = vm.eo_read(-1) -- Retrieve oldest package from RX queue.
  if eo_packet ~= nil then
    if bit.band(eo_packet.bytes[6], 0x08) == 0 then -- A teach-in was received, check for device profile information:
      if (bit.band(eo_packet.bytes[6], 0x80) == 0) -- DB0.Bit7: LRN Type
        or ((eo_packet.bytes[7] == 0x04) -- DB1: ManufacturerID
        and (eo_packet.bytes[8] == 0x08) -- DB2: Device Type
        and (eo_packet.bytes[9] == 0x1C)) then -- DB3: Profile Func.
        -- Check if device is in learn mode:
        print('\tfound a sensor in learning mode: '..eo_packet.enocean_id)
        addSensorMapping(sensorMappingList, eo_packet.enocean_id)
      end
    else
      print('\tno one wants to learn something')
    end
  else
    print('\tno one wants to learn something')
  end
end
print('\n\r')