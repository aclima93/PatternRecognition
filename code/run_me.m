
% Construct a questdlg with two options
choice = questdlg('Which one would you like to run?', 'PR 2015/16', 'Custom Simulation','All Simulations', 'Interesting Simulations','GUI Simulation');

global UI_MODE
global SAVE_FIG_FLAG
global VISUALIZE_DATA_FLAG
global SIMULATION_PATH

% Handle response
switch choice
    case 'GUI Simulation'
        
        UI_MODE = 1;
        SAVE_FIG_FLAG = 1;
        VISUALIZE_DATA_FLAG = 1;
        SIMULATION_PATH = '../images/custom_simulations';
        
        run('main_UI');
        
    case 'All Simulations'
        
        UI_MODE = 0;
        SAVE_FIG_FLAG = 1;
        VISUALIZE_DATA_FLAG = 0;
        SIMULATION_PATH = '../images/all_simulations';
        
        run('run_all');
        
    case 'Interesting Simulations'
        
        UI_MODE = 0;
        SAVE_FIG_FLAG = 1;
        VISUALIZE_DATA_FLAG = 0;
        SIMULATION_PATH = '../images/interesting_simulations';
        
        run('run_simulations');
        
end