

#' @export
dimple <- function(x,
                   y = NULL, 
                   xlab = NULL, 
                   ylab = NULL, 
                   width = NULL, 
                   height = NULL) {
  
  # determine default labels
  xlabel <- deparse(substitute(x))
  ylabel <- if (!missing(y)) 
    deparse(substitute(y))
  
  # determine coordinates
  coords <- grDevices::xy.coords(x, y, xlabel, ylabel)
  
  # final determination of labels
  xlab <- ifelse(is.null(xlab), coords$xlab, xlab)
  ylab <- ifelse(is.null(ylab), coords$ylab, ylab)
  
  # create widget data
  data <- data.frame(x = coords$x, y = coords$y)
  
  # create options
  options <- list()
  options$xlab <- xlab
  options$ylab <- ylab
  
  # create widget
  htmlwidgets::createWidget(
    name = "dimple",
    x = list(options = options, data = data),
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


