function [varargout]=showTrial3(window,windowRect,fileName,trialNum)
%variable-length output argument list : vatatgout: it enables the function
%to return any number of output arguments. When the function excutes,
%varargout is a 1-by-N array
KbName('UnifyKeyNames');%allow to use one common naming scheme for all operating systems
%r1Key = KbName('z');
%r2Key = KbName('/?');
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

if nargout==2
    getKey=true;
    key=NaN;
    rt=NaN;
else
    getKey=false;
end

background=[16 82 140]/255;


DrawFormattedText(window,'Please look at the food for 10 seconds.','center','center');
Screen('Flip',window);
WaitSecs(3);


DrawFormattedText(window,'Please give your rating between 1-9 by pressing the corresponding key','center','center');
Screen('Flip',window);
KbPressWait(-1)

%mx = windowRect(3)/2;
%my = windowRect(4)/2;

%DrawFormattedText(window,'Please look at the red cross for 5 seconds and be relaxed.','center','center');
%Screen('Flip',window);
%WaitSecs(2);
%show fixation cross in the middle
%Screen('DrawLine', window,[1 0 0], mx-25, my,mx+25, my,10);%horizontal line
%Screen('DrawLine', window,[1 0 0], mx, my-25,mx, my+25,10);%vertical
%Screen('Flip',window);
%WaitSecs(3);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ANSWER SCREEN

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
                 
            elseif keyCode(sKey)
                 
                break;
            elseif keyCode(escKey)
                Screen('CloseAll'); ShowCursor;
                disp('ESC is pressed to abort the program.');
            end

        end
    end
    % wait a bit so as not to overload the computer
    WaitSecs(0.1);
end


if (nargout==2)
    varargout{1}=key;
    varargout{2}=rt;
end


