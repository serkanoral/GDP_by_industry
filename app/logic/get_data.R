box::use(bea.R[beaGet], xml2[read_xml, xml_find_all, xml_attr],
         tibble[tibble],
         dplyr[left_join, select, case_when, mutate, pull],
         readr[write_rds], )


# You have to get your own API key and replace with Sys.getenv("HOME"), "/.Renviron"

#' @export
load_data <- function() {
  path <- paste0(Sys.getenv("HOME"), "/.Renviron")
  readRenviron(path)
  bea_specs <- list(
    "UserID" = Sys.getenv("API_KEY"),
    # Set up API key
    "Method" = "GetData",
    # Method
    "datasetname" = "GDPbyIndustry",
    # Specify dataset
    "Frequency" = "Q",
    # Specify table within the dataset
    "Industry" = "ALL",
    # Specify the line code
    "TableID" = "ALL",
    # Specify the geographical level
    "Year" = "ALL" # Specify the year
  )
  
  # data
  data <- beaGet(bea_specs, asWide = FALSE)
  
  # table names
  
  xml_data <-
    read_xml(
      paste0(
        "https://apps.bea.gov/api/data/?&UserID=",
        Sys.getenv("API_KEY"),
        "&method=GetParameterValues&DataSetName=GDPbyIndustry&ParameterName=TableID&ResultFormat=xml"
      )
    )
  
  xml_list <- xml_find_all(xml_data, ".//ParamValue")
  
  TableID <- xml_list |> xml_attr(attr = "Key")
  TableName <- xml_list |> xml_attr(attr = "Desc")
  
  table_ <- tibble("TableID" = TableID, "TableName" = TableName)
  
  df <-  data |>
    left_join(table_, by = c("TableID" = "TableID")) |>
    select(-Frequency,-TableID, -DataValue.1) |>
    mutate(Month = case_when(Quarter == "I" ~ 1,
                             Quarter == "II" ~ 4,
                             Quarter == "III" ~ 7,
                             TRUE ~ 10)) |>
    mutate(Date = as.Date(paste0(Year, "-", Month, "-", 1))) |>
    select(-Year, -Quarter, -NoteRef,-Month,-Industry)
  
  df |> pull(TableName) |>  unique() |> write_rds("app/logic/table_name.rds")
  
  return(df)
}
