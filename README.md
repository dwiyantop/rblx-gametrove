# Bulk Data Export Script

Script to export all data from Roblox game's `ReplicatedStorage.Data` to an API endpoint.

## Description

This script will:
1. Scan all modules and folders in `ReplicatedStorage.Data` recursively
2. Extract serializable data (string, number, boolean, table)
3. Send all data to an API endpoint via POST request in JSON format

## Usage

1. Update the endpoint in `main.lua`:
   ```lua
   local ENDPOINT = "https://your-endpoint.com/api/data" -- Replace with your endpoint
   ```

2. Run the script in a Roblox executor or inject it into the game

3. The script will automatically:
   - Scan `ReplicatedStorage.Data`
   - Print all found data
   - Send to the configured endpoint

## Configuration

Edit this section in `main.lua` to change the endpoint:

```lua
local ENDPOINT = "https://5573347a9747.ngrok-free.app/post-test"
```

## Output

The script will display:
- ✅ Loaded: [module name] - for each successfully loaded module
- Total data sections found: [count] - total number of data sections found
- ✅ All data sent successfully! - if successfully sent to endpoint
- ⚠️ Error messages - if any errors occur

## Features

- ✅ Recursive scanning - scan all folders and subfolders
- ✅ Circular reference detection - prevent infinite loops
- ✅ Error handling - graceful error handling
- ✅ JSON encoding - convert data to JSON format
- ✅ HTTP POST request - send to endpoint

## Requirements

- Roblox game with `ReplicatedStorage.Data` structure
- HttpService enabled in the game
- API endpoint ready to receive POST requests with JSON body

## Notes

- Script only extracts serializable data (string, number, boolean, table)
- Non-serializable data will be skipped
- Make sure your endpoint is ready to receive data in JSON format

