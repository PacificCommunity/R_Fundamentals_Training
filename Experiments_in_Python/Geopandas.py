##
##   Ok, this is James's first attempt at geospatial in Python
##
##      Functionality installed from the command prompt:
##          python -m pip install Geopandas pandas geodatasets
##
##
##
##
##  load some functionality
##
import geopandas
import pandas
import geodatasets
import matplotlib

##
##  Grab some data from some where
##
chicago   = geopandas.read_file(geodatasets.get_path("geoda.chicago_commpop"))
groceries = geopandas.read_file(geodatasets.get_path("geoda.groceries"))
colombia  = geopandas.read_file(geodatasets.get_path('geoda.malaria'))

##
##  Derive some metrics, and join
##

chicago["Area"] = chicago.area
print(chicago)

print(chicago["Area"].sum())

#df = pandas.DataFrame(data= {'Area': chicago.area, 'NID': chicago.NID})

#joined = chicago.merge(df, on='NID')
#Centroids = chicago.centroid




##
##  Plot the data
##
#        Centroids.plot()
    
#        matplotlib.pyplot.show()
