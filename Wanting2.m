numitems = 5 % How many food we present? Please edit here
correct=false
CreateStruct.Interpreter = 'tex';
CreateStruct.WindowStyle = 'modal';

s = RandStream('mt19937ar','Seed','shuffle');
RandStream.setGlobalStream(s);

% Participants will press button, whether 'a or l' to distingush object or non_object.

    prompt = {'\fontsize{18}Your name', '\fontsize{18}Your age'};
    title='FoodWanting Task';
    def={'Bob','30'};

    answer=inputdlg(prompt,title,1,def,CreateStruct);
    name=answer{1};
    age=str2num(answer{2}); 

%\n\n\nPRESS \\color{green}LEFT KEY IF YOU WANT THIS FOOD.\n\n\n\\color{black}PRESS \\color{red}RIGHT KEY IF YON DO NOT WANT IT\n\n\n', name, today1);
today1 = date;
msg=sprintf(['\\fontsize{16}Welcome back! \n\n\n' ...
    ' Now it is time for the final part of task 1 (task 1C). \n\n\n' ...
    'Here we would like you to do exactly the same as before; you will be shown some items and then asked to rank them.\n\n\n' ...
    'Your task is to rank how much you WANT the food right now \n\n\n by clicking the number between -4 to 4 \n\n\n ' ...
    'Press space to start each trial, but please raise your hand before you press the space key \n\n\n' ...
    'Now you can signal the experimenter to start the experiment :)']); 
h=msgbox(msg,'Welcome',CreateStruct); 
set(h, 'position', [0 0 1200 1600]); %makes box bigger
uiwait(h)

fileName=sprintf('%s_%d_Wanting',name,today1);

addpath('..')
 

%% Program Preparation
    
KbName('UnifyKeyNames');
sKey = KbName('space');
r1Key = KbName('Q');
r2Key = KbName('W');
r3Key = KbName('E');
r4Key = KbName('R');
r5Key = KbName('T');
r6Key = KbName('Y');
%r6Key = KbName('Z');%needed to adapt based on the keyboard 
r7Key = KbName('U');
r8Key = KbName('I');
r9Key = KbName('9(');
r0Key = KbName('0)');
escKey = KbName('escape');

 try
    isDone = 0;
    warning('off')
    rootDir = pwd;
    cd(rootDir);
    AssertOpenGL; % check for Opengl compatibility, abort

    %% Program Preparation
     
    KbName('UnifyKeyNames');
    sKey = KbName('space');
    r1Key = KbName('1!');
    r2Key = KbName('2@');
    r3Key = KbName('3#');
    r4Key = KbName('4$');
    r5Key = KbName('5%');
    r6Key = KbName('6^');
    r7Key = KbName('7&');
    r8Key = KbName('8*');
    r9Key = KbName('9(');
    r0Key = KbName('0)');
    escKey = KbName('escape');

    % trialQueue & answer information

    PsychDefaultSetup(2);
    HideCursor;

    % Get the screen numbers
    screens = Screen('Screens');
    Screen('Preference','SkipSyncTests',[2]);
    Screen('Preference','VisualdebugLevel',[2]);
    Screen('Preference','SuppressAllWarnings',[2]);



    % Draw to the external screen if avaliable
    ScreenNumber = min(screens);

    white = WhiteIndex(ScreenNumber);
    black = BlackIndex(ScreenNumber);
    background = [16 90 140]/255;%GrayIndex(ScreenNumber);

    [window, windowRect] = PsychImaging('OpenWindow', ScreenNumber, background);
    refresh = Screen('GetFlipInterval', window);

    Screen('TextFont',window,'Courier New');
    Screen('TextSize',window, 50);
    Screen('TextStyle', window, 1+2);


    td = today1;


    %% Experiment Start
    experimentStart = GetSecs;
 
    resp=zeros(numitems,1);
    rt=zeros(numitems,1);
    trialNum=0;


% save initial setup
    save(fileName,'name','td','windowRect','age');

%Rating begins
    for i = 1:numitems
        [resp(i),rt(i)]=showTrial5(window,windowRect,fileName,trialNum);
        trialNum=trialNum+1;
        save(fileName, 'resp','rt','-append');
        DrawFormattedText(window,'Please raise your hand and wait for the signal to \n\n\n press the space key to start the next trial','center','center',[255,255,0]);
        Screen('Flip',window);
        KbPressWait(-1)      
        WaitSecs(0.1);
    end
    DrawFormattedText(window,'You are almost done! Please choose one food item that you want most.','center','center',[255,255,0]);  

    Screen('Flip',window); 

    WaitSecs(5) 
    
    DrawFormattedText(window,['Thank you for completing task 1,\n\n\n you will now be asked to complete a questionnaire, \n\n\n' ...
        'and then you will move on to task 2.'],'center','center',[255,255,0]);  

    Screen('Flip',window); 

    WaitSecs(5) 
    % End of Experiment, Save results

    Screen('CloseAll');
    ShowCursor;


    fclose('all');
    warning('on');
    isDone =1;
 end 
    
