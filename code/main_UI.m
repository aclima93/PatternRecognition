function varargout = main_UI(varargin)
% MAIN_UI MATLAB code for main_UI.fig
%      MAIN_UI, by itself, creates a new MAIN_UI or raises the existing
%      singleton*.
%
%      H = MAIN_UI returns the handle to a new MAIN_UI or the handle to
%      the existing singleton*.
%
%      MAIN_UI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN_UI.M with the given input arguments.
%
%      MAIN_UI('Property','Value',...) creates a new MAIN_UI or raises
%      the existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_UI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_UI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main_UI

% Last Modified by GUIDE v2.5 01-May-2016 03:29:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_UI_OpeningFcn, ...
                   'gui_OutputFcn',  @main_UI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before main_UI is made visible.
function main_UI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main_UI (see VARARGIN)

% Choose default command line output for main_UI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

%initialize_gui(hObject, handles, false);

% UIWAIT makes main_UI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_UI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --------------------------------------------------------------------
function initialize_gui(fig_handle, handles, isreset)

% Update handles structure
guidata(handles.figure1, handles);


% --- Executes on button press in run_btn.
function run_btn_Callback(hObject, eventdata, handles)
% hObject    handle to run_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% -------------- %
% Pre-Processing %
% -------------- %

global DATASET_PATH
DATASET_PATH = get(handles.dataset_path_edt, 'String');

global NORMALIZE_FLAG
NORMALIZE_FLAG = get(handles.normalize_data_chk, 'Value');

% ----------------- %
% Feature Selection %
% ----------------- %

global FEATURE_SELECTION_FLAG
FEATURE_SELECTION_FLAG = get(handles.feature_selection_chk, 'Value');

global X_COR_COV_FLAG
global X_COR_COV_THRESHOLD_FLAG
X_COR_COV_FLAG = get(handles.cor_cov_x_chk, 'Value');
X_COR_COV_THRESHOLD_FLAG = str2double(get(handles.cor_cov_x_edt, 'String'));

global XY_COR_COV_FLAG
global XY_COR_COV_THRESHOLD_FLAG
XY_COR_COV_FLAG = get(handles.cor_cov_xy_chk, 'Value');
XY_COR_COV_THRESHOLD_FLAG = str2double(get(handles.cor_cov_xy_edt, 'String'));

global KRUSKAL_WALLIS_FLAG
global KRUSKAL_WALLIS_THRESHOLD_FLAG
KRUSKAL_WALLIS_FLAG = get(handles.kruskal_wallis_chk, 'Value');
KRUSKAL_WALLIS_THRESHOLD_FLAG = str2double(get(handles.kruskal_wallis_edt, 'String'));

% ----------------- %
% Feature Reduction %
% ----------------- %

global FEATURE_REDUCTION_FLAG
FEATURE_REDUCTION_FLAG = get(handles.feature_reduction_chk, 'Value');

global PCA_FLAG LDA_FLAG PCA_LDA_FLAG LDA_PCA_FLAG
item_list = get(handles.reduction_method_pop,'String');
selected_item_value = get(handles.reduction_method_pop,'Value');
selected_item_idx = item_list{selected_item_value};
item_flags = zeros(1, length(item_list));
item_flags(selected_item_idx) = 1;
item_flags = num2cell(item_flags);
[PCA_FLAG, LDA_FLAG, PCA_LDA_FLAG, LDA_PCA_FLAG] = item_flags{:};

global KAISER_CRITERIA_FLAG SCREE_TEST_FLAG
item_list = get(handles.additional_reduction_method_pop,'String');
selected_item_value = get(handles.additional_reduction_method_pop,'Value');
selected_item_idx = item_list{selected_item_value};
item_flags = zeros(1, length(item_list));
item_flags(selected_item_idx) = 1;
item_flags = num2cell(item_flags);
[KAISER_CRITERIA_FLAG, SCREE_TEST_FLAG, ~] = item_flags{:};

global KAISER_CRITERIA_THRESHOLD SCREE_TEST_THRESHOLD
KAISER_CRITERIA_THRESHOLD = str2double(get(handles.additional_reduction_method_edt, 'String'));
SCREE_TEST_THRESHOLD = str2double(get(handles.additional_reduction_method_edt, 'String'));

% ------------------- %
% Performance Results %
% ------------------- %

global TRAINING_RATIO
TRAINING_RATIO = str2double(get(handles.splitting_edt, 'String'));

global STRATIFIED_FLAG
STRATIFIED_FLAG = get(handles.splitting_chk, 'Value');

global MATLAB_LDC_FLAG EDC_FLAG MDC_FLAG
item_list = get(handles.classifier_pop,'String');
selected_item_value = get(handles.classifier_pop,'Value');
selected_item_idx = item_list{selected_item_value};
item_flags = zeros(1, length(item_list));
item_flags(selected_item_idx) = 1;
item_flags = num2cell(item_flags);
[MATLAB_LDC_FLAG, EDC_FLAG, MDC_FLAG] = item_flags{:};

close all;
clc;
run('main_script');


% --- Executes on button press in reset_btn.
function reset_btn_Callback(hObject, eventdata, handles)
% hObject    handle to reset_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% -------------- %
% Pre-Processing %
% -------------- %

set(handles.dataset_path_edt, 'String', '../data/dataset.mat');

set(handles.normalize_data_chk, 'Value', 1);

% ----------------- %
% Feature Selection %
% ----------------- %

set(handles.feature_selection_chk, 'Value', 1);

set(handles.cor_cov_x_chk, 'Value', 1);
set(handles.cor_cov_x_edt, 'String', '0.9');

