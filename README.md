# Engformat Format

A custom Typst format for writing engineering calculations that export nicely to PDF.

## Installing

```bash
quarto use template skane88/quarto-engformat
```

This will install the format extension and create an example qmd file
that you can use as a starting place for your document.

## Using
To use the template, the following properties need to be filled out in the .yaml metadata at the front of the document:

```YAML
title: Some Calculation  # this is the title of the calculation document
format:
  engformat-typst:
    company: Some Company  # The name of your company. Used in the disclaimer
    proj_no: 24xxx  # the project number, displayed in the header.
    calc_no: 24xxx-ST-CAL-0001  # the calculation number, displayed in the header.
    proj_title: Some Project  # the project number.
    client: Some Client  # the name of the client, for the header and the disclaimer.
    proj_phase: Detailed Design  # The project phase, displayed in the header.
# provide logos for the company (top LHS of header) and the client (top RHS)
# Note that using _ in the file names appears to give errors.
    logo_company: "logo-company.jpg" 
    logo_client: "logo-client.jpg"

  # provide a list of revisions, in descending order (e.g. add new revisions at the bottom). Each revision field should include:
  # rev_no: the revision number
  # rev_desc: a description of the revision
  # rev_date: the revision date.
  # rev_prep: who prepared the document.
  # rev_check: who checked the document.
  # rev_app: who approved the document.
  # Note that only the bottom 3x entries will be displayed in the PDF
    revisions:
    - rev_no: A
      rev_date: 24/04/2024
      rev_desc: Preliminary
      rev_prep: A. Engineer
      rev_check: B. Engineer
      rev_app: C. Engineer
    - rev_no: B
      ...
```