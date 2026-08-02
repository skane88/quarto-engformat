
// This is an example typst template (based on the default template that ships
// with Quarto). It defines a typst function named 'engformat' which provides
// various customization options. This function is called from the 
// 'typst-show.typ' file (which maps Pandoc metadata function arguments)
//
// If you are creating or packaging a custom typst template you will likely
// want to replace this file and 'typst-show.typ' entirely. You can find 
// documentation on creating typst templates and some examples here: 
//   - https://typst.app/docs/tutorial/making-a-template/
//   - https://github.com/typst/templates

#let logo(logo_path:none) = {
  if logo_path != none {[#image(logo_path)]} else {[]}
}

#let engformat(
  title: none,
  authors: none,

  proj_number: none,
  proj_name: none,
  calc_no: none,
  calc_title: none,
  proj_phase: none,
  logo_company: none,
  rev_data: none,

  cols: 1,
  margin: (inside: 2.5cm, outside: 1.5cm, top: 4cm, bottom: 2cm),
  paper: "a4",
  lang: "en",
  region: "AU",
  font: ("Arial"),
  fontsize: 10pt,
  sectionnumbering: "1.1",
  doc
  ) = {

    if rev_data == none {
      let rev_data = (
        rev_no: none,
        rev_date: none,
        rev_desc: none,
        rev_prep: none,
        rev_check: none,
        rev_app: none,
      )
    }

    set page(
    paper: paper,
    margin: margin,
    numbering: "1",
    footer: context [
      #set text(font: ("Arial"), size: 10pt, weight: "regular")
      #show table.cell.where(y: 0): set text(weight: "regular")
      #table(
        columns: (1fr, 1fr),
        fill: none,
        stroke: (x, y) => (top: if y == 0 { 0.5pt + rgb("3f4042") } else { none }),
        table.cell(align: left)[ROCKFIELD TECHNOLOGIES AUSTRALIA], table.cell(align: right)[COMMERCIAL IN CONFIDENCE],
        [], table.cell(align: right)[Page #counter(page).display("1 of 1", both: true)],
      )
    ],
    footer-descent: 10%,
    header: [
      #set text(size: 8pt, fill: rgb("333333"), font: ("Arial"))
      #show table.cell.where(y: 0): set text(fill: rgb("333333"), weight: "regular", font: ("Arial"))
      #table(
        columns: (2.0fr, 1.9fr, 3.1fr, 1.5fr, 1.5fr),
        rows: (0.5cm, 0.5cm, 0.5cm, 0.5cm, 0.5cm),
        fill: none,
        stroke: 0.5pt + rgb("333333"),
        align: (x, y) => if x == 0 and y == 0 { center + horizon } else { left },
        table.cell(
          inset: 2pt,
          )[#logo(logo_path:logo_company)],
        table.cell(colspan: 4)[*Design Development Plan Form*],
        [*Project Name*],table.cell(colspan: 4)[#proj_name],
        [*Project Number*],table.cell(colspan: 4)[#proj_number],
        [*Document Author*],table.cell(colspan: 4)[#rev_data.last().rev_prep],
        [*File Name*],table.cell(colspan: 2)[#calc_no #calc_title],[*Issued Date*],table.cell(align: right)[#rev_data.last().rev_date],
      )
    ],
    header-ascent: 10%,
  )
  set par(justify: true)
  set text(lang: lang,
           region: region,
           font: font,
           size: fontsize)
  set heading(numbering: sectionnumbering)
  
  // format heading 1 differently from the rest.
  show heading.where(
    level: 1
  ): it => {
    block(width: 100%)[
      #box(width: 100%, stroke: (bottom:0.5pt + rgb("000000")), outset: (bottom: .5em))[
      #set text(weight: "bold", size: 16pt, font: ("Arial"), fill: (rgb("228C3D")))
      #it]
      #v(0.5em)
    ]
  }

  // format heading 2 differently from the rest.
  show heading.where(
    level: 2
  ): it => text(weight: "bold", size: 12pt, font: ("Arial"), fill: (rgb("228C3D")), it)

  // format heading 3 differently from the rest.
  show heading.where(
    level: 3
  ): it => text(weight: "bold", size: 10pt, font: ("Arial"), fill: (rgb("228C3D")), it)

  // format links.
  show link: it => underline(text(fill: rgb("#004270"), it))

  // format code.
  show raw: set text(font: "Arial")

  show table.cell.where(y: 0): set text(weight: "bold", font: ("Arial"))
  set table(
    fill: (_, y) => if y == 0 { rgb("e5e5e6")},
    stroke: (x, _) => (
      top: 0.5pt + rgb("3f4042"),
      bottom: 0.5pt + rgb("3f4042"),
      left: if x > 0 { 0.5pt + rgb("3f4042") } else { none },
    ),
  )
  show table: it => align(center, it)

  place(
    bottom,
    float: true,
    [
      #text(weight: "bold", size: 12pt, fill: rgb("228c3d"))[QA Record]
      #set text(size: 8pt)
      #table(
          columns: (1.3fr, 2fr, 1.1fr, 2fr, 1.3fr, 2fr, 2fr),
          fill: none,
          [#text(weight: "bold", fill: rgb("004270"))[Originator]],
          [#text(weight: "regular")[#rev_data.last().rev_prep]],
          [#text(weight: "bold", fill: rgb("004270"))[Checked]],
          [#text(weight: "regular")[#rev_data.last().rev_check]],
          [#text(weight: "bold", fill: rgb("004270"))[Approved]],
          [#text(weight: "regular")[#rev_data.last().rev_app]],
          [#text(weight: "regular")[#rev_data.last().rev_date]],
          )
      #v(1.5em)
    ]
    )
  

  if cols == 1 {
    doc
  } else {
    columns(cols, doc)
  }

}

#let like_header(it) = {
  v(0.5em)
  box(width: 100%, stroke: (bottom:0.5pt + rgb("000000")), outset: (bottom: -2pt))[
    #set text(weight: "bold", size: 16pt, font: ("Arial"), fill: (rgb("228C3D")))
    #it
    #v(0.5em)
  ]
}

#let article(
  title: none,
  authors: none,
  date: none,
  abstract: none,
  cols: 1,
  margin: (x: 1.25in, y: 1.25in),
  paper: "a4",
  lang: "en",
  region: "US",
  font: (),
  fontsize: 10pt,
  sectionnumbering: none,
  toc: false,
  doc,
) = {
  

  if title != none {
    align(center)[#block(inset: 2em)[
      #text(weight: "bold", size: 1.5em)[#title]
    ]]
  }

  if authors != none {
    let count = authors.len()
    let ncols = calc.min(count, 3)
    grid(
      columns: (1fr,) * ncols,
      row-gutter: 1.5em,
      ..authors.map(author =>
          align(center)[
            #author.name \
            #author.affiliation \
            #author.email
          ]
      )
    )
  }

  if date != none {
    align(center)[#block(inset: 1em)[
      #date
    ]]
  }

  if abstract != none {
    block(inset: 2em)[
    #text(weight: "semibold")[Abstract] #h(1em) #abstract
    ]
  }

  if toc {
    block(above: 0em, below: 2em)[
    #outline(
      title: auto,
      depth: none
    );
    ]
  }

}
