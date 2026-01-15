import subprocess
from pathlib import Path

# === CONFIGURE THESE PATHS ===
input_dir = Path("Input your directory for your folder with the .WAV files")     
output_dir = Path("Input your output directory for MFA compatible .WAV files")       
output_dir.mkdir(exist_ok=True)

# === CONVERT EACH .WAV FILE TO BE COMPATIBLE WITH MFA ===
for wav_file in input_dir.glob("*.wav"):
    output_path = output_dir / wav_file.name
    command = [
        "ffmpeg",
        "-y",                          # Overwrite output if it exists
        "-i", str(wav_file),          # Input file
        "-ar", "16000",               # Set sample rate to 16kHz
        "-ac", "1",                   # Set to mono
        "-sample_fmt", "s16",         # Set sample format to 16-bit PCM
        str(output_path)
    ]
    print(f"Converting: {wav_file.name}")
    subprocess.run(command, check=True)

print("All files converted to MFA-compatible format.")
