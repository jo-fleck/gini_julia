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



### ROBUSTNESS CHECK

# n_robust = 10000
# wagedistarray1 = zeros(n_robust)
# wagedistarray2 = zeros(n_robust,2)
# wagedistarray3 = zeros(n_robust,3)
# for i in 1:length(wagedistarray1[:,1])
#
#    wagedistarray1[i,1]=i*i*i
#
#    wagedistarray2[i,1]=i*i
#    wagedistarray2[i,2]=1/n_robust
#
#    wagedistarray3[i,1]=i*i
#    wagedistarray3[i,2]=1/n_robust
#    wagedistarray3[i,3]=1/n_robust
#
# end
#
# wagedistarray1[1,1]=-10
# @time result1 = gini(wagedistarray1)
# @time result2 = gini(wagedistarray2)
# @time result3 = gini(wagedistarray3)
