function varargout = gui(varargin)
% GUI M-file for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 14-Feb-2012 15:11:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;
bg = imread('background2.jpg');
axes(handles.axes1);
imshow(bg);
a = ones(256,256);
axes(handles.axes2);
imshow(a);
axes(handles.axes3);
imshow(a);
axes(handles.axes4);
imshow(a);
axes(handles.axes5);
imshow(a);
axes(handles.axes6);
imshow(a);
axes(handles.axes7);
imshow(a);
axes(handles.axes8);
imshow(a);
axes(handles.axes9);
imshow(a);
axes(handles.axes10);
imshow(a);
axes(handles.axes11);
imshow(a);
axes(handles.axes12);
imshow(a);
axes(handles.axes13);
imshow(a);
% axes(handles.axes14);
% imshow(a);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in database_load.
function database_load_Callback(hObject, eventdata, handles)
% hObject    handle to database_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data;
msgbox('Database Loaded Completed Successfully');

% --- Executes on button press in Input_im.
function Input_im_Callback(hObject, eventdata, handles)
% hObject    handle to Input_im (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file,path] = uigetfile('*.jpg','Pick an Image File');
if isequal(file,0) || isequal(path,0)
    warndlg('User Pressed Cancel');
else
    a = imread(file);
    axes(handles.axes12);
    imshow(a);
    title('Input Image');
    handles.a = a;
end
% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in clear_im.
function clear_im_Callback(hObject, eventdata, handles)
% hObject    handle to clear_im (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a = ones(256,256);
axes(handles.axes2);
imshow(a);
axes(handles.axes3);
imshow(a);
axes(handles.axes4);
imshow(a);
axes(handles.axes5);
imshow(a);
axes(handles.axes6);
imshow(a);
axes(handles.axes7);
imshow(a);
axes(handles.axes8);
imshow(a);
axes(handles.axes9);
imshow(a);
axes(handles.axes10);
imshow(a);
axes(handles.axes11);
imshow(a);
axes(handles.axes12);
imshow(a);
axes(handles.axes13);
imshow(a);
% axes(handles.axes14);
% imshow(a);

% --- Executes on button press in search_image.
function search_image_Callback(hObject, eventdata, handles)
% hObject    handle to search_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
LL1 = handles.LL1;
LL2 = handles.LL2;
LL3 = handles.LL3;

fid = fopen('database.txt');
resultValues_Gc = [];      % Results matrix...
resultNames_Gc = {};
i = 1;                  % Indices...
j = 1;

while 1
    imagename = fgetl(fid);
    if ~ischar(imagename), break, end       % Meaning: End of File...
    

     database_image = imread(imagename);
     database_image = imresize(database_image,[256 256]);
     YUV_DB = rgb2ycbcr(database_image);
    y = YUV_DB(:,:,1);
    u = YUV_DB(:,:,2);
    v = YUV_DB(:,:,3);
    s1 = get(handles.popupmenu1,'value');
        switch s1
            case 1

            [ll1 lh1 hl1 hh1] = dwt2(y,'haar');
            [ll2 lh2 hl2 hh2] = dwt2(u,'haar');
            [ll3 lh3 hl3 hh3] = dwt2(v,'haar');           

            case 2
            [ll1 lh1 hl1 hh1] = forward_lift(y,2);
            [ll2 lh2 hl2 hh2] = forward_lift(u,2);
            [ll3 lh3 hl3 hh3] = forward_lift(v,2);
        end

     [r c]=size(LL1);
     for m=1:r
         for n=1:c

     Dist1(m,n) = abs((LL1(m,n)-ll1(m,n))+(LL2(m,n)-ll2(m,n))+(LL3(m,n)-ll3(m,n)));
     
         end
     end

      
%  Dist1 = abs((sum(sum(LL1))-sum(sum(ll1)))+(sum(sum(LL2))-sum(sum(ll2)))+(sum(sum(LL3))-sum(sum(ll3))));


    resultValues_Gc(i) = sum(sum(Dist1));
    
    resultNames_Gc(j) = {imagename};
    i = i + 1;
    j = j + 1;
end
fclose(fid);

%%%%%%%%%%%%%%%% Sort the Results in Ascending order..............
[sortedValues1, index1] = sort(resultValues_Gc);     

name = resultNames_Gc;


for i = 1:10
            a = imread(cell2mat(name(index1(i))));
            
            
            
            if i==1
            axes(handles.axes2);
            imshow(a);
            
            
            end
            if i==2
            axes(handles.axes3);
            imshow(a);
            
            end
            if i==3
            axes(handles.axes4);
            imshow(a);
            
            
            end
            if i==4
            axes(handles.axes5);
            imshow(a);
            
            
            end
            if i==5
            axes(handles.axes6);
            imshow(a);
            
           
            end
            if i==6
            axes(handles.axes7);
            imshow(a);
            
           
            end
            if i==7
            axes(handles.axes8);
            imshow(a);
            
            
            end
            if i==8
            axes(handles.axes9);
            imshow(a);
            
            
            end
            if i==9
            axes(handles.axes10);
            imshow(a);
           
            
            end
            if i==10
            axes(handles.axes11);
            imshow(a);
            
            
            end
end     

% --- Executes on button press in quary_feature.
function quary_feature_Callback(hObject, eventdata, handles)
% hObject    handle to quary_feature (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
inp_im = handles.a ;
inp_im = imresize(inp_im,[256 256]);
YUV = rgb2ycbcr(inp_im);
axes(handles.axes13);
imshow(YUV);
title('YUV image');

s1 = get(handles.popupmenu1,'value');

Y = YUV(:,:,1);
U = YUV(:,:,2);
V = YUV(:,:,3);


% % % % Apply wavelet transform for each level
switch s1
    case 1
        
    [LL1 LH1 HL1 HH1] = dwt2(Y,'haar');
    [LL2 LH2 HL2 HH2] = dwt2(U,'haar');
    [LL3 LH3 HL3 HH3] = dwt2(V,'haar');
    

    case 2
    [LL1 LH1 HL1 HH1] = forward_lift(Y,2);
    [LL2 LH2 HL2 HH2] = forward_lift(U,2);
    [LL3 LH3 HL3 HH3] = forward_lift(V,2);
end

dec1 = [LL1 LH1;HL1 HH1];
dec2 = [LL2 LH2;HL2 HH2];
dec3 = [LL3 LH3;HL3 HH3];

figure,imshow(dec1,[]);
title('Wavelet Transform for Y Component');
figure,imshow(dec2,[]);
title('Wavelet Transform for U Component');
figure,imshow(dec3,[]);
title('Wavelet Transform for V Component');

handles.LL1=LL1;
handles.LL2=LL2;
handles.LL3=LL3;

% Update handles structure
guidata(hObject, handles);
helpdlg('Process Completed');

% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
