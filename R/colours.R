#' Complete list of palettes
#'
#' Use \code{\link{beyonce_palette}} to construct palettes of desired length.
#'
#' @name beyonce_palettes
#' @docType data
NULL

#' Beyoncé palette generator
#'
#' A lot of Beyoncé colour palettes.
#'
#' @param n Number of colours desired. Unfortunately most palettes now only
#'   have 4 or 5 colours. But hopefully we'll add more palettes soon. All colour
#'   schemes are derived from the most excellent Tumblr blog:
#'   \href{http://beyoncepalettes.tumblr.com/}{Beyoncé Palettes}.
#'   If omitted, uses all colours.
#' @param number ID of desired palette (1 to 130)
#' @param type Either "continuous" or "discrete". Use continuous if you want
#'   to automatically interpolate between colours.
#' @return A vector of colours.
#' @export
#' @keywords colours
#' @examples
#' beyonce_palette(1, 3)
#'
#' # If you need more colours than normally found in a palette, you
#' # can use a continuous palette to interpolate between existing
#' # colours
#' pal <- beyonce_palette(21, number = 2, type = "continuous")
#' image(volcano, col = pal)
beyonce_palette <- function(number, n, type = c("discrete", "continuous")) {
  type <- match.arg(type)

  data("beyonce_palettes")
  pal <- beyonce_palettes[[number]]
  if (is.null(pal))
    stop("Palette not found.")

  if (missing(n)) {
    n <- length(pal)
  }

  if (type == "discrete" && n > length(pal)) {
    stop("Number of requested colours greater than what palette can offer")
  }

  out <- switch(type,
    continuous = colorRampPalette(pal)(n),
    discrete = pal[1:n]
  )
  structure(out, class = "palette", number = number)
}

#' @export
print.palette <- function(x, ...) {
  n <- length(x)
  old <- par(mar = c(0.5, 0.5, 0.5, 0.5))
  on.exit(par(old))

  image(1:n, 1, as.matrix(1:n), col = x,
    ylab = "", xaxt = "n", yaxt = "n", bty = "n")

  rect(0, 0.9, n + 1, 1.1, col = rgb(1, 1, 1, 0.8), border = NA)
  text((n + 1) / 2, 1, labels = attr(x, "number"), cex = 1, family = "serif")
}

#' heatmap
#'
#' A heatmap example
"heatmap"
