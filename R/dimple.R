

#' @export
dimple <- function(data,
                   x = NULL,
                   y = NULL, 
                   xlab = NULL, 
                   ylab = NULL, 
                   width = NULL, 
                   height = NULL) {
   
  # validate we got data
  if (missing(data))
    stop("data parameter is required")
  
  # get the unevaluated data expression (for y axis label)
  dataExpr <- deparse(substitute(data))
  
  # resolve x and y formula-style syntax
  if (inherits(x, "formula"))
    x <- lattice::latticeParseFormula(x, data = data)$right.name
  if (inherits(y, "formula"))
    y <- lattice::latticeParseFormula(y, data = data)$right.name
   
  # if this isn't a data frame then generate one using xy.coords
  if (!is.data.frame(data)) {
    coords <- grDevices::xy.coords(data, xlab = x, ylab = y)
    if (is.null(coords$xlab))
      coords$xlab <- "x"
    if (is.null(coords$ylab))
      coords$ylab <- "y"
    data <- list()
    data[[coords$xlab]] <- coords$x
    data[[coords$ylab]] <- coords$y
    data <- as.data.frame(data)
    
    # if no y or ylab is specified then use the original 
    # expression as the y label
    if (is.null(y) && is.null(ylab))
      ylab <- dataExpr
  }
  
  # resolve x and y
  if (is.null(x))
    x <- names(data)[[1]]
  if (is.null(y))
    y <- names(data)[[2]]
  
  # resolve labels
  xlab <- ifelse(is.null(xlab), x, xlab)
  ylab <- ifelse(is.null(ylab), y, ylab)
   
  # create "auto" options (overriden by explicit axes, series, etc.)
  auto <- list()
  auto$xAxis <- axis(position = "x", 
                     title = xlab, 
                     measure = x)
  auto$yAxis <- axis(position = "y", 
                     title = ylab, 
                     measure = y)
  auto$series <- series(categoryFields = NULL, 
                        plotFunction = "bubble")
  
  # create widget
  htmlwidgets::createWidget(
    name = "dimple",
    x = list(options = list(auto = auto), data = data),
    width = width,
    height = height,
    htmlwidgets::sizingPolicy(viewer.paneHeight = 400, 
                              browser.fill = TRUE)
  )
  
}

#' Shiny bindings for dimple
#' 
#' Output and render functions for using dimple within Shiny 
#' applications and interactive Rmd documents.
#' 
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{"100\%"},
#'   \code{"400px"}, \code{"auto"}) or a number, which will be coerced to a
#'   string and have \code{"px"} appended.
#' @param expr An expression that generates a dimple graph
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This 
#'   is useful if you want to save an expression in a variable.
#'   
#' @name dimple-shiny
#'
#' @export
dimpleOutput <- function(outputId, width = "100%", height = "400px") {
  htmlwidgets::shinyWidgetOutput(outputId, "dimple", width, height)
}

#' @rdname dimple-shiny
#' @export
renderDimple <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, dimpleOutput, env, quoted = TRUE)
}


