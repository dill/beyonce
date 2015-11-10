library(png)
library(jpeg)

make_palette <- function(path){

  # load an image
  if(grepl(".jpg", path)){
    a_file <- readJPEG(path)
  }else{
    a_file <- readPNG(path)
  }
  # make a matrix -- one row per pixel
  #  columns as rgb
  ff <- matrix(c(as.vector(a_file[,,1]),
                 as.vector(a_file[,,2]),
                 as.vector(a_file[,,3])),ncol=3)

  # get the unique rows == unique colours
  ff <- unique(ff)

  # turn the unique rows into RGB hex values
  bey <- apply(ff, 1, function(x) rgb(x[1],x[2], x[3]))

  return(bey)
}

paths <- dir("bey",full.names=TRUE)

bey_colours <- lapply(paths, make_palette)
