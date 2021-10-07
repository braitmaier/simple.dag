#' Helper function to calculate start and end points of directed edges 
#'
#' Defines a radius around each node. Edges only start and end outside of 
#' this radius 
#'
#' @param x.0 x coordinate of start point
#' @param y.0 y coordinate of start point 
#' @param x.1 x coordinate of end point 
#' @param y.1 y coordinate of end point 
#' @param radius radius around nodes that should not be used for drawing edges 
#' @examples
#' define.arrow(
#'   x.0 = -.5, 
#'   y.0 = 0, 
#'   x.1 = .5, 
#'   y.1 = 0, 
#'   radius = .1
#' )
#' @return data.frame 
#' @export
define.arrow <- function(
x.0, 
y.0, 
x.1, 
y.1, 
radius = 0.1
) {
  ### distance from start to end point 
  d <- as.numeric(dist(rbind(c(x.0, y.0), c(x.1, y.1))))
  if (d == 0) stop("vectors of length zero are not allowed")
  d.1 <- radius
  d.2 <- d - radius
  r.1 <- d.1/d
  r.2 <- d.2/d
  ### move vector to the origin 
  x.1.ori <- x.1 - x.0
  y.1.ori <- y.1 - y.0
  ### calculate adjusted start and end points 
  x.0.hovering <- r.1*x.1.ori+x.0
  y.0.hovering <- r.1*y.1.ori+y.0
  x.1.hovering <- r.2*x.1.ori+x.0
  y.1.hovering <- r.2*y.1.ori+y.0
  ### return output 
  data.frame(
    x.0 = x.0.hovering, 
    y.0 = y.0.hovering, 
    x.1 = x.1.hovering, 
    y.1 = y.1.hovering
  )
}