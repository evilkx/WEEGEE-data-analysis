function timemarker = time_simulation(myevent, ha_event)
% Description: To perform time that the ssvep experience's 
%              working for each trials
% Input: myevent 
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
% First event
indexC = strfind(numtype, myevent(1).type);
idx = find(not(cellfun(@isempty, indexC)));
rectangle('Position', [0, 0, latency(1) 10], ...
    'FaceColor', eventcolor(idx, :) , ...
    'Parent', ha_event);

text(0, 0, myevent(1).type,...
    'HorizontalAlignment', 'left', 'BackgroundColor', 'm', 'Fontsize', 9, 'Parent', ha_event);

% From second event to the end
for i = 2:n  
    curtype = myevent(i).type;
    indexC = strfind(numtype, myevent(i).type);
    idx = find(not(cellfun(@isempty, indexC)));
    try
        hrec = rectangle('Position', [latency(i), 0, latency(i) - latency(i-1), 10]);
    catch ME
        if strcmp(ME.identifier, 'MATLAB:hg:set_chck:DimensionsOutsideRange')
            warning('Two events have the same latency. Check the events');
            % Create new rec, width = 1
            hrec = rectangle('Position', [latency(i), 0, latency(i) - latency(i-1) + 1, 10]);
        else
%             rethrow(ME);
            disp('something else got wrong');
        end
    end
    set(hrec, 'FaceColor', eventcolor(idx, :),'Parent', ha_event);
    text(latency(i), 0, myevent(i).type, 'HorizontalAlignment', 'left', 'BackgroundColor', 'm', 'Fontsize', 9, 'Parent', ha_event);
end

%% 
ylim = get(ha_event, 'YLim');
timemarker = line([0 0], ylim, 'color', [1 0.5 0.5], 'LineWidth', 10);
alpha(0.4)

end


