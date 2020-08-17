#' @title Plotline
#'
#' @description This function uses the binary (0/1) pathology data to plot the percentage of agreement.
#'
#' @param path pathology data as a matrix (missing values are allowed)
#' @param indi an indicator; if indi=0: then do not make plot;
#'             indi=1: then make plot, original scale.
#'             Labels on the x and y-axis are on the original scale
#' @param color the color used to draw pictures
#'
#' @importFrom graphics plot
#'
#' @usage plotline(path,indi=1,color="red")
#' @return
#' A matrix with percentage of agreement from the original scale
#'
#' @export
#'
#' @examples
#' data("sp142_bin")
#' plotline(sp142_bin,1,"red")
plotline = function(path, indi=1, color='red'){
  n = nrow(path)
  m = ncol(path)
  a = rep(0,m-1)

  # Concordance for original data
  concord  = matrix(a,ncol=1)
  M = m-1
  for (i in 1:M){
    temp = rep(0,n)
    I = i+1
    for (j in 1:n){
      comp = as.vector(unlist(path[j,1:I]))
      temp[j] = length(unique(comp))
    }
    concord[i] = sum(temp==1,na.rm = TRUE)/n
  }

  # Plot the data based on the indi status
  if (indi == 1){
    x_axis = 2:m
    plot(x_axis,concord, type = "o", col = color,lwd=1.8,xlim=c(2,m),ylim=c(0,1),
         xlab = 'Number of raters',ylab='Proportion of identical reads',main="Figure(1)")
  }

  C = concord
  return(C)
}
