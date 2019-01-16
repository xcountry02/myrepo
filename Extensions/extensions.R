library(kableExtra)
# HTML Table
mtcars[1:4, 1:4] %>%
  kable() %>%
  kable_styling() %>%
  add_header_above(c(" ", "RStudio" = 2, "Conf" = 2)) %>%
  group_rows("ARM workshop", start_row = 3, end_row = 4)

## Same table, but for LaTeXS
mtcars[1:4, 1:4] %>%
  kable("latex", booktabs = T) %>%
  add_header_above(c(" ", "RStudio" = 2, "Conf" = 2)) %>%
  group_rows("ARM workshop", start_row = 3, end_row = 4) %>%
  kable_styling(latex_options = "striped")


x <- kable(mtcars[1:2, 1:2], "html")

attributes(x)

kableExtra:::read_kable_as_xml(x)

x_xml <- x %>%
  kable_styling(bootstrap_options = "striped") %>%
  kableExtra:::read_kable_as_xml() 

library(xml2)

x_xml %>%           # table level
  xml_child(2) %>%  # Select tbody
  xml_child(1) %>%  # Select first row in body
  xml_child(1) %>%  # Select first column at first row
  xml_set_attr("style", "color: red;") # Adjust color through CSS

kableExtra:::as_kable_xml(x_xml)

library(htmltools)
simple_html_tag <- htmltools::tags$tr(list(
  htmltools::tags$td("a"), 
  htmltools::tags$td("b")
)) 
print(simple_html_tag)

read_xml(as.character(simple_html_tag)) 

knit_print.knitr_kable = function(x, ...) {
  x = paste(c(
    if (!(attr(x, 'format') %in% c('html', 'latex'))) c('', ''), x, '\n'
  ), collapse = '\n')
  asis_output(x)  
}


sample_latex <- kable(mtcars[1:2, 1:2], "latex", booktabs = T)
print(sample_latex)

kableExtra::magic_mirror(sample_latex)
