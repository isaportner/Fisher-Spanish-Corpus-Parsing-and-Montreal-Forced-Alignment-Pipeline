import subprocess
from pathlib import Path

# === CONFIGURE PATHS ===
sph_dir = Path("Insert directory")          
output_dir = Path("Insert directory")      
output_dir.mkdir(parents=True, exist_ok=True)

# === CHOOSE YOUR TOOL ===
USE_SOX = True   # Set to False to use ffmpeg instead

# === CONVERT EACH .sph FILE ===
for sph_file in sph_dir.glob("*.sph"):
    base = sph_file.stem
    ch0_path = output_dir / f"{base}_ch0.wav"
    ch1_path = output_dir / f"{base}_ch1.wav"

    if USE_SOX:
        cmd_ch0 = ["sox", str(sph_file), str(ch0_path), "remix", "1"]
        cmd_ch1 = ["sox", str(sph_file), str(ch1_path), "remix", "2"]
    else:
        cmd_ch0 = ["ffmpeg", "-y", "-i", str(sph_file), "-map_channel", "0.0.0", str(ch0_path)]
        cmd_ch1 = ["ffmpeg", "-y", "-i", str(sph_file), "-map_channel", "0.0.1", str(ch1_path)]

    print(f"Splitting: {sph_file.name}")
    subprocess.run(cmd_ch0, check=True)
    subprocess.run(cmd_ch1, check=True)

print("All .sph files split into mono .wav files.")
