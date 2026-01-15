# Fisher Spanish Corpus Parsing + Montreal Forced Alignment Pipeline
Summary (TLDR): Automates SPH→WAV conversion, channel splitting, and forced alignment runs to generate TextGrid outputs at scale; added quality control checks to support reliable analysis.

Overview:
This repository contains scripts to parse the Fisher Spanish corpus (LDC), split stereo SPH files by channel into per-speaker audio, convert transcripts to per-speaker `.lab` files, and run Montreal Forced Aligner (MFA) to produce TextGrids for downstream phonetic/variationist analysis.

## Corpus
- Source: Fisher Spanish (LDC)
- Format: audio in SPH (SPHERE), transcripts in TDF
- Each conversation has 2 speakers (channel 0 / channel 1) with subject IDs.
- Speakers in this study: 5 native Caribbean Spanish speakers and 91 non-Caribbean speakers.
- Total transcripts cover ~163 hours of telephone speech.

**IMPORTANT:** This repo does not distribute Fisher audio/transcripts. You must obtain the corpus from LDC under the appropriate license.

## Pipeline Overview
1. Split each SPH into two single-channel audio files (speaker 0 and speaker 1)
2. Convert SPH → WAV
3. Resample WAV to 16 kHz for MFA compatibility
4. Convert TDF transcripts → `.lab`, then split by channel/speaker
5. Run Montreal Forced Aligner to generate TextGrids

## Directory Layout
- `data/raw/` place original SPH + TDF here (not tracked by git)
- `data/interim/` intermediate outputs (channel-split audio, per-speaker labs)
- `data/processed/` MFA-aligned outputs (TextGrids, logs)
- `scripts/` processing scripts
- `mfa/` MFA configs, dictionary templates, model notes

## Setup
### Option 1: Conda
```bash
conda env create -f environment.yml
conda activate fisher-align
