##' Connect
##'
##' Connect to dropbox
##'
##' @param sides A string that controls which sides of the plot the frames appear on.
##'   It can be set to a string containing any of \code{"trbl"}, for top, right,
##'   bottom, and left.
##' @param fun_max Function used to calculate the minimum of the range frame line.
##' @param fun_min Function used to calculate the maximum of the range frame line.
##' @export
##'
##' @references Dropbox API
##'
##' @examples
##' (ggplot(mtcars, aes(wt, mpg))
##'  + geom_point() + geom_rangeframe()
##'  + theme_tufte())

dropbox_connect<-function(x){
  
}