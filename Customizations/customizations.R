my_render = function(x) {
    rmarkdown::render('input.Rmd')
}

my_render(iris)

### Input parameters into Rmd
rmarkdown::render('example.Rmd', params = list(year = 2005))


### Use clean = FALSE preserves intermediate reports
rmarkdown::render('example.Rmd', params = list(year = 2005), clean = FALSE)
 
### Create the converted file 
f1 = tempfile()
rmarkdown::pandoc_convert(
  "basic.md",
  to = "json", from = "markdown", output = f1, wd = "."
)

x = jsonlite::fromJSON(f1, simplifyVector = FALSE)

raise_header = function(x) {
  lapply(x, function(el) {
    if (!is.list(el)) return(el)
    if (identical(el[["t"]], "Header")) {
      lvl = el[["c"]][[1]]
      if (lvl <= 1)
        stop("I don't know how to raise the level of h1")
      el[["c"]][[1]] = as.integer(lvl - 1)
    }
    raise_header(el)
  })
}
x = raise_header(x)

f2 = tempfile()  # to write out (the modified) JSON
f3 = tempfile()  # to write out Markdown
xfun::write_utf8(jsonlite::toJSON(x, auto_unbox = TRUE), f2)
rmarkdown::pandoc_convert(
  f2,
  to = "markdown", from = "json", output = f3,
  options = "--atx-headers", wd = "."
)
xfun::file_string(f3)

### Condition output  for within Rmd doc

```{asis, echo=identical(knitr:::pandoc_to(), 'html')}
knitr::kable(iris)
```

```{asis, echo=identical(knitr:::pandoc_to(), 'word')}
flextable(irisx)
```

