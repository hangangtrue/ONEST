#' @title ONEST vignettes function
#'
#' @description This function is only used to create vignettes. Although it can get the same results from ONEST_main(sp142_bin), it uses some precomputed data to decrease the time to get the results. Therefore, it can only be applied to the sp142_bin dataset. Please use ONEST_main instead.
#'
#' @param data a matrix containing the binary pathology data. Each row is the data from one case, and each column is the data from one rater. Missing values are allowed and can be denoted as NA or left blank. If there are n cases and k raters, the input ‘data’ is a matrix with dimension n by k.
#' @param empirical a matrix containing data used to plot the empirical confidence intervals for the sp142_bin dataset.
#'
#' @importFrom graphics barplot
#' @importFrom graphics lines
#' @importFrom graphics legend
#' @importFrom stats quantile
#'
#' @usage ONEST_vignettes(data,empirical)
#'
#' @return
#' consist_p: a vector of length k-1, indicating proportion of identical reads among a set of pathologists. For example, the first element of “consist_p” is the estimate of agreement percentage for 2 raters. The k-1 th element is the estimate of agreement percentage for k raters.
#'
#' consist_low: a vector of length k-1, indicating the lower bound of the agreement percentage with 95 percent confidence level corresponding to “consist_p”.
#'
#' diff_consist: a vector of length k-2, indicating the difference between the consist_p. For example, the first element of “diff_consist” is the estimated difference of agreement percentage after increasing from 2 to 3 raters. The k-2 th element is the difference of agreement percentage after increasing from k-1 to k raters.
#'
#' diff_high: a vector of length k-2, indicating the upper bound of the change of agreement percentage corresponding to “diff_consist” with 95 percent confidence level.
#'
#' size_case: number of cases n
#'
#' size_rater: number of raters k
#'
#' p: the probability of of being rated positive among the proportion of ‘1-p_plus-p_minus’ cases.
#'
#' p_plus: proportion of the cases rated positive by all raters.
#'
#' p_minus: proportion of the cases rated negative by all raters.
#'
#' empirical: a matrix of dimension k-1 by 3, including the empirical estimate of the agreement percentage, and the empirical 95 percent confidence intervals (CI) of the agreement percentage with equal tail probabilities on the two sides. The empirical estimate and CI were calculated by permuting the raters with 1000 random permutations, and using the mean, 2.5th percentile, and 97.5th percentile.
#'
#'
#' @export
#'
#' @examples
#' data('sp142_bin')
#' data('empirical')
#' ONEST_vignettes(sp142_bin,empirical)
ONEST_vignettes = function(data,empirical){

  # Size of the data
  n = nrow(data)
  m = ncol(data)
  size_case = n
  size_rater = m
  M = m-1

  ## Step 1, plot the data
  # 1) Plot the agreement percentage in the order of columns in the input
  color = 'black'
  C = plotline(data,1,color)
  lines(0,0,main="Figure(1)")

  # 2) Plot 100 randomly chosen permutations
  concord = empirical[,1:100]
  x_axis = 2:m
  plot(x_axis,concord[,100], type = "o", col = color,lwd=1.8,xlim=c(2,m),ylim=c(0,1),main="Figure(2)",
       xlab = 'Number of raters',ylab='Proportion of identical reads')
  for (i in 1:99){
    lines(x_axis,concord[,i], type = "o", col = color,lwd=1.8,xlim=c(2,m),ylim=c(0,1))
  }

  # 3) Plot the empirical confidence interval
  D=empirical
  # Calculate mean, 5 th, and 95 th percentiles
  plot_data = matrix(rep(0,3*(m-1)),ncol=3)
  for (j in 1:M){
    plot_data[j,1] = mean(D[j,])
    plot_data[j,2] = quantile(D[j,],0.025,names=FALSE,type=1)
    plot_data[j,3] = quantile(D[j,],0.975,names=FALSE,type=1)
  }

  # plot the mean and empirical 95# CI
  x_axis = 2:m
  plot(x_axis,plot_data[,1], type = "o", col = color,lwd=1.8,xlim=c(2,m),ylim=c(0,1),
       xlab = 'Number of raters',ylab='Proportion of agreement',main="Figure(3)")
  lines(x_axis,plot_data[,2],lty=2, col = color,lwd=1.8,xlim=c(2,m),ylim=c(0,1))
  lines(x_axis,plot_data[,3],lty=2, col = color,lwd=1.8,xlim=c(2,m),ylim=c(0,1))
  legend("topright", c("Mean","95% empirical CI"),lty=1:2,pch = c(1,NA),cex = 0.6)

  # 4) barchart: the x axis is the
  # case number and the Y axis is the number of pathologists that called
  # that case positive, sorted from lowest to highest on the y axis.
  sum_D = matrix(rep(0,n),ncol=1)
  mean_D = matrix(rep(0,n),ncol=1)
  for(k in 1:n){
    sum_D[k] = sum(data[k,],na.rm = TRUE)
    mean_D[k] = sum(data[k,],na.rm = TRUE)/length(which(data[k,]>-1))
  }
  a = tabulate(sum_D)
  # figure(4)
  # Relative proportion
  barplot(sort(mean_D),xlab = 'Cases',ylab='Proportion of positive ratings',col='white',main="Figure(4)")

  ## Step 2, model the data;

  # Input data = sp142_bin;

  data_temp = data

  # Total number of observations;
  N = n*m
  # count the number of nan;
  nan_num = 0
  for (i in 1:n){
    for (j in 1:m){
      if (is.na(data_temp[i,j])==1){
        nan_num = nan_num + 1
      }
    }
  }

  # total number of positve reads;
  K = sum(data_temp==1,na.rm = TRUE)
  # calculate p_plus and p_minus, the proportions of all positive and negative;
  p_plus  = 0; p_minus = 0;
  for (i in 1:n){
    if (sum(data_temp[i,]==1,na.rm = TRUE)==0){
      p_minus = p_minus + 1/n
    }

    if (sum(data_temp[i,]==1,na.rm = TRUE)==sum(data_temp[i,],na.rm = TRUE)+sum(data_temp[i,]==0,na.rm = TRUE)){
      p_plus = p_plus + 1/n
    }
  }
  # [7/68 19/68]
  # [p_minus p_plus]
  # p_plus  = 19/68; p_minus = 7/68;

  # Calculate the probability 'p'
  prop = (K/(N-nan_num)-p_plus)/(1-p_plus-p_minus)

  # Calculate the consistancy probability trajectory;
  consist_p = rep(0,m-1)
  diff_consist = rep(0,m-2)
  o=m-2
  for (i in 1:M){
    consist_p[i] = (1-p_plus-p_minus)*(prop^(i+1)+(1-prop)^(i+1))+p_plus+p_minus
  }
  # Calculate the difference trajectory;
  for (i in 1:o){
    diff_consist[i] = consist_p[i+1]-consist_p[i]
  }

  ## Construct the upper bound for the difference using the lower bound for
  # p_plus+p_minus;
  p_c = p_plus+p_minus
  p_c_low = p_c - 1.645*sqrt(p_c*(1-p_c)/n)

  # Calculate the trajectory;
  consist_low = rep(0,m-1)
  diff_low = rep(0,m-2)
  for (i in 1:M){
    consist_low[i]=(1-p_c_low)*(prop^(i+1)+(1-prop)^(i+1))+p_c_low
  }

  for (i in 1:o){
    diff_low[i] = consist_low[i+1]-consist_low[i]
  }
  # figure(5)
  plot(x_axis,consist_p, type = "o", col = "red",lwd=1.8,ylim = c(0,1),pch=2,xlab = 'Number of raters',ylab='Proportion of identical reads',main="Figure(5)")
  lines(x_axis,consist_low,lty=2,lwd=1.8,col = "orange")
  # figure(6)
  plot(1:o,-diff_consist, type = "o", col = "red",lwd=1.8,pch=2,xlab = 'Number of raters',ylab='Difference between the consist_p',main="Figure(6)")
  lines(1:o,-diff_low,lty=2,lwd=1.8,col = "orange")

  diff_high = -diff_low
  p = prop
  lower_bound = plot_data[,2]
  upper_bound = plot_data[,3]
  mean = plot_data[,1]
  empirical = rbind(cbind(lower_bound,mean,upper_bound))
  consist = rbind(cbind(consist_p,consist_low))
  diff = rbind(cbind(diff_consist,diff_high))
  estimate = rbind(cbind(size_case,size_rater,p,p_plus,p_minus))
  results = list(consistency=consist,difference=diff,estimates=estimate,empirical=empirical)
  return(results)
}

