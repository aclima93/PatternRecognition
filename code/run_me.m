
% Construct a questdlg with two options
choice = questdlg('Which one would you like to run?', 'PR 2015/16', 'GUI Simulation','All Simulations','GUI Simulation');

global UI_MODE
global SAVE_FIG_FLAG
global VISUALIZE_DATA_FLAG

% Handle response
switch choice
    case 'GUI Simulation'
        
        UI_MODE = 1;
        SAVE_FIG_FLAG = 1;
        VISUALIZE_DATA_FLAG = 1;
        
        run('main_UI');
        
    case 'All Simulations'
        
        UI_MODE = 0;
        SAVE_FIG_FLAG = 1;
        VISUALIZE_DATA_FLAG = 0;
        
        run('run_all');
end