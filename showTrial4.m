function [varargout]=showTrial4(window,windowRect,fileName,trialNum)
%variable-length output argument list : vatatgout: it enables the function
%to return any number of output arguments. When the function excutes,
%varargout is a 1-by-N array
KbName('UnifyKeyNames');%allow to use one common naming scheme for all operating systems
%r1Key = KbName('z');
%r2Key = KbName('/?');
sKey = KbName('space');
r1Key = KbName('Q');
r2Key = KbName('W');
r3Key = KbName('E');
r4Key = KbName('R');
r5Key = KbName('T');
%r6Key = KbName('Z');%needed to adapt based on the keyboard 
r6Key = KbName('Y');
r7Key = KbName('U');
r8Key = KbName('I');
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


DrawFormattedText(window,'Please look at the product for 10 seconds.\n\n\n [SCREEEN WILL AUTOMATICALLY CHANGE AFTER 10 SECONDS]','center','center',[255,255,0]);
Screen('Flip',window);
WaitSecs(2);%change here for viewing time


DrawFormattedText(window,['How much do you want this food? \n\n\n If no: how negatively -4.----/-3.---/-2.--/-1.- \n\n\n' ...
    'If yes: how positively 1.+/2.++/3.+++/4.++++'],'center','center',[255,255,0]);
Screen('Flip',window);
KbPressWait(-1)



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
                key = -4;
                break;
            elseif keyCode(r2Key)
                key = -3;
                break;
                 
            elseif keyCode(r3Key)
                key = -2;
                break;
                 
            elseif keyCode(r4Key)
                key = -1;
                break;
                 
            elseif keyCode(r5Key)
                key = 1;
                break;
                 
            elseif keyCode(r6Key)
                key = 2;
                break;
                
            elseif keyCode(r7Key)
                key = 3;
                break;
                 
            elseif keyCode(r8Key)
                key = 4;
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


