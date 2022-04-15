function varargout = compareImages(varargin)
% COMPAREIMAGES MATLAB code for compareImages.fig
%      COMPAREIMAGES, by itself, creates a new COMPAREIMAGES or raises the existing
%      singleton*.
%
%      H = COMPAREIMAGES returns the handle to a new COMPAREIMAGES or the handle to
%      the existing singleton*.
%
%      COMPAREIMAGES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COMPAREIMAGES.M with the given input arguments.
%
%      COMPAREIMAGES('Property','Value',...) creates a new COMPAREIMAGES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before compareImages_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to compareImages_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help compareImages

% Last Modified by GUIDE v2.5 08-Jan-2016 18:35:41


% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @compareImages_OpeningFcn, ...
                   'gui_OutputFcn',  @compareImages_OutputFcn, ...
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


% --- Executes just before compareImages is made visible.
function compareImages_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to compareImages (see VARARGIN)

% Choose default command line output for compareImages
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes compareImages wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = compareImages_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = hObject;

% create a new window for reading images from files with defined extentions
[fn pn] = uigetfile({'*.tif';'*.jpg';'*.bmp'},'Select an Image File');

% generate absolute path of selected file
complete = strcat(pn,fn);
% show absolute path of selected file into 'edit1'
set(handles.edit1,'String',complete);
Im = imread(complete);
[rows cols] = size(Im);

% modifying image size to fit for showing in form
if(cols>384)
    Im = imresize(Im, 384/cols);
elseif(rows>384)
    Im = imresize(Im, 384/rows);
end
% creating showing area
handles.Axes1 = axes('Units', 'pixels', 'position', [65, 300, 200, 200], 'Visible', 'off');
image(Im, 'Parent', handles.Axes1);
imshow(Im,[]);
% save image information for further processing
data = struct('imageData',Im);   
set(hObject,'UserData',data);
guidata(hObject, handles);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = hObject;
% create a new window for reading images from files with defined extentions
[fn pn] = uigetfile({'*.tif';'*.jpg';'*.bmp'},'Select an Image File');
% get absolute path of selected file
complete = strcat(pn,fn);
% show absolute path of selected file into 'edit2'
set(handles.edit2,'String',complete);
Im = imread(complete);
[rows cols] = size(Im);
if(cols>384)
    Im = imresize(Im, 384/cols);
elseif(rows>384)
    Im = imresize(Im, 384/rows);
end
% create showing area
handles.Axes2 = axes('Units', 'pixels', 'position', [420, 300, 200, 200], 'Visible', 'off');
image(Im, 'Parent', handles.Axes2);
imshow(Im,[]);
% save image information for further processing
data = struct('imageData',Im);   
set(hObject,'UserData',data);
guidata(hObject, handles);


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


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% read standard deviation (sigma) of Gaussian Filter
gaussian_size = str2double(get( handles.edit3, 'String' ));
% read lower threshold
lower_threshold = str2double(get( handles.edit4, 'String' ));
% read higher threshold
higher_threshold = str2double(get( handles.edit5, 'String' ));

% set default values
if(isempty(gaussian_size))
    gaussian_size = 1;
end
if(isempty(higher_threshold))
    higher_threshold = 2.5;
end
if(isempty(lower_threshold))
    lower_threshold = 0.5;
end

h = findobj('Tag','pushbutton1');		
data = get(h,'UserData');
Image1 = data.imageData;
h = findobj('Tag','pushbutton2');
data = get(h,'UserData');
Image2 = data.imageData;
% calculate edges of image1
image1Edges = canny(Image1,lower_threshold,higher_threshold,gaussian_size);
% calculate edges of image2
image2Edges = canny(Image2,lower_threshold,higher_threshold,gaussian_size);
% create a view for showing edges
handles.Axes3 = axes('Units', 'pixels', 'position', [65, 70, 200, 200], 'Visible', 'off');
image(image1Edges, 'Parent', handles.Axes3);
imshow(image1Edges,[]);
% create a view for showing edges
handles.Axes4 = axes('Units', 'pixels', 'position', [420, 70, 200, 200], 'Visible', 'off');
image(image2Edges, 'Parent', handles.Axes4);
imshow(image2Edges,[]);
% calculate Hausdorff Distance
distMeasure = compareCannyEdges(image1Edges, image2Edges);
% namayeshe fasele dar 'text4'
set(handles.text4,'String',num2str(distMeasure));


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



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
