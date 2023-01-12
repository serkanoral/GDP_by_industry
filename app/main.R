box::use(shiny[fluidPage, moduleServer, NS, reactive, tags, br, p, h2, a, reactiveFileReader],
         readr[read_rds])

box::use(app / view / tree_chart,
         app / view / line_chart,
         app / logic / get_data)




#' @export
ui <- function(id) {
  ns <- NS(id)
  fluidPage(
    br(),
    br(),
    h2("GDP BY INDUSTRY"),
    br(),
    p("This shiny app gives information about how each indusry effect U.S. economy. 
      All data is recived from Bereau of Economic Analysis U.S Department of Commerce. 
      You may find the link below the dashboard."),
    br(),
    p("Below you can see how the data is devided, you can click elements and expand or scale down.
      Before diving into actual chart, it's a good way to understand the general structure."),
    br(),
    p("For our line chart, first you need to choose the table name, which is what are you looking for? 
      Then you can choose levels and compare them. Inputs are not a drill down selections, so you may compare values between different levels."),
    tree_chart$ui(ns("tree_chart")),
    line_chart$ui(ns("line_chart")),
    a("https://www.bea.gov")
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    
    df <- reactiveFileReader(86400000, session, "app/logic/df.rds", read_rds)
    line_chart$server("line_chart", df)
    tree_chart$server("tree_chart")
  })
}
