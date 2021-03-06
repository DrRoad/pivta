#' webdatarocks.js htmlwidget
#'
#' @description use webdatarocks.js in R to display a pivot table, plus other data analysis tools in the form of a widget
#'
#' @param dsource optional. Allows the user to specify ex-ante the location of the csv/json data frame.
#'
#' @param sep the csv data frame separator. Defaults to comma (","). Will be ignored if data is json.
#'
#' @param report optional. Allows the user to specify ex-ante the location of the json report file.
#'
#' @param width the width of the widget.
#'
#' @param height the height of the widget.
#'
#' @examples
#'
#'
#' if (interactive()) {
#'
#' # Using pivta() within a Shiny application
#'
#' ui <- fluidPage(
#'
#' pivtaOutput(outputId = "pivot_table")
#'
#' )
#'
#' server <- function(input, output) {
#'
#'
#' output$pivot_table <- renderPivta({
#'
#' pivta()
#'
#'
#' })
#'
#'
#' }
#'
#'
#' shinyApp(ui = ui, server = server)
#'
#'
#' }
#'
#'
#' @import htmlwidgets
#'
#' @export
#'

pivta <- function(dsource = "",
                  sep = ",",
                  report = "",
                  width = NULL,
                  height = NULL) {

  # forward options using x
  x = list(
    dsource = dsource,
    report = report,
    sep = sep
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'pivta',
    x,
    width = width,
    height = height,
    package = 'pivta'
  )
}

#' Shiny bindings for pivta
#'
#' Output and render functions for using pivta within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a pivta
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name pivta-shiny
#'
#' @export
pivtaOutput <- function(outputId,  width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'pivta', width, height, package = 'pivta')
}

#' @rdname pivta-shiny
#' @export
renderPivta <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, pivtaOutput, env, quoted = TRUE)
}
