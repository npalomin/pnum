nomis data
================
np
29/10/2018

<style>
  h1, h2, h3, h4, h5, h6{
    color: #668e81;
    font-family: "arial narrow", helvetica;
  }
  h1, h2{
    font-size: 150%
  }
  h2{
    font-variant: small-caps
  }
</style>
Nomis data analysis
===================

------------------------------------------------------------------------

Ref URLs: <https://www.nomisweb.co.uk/>
<https://data.london.gov.uk/dataset/lsoa-atlas>
<http://geoportal.statistics.gov.uk/datasets/lower-layer-super-output-area-2011-to-ward-2017-lookup-in-england-and-wales>
\*\*\*

Download data
-------------

*Data downloads &gt; Query &gt; Business Register and Employment Survey : open access*

*"An employer survey of the number of jobs held by employees broken down by full/part-time and detailed industry (5 digit SIC2007). The survey records a job at the location of an employees workplace. Available from country down to lower level super output area and Scottish datazone."*

Lower Layer Super Output Area (2011) to Ward (2017) Lookup in England and Wales

<img src="lsoa_ward.png" width="1000px" />

LSOA 2011 provide higher spatial resolution than ward

<img src="summ_nomis.png" width="1000px" /> GLA = 4835 LSOA (2011)

<img src="map_nomis.png" width="1000px" />

Is this what we want?
The boundaries of the LSOA areas are:
\* too irregular that can even cut a street segment in many parts \* overlap with streets segments so generate the problem of defining where to assign the centrality measures

> Live-Links These are the Live-links you have created to data downloads.
>
> GLA\_Manufacturing\_perc\_LSOA <https://www.nomisweb.co.uk/livelinks/14448.xlsx>
