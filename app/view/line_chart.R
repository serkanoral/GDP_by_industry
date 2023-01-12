box::use(shiny[moduleServer, NS, fluidPage, sidebarPanel, mainPanel,
               sidebarLayout, br],
         shinyWidgets[pickerInput],
         echarts4r[echarts4rOutput, renderEcharts4r])
box::use(app / logic / plot_func,
         app / logic / data_sets,
         app / main)


#' @export
ui <- function(id) {
  ns <- NS(id)
  fluidPage(sidebarLayout(
    sidebarPanel(
      pickerInput(
        inputId = ns("table_name"),
        label = "Table Name",
        choices = data_sets$table_name,
        selected = "Value Added by Industry (A) (Q)",
        multiple = FALSE
      ),
      pickerInput(
        inputId = ns("group_1"),
        label = "Level 1",
        choices = data_sets$group_1,
        selected = data_sets$group_1,
        multiple = TRUE,
        options = list(
          `actions-box` = TRUE,
          `deselect-all-text` = "None",
          `select-all-text` = "All",
          `none-selected-text` = "Non Selected"
        )
      ),
      pickerInput(
        inputId = ns("group_2"),
        label = "Level 2",
        choices = data_sets$group_2,
        selected = NULL,
        multiple = TRUE,
        options = list(
          `actions-box` = TRUE,
          `deselect-all-text` = "None",
          `select-all-text` = "All",
          `none-selected-text` = "Non Selected"
        )
      ),
      pickerInput(
        inputId = ns("group_3"),
        label = "Level 3",
        choices = data_sets$group_3,
        selected = NULL,
        multiple = TRUE,
        options = list(
          `actions-box` = TRUE,
          `deselect-all-text` = "None",
          `select-all-text` = "All",
          `none-selected-text` = "Non Selected"
        )
      ),
      pickerInput(
        inputId = ns("group_4"),
        label = "Level 4",
        choices = data_sets$group_4,
        selected = NULL,
        multiple = TRUE,
        options = list(
          `actions-box` = TRUE,
          `deselect-all-text` = "None",
          `select-all-text` = "All",
          `none-selected-text` = "Non Selected"
        )
      ),
      pickerInput(
        inputId = ns("group_5"),
        label = "Level 5",
        choices = data_sets$group_5,
        selected = NULL,
        multiple = TRUE,
        options = list(
          `actions-box` = TRUE,
          `deselect-all-text` = "None",
          `select-all-text` = "All",
          `none-selected-text` = "Non Selected"
        )
      ),
      pickerInput(
        inputId = ns("group_6"),
        label = "Level 6",
        choices = data_sets$group_6,
        selected = NULL,
        multiple = TRUE,
        options = list(
          `actions-box` = TRUE,
          `deselect-all-text` = "None",
          `select-all-text` = "All",
          `none-selected-text` = "Non Selected"
        )
      )
    ),
    mainPanel(br(),
              br(),
              echarts4rOutput(ns("line_chart")))
  ))
  
}

#' @export
server <- function(id, df) {
  moduleServer(id, function(input, output, session) {
    output$line_chart <- renderEcharts4r({
      plot_func$line_plot(
        data = df(),
        table_name = input$table_name,
        group_1 = input$group_1,
        group_2 = input$group_2,
        group_3 = input$group_3,
        group_4 = input$group_4,
        group_5 = input$group_5,
        group_6 = input$group_6
      )
    })
    
  })
}
