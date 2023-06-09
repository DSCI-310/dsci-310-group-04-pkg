#' Create a dataframe showing percent proportions
#'
#' Creates a new data frame with three columns,
#' listing the unique values in a column for the input data frame,
#' and the number of observations for each value,
#' along with its proportion of the total data.
#'
#' @param data A data frame or data frame extension (e.g. a tibble).
#' @param to_prop A string name of the column to be proportionalized.
#' @param descriptor A string that can be added to describe from what data the proportion originated from.
#'
#' @return A data frame. The output has the following properties:
#'
#' * The first column (has the same name as the to_prop parameter) lists the unique values from the to_prop named column of the input data frame.
#' * The second column (has the name of the descriptor + "_n") lists the number of observations for each value from the first column.
#' * The third column (has the name of the descriptor + "_prop") lists the percent proportion of the column 1 value out of the whole original dataset.
#'
#' @export
#'
#' @examples
#' one_value_2 <- data.frame(first_column = c("class1", "class1"))
#' count_proportion(one_value_2, 'first_column', 'one')

count_proportion <- function(data, to_prop, descriptor) {

  if (!is.data.frame(data)) {
    stop("`data` should be a data frame")
  }
  if (!is.character(to_prop) | !length(to_prop) == 1) {
    stop("`to_prop should be a string")
  }
  if (!is.character(descriptor) | !length(descriptor) == 1) {
    stop("`descriptor should be string")
  }
  tbr <- data |>
    dplyr::group_by(data[to_prop]) |>
    dplyr::summarize(n = dplyr::n()) |>
    dplyr::mutate(prop = 100* n/nrow(data))
  colnames(tbr) <- c(to_prop, paste(descriptor,"_n",sep = ""), paste(descriptor,"_prop",sep = "")) ## need to add `sep = ""` otherwise it'll default a space
  return(tbr)
}

globalVariables("n")