set(handles.cor_cov_xy_chk, 'Value', 1);
set(handles.cor_cov_xy_edt, 'String', '0.5');

set(handles.kruskal_wallis_chk, 'Value', 1);
set(handles.kruskal_wallis_edt, 'String', '0.05');

% ----------------- %
% Feature Reduction %
% ----------------- %

set(handles.feature_reduction_chk, 'Value', 1);

set(handles.reduction_method_pop, 'Value', 1);

set(handles.additional_reduction_method_pop, 'Value', 1);
set(handles.additional_reduction_method_edt, 'String', '1');

% ------------------- %
% Performance Results %
% ------------------- %

set(handles.splitting_edt, 'String', '0.7');
set(handles.splitting_chk, 'Value', 1);

set(handles.additional_reduction_method_pop, 'Value', 1);



% --- Executes on button press in feature_reduction_chk.
function feature_reduction_chk_Callback(hObject, eventdata, handles)
% hObject    handle to feature_reduction_chk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of feature_reduction_chk


% --- Executes on button press in feature_selection_chk.
function feature_selection_chk_Callback(hObject, eventdata, handles)
% hObject    handle to feature_selection_chk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of feature_selection_chk


% --- Executes on button press in kruskal_wallis_chk.
function kruskal_wallis_chk_Callback(hObject, eventdata, handles)
% hObject    handle to kruskal_wallis_chk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of kruskal_wallis_chk


% --- Executes on button press in cor_cov_x_chk.
function cor_cov_x_chk_Callback(hObject, eventdata, handles)
% hObject    handle to cor_cov_x_chk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cor_cov_x_chk


% --- Executes on button press in cor_cov_xy_chk.
function cor_cov_xy_chk_Callback(hObject, eventdata, handles)
% hObject    handle to cor_cov_xy_chk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cor_cov_xy_chk



function cor_cov_x_edt_Callback(hObject, eventdata, handles)
% hObject    handle to cor_cov_x_edt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cor_cov_x_edt as text
%        str2double(get(hObject,'String')) returns contents of cor_cov_x_edt as a double


% --- Executes during object creation, after setting all properties.
function cor_cov_x_edt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cor_cov_x_edt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cor_cov_xy_edt_Callback(hObject, eventdata, handles)
% hObject    handle to cor_cov_xy_edt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cor_cov_xy_edt as text
%        str2double(get(hObject,'String')) returns contents of cor_cov_xy_edt as a double


% --- Executes during object creation, after setting all properties.
function cor_cov_xy_edt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cor_cov_xy_edt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function kruskal_wallis_edt_Callback(hObject, eventdata, handles)
% hObject    handle to kruskal_wallis_edt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of kruskal_wallis_edt as text
%        str2double(get(hObject,'String')) returns contents of kruskal_wallis_edt as a double


% --- Executes during object creation, after setting all properties.
function kruskal_wallis_edt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kruskal_wallis_edt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dataset_path_edt_Callback(hObject, eventdata, handles)
% hObject    handle to dataset_path_edt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dataset_path_edt as text
%        str2double(get(hObject,'String')) returns contents of dataset_path_edt as a double


% --- Executes during object creation, after setting all properties.
function dataset_path_edt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dataset_path_edt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in browse_btn.
function browse_btn_Callback(hObject, eventdata, handles)
% hObject    handle to browse_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[FileName, PathName, ~] = uigetfile('*.mat');
set(handles.dataset_path_edt, 'String', sprintf('%s%s', PathName, FileName));


% --- Executes on button press in normalize_data_chk.
function normalize_data_chk_Callback(hObject, eventdata, handles)
% hObject    handle to normalize_data_chk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of normalize_data_chk



function additional_reduction_method_edt_Callback(hObject, eventdata, handles)
% hObject    handle to additional_reduction_method_edt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of additional_reduction_method_edt as text
%        str2double(get(hObject,'String')) returns contents of additional_reduction_method_edt as a double


% --- Executes during object creation, after setting all properties.
function additional_reduction_method_edt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to additional_reduction_method_edt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in additional_reduction_method_pop.
function additional_reduction_method_pop_Callback(hObject, eventdata, handles)
% hObject    handle to additional_reduction_method_pop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns additional_reduction_method_pop contents as cell array
%        contents{get(hObject,'Value')} returns selected item from additional_reduction_method_pop


% --- Executes during object creation, after setting all properties.
function additional_reduction_method_pop_CreateFcn(hObject, eventdata, handles)
% hObject    handle to additional_reduction_method_pop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in reduction_method_pop.
function reduction_method_pop_Callback(hObject, eventdata, handles)
% hObject    handle to reduction_method_pop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns reduction_method_pop contents as cell array
%        contents{get(hObject,'Value')} returns selected item from reduction_method_pop


% --- Executes during object creation, after setting all properties.
function reduction_method_pop_CreateFcn(hObject, eventdata, handles)
% hObject    handle to reduction_method_pop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in classifier_pop.
function classifier_pop_Callback(hObject, eventdata, handles)
% hObject    handle to classifier_pop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns classifier_pop contents as cell array
%        contents{get(hObject,'Value')} returns selected item from classifier_pop


% --- Executes during object creation, after setting all properties.
function classifier_pop_CreateFcn(hObject, eventdata, handles)
% hObject    handle to classifier_pop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function splitting_edt_Callback(hObject, eventdata, handles)
% hObject    handle to splitting_edt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of splitting_edt as text
%        str2double(get(hObject,'String')) returns contents of splitting_edt as a double


% --- Executes during object creation, after setting all properties.
function splitting_edt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to splitting_edt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in splitting_chk.
function splitting_chk_Callback(hObject, eventdata, handles)
% hObject    handle to splitting_chk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of splitting_chk
