## gini_julia

The Julia file **gini.jl** contains a function which computes Gini Coefficients. It is based on codes and snippets I found online and assembled into one function.

**gini.jl** inputs can be either 
1. a vector of observations (n, 1)
2. an array of dimension (n, 2) where the second column are the weights of the observations

The file **gini_eval.jl** illustrates the performance (in seconds) of **gini.jl** for different numbers of inputs. 

![performance](https://github.com/Jo-Fleck/gini_julia/blob/master/gini_eval_fig.png) 

