\name{dimensions}

\docType{methods}

\alias{length}
\alias{ncol}
\alias{nrow}
\alias{ncell}
\alias{nlyr}
\alias{nsrc}
\alias{size}
\alias{dim}
\alias{res}
\alias{xres}
\alias{yres}
\alias{ncol<-}
\alias{nrow<-}
\alias{nlyr<-}
\alias{res<-}
\alias{ncell,ANY-method}
\alias{nrow,SpatRaster-method}
\alias{ncol,SpatRaster-method}
\alias{nrow,SpatDataSet-method}
\alias{ncol,SpatDataSet-method}
\alias{nrow<-,SpatRaster,numeric-method}
\alias{ncol<-,SpatRaster,numeric-method}
\alias{nlyr,SpatDataSet-method}

\alias{nlyr,SpatRaster-method}
\alias{nlyr<-,SpatRaster,numeric-method}
\alias{nsrc,SpatRaster-method}
\alias{ncell,SpatRaster-method}
\alias{ncell,SpatDataSet-method}
\alias{length,SpatRaster-method}
\alias{length,SpatDataSet-method}
\alias{size,SpatRaster-method}
\alias{size,SpatDataSet-method}
\alias{dim,SpatRaster-method}
\alias{dim,SpatDataSet-method}
\alias{dim<-,SpatRaster-method}
\alias{dim,SpatVector-method}
\alias{size,SpatVector-method}

\alias{res,SpatDataSet-method}
\alias{res,SpatRaster-method}
\alias{res<-,SpatRaster-method}
\alias{xres,SpatRaster-method}
\alias{yres,SpatRaster-method}

\alias{nrow,SpatVector-method}
\alias{ncol,SpatVector-method}

\alias{length,SpatVector-method}



\title{Dimensions of a SpatRaster or SpatVector}

\description{
Get the number of rows (\code{nrow}), columns (\code{ncol}), cells (\code{ncell}), layers (\code{nlyr}), sources (\code{nsrc}) or the spatial resolution of a SpatRaster; or sub-datasets of a SpatDataSet (\code{length}).

The \code{size} of a SpatRaster \code{x} is \code{ncell(x) * nlyr(x)}. For a SpatRaster \code{length(x)} is the same as \code{ncell(x)}, for a SpatVector \code{length(x)} is the same as \code{nrow(x)}.

You can also set the number of rows or columns or layers. When setting dimensions, all cell values are dropped.
}

\usage{
\S4method{ncol}{SpatRaster}(x)

\S4method{nrow}{SpatRaster}(x)

\S4method{nlyr}{SpatRaster}(x)

\S4method{ncell}{SpatRaster}(x)

\S4method{size}{SpatRaster}(x)

\S4method{length}{SpatRaster}(x)

\S4method{nsrc}{SpatRaster}(x)

\S4method{res}{SpatRaster}(x)

ncol(x, ...) <- value
nrow(x, ...) <- value
nlyr(x, ...) <- value
res(x) <- value

\S4method{xres}{SpatRaster}(x)

\S4method{yres}{SpatRaster}(x)

\S4method{ncol}{SpatVector}(x)

\S4method{nrow}{SpatVector}(x)

\S4method{size}{SpatVector}(x, ...)

\S4method{length}{SpatVector}(x)
}


\arguments{
\item{x}{SpatRaster or SpatVector}
\item{value}{For ncol and nrow: positive integer. For res: one or two positive numbers }  
\item{...}{additional arguments. None implemented}
}

\value{
integer
}

\seealso{ \link{ext}}

\examples{
r <- rast()
ncol(r)
nrow(r)
nlyr(r)
dim(r)
nsrc(r)
ncell(r)
length(r)
size(r)

rr  <- c(r,r)
nlyr(rr)
nsrc(rr)
ncell(rr)
length(rr)
size(rr)

nrow(r) <- 18
ncol(r) <- 36
# equivalent to
dim(r) <- c(18, 36) 

dim(r)
dim(r) <- c(10, 10, 5)
dim(r)

xres(r)
yres(r)
res(r)

res(r) <- 1/120
# different xres and yres
res(r) <- c(1/120, 1/60)
}

\keyword{spatial}

