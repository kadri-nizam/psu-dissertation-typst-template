#import "@preview/psu-etd:0.1.0": psu-document, appendices
// #import "../lib.typ": psu-document, appendices

#show: psu-document.with(
  title: "Interesting Dissertation Topic",
  field: "Astronomy and Astrophysics",
  document-type: "dissertation",
  degree: "Doctor of Science",
  author: "John Doe",
  committee: (
    ("Reader Zero", "Professor of Astronomy", "Chair of Committee"),
    ("Reader One", "Professor of Physics", "Reader"),
    ("Reader Two", "Professor of Aerospace Engineering", "Reader"),
    ("Reader Three", "Associate Professor of Statistics", "Reader"),
  ),
  abstract: [
    #include "front-matter/abstract.typ"
  ],
  acknowledgements: [
    #include "front-matter/acknowledgements.typ"
  ],
  // If you don't need a symbols page, just do: list_of_symbols: none
  list_of_symbols: [ #include "front-matter/symbols.typ" ],
  dedication: [ _To those who look up._ ],
  bibliography_file: "../example/references.bib",
  vita_content: [
    #include "vita.typ"
  ],
)

// ====================
// CHAPTERS
// ====================
#include "chapters/01-introduction.typ"
#include "chapters/02-interesting.typ"

// ====================
// APPENDICES
// ====================
#show: appendices

#include "appendices/A-appendix.typ"
