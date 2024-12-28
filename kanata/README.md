# Kanata Configuration and Setup Guide

This repository contains the configuration for [Kanata](https://github.com/jtroo/kanata), a keyboard remapping tool, as well as scripts for setting up and managing Kanata on a system. The guide below explains the contents of the `kanata.kbd` configuration file, lists necessary plugins, and provides instructions for using the setup scripts.

---

## Kanata Configuration (`kanata.kbd`)

The `kanata.kbd` file defines the custom keyboard layout and behavior for Kanata. Here's an overview of its structure:

### Key Components

1. **Default Keyboard Layout (`defsrc`)**:

   - Specifies the base layout of your keyboard.
   - Example:
     ```plaintext
     esc  f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12
     grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
     ```

2. **Tap-Hold Variables (`defvar`)**:

   - Defines tap and hold timeouts for keys.
   - Example:
     ```plaintext
     tap-timeout 300      ;; Time in milliseconds for a tap
     hold-timeout 200     ;; Time in milliseconds for a hold
     ```

3. **Custom Key Aliases (`defalias`)**:

   - Configures tap-hold and other special behaviors for keys.
   - Example:
     - **Caps Lock**: Tap to send `Esc`, hold to act as `Left Control`:
       ```plaintext
       caps (tap-hold $tt $ht esc lctl)
       ```

4. **Layers (`deflayer` and `deflayermap`)**:

   - Creates layers for advanced keyboard layouts and functionality.
   - Example:
     - **Base Layer**: Standard layout with additional tap-hold actions:
       ```plaintext
       deflayer base
         caps  f1   f2   f3 ...
       ```

5. **Arrows Layer**:
   - Example configuration:
     ```plaintext
     @caps   @a    @s    @d    @f    g    left down up right
     ```

### Purpose

- Adds functionality like tap-hold actions for keys (`Caps`, `Space`, etc.).
- Implements multi-layer support (e.g., base, transparent, and arrows layers).
- Allows efficient keyboard navigation and custom remapping.

---

## Plugins (`plugins.txt`)

The `plugins.txt` file contains a list of packages and plugins required for the system. These plugins are automatically installed by the script. Below is a sample list:

### Required Plugins

1. **neovim**: Modern text editor for developers.
2. **git**: Version control system.
3. **htop**: Interactive process viewer.
4. **yay**: AUR helper for Arch Linux.
5. **zsh**: Powerful shell with scripting capabilities.

---

## Installation and Setup Instructions

Follow these steps to set up Kanata and its dependencies on your system.

### 1. Install Required Plugins

Use the `install/arch.sh` script to install all necessary plugins listed in `plugins.txt`.

#### Steps:

1. Make the script executable:
   ```bash
   chmod +x install/arch.sh
   ```
