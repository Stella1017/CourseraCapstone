library(shiny)
library(shinythemes)

source(file = "./function/GetCleanedText.R")
source(file = "./function/GetBestGuess.R")
source(file = "./function/GetNext.R")
load("./Data/unigram.RData", envir = .GlobalEnv)
load("./Data/bigrams.RData", envir = .GlobalEnv)
load("./Data/trigrams.RData", envir = .GlobalEnv)
load("./Data/quadgrams.RData", envir = .GlobalEnv)


shinyServer(function(input, output, session) {
  #tab1
  voc <- reactive({GetVoc(input$inputtext1)})
  nxt <- reactive({GetNext(voc())})
  opt <- reactive({nxt()})
  
  output$mybutton1 <- renderUI({actionButton("opt1", label=renderText({ print(opt()[1]) }))})
  output$mybutton2 <- renderUI({actionButton("opt2", label=renderText({ print(opt()[2]) }))})
  output$mybutton3 <- renderUI({actionButton("opt3", label=renderText({ print(opt()[3]) }))})
  output$mybutton4 <- renderUI({actionButton("opt4", label=renderText({ print(opt()[4]) }))})
  
  observeEvent(
    input$opt1, {
      lbl <- renderText({ print(opt()[1]) })
      updateTextInput(session, "inputtext1", value = paste(input$inputtext1, lbl(), sep=" "))
    }
  )
  observeEvent(
    input$opt2, {
      lbl <- renderText({ print(opt()[2]) })
      updateTextInput(session, "inputtext1", value = paste(input$inputtext1, lbl(), sep=" "))
    }
  )
  observeEvent(
    input$opt3, {
      lbl <- renderText({ print(opt()[3]) })
      updateTextInput(session, "inputtext1", value = paste(input$inputtext1, lbl(), sep=" "))
    }
  )
  observeEvent(
    input$opt4, {
      lbl <- renderText({ print(opt()[4]) })
      updateTextInput(session, "inputtext1", value = paste(input$inputtext1, lbl(), sep=" "))
    }
  )
  
  #tab 2
  voc2 <- reactive({GetVoc(input$inputtext2)})
  slct <- reactive({c(input$slct1, input$slct2, input$slct3, input$slct4)})
  output$value <- eventReactive(input$button, {GetBestGuess(voc2(), slct())})
})
