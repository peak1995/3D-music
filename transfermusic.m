function varargout = transfermusic(varargin)
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @transfermusic_OpeningFcn, ...
                       'gui_OutputFcn',  @transfermusic_OutputFcn, ...
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
end
function transfermusic_OpeningFcn(hObject, eventdata, handles, varargin)
    handles.output = hObject;
    guidata(hObject, handles);
    %global dist elev flag circle step fs y a;
end

function varargout = transfermusic_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;
end
function [pathname] = uigetdir2(start_path, dialog_title)
    % Pick multiple directories and/or files

    import javax.swing.JFileChooser;

    if nargin == 0 || start_path == '' || start_path == 0 % Allow a null argument.
        start_path = pwd;
    end
    jchooser = javaObjectEDT('javax.swing.JFileChooser', start_path);

    jchooser.setFileSelectionMode(JFileChooser.FILES_AND_DIRECTORIES);
    if nargin > 1
        jchooser.setDialogTitle(dialog_title);
    end
    jchooser.setMultiSelectionEnabled(true);
    status = jchooser.showOpenDialog([]);
    if status == JFileChooser.APPROVE_OPTION
        jFile = jchooser.getSelectedFiles();
        pathname{size(jFile, 1)}=[];
        for i=1:size(jFile, 1)
            pathname{i} = char(jFile(i).getAbsolutePath);
        end

    elseif status == JFileChooser.CANCEL_OPTION
        pathname = [];
    else
        error('Error occured while picking file.');
    end
end
% --- Executes on button press in bt1.
function bt1_Callback(hObject, eventdata, handles)
    global a;
    a=uigetdir2();
    %disp(a)
    set(handles.text1,'String',a); 
end

% --- Executes on button press in bt2.
function bt2_Callback(hObject, eventdata, handles)
    global a data2 fs;
    [data fs]=audioread(a{1});
% 取单通道
    data2=data(:,1);
    sound(data,fs);
%     audiowrite('muc.wav',data2,fs);
%     sound(data,fs)
end

function bt3_Callback(hObject, eventdata, handles)
    global a data2 fs; 
    global dist elev flag circle step y;
    [data fs]=audioread(a{1});
% 取单通道
    data2=data(:,1);
%     sound(data2,fs);
    el=get(handles.menu1,'value');
    switch el
        case 1
            elev=0;
        case 2
            elev=0;
        case 3
            elev=10;
        case 4
            elev=20;
        case 5
            elev=30;
        case 6
            elev=40;
        case 7
            elev=50;
        case 8
            elev=60;
        case 9
            elev=70;
        case 10
            elev=80;
        case 11
            elev=90;
        case 12
            elev=-10;
        case 13
            elev=-20;
        case 14
            elev=-30;
        case 15
            elev=-40;      
    end
%     disp(elev);
    direction=get(handles.menu2,'value');
    switch direction
        case 1
            flag=1;
        case 2
            flag=0;
    end
%     disp(flag);

di=get(handles.menu3,'value');
    switch di
        case 1
            dist=20;
        case 2
            dist=20;
        case 3
            dist=30;
        case 4
            dist=40;
        case 5
            dist=50;
        case 6
            dist=75;
        case 7
            dist=100;
        case 8
            dist=130;
        case 9
            dist=160; 
    end
     disp(dist);


    cl=get(handles.edit2,'String');
    circle=str2num(cl);
    %     frames=20;
    fra=get(handles.edit1,'String');
    step=str2num(fra);
    y=data2;
    dymusic(dist,elev,flag,circle,step,fs,y)
%     disp(cicle)
    %dynamic_music(0,360,dist0,dist1,elev,flag,frames)
end
% --- Executes on selection change in menu2.
function menu2_Callback(hObject, eventdata, handles)  
end
% --- Executes during object creation, after setting all properties.
function menu2_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end

% --- Executes on selection change in menu1.
function menu1_Callback(hObject, eventdata, handles)

end

% --- Executes during object creation, after setting all properties.
function menu1_CreateFcn(hObject, eventdata, handles)

    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end


function edit1_Callback(hObject, eventdata, handles)
end

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)

    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end


function edit2_Callback(hObject, eventdata, handles)
end
% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end

function menu3_CreateFcn(hObject, eventdata, handles)

    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end
% --- Executes on selection change in menu1.
function menu3_Callback(hObject, eventdata, handles)

end
