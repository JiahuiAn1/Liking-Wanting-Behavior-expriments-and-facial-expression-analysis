correct = false;

eyetracker = false;
CreateStruct.Interpreter = 'tex';
CreateStruct.WindowStyle = 'modal';

s = RandStream('mt19937ar','Seed','shuffle');
RandStream.setGlobalStream(s);

% Participants will press button, whether 'a or l' to distingush object or non_object.
while ~correct
    prompt = {'\fontsize{18}Your name', '\fontsize{18}Your age', '\fontsize{18}Vegetarian: yes or no'};
    title='Food preference test';
    def={'Bob','30','no'};

    answer=inputdlg(prompt,title,1,def,CreateStruct);
    name=answer{1};
    age=str2num(answer{2});
    vegetarian=answer{3};
    if (strcmp(vegetarian,'no') || strcmp(vegetarian,'yes'))
        correct=true;
        if strcmp(vegetarian,'no')
            Veggi_only_image_Code=0;
        else
            Veggi_only_image_Code=1;
        end
    end
end

%\n\n\nPRESS \\color{green}LEFT KEY IF YOU WANT THIS FOOD.\n\n\n\\color{black}PRESS \\color{red}RIGHT KEY IF YON DO NOT WANT IT\n\n\n', name, today1);
today1 = date;
keyDir=1
msg=sprintf('\\color{green}\\fontsize{20}Hello, %s! Thank you for participating. Today is %s\n\n\n\nYour task is to look at the food picture, and then rate how much you want this food by giving a number between 0 and 9.',name,today1);
h=msgbox(msg,'Welcome',CreateStruct);
uiwait(h)

fileName=sprintf('%s_%d_FoodPrefTask',name,today1);

addpath('..')
if (eyetracker)

    if ~exist('Tobii', 'var'),
    	[Tobii, my_eyetracker, calParams] = TobiiInitialize;
    end

    %Step 1 : Find the eye tracker!
    tobii = EyeTrackingOperations(); % creating an instance of the EyeTrackingOperations class:

    %This function will look for both eye trackers connected directly to your computer via usb or ethernet cable,
    %as well as eye trackers connected to the same network as your computer. To search for eye trackers simply
    %call find_all_eyetrackers() and assign the output to a new variable:
    found_eyetrackers = tobii.find_all_eyetrackers()

    %The return value of find_all_eyetrackers() is an array of EyeTracker objects.
    %You can access the meta data of the (first) eye tracker, and print it, like this:
    my_eyetracker = found_eyetrackers(1)
    disp(["Address: ", my_eyetracker.Address])
    disp(["Model: ", my_eyetracker.Model])
    disp(["Name (It's OK if this is empty): ", my_eyetracker.Name])
    disp(["Serial number: ", my_eyetracker.SerialNumber])
    %Step 2 : Calibrate the eye tracker
    %Eye Tracker Manager
    % calibrate -- USE TOBII BUILT-IN
    % [calibApplyResult, calParams] = TobiiCalibrate(eyetracker, calParams, winPtr);
    %%%%%fprintf('Run Eye Tracker Manager calibration now!\n'); KbWait;


    status = TobiiSaveCalib(my_eyetracker, [fileName '_calib.mat']);
    if status == -1,
    	warning('Failed to save Tobii calibration data');
    end

    gazeResult=[];

    % poll eye tracker every XX msec until a new gaze sample is available (can timeout!)
    pollTimeSec = 0.050;	% 50 msec
    pollTimeoutSec = 5.0;	% stop waiting for data :(
    t0 = GetSecs + pollTimeoutSec;	% timer
    while isempty(gazeResult) && GetSecs < t0,
    	WaitSecs(pollTimeSec);
    	gazeResult = my_eyetracker.get_gaze_data();
    	fprintf('.');
    end
    fprintf('\n');

    %tell the Pro SDK that yo8u want to start collecting gaze data, using the method from the eye tracker object previously created.
    % if the gaze sample is an error, report details and skip stimulus display phase
    if isa(gazeResult, 'StreamError'),
    	fprintf('Error: %s\n', char(gazeResult.Error));
    	fprintf('Source: %s\n', char(gazeResult.Source));
    	fprintf('SystemTimeStamp: %d\n', gazeResult.SystemTimeStamp);
    	fprintf('Message: %s\n', gazeResult.Message);
    end
end
%This will start to collect gaze data in the background, so if you want to collect data for a second simply use:

%The gaze_data variable will be an array of objects of the GazeData class. We can access the latest data point collected:
%latest_gaze_data = gazeResult(end);

try
    isDone = 0;
    warning('off')
    rootDir = pwd;
    cd(rootDir);
    AssertOpenGL; % check for Opengl compatibility, abort

    %% Program Preparation
    fmt = 'jpg'; % Use JPEG image type.
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

    % Fixation Cross duration in seconds
    showFixtime = 1;


    % Practice Pic (Learn)
    cd('training');
    d = dir('*.jpg');
    [numitemsLearn ~] = size(d);
    [itemlist{1:numitemsLearn}] = deal(d.name);
    PRACTICEList=itemlist';
    for theitem = 1:numitemsLearn
        filename = itemlist{theitem};
        [imgArray] = imread(filename);
        PracticePic{theitem} = imgArray;
    end
    PracticePicList = randperm(numitemsLearn);
    cd('..')

    % Target Faces
    cd('test');
    d = dir('*.jpg');
    [numitems ~] = size(d);
    [itemlist{1:numitems}] = deal(d.name);
    LEARNList=itemlist';
    for theitem = 1:numitems
        filename = itemlist{theitem};
        [imgArray] = imread(filename);
        Learn{theitem} = imgArray;
    end
    LearnList = randperm(numitems);
    cd('..')



    % save initial setup
    save(fileName,'name','td','windowRect','age','vegetarian','PracticePicList','LearnList','keyDir');

    %% Experiment Start
    experimentStart = GetSecs;

    respLearn=zeros(numitemsLearn,1);
    rtLearn=zeros(numitemsLearn,1);


    resp=zeros(numitems,1);
    rt=zeros(numitems,1);
    trialNum=0;

    DrawFormattedText(window,'Press SPACE to begin the task.','center','center');
    Screen('Flip',window);
    KbPressWait(-1);
    Screen('Flip',window);
    %practice trial
    for i  = 1:10
       
        [respLearn(i),rtLearn(i)]=showTrial1(PracticePic{PracticePicList(i)}, window, windowRect, eyetracker, 5, fileName, trialNum, showFixtime, keyDir, 0);
        trialNum=trialNum+1;
        save(fileName, 'respLearn','rtLearn','-append');
        Screen('Flip',window);
        WaitSecs(0.1);
    end

    DrawFormattedText(window,'Training done. \n\nPress SPACE to continue with MAIN TEST.','center','center');
  
    KbPressWait(-1);
    Screen('Flip',window);

    for i  = 1:numitems
        
        [resp(i),rt(i)]=showTrial1(Learn{LearnList(i)}, window, windowRect, eyetracker, 5, fileName, trialNum, showFixtime, keyDir, 0);
        trialNum=trialNum+1;
        save(fileName, 'resp','rt','-append');
        Screen('Flip',window);
        WaitSecs(0.1);
    end

    experimentEnd=GetSecs;
    save(fileName,'experimentStart','experimentEnd','-append');
    % End of Experiment, Save results

    Screen('CloseAll');
    ShowCursor;


    fclose('all');
    warning('on');
    isDone =1;

catch
    sca
    ShowCursor;
    % 	tobii.delete();
    psychrethrow(psychlasterror);

end

 
