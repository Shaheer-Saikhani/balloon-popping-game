# Balloon Popping Game

A fully-featured keyboard-based game developed entirely in x86 Assembly language 
as part of the Computer Organization and Assembly Language (COAL) course at FAST 
NUCES Lahore. The game runs in DOSBox and was built without any high-level language 
— every feature from music to screen rendering to input handling was implemented 
at the hardware level using interrupts, registers, and direct video memory access.

The project is split across multiple .asm modules, each responsible for a specific 
part of the game, making the codebase organized and easy to navigate despite being 
written entirely in Assembly.

---

## Gameplay

Letters appear on screen inside balloons at random positions. The player must press 
the matching key on the keyboard to pop the balloon before it disappears. Each 
correct keypress pops the balloon and adds to the score. Missing too many balloons 
costs lives. The game ends either when all lives are lost (defeat) or when the 
player reaches the target score (victory).

---

## Features

### Core Gameplay
- Random letter balloons appearing across the screen
- Real-time keypress detection matched to the correct balloon
- Popping sound effect triggered on each successful pop
- Score tracker updated live during gameplay
- 5-life system — lose a life each time a balloon is missed

### Difficulty System
- Three difficulty levels: Easy, Medium, Hard
- Difficulty selection screen before the game starts
- Balloon speed and frequency change based on selected difficulty

### Screens
- Start screen with game title and instructions
- Rules screen explaining how to play
- Difficulty selection screen
- Active gameplay screen
- Pause menu with Resume and Restart options
- Victory screen displayed when the player wins
- Defeat screen displayed when all lives are lost
- Game over screen with final score summary

### Audio
- Background music that plays throughout the game
- Built using the PC speaker via hardware interrupts
- Custom note frequency table covering multiple octaves
- Smooth note transitions for better sound quality
- Music pauses when the game is paused

### Pause and Resume
- Player can pause the game at any point during gameplay
- Pause menu offers the option to Resume or Restart
- Game state including screen, score, and timer is fully saved and restored on resume
- Timer pauses and resumes accurately so the game picks up exactly where it left off

### Technical Highlights
- Direct video memory access (0xB800) for all screen rendering
- Hardware interrupt hooking (INT 8 for timer, INT 9 for keyboard)
- Screen buffer saving and restoring for seamless pause/resume transitions
- Modular code structure split across multiple .asm files

---

## File Structure

| File | Purpose |
|---|---|
| main.asm | Core game loop, data labels, interrupt hooks |
| start_screen.asm | Title and start screen rendering |
| rules_screen.asm | Rules screen |
| difficulty_screen.asm | Difficulty selection screen (Easy / Medium / Hard) |
| gameplay_screen.asm | Active gameplay logic and balloon rendering |
| music.asm | Background music system with note frequency table |
| resume_screen.asm | Pause menu with resume and restart options |
| victory.asm | Victory screen and win condition display |
| defeat.asm | Defeat screen and loss condition display |
| gameover_screen.asm | Game over screen with final score |
| new_gameover.asm | Updated game over handling |
| common_functions.asm | Shared utility subroutines used across modules |
| project.asm | Main include file that links all modules together |

---

## How to Run

### Step 1 - Download DOSBox
Download and install DOSBox from: https://www.dosbox.com/download.php?main=1

### Step 2 - Download this project
Click the green Code button on this repo and click Download ZIP
Extract the ZIP folder anywhere on your PC

### Step 3 - Run the game
- Open the extracted folder
- Double click the .exe file
- OR open DOSBox, mount the folder, and run the .exe manually

## No other setup needed
All game files are included. Only DOSBox needs to be installed separately
and it is free to download.

## Controls

| Key | Action |
|---|---|
| Letter keys (A-Z) | Pop the matching balloon |
| P or Esc | Pause the game |
| R | Restart from pause menu |
| Enter | Confirm selection on menus |

---

## What I Learned

This project was the most challenging thing I built during my first year. Writing 
an entire game in Assembly — where there is no standard library, no built-in input 
handling, and no abstraction — meant figuring out everything from scratch. 

Hooking hardware interrupts to handle the keyboard and timer simultaneously, writing 
directly to video memory to render graphics, and saving the full screen state to 
enable a working pause system were all problems that forced me to understand exactly 
how the hardware works underneath the code I usually write.

By the end of it, writing in C++ felt genuinely easy in comparison.

---

## Language
x86 Assembly (NASM — .com format)

## Tools
Assembly Programming Tools, DOSBox, AFD Debugger

## Course
Computer Organization and Assembly Language (COAL) — FAST NUCES Lahore