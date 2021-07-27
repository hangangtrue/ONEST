#' @title The R ONEST package
#' @name ONEST
#' @docType package
#' @description The ONEST software implements a statistical method in Reisenbichler et al. (2020[1]), to determine the minimum number of evaluators needed to estimate agreement involving a large number of raters. This method could be utilized by regulatory agencies, such as the FDA, when evaluating agreement levels of a newly proposed subjective laboratory test. Input to the program should be binary(1/0) pathology data, where “0” may stand for negative and “1” for positive. The example datasets in this software are from Rimm et al. (2017[2]) (the SP142 assay), and Reisenbichler et al. 2020. This program can run in R version 3.5.0 and above.
#'
#'
#' @references
#' [1] Reisenbichler ES, Han G, Bellizzi A, Bossuyt V, Brock J, Cole K, et al. Prospective multi-institutional evaluation of pathologist assessment of PD-L1 assays for patient selection in triple negative breast cancer. Mod Pathol. 2020, DOI: 10.1038/s41379-020-0544-x; PMID: 32300181.
#'
#' [2] Rimm DL, Han G, Taube JM, Yi ES, Bridge JA, Flieder DB, et al. A Prospective, Multi-institutional, Pathologist-Based Assessment of 4 Immunohistochemistry Assays for PD-L1 Expression in Non-Small Cell Lung Cancer. JAMA Oncol. 2017;3(8):1051-8, DOI: 10.1001/jamaoncol.2017.0013, PMID: 28278348.
NULL

#' Example dataset1
#'
#' A pathology reads dataset of triple negative breast cancer in Reisenbichler et al. (2020). A value of 0 means negative and a value of 1 means positive.
#'
#' \itemize{
#'   \item columns : different raters
#'   \item rows : different cases
#' }
#' @docType data
#' @keywords datasets
#' @name sp142_bin
#' @usage data('sp142_bin')
#' @references
#' [1] Reisenbichler ES, Han G, Bellizzi A, Bossuyt V, Brock J, Cole K, et al. Prospective multi-institutional evaluation of pathologist assessment of PD-L1 assays for patient selection in triple negative breast cancer. Mod Pathol. 2020, DOI: 10.1038/s41379-020-0544-x; PMID: 32300181.
NULL

#' Example dataset2
#'
#' A pathology reads dataset of triple negative breast cancer in Reisenbichler et al. (2020). A value of 0 means negative and a value of 1 means positive.
#'
#' \itemize{
#'   \item columns : different raters
#'   \item rows : different cases
#' }
#' @docType data
#' @keywords datasets
#' @name sp263_bin
#' @usage data('sp263_bin')
#' @references
#' [1] Reisenbichler ES, Han G, Bellizzi A, Bossuyt V, Brock J, Cole K, et al. Prospective multi-institutional evaluation of pathologist assessment of PD-L1 assays for patient selection in triple negative breast cancer. Mod Pathol. 2020, DOI: 10.1038/s41379-020-0544-x; PMID: 32300181.
NULL

#' Example dataset3
#'
#' NCCN SP142 stromal data from Rimm et al. (2017) used to illustrate the ONEST method.
#'
#' \itemize{
#'   \item columns : different raters
#'   \item rows : different cases
#' }
#' @docType data
#' @keywords datasets
#' @name NCCN_sp142
#' @usage data('NCCN_sp142')
#' @references
#' [1] Rimm DL, Han G, Taube JM, Yi ES, Bridge JA, Flieder DB, et al. A Prospective, Multi-institutional, Pathologist-Based Assessment of 4 Immunohistochemistry Assays for PD-L1 Expression in Non-Small Cell Lung Cancer. JAMA Oncol. 2017;3(8):1051-8, DOI: 10.1001/jamaoncol.2017.0013, PMID: 28278348.
NULL

#' Example dataset4
#'
#' NCCN SP142 tumor data from Rimm et al. (2017) used to illustrate the ONEST method.
#'
#' \itemize{
#'   \item columns : different raters
#'   \item rows : different cases
#' }
#' @docType data
#' @keywords datasets
#' @name NCCN_sp142_t
#' @usage data('NCCN_sp142_t')
#' @references
#' [1] Rimm DL, Han G, Taube JM, Yi ES, Bridge JA, Flieder DB, et al. A Prospective, Multi-institutional, Pathologist-Based Assessment of 4 Immunohistochemistry Assays for PD-L1 Expression in Non-Small Cell Lung Cancer. JAMA Oncol. 2017;3(8):1051-8, DOI: 10.1001/jamaoncol.2017.0013, PMID: 28278348.
NULL

#' Example dataset5
#'
#' NCCN 22c3 tumor data from Rimm et al. (2017) used to illustrate the ONEST method.
#'
#' \itemize{
#'   \item columns : different raters
#'   \item rows : different cases
#' }
#' @docType data
#' @keywords datasets
#' @name NCCN_22c3_t
#' @usage data('NCCN_22c3_t')
#' @references
#' [1] Rimm DL, Han G, Taube JM, Yi ES, Bridge JA, Flieder DB, et al. A Prospective, Multi-institutional, Pathologist-Based Assessment of 4 Immunohistochemistry Assays for PD-L1 Expression in Non-Small Cell Lung Cancer. JAMA Oncol. 2017;3(8):1051-8, DOI: 10.1001/jamaoncol.2017.0013, PMID: 28278348.
NULL

#' Precomputed dataset
#'
#' A precomputed dataset only used by the ONEST_vignettes function to create the vignettes.
#'
#' \itemize{
#'   \item columns : different permutations
#'   \item rows : agreement percentage
#' }
#' @docType data
#' @keywords datasets
#' @name empirical
#' @usage data('empirical')
NULL

