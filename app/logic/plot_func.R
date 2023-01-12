box::use(echarts4r[e_charts, e_bar, e_line, e_tree, e_theme,
                   e_datazoom, e_tooltip, e_toolbox_feature, e_mark_point],
         dplyr[filter, group_by],)

box::use(app / logic / data_sets)


#' @export
line_plot <-
  function(data,
           table_name,
           group_1 = data_sets$group_1,
           group_2 = NULL,
           group_3 = NULL,
           group_4 = NULL,
           group_5 = NULL,
           group_6 = NULL) {
    data |>
      filter(TableName == table_name) |>
      filter(
        IndustrYDescription %in% group_1 |
          IndustrYDescription %in% group_2 |
          IndustrYDescription %in% group_3 |
          IndustrYDescription %in% group_4 |
          IndustrYDescription %in% group_5 |
          IndustrYDescription %in% group_6
      ) |>
      group_by(IndustrYDescription) |>
      e_charts(Date) |>
      e_line(DataValue) |>
      e_theme("westeros") |>
      e_datazoom(type = "slider") |>
      e_tooltip(trigger = "axis") |>
      e_toolbox_feature(feature = "saveAsImage") |> 
      e_mark_point(data = data_sets$max) |> 
      e_mark_point(data = data_sets$min)
  }

#' @export
tree_plot <- function(data = data_sets$tree) {
  data |>
    e_charts() |>
    e_tree() |>
    e_theme("westeros") |>
    e_toolbox_feature(feature = "saveAsImage") 
}
