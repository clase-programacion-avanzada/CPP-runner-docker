# Cross-Platform Usage Guide

This repository includes scripts for all major operating systems:

## Available Scripts

| Platform | Script | Command Example |
|----------|--------|-----------------|
| Linux/macOS | `run_interactive.sh` | `./run_interactive.sh project_group_1` |
| Windows (Batch) | `run_interactive.bat` | `run_interactive.bat project_group_1` |
| Windows (PowerShell) | `run_interactive.ps1` | `.\run_interactive.ps1 project_group_1` |

## First-Time Setup

### Linux/macOS
```bash
chmod +x run_interactive.sh
```

### Windows
No additional setup required for batch files. For PowerShell, you may need to allow script execution:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

## Which Script Should I Use?

- **Linux**: Use `run_interactive.sh`
- **macOS**: Use `run_interactive.sh` (works perfectly)
- **Windows 10/11**: 
  - **Preferred**: `run_interactive.ps1` (PowerShell - more modern)
  - **Alternative**: `run_interactive.bat` (Command Prompt - widely compatible)
  - **Fallback**: `run_interactive.sh` (if you have Git Bash or WSL)

## Troubleshooting

If you encounter issues with one script, try another:
1. Try the PowerShell version (`.ps1`) - usually the most robust on Windows
2. Try the batch version (`.bat`) - most compatible on Windows
3. Try the bash version (`.sh`) - if you have Unix-like environment

All scripts do exactly the same thing - they just use different syntax for different shells.
