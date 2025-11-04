# Bulk Data Export Script

Script untuk export semua data dari game Roblox `ReplicatedStorage.Data` ke API endpoint.

## Deskripsi

Script ini akan:
1. Scan semua module dan folder di `ReplicatedStorage.Data` secara recursive
2. Extract data yang bisa di-serialize (string, number, boolean, table)
3. Kirim semua data ke API endpoint via POST request dalam format JSON

## Cara Pakai

1. Update endpoint di file `main.lua`:
   ```lua
   local ENDPOINT = "https://your-endpoint.com/api/data" -- Ganti dengan endpoint kamu
   ```

2. Jalankan script di Roblox executor atau inject ke game

3. Script akan otomatis:
   - Scan `ReplicatedStorage.Data`
   - Print semua data yang ditemukan
   - Kirim ke endpoint yang sudah dikonfigurasi

## Konfigurasi

Edit bagian ini di `main.lua` untuk mengubah endpoint:

```lua
local ENDPOINT = "https://5573347a9747.ngrok-free.app/post-test"
```

## Output

Script akan menampilkan:
- ✅ Loaded: [nama module] - untuk setiap module yang berhasil di-load
- Total data sections found: [jumlah] - jumlah total data yang ditemukan
- ✅ All data sent successfully! - jika berhasil kirim ke endpoint
- ⚠️ Error messages - jika ada error

## Fitur

- ✅ Recursive scanning - scan semua folder dan subfolder
- ✅ Circular reference detection - menghindari infinite loop
- ✅ Error handling - handle error dengan graceful
- ✅ JSON encoding - convert data ke JSON format
- ✅ HTTP POST request - kirim ke endpoint

## Requirements

- Roblox game dengan `ReplicatedStorage.Data` structure
- HttpService enabled di game
- API endpoint yang siap menerima POST request dengan JSON body

## Catatan

- Script hanya extract data yang bisa di-serialize (string, number, boolean, table)
- Data yang tidak bisa di-serialize akan di-skip
- Pastikan endpoint kamu siap menerima data dalam format JSON

