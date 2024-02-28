

library(quarto)

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))


#Lijst gemeentenamen HvB
gemeenten_hvb <- c("Bernheze", "Boekel", "Boxtel", "Dongen", "Gilze en Rijen", "Goirle",
                   "'s-Hertogenbosch", "Heusden", "Hilvarenbeek", "Land van Cuijk","Loon op Zand",
                   "Maashorst", "Meierijstad", "Oisterwijk", "Oss", "Sint-Michielsgestel",
                   "Tilburg","Vught", "Waalwijk")

# gemeenten_hvb <- c("'s-Hertogenbosch")


for(gemeentenaam in gemeenten_hvb){
  
  quarto::quarto_render(input = "Kansrijke_Start.qmd",
                        output_file = glue::glue("Kansrijke_Start_{gemeentenaam}.html"),
                        execute_params = list(
                          gemeentenaam = gemeentenaam)
  )
  
}

