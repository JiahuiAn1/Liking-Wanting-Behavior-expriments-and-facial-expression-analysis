function [varargout]=showTrial1(im,window,windowRect,et,showTime,fileName,trialNum,showFixtime, keyDir,my_eyetracker)
%variable-length output argument list : vatatgout: it enables the function
%to return any number of output arguments. When the function excutes,
%varargout is a 1-by-N array

KbName('UnifyKeyNames');%allow to use one common naming scheme for all operating systems
%r1Key = KbName('z');
%r2Key = KbName('/?');
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

if nargout==2
    getKey=true;
    key=NaN;
    rt=NaN;
else
    getKey=false;
end

background=[16 82 140]/255;

myimg=im;


% making the texture for PTB - this is the sharp image, so that goes into
% the clear window, PTB?? texture.jpg ?????? ????.
clwtex = Screen('MakeTexture', window, myimg);
% we also measure how large this is
tRect=Screen('Rect', clwtex);
% we now measure where to put the fovea with ect to the whole window
[ctRect, dx, dy]=CenterRect(tRect, windowRect);

%Screen('Flip',window);

% this initializes the arrays for collecting the eyetracking data
leftEyeAll = [];
rightEyeAll = [];
timeStampAll = [];
leftEyeAllFix = [];
rightEyeAllFix = [];
timeStampAllFix = [];

% define mx, my, mxold, myold in case tracker does not work
% initialize with middle of the screen (that should be at position of fixation cross)

mx = windowRect(3)/2;
mxold = mx;
my = windowRect(4)/2;
myold = my;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%show fixation cross in the middle
%Screen('DrawLine', window,[1 0 0], mx-25, my,mx+25, my,10);%horizontal line
%Screen('DrawLine', window,[1 0 0], mx, my-25,mx, my+25,10);%vertical

%Screen('Flip',window);

% draw images at the center

ScreenSize=get(0,'ScreenSize')
ScreenWidth=ScreenSize(3)
ScreenHeight=ScreenSize(4)
pos=[mx-500 my-400 mx+500 my+400]

Screen('DrawTexture', window, clwtex,[], pos, 0);


% start the trial
startTime=GetSecs;
% this will run forever or until the user presses a key or mouse button
if(et)
    while (GetSecs-startTime)<showFixtime
        if (et)
            %[LeftEye, RightEye, DeviceTimeStamp, trigSignal] = my_eyetracker.get_gaze_data();
            gazeResult=my_eyetracker.get_gaze_data('flat');
            if (~isempty(gazeResult))
                %gazeData = my_eyetracker.get_gaze_data('flat');
                %leftEyeAllFix = vertcat(leftEyeAllFix, LeftEye(:, :));
                leftEyeAllFix = vertcat(leftEyeAllFix,gazeResult.left_gaze_point_on_display_area(:, :));
                %rightEyeAll = vertcat(rightEyeAllFix, RightEye(:, :));
                rightEyeAllFix = vertcat(rightEyeAllFix,gazeResult.right_gaze_point_on_display_area(:, :));
                %timeStampAllFix = vertcat(timeStampAllFix, DeviceTimeStamp(:, :));
                timeStampAllFix = vertcat(timeStampAllFix, gazeResult.device_time_stamp(:, :));
            end
        end
    end
