box::use(app/logic/get_data)
box::use(dplyr[pull], readr[write_rds],  rsconnect[deployApp])


get_data$load_data()|> 
  pull(TableName) |>  
  unique() |> 
  write_rds("app/logic/table_name.rds")

get_data$load_data() |> 
  write_rds("app/logic/df.rds")


deployApp(appName = "GDP_by_indusry",upload = TRUE,  launch.browser = FALSE,forceUpdate = TRUE)
