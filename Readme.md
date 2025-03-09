# Smart home control via touchscreen

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install esphome
./cyd -s run
```

Helper script cyd.sh as wrapper for esphome command.
Four targets exist: 
 * sdl for testing on host
 * 7 for ESP32-8048S070 displays
 * int and prod for ESP32-8048S050 displays

I am using one 5 inch display for testing and one 5 inch display as production device (only updated via OTA if testing was ok).
