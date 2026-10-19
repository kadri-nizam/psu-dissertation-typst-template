# PSU Dissertation & Thesis Typst Template (`psu-etd`)

An unofficial Typst template for Penn State dissertations and master's theses. Designed to meet Penn State Fox Graduate School formatting guidelines out of the box.

---

## Features

* **Penn State Compliant Layout:** Title page, committee page without signature lines, abstract, table of contents, list of figures/tables, acknowledgments, and back matter (bibliography & vita).
* **Flexible Document Types:** Supports both Ph.D. dissertations and Master's theses.
* **Automatic Page Numbering Transitions:** Handles lowercase Roman numerals for front matter and switches to Arabic numerals starting on page 1 of Chapter 1.
* **Vita Page Handling:** Automatically suppresses page numbers on the Vita section per graduate school guidelines.
* **Customizable Parameters:** Configurable typefaces, font sizes, margins, and degree conferral dates.

---

## Repository Structure

```text
psu-dissertation-typst-template/
├── typst.toml             # Package metadata manifest
├── lib.typ                # Entry point re-exporting `psu-document` & `appendices`
├── src/
│   └── defs.typ           # Core template logic, layout, & styling rules
├── example/               # Starter template files for new users
│   ├── main.typ           # Main document entry point
│   ├── references.bib     # Sample bibliography
│   └── chapters/
│       ├── 01-introduction.typ
│       └── 02-methods.typ
│   └── appendices/
│       └── A-appendix.typ
├── LICENSE                # MIT or Apache 2.0 recommended
└── README.md              # Clear setup & usage documentation
```


---

## Quick Start

### 1. Local Package Setup

To use this template locally before it is published to Typst Universe, clone or copy this repository into your local Typst packages directory:

* **Linux:** `~/.local/share/typst/packages/local/psu-etd/0.1.0/`
* **macOS:** `~/Library/Application Support/typst/packages/local/psu-etd/0.1.0/`
* **Windows:** `%APPDATA%\typst\packages\local\psu-etd\0.1.0\`

Make sure `typst.toml`, `lib.typ`, and `src/` reside directly inside the `0.1.0/` folder.

### 2. Usage in `main.typ`

Import the package in your document:

```typst
#import "@local/psu-etd:0.1.0": psu-document, appendices

#show psu-document.with(
  title: "Spatial Reconstruction Algorithms for Hybrid CMOS X-Ray Sensors",
  field: "Astronomy and Astrophysics",
  author: "Firstname Lastname",
  degree: "Doctor of Philosophy",        // "Doctor of Philosophy" or "Master of Science"
  document-type: "dissertation",         // "dissertation" or "thesis"
  
  // Optional style overrides
  font: "Literata",
  heading-font: "Lexend",
  font-size: 12pt,
  margins: (left: 1.4in, top: 0.9in, right: 0.9in, bottom: 0.9in),
  degree-date: datetime(year: 2027, month: 5, day: 1), // Optional explicit date override

  committee: (
    ("Dr. Jane Doe", "Professor of Astronomy", "Chair of Committee"),
    ("Dr. John Smith", "Professor of Physics", "Member"),
  ),
  abstract: [ Insert abstract text here... ],
  acknowledgements: [ Insert acknowledgments here... ],
  bibliography_file: "references.bib",
  vita_content: [ Insert author biography here... ],
): doc

// --- MAIN BODY CHAPTERS ---
#include "chapters/01-introduction.typ"
#include "chapters/02-methods.typ"

// --- APPENDICES (OPTIONAL) ---
#show: appendices
// #include "chapters/appendix-a.typ"

```

---

## License

MIT License. Feel free to use, modify, and distribute for your own degree requirements.
