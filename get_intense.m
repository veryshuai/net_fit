function Q = get_intense(p, theta, v)
% Returns intensity matrix

    % Create zero matrix
    len = size(v,1);
    Q = zeros(len);

    % Fill in up moves
    Q(len + 1:len + 1:end) = theta * v(1:end - 1);

    % Fill in down moves
    Q(2:len + 1:end) = p('delta');

    % Fill in diagonals
    diag = theta * v + p('delta');
    diag(1) = theta * v(1);
    diag(end) = p('delta');
    Q(1:len + 1:end) = -(diag);
    
end

