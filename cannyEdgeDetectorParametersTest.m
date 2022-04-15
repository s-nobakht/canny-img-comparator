function varargout = cannyEdgeDetectorParametersTest(varargin)
% CANNYEDGEDETECTORPARAMETERSTEST MATLAB code for cannyEdgeDetectorParametersTest.fig
%      CANNYEDGEDETECTORPARAMETERSTEST, by itself, creates a new CANNYEDGEDETECTORPARAMETERSTEST or raises the existing
%      singleton*.
%
%      H = CANNYEDGEDETECTORPARAMETERSTEST returns the handle to a new CANNYEDGEDETECTORPARAMETERSTEST or the handle to
%      the existing singleton*.
%
%      CANNYEDGEDETECTORPARAMETERSTEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CANNYEDGEDETECTORPARAMETERSTEST.M with the given input arguments.
%
%      CANNYEDGEDETECTORPARAMETERSTEST('Property','Value',...) creates a new CANNYEDGEDETECTORPARAMETERSTEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before cannyEdgeDetectorParametersTest_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to cannyEdgeDetectorParametersTest_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help cannyEdgeDetectorParametersTest

% Last Modified by GUIDE v2.5 07-Jan-2016 20:16:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @cannyEdgeDetectorParametersTest_OpeningFcn, ...
                   'gui_OutputFcn',  @cannyEdgeDetectorParametersTest_OutputFcn, ...
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


% --- Executes just before cannyEdgeDetectorParametersTest is made visible.
function cannyEdgeDetectorParametersTest_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to cannyEdgeDetectorParametersTest (see VARARGIN)

% Choose default command line output for cannyEdgeDetectorParametersTest
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes cannyEdgeDetectorParametersTest wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = cannyEdgeDetectorParametersTest_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% get object from form
h = findobj('Tag','pushbutton2');
data = get(h,'UserData');
Im = data.imageData;
% Check existence of image
if(exist('Im','var'))
    gaussian_size = str2double(get( handles.edit1, 'String' ));
    higher_threshold = str2double(get( handles.edit2, 'String' ));
    lower_threshold = str2double(get( handles.edit3, 'String' ));
    if(isempty(gaussian_size))
        gaussian_size = 1;
    end
    if(isempty(higher_threshold))
        higher_threshold = 2.5;
    end
    if(isempty(lower_threshold))
        lower_threshold = 0.5;
    end
    
    % extract egdes using canny algorithm
    imageEdges = canny(Im,lower_threshold,higher_threshold,gaussian_size);
    handles.Axes2 = axes('Units', 'pixels', 'position', [600, 50, 256, 256], 'Visible', 'off');
    image(imageEdges, 'Parent', handles.Axes2);
    imshow(imageEdges,[]);    
else
    % if the image does not exist
    disp('Im is not set');
end
guidata(hObject, handles);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = hObject;
[fn pn] = uigetfile({'*.tif';'*.jpg';'*.bmp'},'Select an Image File');
complete = strcat(pn,fn);
set(handles.edit4,'String',complete);
Im = imread(complete);
[rows cols] = size(Im);
if(cols>384)
    Im = imresize(Im, 384/cols);
elseif(rows>384)
    Im = imresize(Im, 384/rows);
end
handles.Axes1 = axes('Units', 'pixels', 'position', [300, 50, 256, 256], 'Visible', 'off');
image(Im, 'Parent', handles.Axes1);
imshow(Im,[]);
data = struct('imageData',Im);   
set(hObject,'UserData',data);
guidata(hObject, handles);



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
