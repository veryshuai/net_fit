function print_results(x, err)
% This function prints results to file

    savename=sprintf('results/running_%s.txt',datestr(now,1));
    f = fopen(savename,'a');
    fprintf(f,'\n err: \n');
    dlmwrite(savename, err, '-append', 'precision','%10.20f')
    fprintf(f,'\n x: \n');
    dlmwrite(savename, x, '-append', 'precision','%10.20f')
    fprintf(f, '\n--\n');
    fclose(f);
