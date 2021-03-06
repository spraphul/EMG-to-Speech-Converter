function varargout = SpeechRecognizer(varargin)
% SPEECHRECOGNIZER MATLAB code for SpeechRecognizer.fig
%      SPEECHRECOGNIZER, by itself, creates a new SPEECHRECOGNIZER or raises the existing
%      singleton*.
%
%      H = SPEECHRECOGNIZER returns the handle to a new SPEECHRECOGNIZER or the handle to
%      the existing singleton*.
%
%      SPEECHRECOGNIZER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SPEECHRECOGNIZER.M with the given input arguments.
%
%      SPEECHRECOGNIZER('Property','Value',...) creates a new SPEECHRECOGNIZER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SpeechRecognizer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SpeechRecognizer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SpeechRecognizer

% Last Modified by GUIDE v2.5 03-Jul-2017 13:21:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SpeechRecognizer_OpeningFcn, ...
                   'gui_OutputFcn',  @SpeechRecognizer_OutputFcn, ...
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


% --- Executes just before SpeechRecognizer is made visible.
function SpeechRecognizer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SpeechRecognizer (see VARARGIN)
% Choose default command line output for SpeechRecognizer
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SpeechRecognizer wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SpeechRecognizer_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in click.
function click_Callback(hObject, eventdata, handles)
% hObject    handle to click (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% Initialization
 clc;


tts('Speak Now');
%% Setup the parameters you will use for this part of the exercise
input_layer_size  = 32;  
num_labels = 8;          

%% =========== Part 1: Loading and Visualizing Data =============

load('matlab.mat'); % training data stored in arrays x, y

m = size(x, 1);
sel=randperm(m);
sel1=sel(1:m-100);

xtrain=x(sel1,:);
ytrain=y(sel1,:);




%% ================ setting x_train & y_train ================
sel2=sel(m-100+1:end);
xtest=x(sel2,:);
ytest=y(sel2,:);

x_feed=xtest(1,:);
y_feed=ytest(1,:);


%% ================ Part 3: Predict for One-Vs-All ================
load('trained_parameters.mat');
all_theta=all_theta;

pred = predictOneVsAll(all_theta, xtest);
%fprintf('\nTest Set Accuracy: %f\n', mean(double(pred == ytest)) * 100);
acc=num2str(mean(double(pred == ytest)) * 100);
acc=strcat(acc,' %');
set(handles.accuracy,'string',acc);


% spoken word
pred = predictOneVsAll(all_theta, x_feed);
if(pred==y_feed)
set(handles.status,'string','Correct Prediction');
else
set(handles.status,'string','Wrong Prediction');
end

axes(handles.axes1);
if(y_feed==1)
plot(x(1,:));
end
if(y_feed==2)
plot(x(101,:));
end
if(y_feed==3)
plot(x(201,:));
end
if(y_feed==4)
plot(x(301,:));
end
if(y_feed==5)
plot(x(401,:));
end
if(y_feed==6)
plot(x(501,:));
end
if(y_feed==7)
plot(x(601,:));
end
if(y_feed==8)
plot(x(701,:));
end


axes(handles.axes2);
if(pred==1)
plot(x(2,:));
end
if(pred==2)
plot(x(102,:));
end
if(pred==3)
plot(x(202,:));
end
if(pred==4)
plot(x(302,:));
end
if(pred==5)
plot(x(402,:));
end
if(pred==6)
plot(x(502,:));
end
if(pred==7)
plot(x(602,:));
end
if(pred==8)
plot(x(702,:));
end


if(pred==1)
set(handles.word,'string','UP');
tts('UP');
end
if(pred==2)
set(handles.word,'string','DOWN');
tts('DOWN');
end
if(pred==3)
set(handles.word,'string','LEFT');
tts('LEFT');
end
if(pred==4)
set(handles.word,'string','RIGHT');
tts('RIGHT');
end
if(pred==5)
set(handles.word,'string','GO');
tts('GO');
end
if(pred==6)
set(handles.word,'string','CROSS');
tts('CROSS');
end
if(pred==7)
set(handles.word,'string','STRAIGHT');
tts('STRAIGHT');
end
if(pred==8)
set(handles.word,'string','COME');
tts('COME');
end

guidata(hObject,handles);


function accuracy_Callback(hObject, eventdata, handles)
% hObject    handle to accuracy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of accuracy as text
%        str2double(get(hObject,'String')) returns contents of accuracy as a double


% --- Executes during object creation, after setting all properties.
function accuracy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to accuracy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
