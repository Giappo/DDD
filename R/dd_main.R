#' Run the DD ruotine: simulation + MLE
#' @author Giovanni Laudanno
#' @export
dd_main <- function(
  lambda,
  mu,
  K,
  age,
  cond = 1,
  seed,
  ddmodel = 1,
  output_folder = NA
) {
  set.seed(seed)
  brts <- DDD::dd_sim(pars = c(lambda, mu, K), age = age, ddmodel = ddmodel)$brts
  out <- DDD::dd_ML(brts = brts, ddmodel = ddmodel, cond = cond)
  out <- unlist(out)
  nomi <- names(out)
  dim(out) <- c(1, length(out))
  colnames(out) <- nomi

  if (!is.na(output_folder)) {
    output_file <- file.path(
      output_folder,
      paste0(
        "[lambda=",
        lambda,
        "]-[",
        "mu=",
        mu,
        "]-[",
        "K=",
        K,
        "]-[",
        "age=",
        age,
        "]-[",
        "cond=",
        cond,
        "]-[",
        "seed=",
        seed,
        "].txt"
      )
    )
    write.csv2(x = out, file = output_file)
  }
  out
}