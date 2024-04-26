
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

#let rev_table(max_items: 3, data) = {
  // Build a revision table for the footer.
  // If no. revisions > max_items only max_items-1 will be shown
  
  data = data.rev()
  // rev_data comes in last to first, but rev table in footer is
  // latest on top.

  if data.len() > max_items {
    data = data.slice(0, max_items)
  }

  for rev in data{
      (
        rev.rev_no,
        rev.rev_date,
        rev.rev_desc,
        rev.rev_prep,
        rev.rev_check,
        rev.rev_app,)
    }
}

#let disclaimer = [
  _This calculation was prepared by SOME ENG COMPANY pursuant to the Engineering Services Contract between SOME ENG COMPANY and CLIENT in connection with the services for PROJECT TITLE_
  ]

#let engformat(
  title: none,
  authors: none,
  proj_no: none,
  calc_no: none,
  proj_title: none,
  client: none,
  proj_phase: none,
  logo_company: none,
  logo_client: none,
  rev_data: none,

  cols: 1,
  margin: (inside: 2.5cm, outside: 1.5cm, top: 4.5cm, bottom: 3.5cm),
  paper: "a4",
  lang: "en",
  region: "AU",
  font: ("calibri"),
  fontsize: 10pt,
  sectionnumbering: "1.1",
  toc: false,
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
      #if counter(page).get().first() !=1 {
        [
          #box(width:100%, stroke: (top: 1pt), outset:(top: 6pt)) 
          #set align(right)
          #set text(size: 9pt)
          #counter(page).display("1 of 1", both:true)
        ]
      } else {
        set text(size: 8pt)
        table(
          columns: (1fr,2fr,6fr,3fr,3fr,3fr,),
          table.header(
            table.cell(
              fill: black,
              text(
                fill: white,
                weight: "bold",
                [*Rev.*]
              )
            ),
            table.cell(
              fill: black,
              text(
                fill: white,
                weight: "bold",
                [*Date*]
              )
            ),
            table.cell(
              fill: black,
              text(
                fill: white,
                weight: "bold",
                [*Description*]
              )
            ),
            table.cell(
              fill: black,
              text(
                fill: white,
                weight: "bold",
                [*Prepared*]
              )
            ),
            table.cell(
              fill: black,
              text(
                fill: white,
                weight: "bold",
                [*Checked*]
              )
            ),
            table.cell(
              fill: black,
              text(
                fill: white,
                weight: "bold",
                [*Approved*]
              )
            )
            ),
            ..rev_table(rev_data)
          )
        disclaimer
      }
    ],
    footer-descent: 0%,
    header: [
      #set text(size: 8pt)
      #table(
        columns: 6*(1fr,),
        rows: (1.5cm, 0.5cm, 0.5cm, 0.5cm),
        table.cell(
          align: center,
          inset: 2pt,
          stroke: (right: (thickness: 0pt)
            )
          )[#logo(logo_path:logo_company)],
        table.cell(
          colspan:4,
          align: center + horizon
          )[#text(size: 28pt)[*CALCULATION SHEET*]],
        table.cell(
          align: center,
          inset: 2pt,
          stroke: (left: (thickness: 0pt)
            )
          )[#logo(logo_path:logo_client)],
        [*Project Title*],table.cell(colspan:3)[#proj_title],[*Project No.*],table.cell(align: right)[#proj_no],
        [*Client*],table.cell(colspan:3)[#client],[*Calculation No.*],table.cell(align: right)[#calc_no],
        [*Calculation Title*],table.cell(colspan:3)[#title],[*Revision*],table.cell(align: right)[#rev_data.last().rev_no],
        [*Project Phase*],table.cell(colspan:3)[#proj_phase],[*Date*],table.cell(align: right)[#rev_data.last().rev_date],
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
      #box(width: 100%, stroke: (bottom:1pt), outset: (bottom: .5em))[
      #set text(weight: "light", size: 17pt)
      #counter(heading).display(it.numbering) #smallcaps(it.body)]
      #v(0.5em)
    ]
  }

  if cols == 1 {
    doc
  } else {
    columns(cols, doc)
  }

}

#let like_header(it) = {
  v(0.5em)
  box(width: 100%, stroke: (bottom:1pt), outset: (bottom: -2pt))[
    #set text(weight: "light", size: 17pt)
    #smallcaps(it)
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
  paper: "us-letter",
  lang: "en",
  region: "US",
  font: (),
  fontsize: 11pt,
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
