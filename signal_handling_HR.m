%Tbl = xlsread('zsfkdbfaslvdbfl.xlsx');
Tbl = readtable('Jiahui_An_2022-10-17_14-30-15.CSV',delimiter=',');
Tbl=Tbl(:,{'Time','HR_bpm_'});
disp(Tbl)
summary(Tbl)
hr=Tbl.HR_bpm_;
duration=length(hr);
%fill missing value 0 with previous value
%idx=find(hr==0)
%diameter(idx)=diameter(idx-2)%-1 or -2

%Find Rows with Missing Values
TF = ismissing(Tbl(:,2),{0 '' '.' 'NA' NaN -99});
rowsWithMissing = Tbl(any(TF,2),:);
disp(rowsWithMissing)  
%we found here is the first rows with NAN, so next we will exclude these
%two rows

%DROP rows with NA
Tbl=Tbl(3:length(hr),:);

%Replace the outliers using linear interpolation.
HR = filloutliers(hr,"linear");

%Plot the original data and the data with the outliers filled.
plot(hr)
hold on
plot(HR,"o-")
legend("Original Data","Filled Data")