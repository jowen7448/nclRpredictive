#' Convience function for creating boundary plots
#' 
#' @param model A caret classification model
#' @param x Data
#' @param y Data
#' @param z Observed values
#' @param ... Additional arguments passed to the contour function
#' @export
boundary_plot = function(model, x, y, z, ...) {
  
  ## Set up a grid for prediction
  x_range = range(x)
  y_range = range(y)
  x_seq = seq(x_range[1], x_range[2], length.out = 100)
  y_seq = seq(y_range[1], y_range[2], length.out = 100)
  
  grid = expand.grid( x_seq, y_seq)
  colnames(grid) = all.vars(formula(model))[2:3]
  
  # make the predictions
  predictions = predict(model, grid, type = "prob")
  # turn the predictions into a matrix for a contour plot
  predmat = matrix(predictions[,2], nrow=100)
  contour(x_seq, y_seq, predmat, levels = 0.5, lwd = 2, ...)
  
  # the background points indicating prediction
  points(grid, col = c("red","blue")[predict(m1,grid)], 
         cex = 0.2)
  # there are few unique combinations of prices, 
  # jitter can help see the points
  # points of prices coloured by purchased brand
  points(jitter(x),
         jitter(y),
         col = c("red","blue")[z], 
         pch = 19, cex = 0.6)
  
  }