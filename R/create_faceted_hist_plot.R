#' Create a faceted plot for a target variable
#'
#' Creates a faceted plot for the target variable
#' including the selected feature
#' combined using the face_grid() function
#'
#' @param df Tidy data containing a list of genres and acoustic features, as a `df`.
#' @param feature Specified acoustic feature of which we want a visualization, as a `character`.
#' @param row Input to 'rows' parameter of `facet_grid()`, as a `character`.
#'
#' @return A faceted plot of multiple histograms.
#' @export
#' @examples
#' data <- as.data.frame(data("iris"))
#' plot <- create_faceted_hist_plot(data, 'Petal.Length', 'Species')

#' @importFrom ggplot2 ggplot aes geom_bar facet_grid

create_faceted_hist_plot <- function(df,feature,row) {
  if (!is.character(feature)) {
    stop("`feature` should be a string")
  }
  if (!is.character(row)) {
    stop("`row` should be a string")
  }
  if (!is.data.frame(df)) {
    stop("`df` should be a data frame")
  }
  if (nrow(df) == 0) {
    stop("`df` should be a data frame")
  }
  xvar <- rlang::sym(feature)

  ggplot(df, aes(x = !!xvar)) +
    geom_bar(stat = "bin", bins = 20)  +
    facet_grid(rows = row)
}
