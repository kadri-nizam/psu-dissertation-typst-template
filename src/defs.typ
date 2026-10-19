// ============================================================================
// USER-CONFIGURABLE TEMPLATE DEFAULTS
// ============================================================================
#let config-font = "Literata"
#let config-heading-font = "Lexend"
#let config-font-size = 12pt
#let config-margins = (left: 1.4in, top: 0.9in, right: 0.9in, bottom: 0.9in)

// Automatic conferral date calculator (May, August, or December)
#let conferral_date() = {
  let today = datetime.today()
  return if today.month() <= 5 {
    datetime(year: today.year(), month: 5, day: 1)
  } else if today.month() <= 8 {
    datetime(year: today.year(), month: 8, day: 1)
  } else {
    datetime(year: today.year(), month: 12, day: 1)
  }
}

// Custom chapter heading style
#let chapter_style(head: none, body) = {
  if head != none {
    v(1.5in)
    smallcaps[#head]
    linebreak()
  } else {
    v(1.5in)
    linebreak()
  }
  text(size: 32pt)[
    *#body*
  ]
  line()
  v(0.5cm)
}

/// A comprehensive template for Penn State dissertations and theses complying
/// with Fox Graduate School guidelines.
///
/// - title (str): The title of the thesis or dissertation.
/// - field (str): The academic field or program name (e.g., "Astronomy and Astrophysics").
/// - author (str): The full name of the author.
/// - degree (str): The degree being conferred (e.g., "Doctor of Philosophy", "Master of Science").
/// - document-type (str): Either "dissertation" or "thesis".
/// - committee (array): An array of tuples representing committee members: `((name, creds, position), ...)`.
/// - abstract (content): The abstract content block.
/// - acknowledgements (content): The acknowledgments content block.
/// - list_of_symbols (content): Optional list of symbols or abbreviations.
/// - dedication (content): Optional dedication block.
/// - bibliography_file (str): Path to the bibliography .bib or .yml file.
/// - vita_content (content): The author vita content block.
/// - font (str): Base font family name.
/// - heading-font (str): Font family name for headings.
/// - font-size (length): Base font size for body text.
/// - margins (dictionary): Page margins dictionary.
/// - degree-date (datetime or str): Explicit conferral date override.
#let psu-document(
  title: none,
  field: none,
  author: none,
  degree: "Doctor of Philosophy",
  document-type: "dissertation",
  committee: (),
  abstract: none,
  acknowledgements: none,
  list_of_symbols: none,
  dedication: none,
  bibliography_file: none,
  vita_content: none,
  // Template overrides
  font: config-font,
  heading-font: config-heading-font,
  font-size: config-font-size,
  margins: config-margins,
  degree-date: none,
  doc,
) = {
  // Custom typeface and size setup
  set text(font: font, size: font-size)
  show heading: set text(font: heading-font)
  show heading: set heading(supplement: [Chapter])

  // Custom format for top level headings in the main matter
  show heading.where(level: 1, outlined: true): it => {
    if it.has("label") {
      pagebreak()
    }
    chapter_style(
      head: if it.has("label") { [
        Chapter #counter(heading).display().replace(".", "") -
      ]},
      it.body,
    )
  }

  // Page and paragraph setup
  set page(
    paper: "us-letter",
    margin: margins,
  )
  set par(justify: true)

  let final_date = if degree-date != none { degree-date } else { conferral_date() }
  let doc-type-cap = if document-type == "thesis" { "Thesis" } else { "Dissertation" }

  // ====================
  // TITLE PAGE
  // ====================
  [
    #set align(center)
    #v(-0.25in)
    The Pennsylvania State University\
    The J. Jeffrey and Ann Marie Fox Graduate School\
    Eberly College of Science

    #v(1fr)
    #text(weight: "bold", upper(title))
    #v(1fr)

    A #doc-type-cap in\
    #field\
    by\
    #author

    #v(1fr)
    © #datetime.today().year() #author
    #v(1fr)

    Submitted in Partial Fulfillment\
    of the Requirements\
    for the Degree of

    #v(1fr)
    #degree
    #v(1fr)

    #final_date.display("[month repr:long] [year]")
  ]
  pagebreak()

  // ====================
  // FRONT MATTER
  // ====================
  set page(
    numbering: "i",
    number-align: top + right,
  )
  counter(page).update(2)

  // Committee page
  [
    #let leading_space = if committee.len() == 6 { 1em } else { 1.5em }
    #set par(leading: leading_space)

    #v(-0.2in)
    The #document-type of #author was reviewed and approved#super[\*] by the following:
    #v(3 * leading_space)

    #block(inset: (left: 0.5in))[
      #for (name, creds, position) in committee {
        name; linebreak()
        creds; linebreak()
        if position.len() != 0 {
          position; linebreak()
        }
        linebreak()
      }
    ]
    #align(bottom)[
      \*Signatures are on file in the Graduate School.
    ]
  ]

  // Abstract
  pagebreak()
  [
    = Abstract
    #abstract
  ]

  // Table of Contents
  pagebreak()
  {
    show outline.entry.where(level: 1): set block(above: 0.75em)

    show outline.entry: it => link(
      it.element.location(),
      if (it.prefix() != none) and (it.level == 1) {
        v(0.75cm)
        show linebreak: none

        let prefix = if "A" in it.element.numbering {
          "Appendix"
        } else {
          "Chapter"
        }

        text(
          weight: "bold",
          smallcaps(
            if it.element.has("label") {[#prefix #it.prefix() --- #it.inner()]}
          )
        )
      } else {
        it.indented(it.prefix(), it.inner())
      }
    )

    outline(
      title: [
        #text(weight: "bold", size: 18pt, "Table of Contents")
        #v(2em)
      ],
      target: heading,
    )
  }

  // List of Tables
  pagebreak()
  outline(
    title: [
      #text(weight: "bold", size: 18pt, "List of Tables")
      #v(1.25em)
    ],
    target: figure.where(kind: table),
  )

  // List of Figures
  pagebreak()
  outline(
    title: [
      #text(weight: "bold", size: 18pt, "List of Figures")
      #v(1.25em)
    ],
    target: figure.where(kind: image),
  )

  // List of Symbols (Optional)
  if list_of_symbols != none {
    pagebreak()
    [
      = List of Symbols
      #list_of_symbols
    ]
  }

  // Acknowledgements
  pagebreak()
  [
    = Acknowledgments
    #acknowledgements
  ]

  // Dedication (Optional)
  if dedication != none {
    pagebreak()
    [
      #set align(center + horizon)
      #dedication
    ]
  }

  // ====================
  // MAIN MATTER
  // ====================
  pagebreak(weak: true)
  counter(page).update(1)
  set page(numbering: "1", number-align: top + right)

  set heading(numbering: "1.")
  show heading: it => {
    if it.level == 2 {
      set text(size: 18pt)
      it
      v(0.25em)
    } else {
      it
    }
  }

  // Render actual chapters/sections content
  doc

  // ====================
  // BACK MATTER & BIBLIOGRAPHY
  // ====================
  if bibliography_file != none {
    pagebreak()
    set par(spacing: 1em)
    show heading: set text(font: heading-font)

    [
      #bibliography(bibliography_file, style: "apa")
    ]
  }

  // Vita (Required for PhD, optional for Master's)
  if vita_content != none {
    pagebreak()
    set page(numbering: none)
    [
      #set align(center)
      #text(weight: "bold", size: 16pt)[Vita]\
      #text(weight: "bold", size: 12pt)[#author]
      #v(1.5em)
      #set align(left)
      #set par(justify: true)
      #vita_content
    ]
  }
}

// Helper function for Appendices
#let appendices(body) = {
  counter(heading).update(0)
  set heading(numbering: "A.1")
  show heading.where(level: 1, outlined: true): it => {
    pagebreak()
    chapter_style(
      head: [Appendix #counter(heading).display("A") - ],
      it.body,
    )
  }
  body
}
