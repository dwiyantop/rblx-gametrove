-- Bulk Data Export
-- Get all database/data from the game and send to API

local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ENDPOINT = "https://5573347a9747.ngrok-free.app/post-test" -- Endpoint to receive all data

print("")
print("==========================================")
print("📦 Bulk Data Export")
print("==========================================")
print("")

-- Function to extract serializable data from table
local function extractSerializable(data, visited)
	visited = visited or {}
	
	if visited[data] then
		return nil -- Circular reference
	end
	
	local valueType = type(data)
	
	if valueType == "table" then
		visited[data] = true
		local result = {}
		
		for k, v in pairs(data) do
			local keyType = type(k)
			local valType = type(v)
			
			-- Only include string/number keys
			if keyType == "string" or keyType == "number" then
				local keyStr = tostring(k)
				
				-- Recursively extract nested tables
				if valType == "table" then
					local extracted = extractSerializable(v, visited)
					if extracted then
						result[keyStr] = extracted
					end
				elseif valType == "string" or valType == "number" or valType == "boolean" then
					result[keyStr] = v
				end
			end
		end
		
		visited[data] = nil
		return result
	elseif valueType == "string" or valueType == "number" or valueType == "boolean" then
		return data
	end
	
	return nil
end

-- Function to scan RS.Data recursively
local function scanData(parent, path, allData)
	path = path or ""
	allData = allData or {}
	
	for _, item in pairs(parent:GetChildren()) do
		local currentPath = path == "" and item.Name or path .. "." .. item.Name
		
		if item:IsA("ModuleScript") then
			local success, moduleData = pcall(function()
				return require(item)
			end)
			
			if success and moduleData then
				local extracted = extractSerializable(moduleData)
				if extracted then
					allData[currentPath] = extracted
					print("✅ Loaded: " .. currentPath)
				else
					warn("⚠️  Failed to extract: " .. currentPath)
				end
			else
				if not success then
					warn("⚠️  Failed to load module: " .. currentPath .. " - " .. tostring(moduleData))
				end
			end
		elseif item:IsA("Folder") then
			-- Recursively scan folders
			scanData(item, currentPath, allData)
		end
	end
	
	return allData
end

-- Start scanning
print("Scanning ReplicatedStorage.Data...")
print("")

local allData = {}
if ReplicatedStorage:FindFirstChild("Data") then
	allData = scanData(ReplicatedStorage.Data)
else
	warn("⚠️  ReplicatedStorage.Data not found")
end

print("")
-- Count total data sections
local count = 0
for _ in pairs(allData) do
	count = count + 1
end
print("Total data sections found: " .. tostring(count))
print("")

-- Print all data
print("==========================================")
print("📋 All Data Found:")
print("==========================================")
print("")

-- Send all data to endpoint
if next(allData) then
	local success, result = pcall(function()
		local jsonData = HttpService:JSONEncode(allData)
		local httpResponse = HttpService:RequestAsync({
			Url = ENDPOINT,
			Method = "POST",
			Body = jsonData,
			Headers = {
				["Content-Type"] = "application/json",
				["ngrok-skip-browser-warning"] = "true"
			}
		})
		
		if not httpResponse.Success then
			error("HTTP request failed: " .. tostring(httpResponse.StatusCode))
		end
		
		return httpResponse
	end)
	
	if success then
		print("✅ All data sent successfully!")
	else
		warn("⚠️  Failed to send data: " .. tostring(result))
	end
else
	warn("⚠️  No data found to send")
end

