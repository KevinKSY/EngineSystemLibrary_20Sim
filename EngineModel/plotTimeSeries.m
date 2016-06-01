function varargout = plotTimeSeries(varargin)
% PLOTTIMESERIES MATLAB code for plotTimeSeries.fig
%      PLOTTIMESERIES, by itself, creates a new PLOTTIMESERIES or raises the existing
%      singleton*.
%
%      H = PLOTTIMESERIES returns the handle to a new PLOTTIMESERIES or the handle to
%      the existing singleton*.
%
%      PLOTTIMESERIES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLOTTIMESERIES.M with the given input arguments.
%
%      PLOTTIMESERIES('Property','Value',...) creates a new PLOTTIMESERIES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before plotTimeSeries_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to plotTimeSeries_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help plotTimeSeries

% Last Modified by GUIDE v2.5 18-Mar-2016 13:28:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @plotTimeSeries_OpeningFcn, ...
                   'gui_OutputFcn',  @plotTimeSeries_OutputFcn, ...
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


% --- Executes just before plotTimeSeries is made visible.
function plotTimeSeries_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to plotTimeSeries (see VARARGIN)

% Choose default command line output for plotTimeSeries
handles.output = hObject;
handles.cases = (1:20)';
handles.filterApply = 0;

set(handles.listbox3,'String',handles.cases);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes plotTimeSeries wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = plotTimeSeries_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2


% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
idxSelected = get(handles.listbox1,'Value');
caseNo = get(handles.listbox3,'Value');
sampFreq = str2double(get(handles.edit2,'String'));
if isfield(handles,'namesSelected') 
    if isempty(handles.namesSelected)
        handles.namesSelected{1} = handles.names{idxSelected};
        handles.dataSelected{1} = handles.data{caseNo}(:,idxSelected);
        handles.timeSelected{1} = handles.data{caseNo}(:,1);
        handles.condSelected{1} = strcat('Case ',num2str(caseNo));
    else
        handles.namesSelected = [handles.namesSelected; handles.names{idxSelected}];
        handles.dataSelected = [handles.dataSelected; handles.data{caseNo}(:,idxSelected)];
        handles.timeSelected = [handles.timeSelected; handles.data{caseNo}(:,1)];
        handles.condSelected = [handles.condSelected; strcat('Case ',num2str(caseNo))];
    end;
else
    handles.namesSelected{1} = handles.names{idxSelected};
    handles.dataSelected{1} = handles.data{caseNo}(:,idxSelected);
    handles.timeSelected{1} = handles.data{caseNo}(:,1);
    handles.condSelected{1} = strcat('Case ',num2str(caseNo));
end;
if handles.filterApply
    sampFq = 1/(handles.data{caseNo}(end,1) - handles.data{caseNo}(end-1,1));
    [b, a] = butter(4,2.5*2/sampFq);
    handles.dataSelected{end} = filter(b,a,handles.dataSelected{end});
end;
ts = timeseries(handles.dataSelected{end},handles.timeSelected{end});
newTime = (ts.Time(1):1/sampFreq:ts.Time(end))';
ts = resample(ts,newTime);
handles.dataSelected{end} = ts.Data;
handles.timeSelected{end} = ts.Time;
set(handles.listbox2,'String',handles.namesSelected);

plotData(handles.axes1,handles);


guidata(hObject, handles);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
idxSelected = get(handles.listbox2,'Value');
if isfield(handles,'namesSelected')
    if ~isempty(handles.namesSelected)
        handles.namesSelected(idxSelected) = [];
        handles.dataSelected(idxSelected) = [];
        handles.timeSelected(idxSelected) = [];
        handles.condSelected(idxSelected) = [];
    end;
end;

set(handles.listbox2,'String',handles.namesSelected);

plotData(handles.axes1,handles);

guidata(hObject, handles);    

% --------------------------------------------------------------------
function uipushtool1_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname] = uigetfile('*.mat');

load(strcat(pathname,filename));

handles.names = names;
set(handles.listbox1,'String',handles.names);
handles.data = values;


guidata(hObject,handles);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure1 = figure;
h = axes('Parent',figure1);
plotData(h,handles);

function plotData(ax,handles)
cla(ax,'reset');
hold(ax,'on')
m = length(handles.namesSelected);
for i = 1:m
    switch i
        case 1
            lineSpec = '''-black'',''Linewidth'',2';
        case 2
            lineSpec = '''--black'',''Linewidth'',2';
        case 3
            lineSpec = ''':black'',''Linewidth'',2';
        otherwise
            lineSpec = '''-black'',''Linewidth'',2';
    end;      
    eval(strcat('plot(ax,handles.timeSelected{i},handles.dataSelected{i},',lineSpec,')'));
end;

legendS = cellfun(@strcat,handles.namesSelected, handles.condSelected,'UniformOutput',false);
legend(legendS);
xlabel('Time (s)');



% --- Executes on selection change in listbox3.
function listbox3_Callback(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox3


% --- Executes during object creation, after setting all properties.
function listbox3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox4.
function listbox4_Callback(hObject, eventdata, handles)
% hObject    handle to listbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox4


% --- Executes during object creation, after setting all properties.
function listbox4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox5.
function listbox5_Callback(hObject, eventdata, handles)
% hObject    handle to listbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox5


% --- Executes during object creation, after setting all properties.
function listbox5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in uibuttongroup1.
function uibuttongroup1_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup1 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = eventdata.NewValue.String;
if strcmp(selection,'On')
    handles.filterApply = 1;
else
    handles.filterApply = 0;
end;

guidata(hObject,handles);


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
varName = get(handles.edit1,'String');
dataToExport.namesSelected = handles.namesSelected;
dataToExport.dataSelected = handles.dataSelected;
dataToExport.timeSelected = handles.timeSelected;
dataToExport.condSelected = handles.condSelected;
assignin('base',varName{1},dataToExport);



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
