# creating a shapefile of MICS countries

library(maps) # maps

library(maptools) # maptools

library(countrycode) # manipulate country names and codes

library(dplyr) # data wrangling

library(sf) # simple features

data(wrld_simpl) # world simple data

global_data <- st_as_sf(wrld_simpl) %>% # make an sf dataset
  select(-POP2005) # remove POP2005
  

# write sf to shapefile

st_write(global_data, 
         "mapping/shapefiles/wrld_simpl/wrld_simpl.shp",
         append = FALSE) # replace; don't append

# get MICS countries

country <- c("Afghanistan", "Algeria",  "Argentina",  
             "Bangladesh",  "Barbados",  "Belarus",  
             "Belize",  "Benin",  "Bosnia and Herzegovina",  
             "Cameroon",  "Central African Republic",  "Chad",  
             "Democratic Republic of the Congo",  
             "Republic of the Congo",  
             "Costa Rica",  "Cote d'Ivoire",  "Dominican Republic",  
             "El Salvador",  "Eswatini",  "Ghana",  
             "Guinea",  "Guinea Bissau",  "Guyana",  
             "Iraq",  "Jamaica",  "Kazakhstan",  
             "Kenya",  "Kosovo",  "Kyrgyzstan",  
             "Laos", "Macedonia",  "Madagascar",  
             "Malawi",  "Mali",  "Mauritania",  
             "Mexico",  "Moldova",  "Mongolia",  
             "Montenegro",  "Nepal",  "Nigeria",  
             "Pakistan",  "Panama",  "Paraguay",  
             "Sao Tome and Principe",  "Senegal",  "Serbia",  
             "Sierra Leone",  "Somalia",  "St. Lucia",  
             "State of Palestine",  "Suriname",  "Thailand",  
             "The Gambia",  "Togo",  "Trinidad and Tobago",  
             "Tunisia",  "Turkmenistan",  "Ukraine",  
             "Uruguay",  "Vietnam",  "Zimbabwe")

# convert to ISO3

country_iso <- countrycode(country, 
                           'country.name', 
                           'iso3c')

# MICS is an sf object that is subset of global_data

MICS <- global_data %>% 
  filter(ISO3 %in% country_iso)

st_write(MICS, 
         "mapping/shapefiles/MICS/MICS.shp",
         append = FALSE) # replace; don't append

zip(zipfile = "mapping/shapefiles/MICS/MICS.zip",
    files = c("mapping/shapefiles/MICS/MICS.dbf",
              "mapping/shapefiles/MICS/MICS.prj",
              "mapping/shapefiles/MICS/MICS.shp",
              "mapping/shapefiles/MICS/MICS.shx"))




