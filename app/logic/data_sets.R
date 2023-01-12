box::use(readr[read_delim, read_rds],
         dplyr[mutate_if, pull],
         tibble[tibble],
         stringr[str_trim], stats[na.omit])
         


#' @export
drill_down <- read_delim("app/logic/drill_down.csv", delim = ";") |>
  mutate_if(is.character, str_trim)

#' @export
tree <- tibble(name = drill_down$group_1 |> unique(),
               children = list(
                 tibble(
                   name = drill_down$group_2 |> na.omit() |> unique(),
                   children = list(
                     tibble(
                       name = (drill_down$group_3 |> na.omit() |> unique())[1:14],
                       children = list(
                         tibble(name = (
                           drill_down$group_4 |> na.omit() |> unique()
                         )[1:2]),
                         tibble(name = (
                           drill_down$group_4 |> na.omit() |> unique()
                         )[3:5]),
                         NULL,
                         NULL,
                         tibble(
                           name = (drill_down$group_4 |> na.omit() |> unique())[6:7],
                           children = list(tibble(
                             name = (drill_down$group_5 |> na.omit() |> unique())[1:11]
                           ),
                           tibble(
                             name = (drill_down$group_5 |> na.omit() |> unique())[12:19]
                           ))
                         ),
                         NULL,
                         tibble(name = (
                           drill_down$group_4 |> na.omit() |> unique()
                         )[8:11]),
                         tibble(name = (
                           drill_down$group_4 |> na.omit() |> unique()
                         )[12:19]),
                         tibble(name = (
                           drill_down$group_4 |> na.omit() |> unique()
                         )[20:23]),
                         tibble(
                           name = (drill_down$group_4 |> na.omit() |> unique())[24:25],
                           children = list(tibble(
                             name = (drill_down$group_5 |> na.omit() |> unique())[20:23]
                           ),
                           tibble(
                             name = (drill_down$group_5 |> na.omit() |> unique())[24:25],
                             children = list(tibble(
                               name = (drill_down$group_6 |> na.omit() |> unique())[1:2]
                             ), NULL)
                           ))
                         ),
                         tibble(
                           name = (drill_down$group_4 |> na.omit() |> unique())[26:28],
                           children = list(tibble(
                             name = (drill_down$group_5 |> na.omit() |> unique())[26:28]
                           ),
                           NULL,
                           tibble(
                             name = (drill_down$group_5 |> na.omit() |> unique())[29:30]
                           ))
                         ),
                         tibble(
                           name = (drill_down$group_4 |> na.omit() |> unique())[29:30],
                           children = list(NULL,
                                           tibble(
                                             name = (drill_down$group_5 |>
                                                       na.omit() |>
                                                       unique())[31:34]
                                           ))
                         ),
                         tibble(
                           name = (drill_down$group_4 |> na.omit() |> unique())[31:32],
                           children = list(tibble(
                             name = (drill_down$group_5 |> na.omit() |> unique())[35:36]
                           ),
                           tibble(
                             name = (drill_down$group_5 |> na.omit() |> unique())[37:38]
                           ))
                         ),
                         NULL
                       )
                     ),
                     tibble(
                       name = (drill_down$group_3 |> na.omit() |> unique())[15:16],
                       children = list(
                         tibble(
                           name = (drill_down$group_4 |> na.omit() |> unique())[33:34],
                           children = list(tibble(
                             name = (drill_down$group_5 |> na.omit() |> unique())[39:40]
                           ),
                           NULL)
                         ),
                         tibble(
                           name = (drill_down$group_4 |> na.omit() |> unique())[33:34],
                           children = list(NULL, tibble(
                             name = (drill_down$group_5 |> na.omit() |> unique())[41:43]
                           ))
                         )
                       )
                     )
                   )
                 )
               ))

#' @export
group_1 <- drill_down |> pull(group_1) |> na.omit() |> unique()

#' @export
group_2 <- drill_down |> pull(group_2) |> na.omit() |> unique()

#' @export
group_3 <- drill_down |> pull(group_3) |> na.omit() |> unique()

#' @export
group_4 <- drill_down |> pull(group_4) |> na.omit() |> unique()

#' @export
group_5 <- drill_down |> pull(group_5) |> na.omit() |> unique()

#' @export
group_6 <- drill_down |> pull(group_6) |> na.omit() |> unique()

#' @export

table_name <- read_rds("app/logic/table_name.rds")


#' @export
max <- list(name = "Max",
            type = "max")
#' @export
min <- list(name = "Min",
            type = "min")
#' @export
avg <- list(type = "average",
            name = "AVG")
