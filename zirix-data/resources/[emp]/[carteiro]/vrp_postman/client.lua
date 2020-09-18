-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("vrp_postman")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local check = 0
local blips = false
local inService = false
local serviceX = 53.51
local serviceY = 114.72
local serviceZ = 79.19
--Locs 53.51,114.72,79.19
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESIDENCES
-----------------------------------------------------------------------------------------------------------------------------------------
local deliverys = {
	[1] = { -34.20,-1847.02,26.19 },
	[2] = { -20.62,-1858.82,25.40 },
	[3] = { -4.95,-1872.08,24.15 },
	[4] = { 23.18,-1896.54,22.96 },
	[5] = { 39.24,-1911.63,21.95 },
	[6] = { 56.64,-1922.50,21.91 },
	[7] = { 72.11,-1939.04,21.36 },
	[8] = { 76.53,-1948.19,21.17 },
	[9] = { 85.59,-1959.67,21.12 },
	[10] = { 114.21,-1961.01,21.33 },
	[11] = { 144.24,-1969.04,18.85 },
	[12] = { 148.85,-1960.51,19.45 },
	[13] = { 165.28,-1944.99,20.23 },
	[14] = { 179.17,-1924.14,21.37 },
	[15] = { 148.72,-1904.33,23.53 },
	[16] = { 126.58,-1929.87,21.38 },
	[17] = { 118.16,-1920.95,21.32 },
	[18] = { 101.06,-1912.26,21.40 },
	[19] = { 115.14,-1887.88,23.92 },
	[20] = { 104.11,-1885.18,24.31 },
	[21] = { 128.18,-1897.06,23.67 },
	[22] = { 5.26,-1884.31,23.69 },
	[23] = { 1395.30,1141.76,114.63 },
	[24] = { -1149.81,-1522.00,10.62 },
	[25] = { -817.01,178.06,72.22 },
	[26] = { -842.30,-25.06,40.39 },
	[27] = { -896.56,-5.07,43.79 },
	[28] = { -930.33,19.47,48.53 },
	[29] = { -888.29,42.65,49.14 },
	[30] = { -830.38,115.11,56.04 },
	[31] = { -913.38,108.26,55.51 },
	[32] = { -971.60,122.19,57.04 },
	[33] = { -998.14,157.94,62.31 },
	[34] = { -1038.06,222.16,64.37 },
	[35] = { -949.25,196.73,67.39 },
	[36] = { -902.41,191.54,69.44 },
	[37] = { -819.30,267.76,86.39 },
	[38] = { -1038.49,312.00,67.27 },
	[39] = { 1300.99,-574.21,71.73 },
	[40] = { 1323.37,-583.15,73.24 },
	[41] = { 1341.30,-597.26,74.70 },
	[42] = { 1367.23,-606.68,74.71 },
	[43] = { 1386.29,-593.54,74.48 },
	[44] = { 1389.09,-569.46,74.49 },
	[45] = { 1373.29,-555.81,74.68 },
	[46] = { 1348.44,-546.72,73.89 },
	[47] = { 1328.64,-536.04,72.44 },
	[48] = { 1303.25,-527.36,71.46 },
	[49] = { -14.18,-1441.65,31.10 },
	[50] = { -106.83,-8.50,70.52 },
	[51] = { 8.27,539.61,176.02 },
	[52] = { 313.36,-2040.47,20.93 },
	[53] = { 317.12,-2043.53,20.93 },
	[54] = { 324.37,-2049.63,20.93 },
	[55] = { 325.70,-2050.96,20.93 },
	[56] = { 333.07,-2056.97,20.93 },
	[57] = { 334.46,-2058.15,20.93 },
	[58] = { 341.76,-2064.37,20.93 },
	[59] = { 345.46,-2067.50,20.93 },
	[60] = { 356.74,-2074.75,21.74 },
	[61] = { 357.78,-2073.33,21.74 },
	[62] = { 365.07,-2064.74,21.74 },
	[63] = { 371.21,-2057.33,21.74 },
	[64] = { 372.42,-2056.05,21.74 },
	[65] = { 364.54,-2045.55,22.35 },
	[66] = { 360.80,-2042.48,22.35 },
	[67] = { 353.54,-2036.29,22.35 },
	[68] = { 352.17,-2035.19,22.35 },
	[69] = { 344.77,-2029.02,22.35 },
	[70] = { 343.40,-2027.82,22.35 },
	[71] = { 336.07,-2021.78,22.35 },
	[72] = { 332.36,-2018.66,22.35 },
	[73] = { 297.87,-2034.54,19.83 },
	[74] = { 293.37,-2044.23,19.64 },
	[75] = { 295.08,-2067.54,17.64 },
	[76] = { 286.26,-2052.54,19.64 },
	[77] = { 290.88,-2047.32,19.64 },
	[78] = { 330.66,-1999.91,24.04 },
	[79] = { 335.17,-1994.75,24.04 },
	[80] = { 337.72,-1991.66,24.04 },
	[81] = { 356.86,-1996.79,24.24 },
	[82] = { 345.41,-2015.36,22.39 },
	[83] = { 367.19,-2000.38,24.24 },
	[84] = { 331.32,-225.97,54.22 },
	[85] = { 334.96,-227.27,54.22 },
	[86] = { 337.13,-224.78,54.22 },
	[87] = { 339.12,-219.49,54.22 },
	[88] = { 340.94,-214.93,54.22 },
	[89] = { 343.00,-209.63,54.22 },
	[90] = { 344.70,-205.03,54.22 },
	[91] = { 346.73,-199.71,54.22 },
	[92] = { 312.81,-218.84,54.22 },
	[93] = { 310.80,-218.06,54.22 },
	[94] = { 307.22,-216.68,54.22 },
	[95] = { 307.55,-213.29,54.22 },
	[96] = { 309.57,-207.96,54.22 },
	[97] = { 311.41,-203.41,54.22 },
	[98] = { 313.38,-198.11,54.22 },
	[99] = { 315.80,-194.89,54.22 },
	[100] = { 319.42,-196.20,54.22 },
	[101] = { 321.39,-196.99,54.22 },
	[102] = { 329.35,-225.11,58.01 },
	[103] = { 331.34,-225.91,58.01 },
	[104] = { 334.92,-227.31,58.01 },
	[105] = { 337.10,-224.80,58.01 },
	[106] = { 339.20,-219.50,58.01 },
	[107] = { 340.97,-214.92,58.01 },
	[108] = { 342.90,-209.60,58.01 },
	[109] = { 344.77,-205.03,58.01 },
	[110] = { 346.73,-199.75,58.01 },
	[111] = { 325.09,-229.57,54.22 },
	[112] = { 312.80,-218.76,58.01 },
	[113] = { 310.82,-218.08,58.01 },
	[114] = { 307.25,-216.64,58.01 },
	[115] = { 307.59,-213.31,58.01 },
	[116] = { 309.59,-207.96,58.01 },
	[117] = { 311.32,-203.40,58.01 },
	[118] = { 313.29,-198.06,58.01 },
	[119] = { 315.81,-194.83,58.01 },
	[120] = { 319.35,-196.22,58.01 },
	[121] = { 321.32,-197.11,58.01 },
	[122] = { 329.37,-225.20,54.22 },
	[123] = { -223.16,-1617.58,38.05 },
	[124] = { -209.94,-1607.08,38.04 },
	[125] = { -208.65,-1600.58,38.04 },
	[126] = { -215.67,-1576.25,34.86 },
	[127] = { -219.27,-1579.88,34.86 },
	[128] = { -223.12,-1585.77,34.86 },
	[129] = { -209.97,-1607.14,34.86 },
	[130] = { -212.85,-1618.17,34.86 },
	[131] = { -223.15,-1617.57,34.86 },
	[132] = { 332.77,-1741.22,29.73 },
	[133] = { 321.00,-1759.92,29.63 },
	[134] = { 304.74,-1775.85,29.10 },
	[135] = { 299.84,-1784.27,28.43 },
	[136] = { 288.92,-1792.19,28.08 },
	[137] = { 281.58,-1694.61,29.64 },
	[138] = { 269.39,-1713.25,29.66 },
	[139] = { 257.11,-1723.59,29.65 },
	[140] = { 249.76,-1730.53,29.67 },
	[141] = { -1046.30,-1159.33,2.15 },
	[142] = { -986.36,-1121.92,4.54 },
	[143] = { -967.58,-1080.30,2.17 },
	[144] = { -1041.08,-1114.20,2.15 },
	[145] = { -1114.53,-1068.84,2.15 },
	[146] = { -1104.08,-1059.85,2.74 },
	[147] = { -1003.40,-977.47,2.15 },
	[148] = { -1054.04,-1000.17,6.41 },
	[149] = { -1094.92,427.40,75.87 },
	[150] = { -1087.44,479.22,81.32 },
	[151] = { -1122.57,486.26,82.35 },
	[152] = { -1158.86,481.85,86.09 },
	[153] = { -1174.46,440.24,86.84 },
	[154] = { -1052.07,432.59,77.25 },
	[155] = { 374.17,427.78,145.69 },
	[156] = { 346.46,440.6,147.73 },
	[157] = { 331.51,465.29,151.26 },
	[158] = { 315.81,502.0,153.18 },
	[159] = { 318.54,561.31,154.85 },
	[160] = { -184.28,967.37,232.14 },
	[161] = { -151.77,910.63,235.66 },
	[162] = { -85.61,834.64,235.93 },
	[163] = { -112.95,985.96,235.76 },
	[164] = { -1471.49,-668.43,29.59 },
	[165] = { -1467.46,-665.61,29.59 },
	[166] = { -1462.85,-662.3,29.59 },
	[167] = { -1458.89,-659.41,29.59 },
	[168] = { -1454.27,-656.07,29.59 },
	[169] = { -1452.21,-653.1,29.59 },
	[170] = { -1461.1,-640.82,29.59 },
	[171] = { -1465.17,-639.46,29.59 },
	[172] = { -1469.73,-642.79,29.59 },
	[173] = { -1473.76,-645.73,29.59 },
	[174] = { -1478.31,-649.03,29.59 },
	[175] = { -1482.27,-651.96,29.59 },
	[176] = { -1486.81,-655.26,29.59 },
	[177] = { -1490.86,-658.12,29.03 },
	[178] = { -1495.46,-661.47,29.03 },
	[179] = { -1498.23,-664.83,29.03 },
	[180] = { -1493.85,-668.44,29.03 },
	[181] = { -1476.02,-671.85,33.39 },
	[182] = { -1471.4,-668.53,33.39 },
	[183] = { -1467.45,-665.63,33.39 },
	[184] = { -1462.84,-662.28,33.39 },
	[185] = { -1458.87,-659.42,33.39 },
	[186] = { -1454.29,-656.08,33.39 },
	[187] = { -1452.18,-653.08,33.39 },
	[188] = { -1455.56,-648.5,33.39 },
	[189] = { -1461.1,-640.81,33.39 },
	[190] = { -1465.16,-639.46,33.39 },
	[191] = { -1469.74,-642.79,33.39 },
	[192] = { -1473.71,-645.74,33.39 },
	[193] = { -1478.29,-649.02,33.39 },
	[194] = { -1482.26,-651.9,33.39 },
	[195] = { -1486.87,-655.25,33.39 },
	[196] = { -1490.83,-658.13,33.39 },
	[197] = { -1495.41,-661.48,33.39 },
	[198] = { -1498.22,-664.85,33.39 },
	[199] = { -1493.87,-668.44,33.39 },
	[200] = { -1490.05,-671.55,33.39 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
local hora = 0
function CalculateTimeToDisplay()
	hora = GetClockHours()
	if hora <= 9 then
		hora = "0" .. hora
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTDELIVERY
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if not inService then
			local ped = PlayerPedId()
			if not IsPedInAnyVehicle(ped) then
				local x,y,z = table.unpack(GetEntityCoords(ped))
				local distance = Vdist(serviceX,serviceY,serviceZ,x,y,z)
				if distance <= 30.0 then
					DrawMarker(23,serviceX,serviceY,serviceZ-0.97,0,0,0,0,0,0,1.0,1.0,0.5,240,200,80,20,0,0,0,0)
					if distance <= 1.2 then
						drawTexts("PRESSIONE  ~b~E~w~  PARA INICIAR ENTREGAS",4,0.5,0.93,0.50,255,255,255,180)
						if IsControlJustPressed(1,38) then
							CalculateTimeToDisplay()
							if parseInt(hora) >= 06 and parseInt(hora) <= 20 then
								inService = true
								check = math.random(#deliverys)
								makeBlipsServices()
							else
								TriggerEvent("Notify","importante","Funcionamento é das <b>06:00</b> as <b>20:00</b>.",8000)
							end
						end
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOOPDELIVERYS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if inService then
			local ped = PlayerPedId()
			if not IsPedInAnyVehicle(ped) then
				local x,y,z = table.unpack(GetEntityCoords(ped))
				local distance = Vdist(deliverys[check][1],deliverys[check][2],deliverys[check][3],x,y,z)
				if distance <= 30.0 then
					DrawMarker(21,deliverys[check][1],deliverys[check][2],deliverys[check][3]-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,240,200,80,50,0,0,0,1)
					if distance <= 1.2 then
						drawTexts("PRESSIONE  ~b~E~w~  PARA ENTREGAR ENCOMENDAS",4,0.5,0.93,0.50,255,255,255,180)
						if IsControlJustPressed(1,38) then
							CalculateTimeToDisplay()
							if parseInt(hora) >= 06 and parseInt(hora) <= 20 then
								if vSERVER.startPayments() then
									RemoveBlip(blips)
									check = math.random(#deliverys)
									makeBlipsServices()
								end
							else
								TriggerEvent("Notify","importante","Funcionamento é das <b>06:00</b> as <b>20:00</b>.",8000)
							end
						end
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if inService and IsControlJustPressed(1,121) then
			inService = false
			RemoveBlip(blips)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXTS
-----------------------------------------------------------------------------------------------------------------------------------------
function drawTexts(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAKEBLIPSSERVICES
-----------------------------------------------------------------------------------------------------------------------------------------
function makeBlipsServices()
	blips = AddBlipForCoord(deliverys[check][1],deliverys[check][2],deliverys[check][3])
	SetBlipSprite(blips,1)
	SetBlipColour(blips,5)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Encomendas")
	EndTextCommandSetBlipName(blips)
end