numitems = 5 % How many food we present? Please edit here
correct=false
CreateStruct.Interpreter = 'tex';
CreateStruct.WindowStyle = 'modal';

s = RandStream('mt19937ar','Seed','shuffle');
RandStream.setGlobalStream(s);

% Participants will press button, whether 'a or l' to distingush object or non_object.

    prompt = {'\fontsize{18}Your name', '\fontsize{18}Your age'};
    title='Foodliking Task';
    def={'Bob','30'};

    answer=inputdlg(prompt,title,1,def,CreateStruct);
    name=answer{1};
    age=str2num(answer{2}); 

%\n\n\nPRESS \\color{green}LEFT KEY IF YOU WANT THIS FOOD.\n\n\n\\color{black}PRESS \\color{red}RIGHT KEY IF YON DO NOT WANT IT\n\n\n', name, today1);
today1 = date;
msg=sprintf(['\\fontsize{16}Hello again! Welcome to the final task (task2).\n\n\n You are going to be presented ' ...
    'with some foods to taste \n\n\n  -Each food will be handed to you by the researcher \n\n\n  -Please look at the food for 10 seconds \n\n\n' ...
    '  -Then take the spoon/cup and place the product in your mouth\n\n\n  -Return the spoon/cup, and then swallow the food \n\n\n Please take your time to taste the food \n\n\n after you have tasted the food:\n\n\n 1.Please raise your hand to signal the researcher, then\n\n\n' ...
    '2. Rate how much you like this food by giving a number between 1 and 9.\n\n\n' ...
    'When you have understood the above, please raise your hand to signal to the researcher we are ready to begin, and then press the space bar.']);
h=msgbox(msg,'Welcome',CreateStruct); 
set(h, 'position', [0 0 1200 1600]); %makes box bigger
uiwait(h)

fileName=sprintf('%s_%d_FoodLiking',name,today1);

addpath('..')
 

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
    Screen('TextSize',window, 50);
    Screen('TextStyle', window, 1+2);


    td = today1;


    %% Experiment Start
    experimentStart = GetSecs;
 
    resp=zeros(numitems,1);
    rt=zeros(numitems,1);
    trialNum=0;
    %DrawFormattedText(window,'Please give your rating between 0-9 by pressing the corresponding key.','center','center');
    %KbPressWait(-1);
    %Screen('Flip',window);

% save initial setup
    save(fileName,'name','td','windowRect','age');

%Rating begins
    for i = 1:numitems
        [resp(i),rt(i)]=showTrial3(window,windowRect,fileName,trialNum);
        trialNum=trialNum+1;
        save(fileName, 'resp','rt','-append');
        
        %DrawFormattedText(window,'Please taste the food when the spoon is returned to the researcher. Raise your hand when you finish','center','center');
        %Screen('Flip',window);
        %KbPressWait(-1)      
        %WaitSecs(0.1);
    end
    DrawFormattedText(window,'Your session is now complete!\n\n\n Thank you very much for your participation:) \n\n\n If you have any questions for the researchers, please feel free to ask.','center','center',[255,255,0]);  

    Screen('Flip',window); 

    WaitSecs(5) 
    
    % End of Experiment, Save results

    Screen('CloseAll');
    ShowCursor;


    fclose('all');
    warning('on');
    isDone =1;
 end 
    
