%Tbl = xlsread('zsfkdbfaslvdbfl.xlsx');
Tbl = readtable('Kinga_11-10-2022_15-22-46.csv',delimiter=',');
Tbl=Tbl(:,{'id','x2d_diameter'});
disp(Tbl)
summary(Tbl)
diameter=Tbl.x2d_diameter;

%fill missing value 0 with previous value
idx=find(diameter==0)
diameter(idx)=diameter(idx-2)%-1 or -2

%Find Rows with Missing Values
TF = ismissing(Tbl(:,2),{0 '' '.' 'NA' NaN -99});
rowsWithMissing = Tbl(any(TF,2),:);
disp(rowsWithMissing)    

%Replace the outliers using linear interpolation.
pupil = filloutliers(diameter,"linear");

%Plot the original data and the data with the outliers filled.
plot(diameter)
hold on
plot(pupil,"o-")
legend("Original Data","Filled Data")