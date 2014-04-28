function break_me = break_fun(k, loc, N)
% This function returns one if k > N, zero otherwise

    if k > N
        break_me = 1;
        display('Warning! Solver problem in following location');
        display(loc);
    else
        break_me = 0;
    end

end
