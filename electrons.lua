--Electron Configuration
function ec(num, doprint)

 --num = num or tonumber(io.stdin:read("*l"))
 --doprint = doprint or true This doesn't work, because we expect doprint to be a boolean, so doprint or true does a logical or
 if (doprint == null) then doprint = true end

 --[[
 if (type(num) ~= "number") then
  print("Invalid Input!")
  return false
 elseif (num <= 0 or num > 132) then
  print("Input must be between 1 and 132!")
  return false
 end
 --]]

 --Check if the input is correct
 assert(type(num) == "number", "Numerical Input Expected!")
 assert(num >= 1 and num <= 117, "Input must be between 1 and 117!")

 --Set the order of the sublevels, and the maximum energy level
 local order = { "1s", "2s", "2p", "3s", "3p", "4s", "3d", "4p", "5s", "4d", "5p", "6s", "4f", "5d", "6p", "7s", "5f", "6d", "7p", "6f", "7d", "7f" }
 local orderMaxLvl = 7
 
 --Set the maximum electrons in each sub level
 local maxElecs = { s = 2, p = 6, d = 10, f = 14 }

 --A table for storing the configuration
 local level = {}

 --Lots of local variables
 --i is a counter
 --NextLevel, NextSubLevel, MaxElectrons, NumberOfLevels, HighestEnergyLevelElectrons, Level, Sublevel, ElectronConfigurationReturn
 local i = 0
 local nl = 0
 local nsl = ""
 local me = 0
 local numLevles = 0
 local hel = 0
 local lev = 0
 local sub = ""
 local ecRet = "";

 --Keep looping until we've used all the electrons
 while (num ~= 0) do
  --Increase the counter
  i = i + 1
 
  --Get the next level, sublevel, and the max elecs on this sublevel
  nl = tonumber(string.sub(order[i], 1, 1))
  nsl = string.sub(order[i], 2, 2)
  me = tonumber(maxElecs[nsl])
 
  --If the next sublevel is an "s" then it is the first sublevel of the energy level, so create the data for that energy level
  if nsl == "s" then
   level[nl] = { s = 0, p = 0, d = 0, f = 0}
  end
  
  --If there are less electrons left than the max electrons in this sublevel, then use all the remaining electrons
  if (num < me) then
   level[nl][nsl] = num
   num = 0
  else
   --Else, just fill the sublevel with some of the remaining electrons
   level[nl][nsl] = me
   num = num - me
  end
 end
 
 numLevels = table.getn(level) --Get the number of energy levels
 hel = 0
 i = 0

 --Loop until we tell it to break
 while (true) do
  --Increase the counter
  i = i + 1
  
  --Get the level and sublevel
  lev = tonumber(string.sub(order[i], 1, 1))
  sub = string.sub(order[i], 2, 2)

  --If the level is greater than the number of energy levels, or if the sublevel has no electrons, break
  if lev > numLevels then break end
  if level[lev][sub] == 0 then break end
  
  --Add this sublevel info to the return
  ecRet = ecRet .. lev .. sub .. level[lev][sub] .. " "
 end

 --If we are supposed to print, then print
 if doprint then
  print("\nElectron Configuration")
  print(ecRet)
 end

 --Add up all the electrons in the highest level
 hel = level[numLevels]["s"] + level[numLevels]["p"] + level[numLevels]["d"] + level[numLevels]["f"]

 --If we are supposed to print, print
 if doprint then
  local elecOutput = ""
  if (hel > 1) then elecOutput = "electrons"
  else elecOutput = "electron"
  end
  print("\nHighest Energy Level: " .. numLevels .. " (Contains " .. hel .. " " .. elecOutput .. ")\n")
 end

 --Return
 return ecRet, numLevels, hel
end

function ngc(num, toprint)
 --num = num or tonumber(io.stdin:read("*l"))
 if (toprint == null) then toprint = true end

 
 assert(type(num) == "number", "Numerical Input Expected!")
 assert(num >= 1 and num <= 117, "Input must be between 1 and 117!")

 local lec = ""
 local henlvl = 0
 local hel = 0

 lec, henlvl, hel = ec(num, toprint)

 local ngnum = {2,    10,    18,   36,   54,   86}
 local ngstr = {"He", "Ne", "Ar", "Kr", "Xe", "Rn"}

 local i = 0
 for j = table.getn(ngnum), 1, -1 do
  if ngnum[j] < num then i = j break end
  if j == 1 then i = 0 end
 end


 local ngec = ""
 local nghenlvl = 0
 local nghel = 0
 local shortec = ""

 if i > 0 then
  ngec, nghenlvl, nghel = ec(ngnum[i], false)
  assert(string.find(lec, ngec) == 1, "Error finding a Noble Gas")
  shortec = string.gsub(lec, ngec, "[" .. ngstr[i] .. "] ", 1)
 else
  shortec = lec
 end

 if toprint then
  print("\nNoble Gas Configuratin")
  print(shortec .. "\n")
 end

 return shortec, henlvl, hel
end

