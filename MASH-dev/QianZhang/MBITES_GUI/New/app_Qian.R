################################################################################################################
# MBITES: Gadget
# October 2017
################################################################################################################
library(shiny)
library(miniUI)
library(ggplot2)
library(shinythemes)
library(shinyjs)
library(shinydashboard)
library(plotly)
library(markdown)
library(igraph)
library(jsonlite)
if(system("whoami",intern=TRUE) == "chipdelmal"){
  DIR = "/Users/chipdelmal/Documents/Github/MASH-MAIN/MASH-dev/HectorSanchez/MBITES_GUI/New/"
  setwd(DIR)
}else if(system("whoami",intern=TRUE) == "qianzh"){
  DIR = "/Users/qianzh/project/MASH-Main/MASH-dev/QianZhang/MBITES_GUI/NEW"
  setwd(DIR)
}

################################################################################################################
# CONSTANTS
################################################################################################################
INITIAL_GUI_WIDTH = 2000
INITIAL_GUI_HEIGHT = 1000
VAR_DESCR_COL_WIDTH = 3
VAR_SLIDE_COL_WIDTH = 4
THEME = "flatly"#themeSource="https://bootswatch.com/flatly/"
################################################################################################################
mbitesGadget = function(...){
  #########################################################################################
  # UI
  #########################################################################################
  ui = shinyUI(fluidPage(theme = shinytheme(THEME),
      tags$head(tags$script("
        window.onload = function() {
            $('#nav a:contains(\"Options\")').parent().addClass('hide');
            $('#nav a:contains(\"Bouts\")').parent().addClass('hide');
            $('#nav a:contains(\"Landscape\")').parent().addClass('hide');
            $('#nav a:contains(\"Ecology\")').parent().addClass('hide');
        };

        Shiny.addCustomMessageHandler('activeNavs', function(nav_label) {
            $('#nav a:contains(\"' + nav_label + '\")').parent().removeClass('hide');
        });
   ")),
                       
      titlePanel(h1("MBITES Gadget")),
      navbarPage("Welcome ", id = "nav",
          #################################################################################
          tabPanel("Get Started",
              navlistPanel(widths = c(2,4),
                tabPanel("Overview",
                  includeMarkdown("instructions.md"),
                  img(src='boutFull.png',align="center",width="50%")
                ),
                ###########################################################################
                tabPanel("Launch a project",
                  h2("Welcome to MBITES!"), 
                  hr(),
                  h4("To launch your project, please choose:"),
                  radioButtons("project", "", 
                    c("First time user (Run our demo project)" = "demo",
                      "Start a new project" = "new",
                      "Work on an existing project" = "exist")),
                  uiOutput("prepath.box"),
                  hr(),
                  actionButton("launchgo", "Go!")
                )
              )
           ),
          #################################################################################
          tabPanel(title = "Options", value = "options",
            fluidPage(
              helpText("Please choose parameters:"),
              navlistPanel(widths = c(2,10),
                #########################################################################
                tabPanel("Senescence",
                  checkboxInput(inputId = "senesce", label = "Mortality during Generic Flight", value = FALSE),
                  sliderInput(inputId = "sns.a", label ="Exp: a",
                              value = 0.085, min = 0, max = 0.1, step = 0.001),
                  sliderInput(inputId = "sns.b", label ="Exp: b",
                              value = 100, min = 0, max = 1000, step = 1)
                  ),
                ###########################################################################
                tabPanel("Wing Tattering",
                  checkboxInput(inputId = "tatter", label = "During Generic Flight", value = FALSE),
                  sliderInput(inputId = "ttsz.p", label ="Zero-inflation for Tattering Damage",
                              value = 0.5, min = 0, max = 1, step = 0.1),
                  sliderInput(inputId = "ttsz.a", label ="Shape Param: a for Tattering Damage",
                              value = 5, min = 0, max = 100, step = 1),
                  sliderInput(inputId = "ttsz.b", label ="Shape Param: b for Tattering Damage",
                              value = 95, min = 0, max = 100, step = 1),
                  sliderInput(inputId = "ttr.a", label ="Exp: a for Tattering Survival",
                              value = 15, min = 0, max = 100, step = 1),
                  sliderInput(inputId = "ttr.b", label ="Exp: b for Tattering Survival",
                              value = 500, min = 0, max = 1000, step = 10)
                  ),
                ################################################################################
                tabPanel("Blood Feeding"
                  ),
                tabPanel("Energetics",
                  sliderInput(inputId = "S.u", label ="Per-bout Energy Expenditure",
                              value = 1/7, min = 0, max = 1, step = 0.01),
                  hr(),
                  tags$h4("As Function of Energy Reserves:"),
                  sliderInput(inputId = "S.a", label ="Shape Param a of per-bout Probabilityof Survival",
                              value = 20, min = 0, max = 100, step = 1),
                  sliderInput(inputId = "S.b", label ="Shape Param b of per-bout Probabilityof Survival",
                              value = 10, min = 0, max = 100, step = 1),
                  sliderInput(inputId = "S.sa", label ="Shape Param a of Probability to queue Sugar bout",
                              value = 20, min = 0, max = 100, step = 1),
                  sliderInput(inputId = "S.sb", label ="Shape Param b of Probability to queue Sugar bout",
                              value = 10, min = 0, max = 100, step = 1),
                  sliderInput(inputId = "energypreg", label ="Pre-gonotrophic Energy Requirement",
                              value = 0, min = 0, max = 100, step = 1)
                  ),
                tabPanel("Sugar Feeding"
                  ),
                tabPanel("??Esteration"
                  ),
                tabPanel("??Mohration"
                  ),
                tabPanel("Mating"
                  ),
                tabPanel("Male Mosquitoes"
                  ),
                tabPanel("Timing",
                  sliderInput(inputId = "gammaShape", label ="Shape Param for Gamma Distributed Dwell Times:",
                              value = 8, min = 0.1, max = 10, step = 0.1),
                  sliderInput(inputId = "pfeip", label ="Entomological Inoculation Period for Plasmodium falciparum During MosquitoFemale$probing()",
                              value = 12, min = 0, max = 100, step = 1)
                  ),
                tabPanel("Resting Spot"
                  ),
                tabPanel("Egg",
                  sliderInput(inputId = "bs_m", label ="Mean of Normally-distributed Egg Batch Size",
                              value = 30, min = 0, max = 100, step = 1),
                  sliderInput(inputId = "bs_v", label ="Standard Deviation of Normally-distributed Egg Batch Size",
                              value = 30, min = 0, max = 100, step = 1),
                  sliderInput(inputId = "maxbatch", label ="Maximum Egg Batch Size",
                              value = 30, min = 0, max = 100, step = 1),
                  sliderInput(inputId = "emt_m", label ="Mean of Normally-distributed Egg Batch Maturation Time",
                              value = 3, min = 0, max = 10, step = 1),
                  sliderInput(inputId = "emt_v", label ="Standard Deviation of Normally-distributed Egg Batch Maturation Time",
                              value = 1, min = 0, max = 10, step = 1),
                  sliderInput(inputId = "eggT", label ="Minimum Time to Egg Maturation",
                              value = 0, min = 0, max = 10, step = 1),
                  sliderInput(inputId = "eggP", label ="Minimum Provision to Produce Eggs",
                              value = 0, min = 0, max = 10, step = 1)

                  )

                )

            )),
          #################################################################################
          tabPanel(title = "Bouts",   value = "bouts",
            fluidPage(
              sidebarLayout(position = "right",
                sidebarPanel(style = "overflow-y:scroll; max-height: 600px",
                  helpText("Please Select the Bouts and Set Parameters:"),
                  checkboxInput("showF", "F: Blood Feeding Search", FALSE),
                  conditionalPanel(condition = "input.showF",
                    wellPanel(sliderInput(inputId = "f_time", label ="Mean Time Elapsed (in days)",
                              value = 1, min = 0, max = 10, step = 0.1),
                              sliderInput(inputId = "f_succeed", label ="Probability of Success",
                              value = 0.99, min = 0, max = 1, step = 0.01),
                              sliderInput(inputId = "f_surv", label ="Baseline Probability of Survival",
                              value = 0.95, min = 0, max = 1, step = 0.01),
                              textInput("f_wts", "Landing Spot Weights: Enter a vector (comma delimited)", "1,1,1,1,1")
                              )
                    ),

                  checkboxInput("showB", "B: Blood Feeding Attempt", FALSE),
                  conditionalPanel(condition = "input.showB",
                    wellPanel(sliderInput(inputId = "b_time", label ="Mean Time Elapsed (in days)",
                              value = 0.75, min = 0, max = 10, step = 0.05),
                              sliderInput(inputId = "b_succeed", label ="Probability of Success",
                              value = 0.99, min = 0, max = 1, step = 0.01),
                              sliderInput(inputId = "b_surv", label ="Baseline Probability of Survival",
                              value = 0.98, min = 0, max = 1, step = 0.01),
                              textInput("b_wts", "Landing Spot Weights: Enter a vector (comma delimited)", "1,1,1,1,1"),
                              checkboxInput("showhuman", "Human Host Encounter", FALSE),
                              conditionalPanel(condition = "input.showhuman",
                                wellPanel(sliderInput(inputId = "surviveH", label ="Survival Probability of Initial Encounter (Proceed to Probe)",
                              value = 1, min = 0, max = 1, step = 0.01),
                                          sliderInput(inputId = "probeH", label ="Probability Undeterred and Begin Probing",
                              value = 1, min = 0, max = 1, step = 0.01),
                                          sliderInput(inputId = "surviveprobeH", label ="Survival Probability of Probing",
                              value = 1, min = 0, max = 1, step = 0.01),
                                          sliderInput(inputId = "feedH", label ="Probability to Successfully blood feed",
                              value = 1, min = 0, max = 1, step = 0.01)
                                )),
                              checkboxInput("shownonhuman", "Non-human Host Encounter", FALSE),
                              conditionalPanel(condition = "input.shownonhuman",
                                wellPanel(sliderInput(inputId = "surviveZ", label ="Survival Probability of Initial Encounter (Proceed to Feed)",
                              value = 1, min = 0, max = 1, step = 0.01),
                                          sliderInput(inputId = "feedZ", label ="Probability to Successfully Blood Feed",
                              value = 1, min = 0, max = 1, step = 0.01)
                                  )
                                ),
                              sliderInput(inputId = "bm_a", label ="Shape Param a for Bloodmeal Size",
                              value = 7.5, min = 0, max = 20, step = 0.5),
                              sliderInput(inputId = "bm_b", label ="Shape Param b for Bloodmeal Size",
                              value = 2.5, min = 0, max = 20, step = 0.5),
                              checkboxInput("overfeed", "Overfeed", FALSE),
                              conditionalPanel(condition = "input.overfeed",
                                sliderInput(inputId = "of_a", "Exp Param a for overfeeding as function of bmSize",
                                  value = 5, min = 0, max = 100, step = 1),
                                sliderInput(inputId = "of_b", "Exp Param b for overfeeding as function of bmSize",
                                  value = 5000, min = 0, max = 10000, step = 100)),
                              sliderInput(inputId = "preGblood", label ="Amount of Energy a Blood Meal Contributes to Pre-gonotrophic Energy Requirement",
                              value = 0, min = 0, max = 100, step = 1),
                              sliderInput(inputId = "q", label ="Human Blood Index",
                              value = 0.9, min = 0, max = 1, step = 0.1)
                              )
                    ),
                  
                  checkboxInput("showR", "R: Post-prandial Resting", FALSE),
                  conditionalPanel(condition = "input.showR",
                    wellPanel(sliderInput(inputId = "r_time", label ="Mean Time Elapsed (in days)",
                              value = 1.5, min = 0, max = 10, step = 0.5),
                              sliderInput(inputId = "r_surv", label ="Baseline Probability of Survival",
                              value = 0.98, min = 0, max = 1, step = 0.01),
                              textInput("r_wts", "Landing Spot Weights: Enter a vector (comma delimited)", "1,1,1,1,1"),
                              checkboxInput("refeed", "Refeed", FALSE),
                              conditionalPanel(condition = "input.refeed",
                                sliderInput(inputId = "rf_a", "Exp Param a for refeeding as function of bmSize",
                                  value = 60, min = 0, max = 100, step = 1),
                                sliderInput(inputId = "rf_b", "Exp Param b for refeeding as function of bmSize",
                                  value = 5000, min = 0, max = 10000, step = 100)))
                    ),
                  
                  checkboxInput("showL", "L: Egg Laying Search", FALSE),
                  conditionalPanel(condition = "input.showL",
                    wellPanel(sliderInput(inputId = "l_time", label ="Mean Time Elapsed (in days)",
                              value = 0.75, min = 0, max = 5, step = 0.05),
                              sliderInput(inputId = "l_succeed", label ="Probability of Success",
                              value = 0.99, min = 0, max = 1, step = 0.01),
                              sliderInput(inputId = "l_surv", label ="Baseline Probability of Survival",
                              value = 0.8, min = 0, max = 1, step = 0.01),
                              textInput("l_wts", "Landing Spot Weights: Enter a vector (comma delimited)", "1,1,1,1,1"))
                    ),
                  
                  checkboxInput("showO", "O: Egg Laying Attempt", FALSE),
                  conditionalPanel(condition = "input.showO",
                    wellPanel(sliderInput(inputId = "o_time", label ="Mean Time Elapsed (in days)",
                              value = 0.99, min = 0, max = 5, step = 0.01),
                              sliderInput(inputId = "o_succeed", label ="Probability of Success",
                              value = 0.99, min = 0, max = 1, step = 0.01),
                              sliderInput(inputId = "o_surv", label ="Baseline Probability of Survival",
                              value = 0.98, min = 0, max = 1, step = 0.01),
                              textInput("o_wts", "Landing Spot Weights: Enter a vector (comma delimited)", "1,1,1,1,1"))
                    ),

                  checkboxInput("showM", "M: Mating", FALSE),
                  conditionalPanel(condition = "input.showM",
                    wellPanel(sliderInput(inputId = "m_time", label ="Mean Time Elapsed (in days)",
                              value = 1.5, min = 0, max = 10, step = 0.5),
                              sliderInput(inputId = "m_succeed", label ="Probability of Success",
                              value = 0.95, min = 0, max = 1, step = 0.01),
                              sliderInput(inputId = "m_surv", label ="Baseline Probability of Survival",
                              value = 0.98, min = 0, max = 1, step = 0.01),
                              textInput("m_wts", "Landing Spot Weights: Enter a vector (comma delimited)", "1,1,1,1,1"))
                    ),

                  checkboxInput("showS", "S: Sugar Feeding Attempt", FALSE),
                  conditionalPanel(condition = "input.showS",
                    wellPanel(sliderInput(inputId = "s_time", label ="Mean Time Elapsed (in days)",
                              value = 0.95, min = 0, max = 5, step = 0.05),
                              sliderInput(inputId = "s_succeed", label ="Probability of Success",
                              value = 0.95, min = 0, max = 1, step = 0.01),
                              sliderInput(inputId = "s_surv", label ="Baseline Probability of Survival",
                              value = 0.98, min = 0, max = 1, step = 0.01),
                              textInput("s_wts", "Landing Spot Weights: Enter a vector (comma delimited)", "1,1,1,1,1"),
                              sliderInput(inputId = "pregsugar", label ="Amount of Energy a Sugar Meal Contributes to Pre-gonotrophic Energy Requirement",
                              value = 0, min = 0, max = 100, step = 1))
                    ),
                  
                  checkboxInput("showE", "E: Estivation", FALSE),
                  conditionalPanel(condition = "input.showE",
                    wellPanel(helpText("test"))
                  ),

                  checkboxInput("showMale", "Male Mosquitoes", FALSE),
                  conditionalPanel(condition = "input.showMale",
                    wellPanel(
                      checkboxInput("showMaleS", "Sugar Feeding", FALSE),
                      conditionalPanel(condition = "input.showMaleS",
                        wellPanel("test")),
                      checkboxInput("showMaleM", "Mating", FALSE),
                      conditionalPanel(condition = "input.showMaleM",
                        wellPanel("test"))
                        )
                    )

                  ),
                
                mainPanel(
                  helpText("Output Plots")
                  )
                )
            )),
          #################################################################################
          tabPanel(title = "Landscape", value = 'landscape',                 
            sidebarLayout(position = "right",
              sidebarPanel(style = "overflow-y:scroll; max-height: 600px",
                helpText("Please set the parameters"),
                checkboxInput("showPoints", "Points", FALSE),
                conditionalPanel(condition = "input.showPoints",
                  wellPanel(
                    helpText("f"),
                    helpText("m"),
                    helpText("s")
                    )
                  ),
                checkboxInput("showKernels", "Kernels(Female)", FALSE),
                conditionalPanel(condition = "input.showKernels",
                  wellPanel(
                    helpText("f"),
                    helpText("l"),
                    helpText("m"),
                    helpText("s")
                    )
                  ),
                checkboxInput("show_land_male", "Males", FALSE),
                conditionalPanel(condition = "input.show_land_male",
                  wellPanel(
                    helpText("M"),
                    helpText("s")
                    )
                  )
                ),
              mainPanel(
                helpText("test output")
                )
          )),
          #################################################################################
          tabPanel(title = "Ecology", value = "ecology",              
            sidebarLayout(position = "right",
              sidebarPanel(style = "overflow-y:scroll; max-height: 600px",
                checkboxInput("showEmerge", "Emerge", FALSE),
                conditionalPanel(condition = "input.showEmerge",
                  helpText("Parameters")
                  ),
                checkboxInput("showEL4P", "EL4P", FALSE),
                conditionalPanel(condition = "input.showEL4P",
                  helpText("Parameters")
                  )
                ),
              mainPanel(
                helpText("test output")
                )
              )
          ),
          #################################################################################
          tabPanel("About",
            tabsetPanel(selected = "The Project",
               tabPanel("The Model",includeMarkdown("model.md")),
               tabPanel("The Project",includeMarkdown("project.md")),
               tabPanel("People",includeMarkdown("team.md"))
          )
        )
      )
    )
  )
  #########################################################################################
  # SERVER
  #########################################################################################
  server <- function(input, output, session) {
    cat(getwd())
    output$plot <- renderPlot({
      ggplot(data, aes_string(xvar, yvar)) + geom_point()
    })
    observe({
        if (input$launchgo > 0) {
            session$sendCustomMessage('activeNavs', 'Options')
        }
    })

    observe({
        if (input$launchgo > 0) {
            session$sendCustomMessage('activeNavs', 'Bouts')
        }
    })

    observe({
        if (input$launchgo > 0) {
            session$sendCustomMessage('activeNavs', 'Landscape')
        }
    })
    observe({
        if (input$launchgo > 0) {
            session$sendCustomMessage('activeNavs', 'Ecology')
        }
    })
    output$prepath.box <- renderUI({
      if(input$project == "exist"){
        textInput("prepath", "Please provide the previous working directory (the folder contains .json file)", "")
      }
    })
    observeEvent(input$done, {
      stopApp(brushedPoints(data, input$brush))
    })
  }
  #########################################################################################
  # RUN
  #########################################################################################
  runGadget(ui,server,viewer=dialogViewer("ggbrush",width=INITIAL_GUI_WIDTH,height=INITIAL_GUI_HEIGHT))
}

mbitesGadget()