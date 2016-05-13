% Script file: RE_marking.m
% Modify event markers one more time
%

for i = 1:length(ALLEEG.event)
    if mod(i,2)     
        ALLEEG.event(i).type = 'Close';
    else
        ALLEEG.event(i).type = 'Open';
    end
end