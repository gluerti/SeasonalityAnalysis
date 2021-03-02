
close all;clear all;clc;

%% load lat and long with only 1 deployment
HZ_mean = [41.06165,-66.35]; %[lat,long]
HZtext = repmat({'HZ'},size(HZ_mean,1),1);
HZ = [HZtext num2cell(HZ_mean)];

GS_mean = [33.66991667,-76.00]; 
GStext = repmat({'GS'},size(GS_mean,1),1);
GS = [GStext num2cell(GS_mean)];

WIL_mean = [33.585,-76.45];
WILtext = repmat({'WIL'},size(WIL_mean,1),1);
WIL = [WILtext num2cell(WIL_mean)];

%create one table with all lat and longs
LL = [HZ; GS; WIL];
LatLong = cell2mat(LL(:,2:3));

LatLongTAB = array2table(LatLong);
LatLongTAB.Properties.VariableNames = {'Latitude' 'Longitude'};
LatLongTAB{:,'Site'} = {'HZ'; 'GS'; 'WIL'};
%% grey site map with no color distinction
figure(1)
LatLongTAB.Site = categorical(LatLongTAB.Site);
A = 200;
latitude = LatLongTAB.Latitude;
longitude = LatLongTAB.Longitude;
sites = LatLongTAB.Site;
gm = geoscatter(latitude,longitude,A,sites,'.');
%geolimits([45 65],[-220 -120]);
text(latitude(1),longitude(1)-0.5,'HZ','HorizontalAlignment','right','FontSize',10);
text(latitude(2)+0.75,longitude(2),'GS','HorizontalAlignment','right','FontSize',10);
text(latitude(3),longitude(3)-0.5,'WIL','HorizontalAlignment','right','FontSize',10);
% geolimits([45 65],[-200 -120]);
%% grey site map
figure(2)
LatLongTAB.Site = categorical(LatLongTAB.Site);
A = 50;
latitude = LatLongTAB.Latitude;
longitude = LatLongTAB.Longitude;
gm = geoscatter(latitude,longitude,A,'.','k');  
geolimits([-3 74],[-180 -110]);