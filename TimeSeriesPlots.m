clearvars
close all
%% Parameters defined by user
filePrefix = 'GofAK_CB'; % File name to match
siteabrev = 'CB'; %abbreviation of site
sp = 'Pm'; % your species code
saveDir = 'E:\Project_Sites\CB\Seasonality'; %specify directory to save files
titleNAME = 'Gulf of Alaska - Continental Slope';
%% load workspace
load([saveDir,'\',siteabrev,'_workspaceStep2.mat']);
load([saveDir,'\',siteabrev,'_workspaceStep3.mat']);
%% Fill in missing days
binPresence.day = double(binPresence.day);
binPresence = retime(binPresence,'daily','fillwithconstant');
%% Retime for weekly presence
weekPresence = retime(binPresence,'weekly','sum');
weekPresence.NormEffort_Bin = weekPresence.Effort_Sec ./weekPresence.MaxEffort_Sec;
weekPresence.NormEffort_Bin(isnan(weekPresence.NormEffort_Bin)) = 0;
weekPresence.FeHoursProp = weekPresence.FeHours ./(weekPresence.Effort_Sec ./ (60*60));
weekPresence.JuHoursProp = weekPresence.JuHours ./(weekPresence.Effort_Sec ./ (60*60));
weekPresence.MaHoursProp = weekPresence.MaHours ./(weekPresence.Effort_Sec ./ (60*60));
%% Plots
%Plot proportion of hours per DAY with sperm whale presence
%Plot proportion of hours per WEEK with sperm whale presence

%Plot proportion of hours per DAY with presence from each group
figure
subplot(3,1,1)
yyaxis left
bar(binPresence.tbin,binPresence.FeHoursProp,'FaceColor','y','BarWidth',3)
ylim([0 max(binPresence.FeHoursProp)])
yyaxis right
plot(binPresence.tbin, binPresence.NormEffort_Bin*100,'.r')
ylim([-1 101])
title(['Daily Presence of Social Units in the ',titleNAME])
subplot(3,1,2)
yyaxis left
bar(binPresence.tbin,binPresence.JuHoursProp,'FaceColor','b','BarWidth',3)
ylim([0 max(binPresence.JuHoursProp)])
ylabel('Proportion of hours per day with group presence')
yyaxis right
plot(binPresence.tbin, binPresence.NormEffort_Bin*100,'.r')
ylim([-1 101])
ylabel('Percent Effort')
title(['Daily Presence of Mid-Size Animals in the ',titleNAME])
subplot(3,1,3)
yyaxis left
bar(binPresence.tbin,binPresence.MaHoursProp,'FaceColor','c','BarWidth',3)
ylim([0 max(binPresence.MaHoursProp)])
title(['Daily Presence of Males in the ',titleNAME])
yyaxis right
plot(binPresence.tbin, binPresence.NormEffort_Bin*100,'.r')
ylim([-1 101])
saveas(gcf,[saveDir,'\',siteabrev,'DailyPresence_AllClasses_Subplots.png']);

%Plot proportion of hours per WEEK with presence from each group
figure
subplot(3,1,1)
yyaxis left
bar(weekPresence.tbin,weekPresence.FeHoursProp,'FaceColor','y','BarWidth',3)
ylim([0 max(weekPresence.FeHoursProp)])
yyaxis right
plot(weekPresence.tbin, weekPresence.NormEffort_Bin*100,'.r')
ylim([-1 101])
title(['Weekly Presence of Social Units in the ',titleNAME])
subplot(3,1,2)
yyaxis left
bar(weekPresence.tbin,weekPresence.JuHoursProp,'FaceColor','b','BarWidth',3)
ylim([0 max(weekPresence.JuHoursProp)])
ylabel('Proportion of hours per week with group presence')
yyaxis right
plot(weekPresence.tbin, weekPresence.NormEffort_Bin*100,'.r')
ylim([-1 101])
ylabel('Percent Effort')
title(['Weekly Presence of Mid-Size Animals in the ',titleNAME])
subplot(3,1,3)
yyaxis left
bar(weekPresence.tbin,weekPresence.MaHoursProp,'FaceColor','c','BarWidth',3)
ylim([0 max(weekPresence.MaHoursProp)])
title(['Weekly Presence of Males in the ',titleNAME])
yyaxis right
plot(weekPresence.tbin, weekPresence.NormEffort_Bin*100,'.r')
ylim([-1 101])
saveas(gcf,[saveDir,'\',siteabrev,'WeeklyPresence_AllClasses_Subplots.png']);

%Average yearly presence of proportion of hours per DAY with sperm whale
%presence
%Average yearly presence of proportion of hours per WEEK with sperm whale
%presence

%Average yearly presence of proportion of hours per DAY with presence from
%each group
%Average yearly presence of proportion of hours per WEEK with presence from
%each group

figure
subplot(3,1,1)
bar(binPresence.tbin,binPresence.FeHoursProp,'FaceColor','y','BarWidth',3)
title(['Daily Presence of Social Units in the ',titleNAME])
subplot(3,1,2)
bar(binPresence.tbin,binPresence.JuHoursProp,'FaceColor','b','BarWidth',3)
ylabel('Daily Presence (5-min bins)')
ylim([0 50])
title(['Daily Presence of Mid-Size Animals in the ',titleNAME])
subplot(3,1,3)
bar(binPresence.tbin,binPresence.MaHoursProp,'FaceColor','c','BarWidth',3)
title(['Daily Presence of Males in the ',titleNAME])
saveas(gcf,[saveDir,'\',siteabrev,'DailyPresence_AllClasses_Subplots130.png']);

%Plot daily presence in 5-min bins for all classes in one plot
figure
bar(binPresence.tbin,binPresence.MaleNormBin,'FaceColor','c','BarWidth',1)
ylabel('Daily Presence (5-min bins)')
title(['Daily Presence of Each Size Class at ',titleNAME])
hold on
bar(binPresence.tbin,binPresence.JuvenileNormBin,'FaceColor','b','BarWidth',1)
bar(binPresence.tbin,binPresence.FemaleNormBin,'FaceColor','y','BarWidth',1)
legend('Males','Mid-Size','Social Units')
saveas(gcf,[saveDir,'\',siteabrev,'DailyPresence_AllClasses130.png']);

%Plotting sperm whale presence with presence of each size class over it
dayBinTAB = readtable(dayBinCSV); %read general PM table with presence information
figure
bar(dayBinTAB.tbin,dayBinTAB.NormBin,'k')
hold on
bar(binPresence.tbin,binPresence.MaleNormBin,'FaceColor','c','BarWidth',1)
bar(binPresence.tbin,binPresence.JuvenileNormBin,'FaceColor','b','BarWidth',1)
bar(binPresence.tbin,binPresence.FemaleNormBin,'FaceColor','y','BarWidth',1)
ylabel('Daily Presence (5-min bins)')
title(['Daily Presence with Each Size Class at ',titleNAME])
legend('All','Males','Mid-Size','Social Units')
saveas(gcf,[saveDir,'\',siteabrev,'AllDailyPresence_with_SizeClasses130.png']);