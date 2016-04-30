
% Construct a questdlg with two options
choice = questdlg('Which one would you like to run?', 'PR 2015/16', 'GUI Simulation','All Simulations','GUI Simulation');

% Handle response
switch choice
    case 'GUI Simulation'
        run('main_UI');
    case 'All Simulations'
        run('run_all');
end