# R Quarto
R Quarto is een functionaliteit binnen RStudio die het mogelijk maakt om de opmaak van een tekst (denk aan Word) te combineren met code (denk aan R, maar andere talen zoals Python, SQL en css zijn ook mogelijk). Links zie je een Quarto document in R zonder codeblokken, rechts zie je het resultaat als je deze zou ‘renderen’ naar html. 

![image](https://github.com/ggdatascience/Digitoegankelijke_schets/assets/50368629/90fbc0e3-91c9-4fca-ae1b-95bc2f7f6a68)

En een voorbeeld met een R codeblok. Een codeblok begint met 3 zogeheten ‘backticks’, de soort apostrof-tekens links van de 1 op het toetsenbord, gevolgd door ‘r’ tussen accolades: \`\`\`{r}. Een codeblok eindigt vervolgens met alleen 3 backticks. Standaard wordt zowel de R code zelf als de output die je normaal in de console zou zien opgenomen in het document, iets wat je in een thematische schets niet wilt. De output kan echter onderdrukt worden door parameters toe te voegen aan de kop van het codeblok: \`\`\`{r echo=FALSE, message=F}

![image](https://github.com/ggdatascience/Digitoegankelijke_schets/assets/50368629/50c27245-4c81-4153-a4f6-5a86495503c9)

Bovenaan een Quarto document definieer je parameters. In het voorbeeld hierboven staat alleen de titel opgegeven (“Voorbeeld”) en het type document (format: html). De schets voor Kansrijke start bevat er wat meer. De meeste parameters kun je negeren, maar goed om te weten is dat hier ook de bestandsnamen van de inputbestanden in opgenomen zijn. Mocht je de Excel met data over de prognoses van geboorten anders gaan noemen dan “Bevolking – gemeenten – prognose 2023.xlsx”, dan moet dit ook aangepast worden in het R Quarto document. Als de Excel bestanden in een andere map gezet worden dan de map “input” en daarin de submap “data”, dan moet dat hier ook aangepast. 

![image](https://github.com/ggdatascience/Digitoegankelijke_schets/assets/50368629/30b592cf-0ce1-4bd5-9438-dc39e9e1e690)

De rest van het document is vervolgens een afwisseling van codeblokken en tekst met opmaak. Hieronder een voorbeeld van een relatief simpel blok. Er is een R code blok, genaamd “opleiding” waarvan de output zelf onderdrukt wordt (echo=FALSE, message=F). In de code wordt een Excel bestand ingelezen (read_excel) wiens locatie opgeslagen is onder opleiding_xlsx in de parameters (params$opleiding_xlsx). De data in de kolom “Ouders zijn laag/midden opgeleid (MAVO, MBO) (0-11 jaar)” wordt vermenigvuldigd met 100 - dit is omdat de waarden in Excel geformatteerd waren als percentage en door R worden ingelezen als een waarde tussen 0 en 1. De kolomnaam bevat spaties, iets waar R hier alleen mee om kan gaan als de kolomnaam tussen enkele backticks staat (dat apostrof-teken links van de 1 op het toetsenbord). Het resultaat van deze bewerking wordt opgeslagen als “data_opleiding”.

![image](https://github.com/ggdatascience/Digitoegankelijke_schets/assets/50368629/4c0aeb04-5811-427e-a6bf-1ee3a8122b4d)

Vervolgens wordt in het script een gemeentelijk cijfer uitgerekend (dat wordt opgeslagen als “opleiding_gemeente”) en een GGD cijfer (opgeslagen in “opleiding_GGDHVB”). Ook bij deze berekeningen komt de kolomnaam uit het Excel bestand voor, en zou in de code aangepast moeten worden als het in het Excelbestand ook is veranderd.
Als laatste stap wordt er een stukje html code aangemaakt en dit wordt opgeslagen in “opleiding”. Stel dat opleiding_gemeente = 4 en opleiding_GGDHvB = 5, dan worden de brokjes html code en deze cijfers samengevoegd tot het volgende: 

‘Bij <span style=”color:#fdc715”>4%</span> van de kinderen tussen 0 en 11 jaar hebben beide ouders maximaal een MAVO/MBO-opleiding afgerond (2021). In de regio GGD Hart voor Brabant is dit 5%’.

De span met kleurcode zorgt ervoor dat het percentage een gele tekstkleur krijgt. Mocht je kleine wijzigingen willen maken in de tekst bij de indicatoren, kan dan dat dus in het stukje R code dat de html code genereert.

Het oproepen van het R object “opleiding” in de tekst gebeurt daarna als volgt:

![image](https://github.com/ggdatascience/Digitoegankelijke_schets/assets/50368629/03994303-152f-4874-9882-ba3939383835)

Wat hier staat is dat er een element aan wordt gemaakt met 2 kolommen, waarvan 1 10% breed is en de andere 90% breed. De tekst wordt uitgelijnd aan de onderkant (layout-valign=”bottom”). Er wordt een plaatje ingelezen zonder ondertitel (“![]”) maar met een alt-tekst, een tekst die voorgelezen wordt door schermlezers. R geeft een preview van dit plaatje in de Quarto editor. Dit eerste element komt in de eerste kolom. Vervolgens is er een tweede regel, \`r opleiding\`, die geplaatst zal worden in de tweede kolom. Deze \`r opleiding\` geeft aan dat die plek in de tekst vervangen moet worden met de waarde van het R object “opleiding” - waar we net html code in hadden opgeslagen. Let op, de aanhalingstekens hier zijn weer backticks. 

Het resultaat van dit alles is als volgt:
![image](https://github.com/ggdatascience/Digitoegankelijke_schets/assets/50368629/33ae77fb-3d90-462c-9d90-49ac1b34364a)

# Meerdere schetsen in 1 keer maken
Het script “Kansrijke_Start.qmd” bevat de Quarto Markdown code voor de schets Kansrijke Start. Je zou handmatig elke keer de gemeentenaam onder de parameters kunnen vervangen, op “Render” klikken en het resulterende Kansrijke_Start.html bestand kunnen hernoemen naar de juiste gemeente, maar dat is een hoop onnodig werk. Er is een tweede R script, “Maak_schetsen.R”, waarin de code van het qmd bestand meerdere keren wordt uitgevoerd, steeds voor een andere gemeente. 

De code van dit script is als volgt:
![image](https://github.com/ggdatascience/Digitoegankelijke_schets/assets/50368629/6996162d-697e-49ca-8a9e-92edb7f5ac48)

In de lijst die wordt opgeslagen in “gemeenten_hvb” bepaal je welke gemeenten je uit wilt draaien. Door middel van dit script krijgt elke gemeente zijn eigen bestandsnaam, via “output_file = glue::glue(“Kansrijke_Start_{gemeentenaam}.html”. Mocht je de bestandsnaam anders willen, dan kun je dat hier aanpassen. 
