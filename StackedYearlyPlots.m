clearvars
close all

%% Parameters defined by user
filePrefix = 'ALEUT'; % File name to match. 
siteabrev = 'BD'; %abbreviation of site.
SiteName_forPlots = 'Buldir Island - Aleutian Chain';
sp = 'Pm'; % your species code
itnum = '2'; % which iteration you are looking for
srate = 200; % sample rate
tpwsPath = 'E:\Project_Sites\BD\TPWS_125'; %directory of TPWS files
effortXls = 'E:\Project_Sites\BD\Pm_Effort_BD.xlsx'; % specify excel file with effort times
saveDir = 'E:\Project_Sites\BD\Seasonality'; %specify directory to save and load files
%% load workspace
load([saveDir,'\',siteabrev,'_workspace125.mat']);
%% group data by 5min bins, days, weeks, and seasons
%group data by 5 minute bins
binTable = synchronize(binData,binEffort);
binTable.Properties.VariableNames{'bin'} = 'Effort_Bin';
binTable.Properties.VariableNames{'sec'} = 'Effort_Sec';
binTable.maxPP = [];
binidx1 = (binTable.Count >= 1);
[y,~]=size(binTable);
binTable.PreAbs = zeros(y,1);
binTable.PreAbs(binidx1) = 1; %table with 0 for no presence in 5min bin and 1 with presence in 5min bin
%no effort bins are excluded 

Click = retime(binData(:,1),'daily','sum'); % #click per day
Bin = retime(binData(:,1),'daily','count'); % #bin per day

%group data by day
dayData = synchronize(Click,Bin);
dayEffort = retime(binEffort,'daily','sum');
dayTab = synchronize(dayData,dayEffort);
dayTable = synchronize(dayData,dayEffort);
dayTable.Properties.VariableNames{'bin'} = 'Effort_Bin';
dayTable.Properties.VariableNames{'sec'} = 'Effort_Sec';
dayTableZeros = dayTable;
dayTable(~dayTable.Effort_Bin,:)=[]; %removes days with no effort, NOT days with no presence
%% statistical methods from Diogou, et al. 2019 - by 5 min bins (0s = Absence, 1s = Presence)
% if there was a whale clicking during that 5 minutes, count that bin as a
% 1, if there was no whale clicking but there was effort, count that bin as
% 0
binTable.Season = zeros(y,1);
binTable.month = month(binTable.tbin);
summeridxB = (binTable.month == 6  | binTable.month == 7 | binTable.month == 8);
fallidxB = (binTable.month == 9  | binTable.month == 10 | binTable.month == 11);
winteridxB = (binTable.month == 12  | binTable.month == 1 | binTable.month == 2);
springidxB = (binTable.month == 3  | binTable.month == 4 | binTable.month == 5);

binTable.Season(summeridxB) = 1;
binTable.Season(fallidxB) = 2;
binTable.Season(winteridxB) = 3;
binTable.Season(springidxB) = 4;
%% statistical methods from Diogou, et al. 2019 - by daily 5 min bins ** USE THIS **
[p,~]=size(dayTable);
dayTable.MaxEffort_Bin = ones(p,1)*(288); %total number of bins possible in one day
dayTable.MaxEffort_Sec = ones(p,1)*(86400); %seconds in one day

%dealing with duty cycled data
if strcmp(siteabrev,'CB');
dayTable.Effort_Bin(222:507) = 127;%for CB02 ONLY - only .44 of each hour is recorded...
%so effort of 5 min bins for each day is 127 bins
    else
if strcmp(siteabrev,'BD');
dayTable.Effort_Bin(274:end) = 96; %for ALEUT03BD ONLY - only 0.33 of each hour is recorded...
%so effort of 5 min bins for each day is 96
    else
dayTable.MaxEffort_Bin = ones(p,1)*(288);
end
end

dayTable.NormEffort_Bin = dayTable.Effort_Bin./dayTable.MaxEffort_Bin; %what proportion of the day was there effort
dayTable.NormEffort_Sec = dayTable.Effort_Sec./dayTable.MaxEffort_Sec; %what proportion of the day was there effort
dayTable.NormBin = dayTable.Count_Bin ./ dayTable.NormEffort_Bin; %what would the normalized bin count be given the amount of effort
dayTable.NormClick = dayTable.Count_Click ./ dayTable.NormEffort_Sec; %what would be the normalized click count given the amount of effort

%group data by week
weekTable = retime(dayTable,'weekly','mean');
%add month and year to week table
weekTable.year = year(weekTable.tbin);
weekTable.month = month(weekTable.tbin);

%add season and month to daytable
dayTable.Season = zeros(p,1);
dayTable.month = month(dayTable.tbin);
summeridxD = (dayTable.month == 6  | dayTable.month == 7 | dayTable.month == 8);
fallidxD = (dayTable.month == 9  | dayTable.month == 10 | dayTable.month == 11);
winteridxD = (dayTable.month == 12  | dayTable.month == 1 | dayTable.month == 2);
springidxD = (dayTable.month == 3  | dayTable.month == 4 | dayTable.month == 5);

%adds the season according to the month the data was collected
dayTable.Season(summeridxD) = 1;
dayTable.Season(fallidxD) = 2;
dayTable.Season(winteridxD) = 3;
dayTable.Season(springidxD) = 4;

NANidx = ismissing(dayTable(:,{'NormBin'}));
dayTable{:,{'NormBin'}}(NANidx) = 0; %if there was effort, but no detections change the NormBin column to zero
dayTable.year = year(dayTable.tbin);
%%
weekTable.Percent = weekTable.Effort_Sec./604800
figure
yyaxis left
bar(weekTable.tbin,weekTable.Count_Bin,'k')
title('Average Weekly Presence of Sperm Whales at Guadalupe Island in Baja California')
ylabel('Average # of 5-Minute Bins')
hold on
yyaxis right
plot(weekTable.tbin,weekTable.Percent,'.r')
ylabel('Percent Effort')
col = [0 0 0];
set(gcf,'defaultAxesColorOrder',[col;col])

%% Average weekly click count (log scale)
figure
title(['Average Daily Presence of Sperm Whales at ',SiteName_forPlots])
subplot(3,1,1) %number of plots, column, row)
bar1 = bar(dayTable.tbin(dayTable.year==2010),dayTable.NormBin(dayTable.year==2010),'k')
title(['Average Daily Presence of Sperm Whales at ',SiteName_forPlots])
tstart = datetime(2010,01,01);
tend = datetime(2010,12,31);
xlim([tstart tend]);
ylim1 = min(dayTable.NormBin);
ylim2 = max(dayTable.NormBin);
ylim([ylim1 ylim2]);
subplot(3,1,2) %number of plots, column, row)
bar2 = bar(dayTable.tbin(dayTable.year==2011),dayTable.NormBin(dayTable.year==2011),'k')
tstart = datetime(2011,01,01);
tend = datetime(2011,12,31);
xlim([tstart tend]);
ylim([ylim1 ylim2]);
ylabel('Average Daily # of 5-min Bins')
subplot(3,1,3) %number of plots, column, row)
bar3 = bar(dayTable.tbin(dayTable.year==2012),dayTable.NormBin(dayTable.year==2012),'k')
tstart = datetime(2012,01,01);
tend = datetime(2012,12,31);
xlim([tstart tend]);
ylim([ylim1 ylim2]);
xlabel('Time (months)')
% Save plot
dailyfn = [filePrefix,'_','_subplots_daily_average_presence'];
saveas(gcf,fullfile(saveDir,dailyfn),'png')
saveas(gcf,fullfile(saveDir,dailyfn),'fig')
