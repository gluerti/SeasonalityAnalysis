clearvars
close all
%% Parameters defined by user
filePrefix = 'ALEUT01KS'; % File name to match. 
siteabrev = 'KS'; %abbreviation of site.
titleNAME = 'Aleutian Islands - Kiska Island';
sp = 'Pm'; % your species code
tpwsPath = ['E:\Project_Sites\',siteabrev,'\TPWS_125\TPWS2\TPWS3\']; %directory of TPWS files
%% load data from step 3
filename = ['G:\My Drive\GofAK_TPWS_metadataReduced\SeasonalityAnalysis\',siteabrev,'\',siteabrev,'_workspaceStep3'];
load(filename);
saveDir = ['G:\My Drive\GofAK_TPWS_metadataReduced\SeasonalityAnalysis\',siteabrev]; %specify directory to save files
%% define pie chart colors
blue = [0.2081    0.1663    0.5292];
cyan = [0.0383, 0.6742, 0.7435];
yellow = [0.9763    0.9831    0.0538];
tilecolor = [blue; cyan; yellow];
%% pie chart for F/J/M presence at each site (year round) - counting sum of hours NO TEXT
if strcmp(siteabrev,'KOA') == 1 || strcmp(siteabrev,'KS') == 1
x = [sum(meantab365.HoursPropJU) sum(meantab365.HoursPropMA) sum(meantab365.HoursPropFE)];
pie_modified(x,tilecolor);
ax = gca;
ax.Children(2).EdgeAlpha = 0;
ax.Children(4).EdgeAlpha = 0;
title([{'Proportion of Hours with Presence of Each Class'},{titleNAME}]);
delete(ax.Children([1,3]));
saveas(gcf,[saveDir,'\',siteabrev,'YearRoundRatio_BinsNOTEXT.png']);
elseif strcmp(siteabrev,'AB')
x = [sum(meantab365.HoursPropJU) sum(meantab365.HoursPropMA) sum(meantab365.HoursPropFE)];
pie_modified(x,tilecolor);
ax = gca;
ax.Children(2).EdgeAlpha = 0;
ax.Children(4).EdgeAlpha = 0;
ax.Children(6).EdgeAlpha = 0;
title([{'Proportion of Hours with Presence of Each Class'},{titleNAME}]);
delete(ax.Children([1,3,5]));
saveas(gcf,[saveDir,'\',siteabrev,'YearRoundRatio_BinsNOTEXT.png']);
else
x = [sum(meantabJU365.HoursPropJU) sum(meantabMA365.HoursPropMA) sum(meantabFE365.HoursPropFE)];
pie_modified(x,tilecolor);
ax = gca;
ax.Children(2).EdgeAlpha = 0;
ax.Children(4).EdgeAlpha = 0;
ax.Children(6).EdgeAlpha = 0;
title([{'Proportion of Hours with Presence of Each Class'},{titleNAME}]);
delete(ax.Children([1,3,5]));
saveas(gcf,[saveDir,'\',siteabrev,'YearRoundRatio_BinsNOTEXT.png']);
end
%% pie chart for F/J/M presence at each site (year round) - counting sum of days NO TEXT
if strcmp(siteabrev,'KOA') == 1 || strcmp(siteabrev,'KS') == 1 || strcmp(siteabrev,'AB')
meantab365.Fem = meantab365.HoursPropFE > 0;
meantab365.Juv = meantab365.HoursPropJU > 0;
meantab365.Mal = meantab365.HoursPropMA > 0;
x2 = [sum(meantab365.Juv) sum(meantab365.Mal) sum(meantab365.Fem)];
pie_modified(x2,tilecolor);
ax = gca;
ax.Children(2).EdgeAlpha = 0;
ax.Children(4).EdgeAlpha = 0;
title([{'Proportion of Days with Presence of Each Class'},{titleNAME}]);
delete(ax.Children([1,3]));
saveas(gcf,[saveDir,'\',siteabrev,'YearRoundRatio_DaysNOTEXT.png']);
else
meantab365.Fem = meantabFE365.HoursPropFE > 0;
meantab365.Juv = meantabJU365.HoursPropJU > 0;
meantab365.Mal = meantabMA365.HoursPropMA > 0;
x2 = [sum(meantab365.Juv) sum(meantab365.Mal) sum(meantab365.Fem)];
pie_modified(x2,tilecolor);
ax = gca;
ax.Children(2).EdgeAlpha = 0;
ax.Children(4).EdgeAlpha = 0;
ax.Children(6).EdgeAlpha = 0;
title([{'Proportion of Days with Presence of Each Class'},{titleNAME}]);
delete(ax.Children([1,3,5]));
saveas(gcf,[saveDir,'\',siteabrev,'YearRoundRatio_DaysNOTEXT.png']);
end
%% pie chart for F/J/M presence at each site (year round)- counting sum of days with text
if strcmp(siteabrev,'KOA') == 1 || strcmp(siteabrev,'KS') == 1
x = [sum(meantab365.HoursPropJU) sum(meantab365.HoursPropMA) sum(meantab365.HoursPropFE)];
pie_modified(x,tilecolor);
pText = findobj('Type','text');
percentValues = get(pText,'String');
labels = {'Mid-Size: '; 'Males: ';};
combinedtxt = strcat(labels,percentValues);
pText(1).String = combinedtxt(1);
pText(1).FontSize = 14;
pText(2).String = combinedtxt(2);
pText(2).FontSize = 14;
title([{'Proportion of Hours with Presence of Each Class'},{titleNAME}]);
saveas(gcf,[saveDir,'\',siteabrev,'YearRoundRatio_BinsTEXT.png']);
elseif strcmp(siteabrev,'AB') == 1
x = [sum(meantab365.HoursPropJU) sum(meantab365.HoursPropMA) sum(meantab365.HoursPropFE)];
pie_modified(x,tilecolor);
pText = findobj('Type','text');
percentValues = get(pText,'String');
labels = {'Mid-Size: '; 'Males: '; 'Social Units: '};
combinedtxt = strcat(labels,percentValues);
pText(1).String = combinedtxt(1);
pText(1).FontSize = 14;
pText(2).String = combinedtxt(2);
pText(3).String = combinedtxt(3);
pText(3).FontSize = 14;
title([{'Proportion of Hours with Presence of Each Class'},{titleNAME}]);
saveas(gcf,[saveDir,'\',siteabrev,'YearRoundRatio_BinsTEXT.png']);
else
x = [sum(meantabJU365.HoursPropJU) sum(meantabMA365.HoursPropMA) sum(meantabFE365.HoursPropFE) ];
p = pie(x);
pText = findobj('Type','text');
percentValues = get(pText,'String');
labels = {'Mid-Size: '; 'Males: '; 'Social Units: '};
combinedtxt = strcat(labels,percentValues);
pText(1).String = combinedtxt(1);
pText(1).FontSize = 14;
pText(2).String = combinedtxt(2);
pText(2).FontSize = 14;
pText(3).String = combinedtxt(3);
pText(3).FontSize = 14;
title([{'Proportion of Hours with Presence of Each Class'},{titleNAME}]);
saveas(gcf,[saveDir,'\',siteabrev,'YearRoundRatio_BinsTEXT.png']);
end
%% pie chart for F/J/M presence at each site (year round) - counting sum of days with text
if strcmp(siteabrev,'KOA') == 1 || strcmp(siteabrev,'KS') == 1
x2 = [sum(meantab365.Juv) sum(meantab365.Mal) sum(meantab365.Fem)];
pie_modified(x2,tilecolor);
pText = findobj('Type','text');
percentValues = get(pText,'String');
labels = {'Mid-Size: '; 'Males: ';};
combinedtxt = strcat(labels,percentValues);
pText(1).String = combinedtxt(1);
pText(1).FontSize = 14;
pText(2).String = combinedtxt(2);
pText(2).FontSize = 14;
title([{'Proportion of Days with Presence of Each Class'},{titleNAME}]);
saveas(gcf,[saveDir,'\',siteabrev,'YearRoundRatio_DaysTEXT.png']);
elseif strcmp(siteabrev,'AB') == 1
x2 = [sum(meantab365.Juv) sum(meantab365.Mal) sum(meantab365.Fem)];
pie_modified(x,tilecolor);
pText = findobj('Type','text');
percentValues = get(pText,'String');
labels = {'Mid-Size: '; 'Males: '; 'Social Units: '};
combinedtxt = strcat(labels,percentValues);
pText(1).String = combinedtxt(1);
pText(1).FontSize = 14;
pText(2).String = combinedtxt(2);
pText(2).FontSize = 14;
pText(3).String = combinedtxt(3);
pText(3).FontSize = 14;
title([{'Proportion of Days with Presence of Each Class'},{titleNAME}]);
saveas(gcf,[saveDir,'\',siteabrev,'YearRoundRatio_DaysTEXT.png']);
else
x2 = [sum(meantab365.Juv) sum(meantab365.Mal) sum(meantab365.Fem)];
pie_modified(x,tilecolor);
pText = findobj('Type','text');
percentValues = get(pText,'String');
labels = {'Mid-Size: '; 'Males: '; 'Social Units: '};
combinedtxt = strcat(labels,percentValues);
pText(1).String = combinedtxt(1);
pText(1).FontSize = 14;
pText(2).String = combinedtxt(2);
pText(2).FontSize = 14;
pText(3).String = combinedtxt(3);
pText(3).FontSize = 14;
title([{'Proportion of Days with Presence of Each Class'},{titleNAME}]);
saveas(gcf,[saveDir,'\',siteabrev,'YearRoundRatio_DaysTEXT.png']);
end