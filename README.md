# PHYLAX — Open-Source Bitcoin Hardware Wallet

**PHX-001 · Version 3 · Square Button**

PHYLAX (Greek *φύλαξ*, "guardian") is an open-source, Bitcoin-only hardware wallet built around a simple idea: no black-box chips, no wireless radios, no telemetry, and firmware you can read and verify yourself. This repository contains the KiCad hardware design files for the PHYLAX Version 3 board (square button variant).

🌐 Website: [phylaxwallet.com](https://phylaxwallet.com/)

> **Status:** In development — prototype targeted for Q4 2026. Hardware and firmware are subject to change.

---

## Why PHYLAX

- **Zero black-box chips** — no proprietary secure element; every component is one you can trace and verify.
- **Fully open firmware** — released under GPL v3.
- **Bitcoin-only** — no altcoins, no unnecessary attack surface.
- **No wireless radios, no telemetry** — the device only talks over USB-C, and only when you plug it in.
- **Built by the community** — the project is developed and audited in the open.

## What's in This Repository

This is a **KiCad 8 project** containing the schematic, PCB layout, 3D models, fabrication outputs, and supporting library parts for the PHYLAX board.

```
Phylax_Version_3 Square Button/
├── Phylax_Version_3.kicad_pro       # KiCad project file
├── Phylax_Version_3.kicad_sch       # Schematic
├── Phylax_Version_3.kicad_pcb       # PCB layout
├── 3D/                              # 3D models & case designs (.step, .stl, .FCStd, .scad)
├── Library/                         # Custom symbol, footprint, and 3D model libraries per part
├── Gerber/                          # Fabrication (Gerber/drill) outputs
├── PCB Outline/                     # Board outline drawings (DXF/PDF)
├── production/                      # BOM, position files, netlist, and production archives
├── Phylax_Version_3-backups/        # KiCad autosave/backup archives
├── fp-lib-table / sym-lib-table     # KiCad footprint & symbol library tables
└── Button Note.txt                  # Working design notes on component substitutions
```

### Key components

| Part | Role |
|---|---|
| STM32F205RET6 | Main microcontroller |
| SX1308 | Boost converter |
| MCP1703AT-3302E | 3.3V LDO regulator |
| USB4215-03-A | USB-C connector |
| SKHCBEA010 | Tactile push button |
| ABMM2-8.000MHZ-E2-T | Crystal oscillator |

*(See `production/bom.csv` for the full bill of materials.)*

## Getting Started

### Prerequisites

- [KiCad 8](https://www.kicad.org/download/) or later
- (Optional) [FreeCAD](https://www.freecad.org/) to view/edit the `.FCStd` case files
- (Optional) [OpenSCAD](https://openscad.org/) to view/edit the `.scad` case files

### Opening the project

1. Clone this repository:
   ```bash
   git clone https://github.com/ta007403/PHYLAX.git
   cd PHYLAX
   ```
2. Open `Phylax_Version_3.kicad_pro` in KiCad.
3. Schematic, PCB, and 3D viewer are all accessible from the KiCad project manager.

### Manufacturing

Fabrication-ready outputs (Gerbers, drill files, BOM, and pick-and-place data) are provided in the `Gerber/` and `production/` folders for sending directly to a PCB manufacturer/assembler.

## Contributing

PHYLAX is built in the open and welcomes community review and contributions — from schematic review to case design. Please open an issue or pull request with proposed changes. If you spot a design or safety issue, responsible disclosure is appreciated.

## License

Firmware and hardware design files are released under **GPL v3** unless otherwise noted. See the [PHYLAX manifesto](https://phylaxwallet.com/manifesto) and [specs](https://phylaxwallet.com/specs) for more on the project's philosophy and technical details.

## Links

- Website: [phylaxwallet.com](https://phylaxwallet.com/)
- Specifications: [phylaxwallet.com/specs](https://phylaxwallet.com/specs)
- Manifesto: [phylaxwallet.com/manifesto](https://phylaxwallet.com/manifesto)
- Journal / build updates: [phylaxwallet.com/journal](https://phylaxwallet.com/journal/)
- Facebook: [facebook.com/phylaxwallet](https://www.facebook.com/phylaxwallet)

---

*Not your keys, not your coins — PHYLAX gives you the keys.*