end
%Screen('Flip',window);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% start the trial
startTime=GetSecs;
% this will run forever or until the user presses a key or mouse button
if(et)
    while (GetSecs-startTime)<showTime
        if (~et)
            % obviously, the mx,my coordinates will need to come from the
            % eye-tracker in the future
            [mx, my, buttons]=GetMouse(window);
            leftEyeAll = vertcat(leftEyeAll, mx);
            rightEyeAll = vertcat(rightEyeAll, my);
            timeStampAll = vertcat(timeStampAll, GetSecs);
        else
            gazeResult=my_eyetracker.get_gaze_data('flat');
            %[LeftEye, RightEye, DeviceTimeStamp, trigSignal] = my_eyetracker.get_gaze_data();
            if (~isempty(gazeResult))
                %leftEyeAll = vertcat(leftEyeAll, LeftEye(:, :));
                %rightEyeAll = vertcat(rightEyeAll, RightEye(:, :));
                %timeStampAll = vertcat(timeStampAll, DeviceTimeStamp(:, :));
                timeStampAll = vertcat(timeStampAll,gazeResult.device_time_stamp(:, :));
                leftEyeAll = vertcat(leftEyeAll, gazeResult.left_gaze_point_on_display_area(:, :));
                rightEyeAll = vertcat(rightEyeAll,gazeResult.right_gaze_point_on_display_area(:, :));

                mxold = mx;
                myold = my;
                mx = gazeResult.left_gaze_point_on_display_area*windowRect(3);%what is it??
                my = gazeResult.right_gaze_point_on_display_area*windowRect(4);
            else
                mx = mxold;
                my = myold;
            end
            buttons=0;
        end
    end

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ANSWER SCREEN
%if (keyDir==1)
%    DrawFormattedText(window,'Do you want this food?\n\n\n\nGreen(LEFT) = Yes                    Red(RIGHT) = No','center', 'center');
%else
%    DrawFormattedText(window,'Do you want this food?\n\n\n\nGreen(LEFT) = No                Red(RIGHT) = Yes','center', 'center');
%end
%Screen('Flip',window);
%KbPressWait(-1);
% start the trial
startTime=GetSecs;
keyIsDown = false;
% this will run forever or until the user presses a key or mouse button
while ~keyIsDown
    % Abort the for-loop on keypress our mouse-click:
    if (getKey)
        [keyIsDown,~,keyCode] = KbCheck;
        if keyIsDown
            rt = GetSecs-startTime;
            if keyCode(r1Key)
                key = 1;
                break;
            elseif keyCode(r2Key)
                key = 2;
                break;
                 
            elseif keyCode(r3Key)
                key = 3;
                break;
                 
            elseif keyCode(r4Key)
                key = 4;
                break;
                 
            elseif keyCode(r5Key)
                key = 5;
                break;
                 
            elseif keyCode(r6Key)
                key = 6;
                break;
                
            elseif keyCode(r7Key)
                key = 7;
                break;
                 
            elseif keyCode(r8Key)
                key = 8;
                break;
                 
            elseif keyCode(r9Key)
                key = 9;
                break;
                 
            elseif keyCode(r0Key)
                key = 0;
                break;
            elseif keyCode(escKey),
                Screen('CloseAll'); ShowCursor;
                disp('ESC is pressed to abort the program.');
            end

        end
    end
    % wait a bit so as not to overload the computer
    WaitSecs(0.1);
end

if (et)
    eval(sprintf('dataLeft%04d=leftEyeAll;',trialNum));
    eval(sprintf('dataRight%04d=rightEyeAll;',trialNum));
    eval(sprintf('dataTime%04d=timeStampAll;',trialNum));
    eval(sprintf('dataLeftFix%04d=leftEyeAllFix;',trialNum));
    eval(sprintf('dataRightFix%04d=rightEyeAllFix;',trialNum));
    eval(sprintf('dataTimeFix%04d=timeStampAllFix;',trialNum));
    eval(sprintf('x1%04d=x1;',trialNum));
    eval(sprintf('x2%04d=x2;',trialNum));
    eval(sprintf('y1%04d=y1;',trialNum));
    eval(sprintf('y2%04d=y2;',trialNum));
    save(fileName,...
        sprintf('dataLeft%04d',trialNum),...
        sprintf('dataRight%04d',trialNum),...
        sprintf('dataTime%04d',trialNum),...
        sprintf('x1%04d',trialNum),...
        sprintf('x2%04d',trialNum),...
        sprintf('y1%04d',trialNum),...
        sprintf('y2%04d',trialNum),...
        sprintf('dataLeftFix%04d',trialNum),...
        sprintf('dataRightFix%04d',trialNum),...
        sprintf('dataTimeFix%04d',trialNum),'-append');
    %sprintf('offH%04d',trialNum),...
    %sprintf('offV%04d',trialNum),...
end
if (nargout==2)
    varargout{1}=key;
    varargout{2}=rt;
end


