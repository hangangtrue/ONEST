#' The ONEST_inflation_test
#'
#' @description This function uses the binary (0/1) pathology data to test if the agreement proportion will converge to 0 with an increasing number of observers.
#'
#' @param Y pathology data as a matrix (missing values are allowed)
#'
#' @importFrom stats pchisq
#'
#' @usage ONEST_inflation_test(Y)
#' @return
#' p_value: chi-square p-value, a small p-value indicates significant evidence that the observers’ agreement will converge to a non-zero proportion.
#'
#' @export
#'
#' @examples
#' data("sp263_bin")
#' ONEST_inflation_test(sp263_bin)
ONEST_inflation_test=function(Y){
  # Step 1: estimate the parameter p under H0;
  # Initiate n, M, C0, C1;
  # Input Y;
  sum_1 = sum(Y,na.rm = T)
  sum_0 = sum(1-Y,na.rm = T)
  p = sum_1/(sum_1 + sum_0)
  n = nrow(Y)
  M = ncol(Y)

  # calculate theta_0 and theta_1;
  # theta_0: number of cases all being 0;
  # theta_1: number of cases all being 1;
  C0  = 0; CM = 0;
  for (i in 1:n){
    if (sum(Y[i,] == 1, na.rm = TRUE)==0){
      C0 = C0 + 1
    }

    if (sum(Y[i,] == 1, na.rm = TRUE) == sum(Y[i,],na.rm = TRUE) + sum(Y[i,] == 0, na.rm = TRUE)){
      CM = CM + 1
    }
  }
  if (C0>0){
    C0 = C0#-0.5
  }
  if (CM>0){
    CM = CM#-0.5
  }

  # theta_0
  # theta_1

  U = matrix(c(CM/(p^M)-n, C0/(1-p)^M-n),ncol = 2)
  I = matrix(c(n-n*p^M+n*p^M*((1-p^M)/p^M)^2,-3*n,-3*n,n-n*(1-p)^M+n*(1-p)^M*((1-(1-p)^M)/(1-p)^M)^2),ncol = 2)
  #I = I;

  # Test statistic;
  S = U%*%solve(I)%*%t(U)
  S2 = matrix(c(n,n),ncol = 2)%*%solve(I)%*%t(matrix(c(n,n),ncol = 2))

  # P-value;
  p1_value = pchisq(S,2,lower.tail = F)
  p2_value = pchisq(S2,2,lower.tail = F)

  # 3 by 3 covariance matrix, including p;
  U2 = matrix(c(U,0),ncol = 3)
  I2 = matrix(rep(0,9),ncol = 3)
  I2[1:2,1:2] = I
  I2[3,3] = M*n*(1/p + 1/(1-p))
  I2[1,3] = -1*(1/p+(M*n-1)*p^(M-1))
  I2[3,1] = I2[1,3]
  I2[2,3] = -1*(1/(1-p)+(M*n-1)*(1-p)^(M-1))
  I2[3,2] = I2[2,3]

  S3 = U2%*%solve(I2)%*%t(U2)
  p3_value = pchisq(S3,2,lower.tail = F)

  p_values = c(p1_value=p1_value,p2_value=p2_value,p3_value=p3_value)
  p_value=c(p_value=p3_value)
  return(p_value)

}
