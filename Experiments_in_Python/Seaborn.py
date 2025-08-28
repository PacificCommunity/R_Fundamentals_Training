##
##   Play with Seaborn: https://seaborn.pydata.org/index.html
##
##
##
import geopandas
import pandas
import geodatasets
import matplotlib
import seaborn as sns

df = sns.load_dataset("penguins")
sns.pairplot(df, hue="species")



sns.set_theme(style="ticks")

dots = sns.load_dataset("dots")

# Define the palette as a list to specify exact values
palette = sns.color_palette("rocket_r")

# Plot the lines on two facets
sns.relplot(
    data=dots,
    x="time", y="firing_rate",
    hue="coherence", size="choice", col="align",
    kind="line", size_order=["T1", "T2"], palette=palette,
    height=5, aspect=.75, facet_kws=dict(sharex=False),
)
matplotlib.pyplot.show()
