#' A function for marking models during the predictive analytics course
#' 
#' @param model A model resulting from a call to train
#' @return NULL
#' @importFrom stats lowess
#' @export
mark = function(model){
  if(!inherits(model,"validated")) stop("Make sure to validate your model before trying to mark it")
  data(FuelEconomy, package = "AppliedPredictiveModeling")
  pred = predict(model, cars2011)
  err = cars2011$FE - pred
  rmse = sqrt(mean(err*err))
  op = par(mfrow = c(1,2), oma = c(0,0,1,0))
  plot(cars2011$FE,pred,xlab = "Observed", ylab = "Fitted", col = "grey", xlim = range(cars2011$FE),
       ylim = range(cars2011$FE))
  abline(0,1)
  lines(lowess(cars2011$FE,pred),col = 2, lwd = 2, lty = 2)
  plot(cars2011$FE,err, xlab = "Observed", ylab = "Errors", col = "grey")
  abline(h = 0)
  lines(lowess(cars2011$FE,err),col = 2, lwd = 2, lty = 2)
  mtext(text = paste("RMSE: ",round(rmse,4)), outer = TRUE, line = -3)
}