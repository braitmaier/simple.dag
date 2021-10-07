
library(simple.dag)


### define the nodes of the DAG 
nodes <- data.frame(
  name =        c("X",  "Y",  "D", "C_DY",  "C_XD",  "C_XY"), 
  description = c("X",  "Y",  "D", "C[DY]", "C[XD]", "C[XY]"), 
  x =           c(-0.5,  0.5,  0,   1,      -1,       0), 
  y =           c( 0,    0,   -1,  -1,      -1,       1)
)

### define directed edges between nodes 
g <- "gray50"
b <- "black"
edges <- data.frame(
  from = c("X", "D", "C_XY", "C_XY", "C_XD", "C_XD", "C_DY", "C_DY"), 
  to =   c("Y", "Y", "X",    "Y",    "X",    "D",    "D",    "Y"), 
  lwd =  c( 1,   2,   1,      1,      1,      1,      1,      1), 
  col =  c( g,   b,   g,      g,      g,      g,      g,      g)
)

### define start and end points of edges (don't start edge directly on the edge, 
### but add some blank space around the edge)
add.to.edges <- vector(mode = "list", length = nrow(edges))
for (i in 1:length(add.to.edges)) {
  add.to.edges[[i]] <- define.arrow(
    x.0 = nodes[nodes$name == edges$from[i],"x"], 
    y.0 = nodes[nodes$name == edges$from[i],"y"], 
    x.1 = nodes[nodes$name == edges$to[i],"x"], 
    y.1 = nodes[nodes$name == edges$to[i],"y"], 
    radius = 0.2
  )
}
add.to.edges <- do.call(rbind, add.to.edges)
edges <- cbind(edges, add.to.edges)

nodes
edges


par(mar = c(.1, .1, .1, .1))
plot(c(-1,-1), c(1,1), ylim = c(-1.1, 1.1), xlim = c(-1.1, 1.1), 
     axes = F, xlab = "", ylab = "", type = "n")
text(nodes$x, nodes$y, parse(text = nodes$description))
for (i in 1:nrow(edges)) {
  arrows(
    edges$x.0[i], 
    edges$y.0[i], 
    edges$x.1[i], 
    edges$y.1[i], 
    length = .1, 
    lwd = edges$lwd[i], 
    col = edges$col[i]
  )
}











dag <- dagitty("dag{
  C_DY [pos=\" 1,  1\"]
  C_XD [pos=\"-1,  1\"]
  C_XY [pos=\" 0, -1\"]
  D    [pos=\" 0,  1\"]
  X [exposure,pos=\"-0.5, 0\"]
  Y [outcome,pos=\"  0.5, 0\"]
  C_DY -> D
  C_DY -> Y
  C_XD -> D
  C_XD -> X
  C_XY -> X
  C_XY -> Y
  D -> Y
  X -> Y
}"
)
plot(dag)

