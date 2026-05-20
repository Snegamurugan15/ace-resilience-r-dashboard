score_ace_level <- function(values) {
  total <- sum(as.numeric(values), na.rm = TRUE)

  level <- dplyr::case_when(
    total <= 10 ~ "Low",
    total <= 40 ~ "Moderate",
    TRUE ~ "High"
  )

  list(total = total, level = level)
}

