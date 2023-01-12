box::use(shiny[moduleServer, NS],
         echarts4r[renderEcharts4r, echarts4rOutput])

box::use(app / logic / plot_func[tree_plot])

#' @export
ui <- function(id) {
  ns <- NS(id)
  echarts4rOutput(ns("tree_plot"))
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    output$tree_plot <- renderEcharts4r(tree_plot())
  })
}
