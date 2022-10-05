numitems = 4 % How many food we present? Please edit here
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
msg=sprintf(['\\fontsize{16}Hello! Thank you for volunteering to participate in this study.' ... 
'During the study, all of the instructions will be presented on this screen. A researcher will also be ' ... 
'here to present you with various items. We ask that you remain seated throughout the study and keep' ... 
'facing this screen. Please keep your questions for the end of the study, our research team will be ' ... 
'happy to answer everything then! \n\n\n\\color{red}Task 1A. \n\n\n You are going to be presented with various items, your task is to rank how much you WANT the food right now by giving' ... 
'the number between -4 to 4. Press space to start each trial.']); 
h=msgbox(msg,'Welcome',CreateStruct); 
uiwait(h)

fileName=sprintf('%s_%d_FoodWanting',name,today1);

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

    Screen('TextFont',window, 'Courier New');
    Screen('TextSize',window, 20);
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
        [resp(i),rt(i)]=showTrial4(window,windowRect,fileName,trialNum);
        trialNum=trialNum+1;
        save(fileName, 'resp','rt','-append');
        DrawFormattedText(window,'Please press the space key to start next trial','center','center');
        Screen('Flip',window);
        KbPressWait(-1)      
        WaitSecs(0.1);
    end
   
    DrawFormattedText(window,'Please now avert your attention to the researcher for task 1B.','center','center');  

    Screen('Flip',window); 

    WaitSecs(5) 
    % End of Experiment, Save results

    Screen('CloseAll');
    ShowCursor;


    fclose('all');
    warning('on');
    isDone =1;
 end 
    
