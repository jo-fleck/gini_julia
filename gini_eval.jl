# Input is either vector or array where second column are weights (= inverse probability)

function gini(datadistarray)

if minimum(datadistarray[:,1]) < 0
    printstyled("There are negative input values - use a different inequality measure \n", bold=:true, color=:red)
    return

else
    if size(datadistarray,2) == 1
        n = length(datadistarray)
    	datadistarray_sorted = sort(datadistarray)
    	2*(sum(collect(1:n).*datadistarray_sorted))/(n*sum(datadistarray_sorted))-1

    elseif size(datadistarray,2) == 2
        Swages = cumsum(datadistarray[:,1].*datadistarray[:,2])
        Gwages = Swages[1]*datadistarray[1,2] + sum(datadistarray[2:end,2] .* (Swages[2:end]+Swages[1:end-1]))
        return 1 - Gwages/Swages[end]

    else
    printstyled("Input data does not have conformable dimension \n", bold=:true, color=:red)
    return
    end

end

end

## PERFORMANCE EVALUATION

obs = 10
n_max = 8 # max 8 - higher number might lead to system freeze
res_perf = zeros(n_max,3)

for k = 1:n_max
    n_obs = obs.^k
    dist1 = zeros(n_obs)
    dist2 = zeros(n_obs,2)

    for i in 1:n_obs
        dist1[i,1]=i*i
        dist2[i,1]=i*i
        dist2[i,2]=1/n_obs
    end

    res_perf[k,1] = @elapsed gini(dist1)
    res_perf[k,2] = @elapsed gini(dist2)
    res_perf[k,3] = n_obs
end

y1 = res_perf[:,1]
y2 = res_perf[:,2]
x = res_perf[:,3]

using PyPlot
clf()   # clear current plot
semilogx(x,y1, label = "gini with vector input")
semilogx(x,y2, label = "gini with array input (for weights)")
xlabel(L"Number of observations ($10^6$ = 1.000.000 = 1 mio)")
ylabel("Elapsed time (in seconds)")
legend() # turn on legend
title("Performance Evaluation of the gini.jl Function")
savefig("/Users/main/Documents/GitHubRepos/Gini_julia/gini_eval_fig.png")
close() # close the window
