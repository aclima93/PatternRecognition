global REFERENCE_PATH
simulation_folders = subdirectories(REFERENCE_PATH);
num_simulations = length(simulation_folders);

configuration_string = '';

for i = 1:num_simulations
    
    % go to simulation folder
    simulation_path = sprintf('%s/%s', REFERENCE_PATH, simulation_folders(i).name);
    
    iteration_folders = subdirectories(simulation_path);
    num_iterations = length(iteration_folders);
    
    % go to iteration folder 1 as they are all the same
    iteration_path = sprintf('%s/1', simulation_path);
    
    load( sprintf('%s/configuration', iteration_path) );
    
    configuration_string = sprintf('%s \\\\ \\hline \n\n %d', configuration_string, i);
    
    fieldname_strings = fieldnames(configuration);
    fieldname_strings = fieldname_strings(5:end); % discard the useless first five confs.
    
    for fieldname_idx = 1:length(fieldname_strings)
        fieldname = fieldname_strings{fieldname_idx};
        
        if ischar(configuration.(fieldname))
            configuration_string = sprintf('%s & %s', configuration_string, configuration.(fieldname) );
        elseif isnumeric(configuration.(fieldname))
            configuration_string = sprintf('%s & %s', configuration_string, num2str(configuration.(fieldname)) );
        end
    end
     
end

disp(configuration_string)