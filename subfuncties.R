
library(dplyr)
library(glue)
library(stringr)


# Subfunctie voor corrext afronden (round rond een half af naar rechtsbijzijnde even getal, dus ene keer omhoog en andere keer omlaag)
round2 = function(x, digits = 1) {
  scale<-10 ^ digits; trunc(x * scale + sign(x) * 0.5) / scale}

# Functie om html code te maken die uitkorting uitschrijft als je met de cursor over een woord beweegt/ uitleest voor screenreaders.
maak_abbr_tag <- function(afkorting, uitgeschreven){
  glue("<abbr title = '{uitgeschreven}'> {afkorting} </abbr>")
}


# Functie voor bol met tekst

bol_met_tekst <- function(getal, regel1 = NA, regel2 = NA, regel3 = NA, regel4 = NA, regel5 = NA, regel6 = NA){
  
  # Opbouw: svg_deel1, getal, svg_deel2, regel1 en verder, svg_deel3
  
  svg_deel1 <- '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" xml:space="preserve" style="shape-rendering:geometricPrecision; text-rendering:geometricPrecision; image-rendering:optimizeQuality;"
                viewBox="0 0 225 75">
                <g id="circle">
                    <circle style="fill:#fec80f;" cx="25" cy="25" r="20">
                    </circle>
                    <text x=25 y="25" text-anchor="middle" stroke="#010101" stroke-width="1px" dy=".3em" font-size="1em">'
  
  svg_deel2 <- '</text></g>
                <g id="tekst">
                <text x=50 y="25" stroke="#010101" stroke-width="0.01px" dy=".3em" font-size="0.5em">'
  
  
  svg_deel3 <- '</text>
                </g></svg>'
  
  tekst <- c()
  
  for (regel in c(regel1, regel2, regel3, regel4, regel5, regel6)){
    if(!is.na(regel)){
      
      if(length(tekst) == 0){
        tekst <- paste0('<tspan>', regel, '</tspan>')
      }
      else if (length(tekst) > 0){
      tekst <- paste0(tekst, '<tspan x=50 dy="1em">', regel, '</tspan>')
      }
    }
  }
  
  svg_code <- paste0(svg_deel1, getal, svg_deel2, tekst, svg_deel3)
  
  return(svg_code)
}

# knitr::raw_html('<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" xml:space="preserve" style="shape-rendering:geometricPrecision; text-rendering:geometricPrecision; image-rendering:optimizeQuality;"
#                 viewBox="0 0 225 100">
#                 <g id="circle">
#                     <circle style="fill:#fec80f;" cx="25" cy="25" r="20">
#                     </circle>
#                     <text x=25 y="25" text-anchor="middle" stroke="#010101" stroke-width="1px" dy=".3em">50</text></g>
#                 <g id="tekst">
#                 <text x=50 y="25" stroke="#010101" stroke-width="0.1px" dy=".3em" font-size="0.5em">
#                   <tspan>van de 1000 kinderen overlijden rond de </tspan>
#                   <tspan x=50 dy="1em">geboorte (vanaf 24 weken) zwangerschaps-</tspan>
#                   <tspan x=50 dy="1em">duur, perinatale morbiditeit)(2020). Landelijk</tspan>
#                   <tspan x=50 dy="1em">gaat het om 4.3 van de 1000 kinderen.</tspan>
#                   </text>
#                 </g></svg>')
#






