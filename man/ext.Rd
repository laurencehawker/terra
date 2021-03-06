\name{extent}

\docType{methods}


\alias{ext}
\alias{ext<-}
\alias{ext,SpatExtent-method}
\alias{ext,SpatRaster-method}
\alias{ext,SpatVector-method}
\alias{ext,SpatDataSet-method}
\alias{ext<-,SpatRaster,SpatExtent-method}
\alias{ext<-,SpatRaster,numeric-method}
\alias{ext,numeric-method}
\alias{ext,missing-method}
\alias{bbox,SpatRaster-method}
\alias{bbox,SpatVector-method}


  
\title{Create, get or set a SpatExtent}

\description{
Get a SpatExtent of a SpatRaster, or coordinates from such an object. Or create a SpatExtent from a vector (length=4; order= xmin, xmax, ymin, ymax)
}

\usage{
\S4method{ext}{SpatRaster}(x, ...)

\S4method{ext}{SpatRaster,SpatExtent}(x)<-value

\S4method{ext}{SpatRaster,numeric}(x)<-value
}

\arguments{
  \item{x}{SpatRaster}
  \item{value}{SpatExtent, or numeric vector of lenght four (xmin, xmax, ymin, ymax)}  
  \item{...}{additional arguments. None implemented }
}
 
\value{
SpatExtent
}

\examples{
r <- rast()
e <- ext(r)
as.vector(e)
as.character(e)

ext(r) <- c(0, 2.5, 0, 1.5)
r
er <- ext(r)

round(er)
# go "in"
floor(er)
# go "out"
ceiling(er)

ext(r) <- e

}

\keyword{spatial}

