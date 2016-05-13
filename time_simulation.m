function timemarker = time_simulation(myevent, ha_event, Fs)
% Description: To perform time that the ssvep experience's 
%              working for each trials
% Input: 
%   myevent     : event vectors
%   ha_event    : axes handles
%   Fs          : sampling frequency
%        
% Output: time_simulation % That the figure will be shown
% Example: 
%   ...\time_simulation.m % Load the function
%   time_simulation % Run the function
%

n = length(myevent);
latency = zeros(1, n);

% Determine how many event types
numtype = cell(1,1);            % Number of even types
numtype{1} = myevent(1).type;
flag = 1;
for j = 1:n
    latency(:,j) = myevent(j).latency;
    curtype = myevent(j).type;
    for i = 1:length(numtype)
        if strcmp(curtype, numtype{i})
            flag = 0;
            continue;
        end
    end
    if flag
        numtype = [numtype, {curtype}];
    end
    flag = 1;
end

eventcolor = rand(length(numtype), 3);

%% Plot event marker
for i = 1:n  
    curtype = myevent(i).type;
    indexC = strfind(numtype, myevent(i).type);
    idx = find(not(cellfun(@isempty, indexC)));

    rectangle('Position', [latency(i)/Fs, 0, 2, 10], ...
        'FaceColor', eventcolor(idx, :),'Parent', ha_event);
    text(latency(i)/Fs, 0, myevent(i).type, ...
        'HorizontalAlignment', 'left', 'BackgroundColor', 'm', 'Fontsize', 9, 'Parent', ha_event);
end

%% 
ylim = get(ha_event, 'YLim');
timemarker = line([0 0], ylim, 'color', [1 0.5 0.5], 'LineWidth', 5, 'Parent', ha_event);
alpha(0.4)

end


