rm(list=ls())
library(shiny)
library(shinythemes)
library(markdown)

shinyUI(navbarPage("Capstone Project", theme=shinytheme("cerulean"),
    tabPanel("Document",
        includeMarkdown("Tab3Intro.md")
    ),
    tabPanel(title="Predictive Keyboard", 
        includeMarkdown("Tab1Intro.md"),
            
        textInput("inputtext1", strong("Please type here:")),
        div(style="display:inline-block", uiOutput("mybutton1")),
        div(style="display:inline-block", uiOutput("mybutton2")),
        div(style="display:inline-block", uiOutput("mybutton3")),
        div(style="display:inline-block", uiOutput("mybutton4"))
    ),
       
    tabPanel(title="Multiple Choices Question",
        includeMarkdown("Tab2Intro.md"),
        textInput("inputtext2", "Please type your sentence:"),
        div(style="display:inline-block", textInput("slct1", "First choice:", width = '120px')),
        div(style="display:inline-block", textInput("slct2", "Second choice:", width = '120px')),
        div(style="display:inline-block", textInput("slct3", "Third choice:", width = '120px')),
        div(style="display:inline-block", textInput("slct4", "Forth choice:", width = '120px')),
        br(),
        actionButton("button", label=strong("submit")),
        h4("  "),  
        h4("My best guess is:"),
        textOutput("value")
    )
  )
)
