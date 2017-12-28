dofile("electrons.lua")

print("\n\n\n\n")

local running = true

while (running) do


--Even though the electron functions support up to 117, I will only use to 112 because it makes the output look nice.
--Besides that, there aren't any known elements above 110 or so.

--Get the user input
print("\n\n\n\n\n\n\nEnter a number between 1 and 112, or enter 0 to exit.")

local input = io.stdin:read("*l")
local toend = false

input = tonumber(input)

-- if the input is a number, and it is a whole number
if (type(input) == "number" and math.floor(input) == input) then
 -- if the input is between 1 and 112
 if (input >= 1 and input <= 112 and math.floor(input) == input) then
  ngc(input)
 --if the input is 0
 elseif (input == 0) then
  running = false
 end
end

end
