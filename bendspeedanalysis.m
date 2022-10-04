%% Bend Speed Analysis

%takes in excel files, plots individual larva graphs for speed vs
%curvature, plots avg of all larva regression

%Patricia Cooney, 9/2020

%%
%load in indiv excel files

% indiv1 = xlsread('indiv1');
% 
% indiv2 = xlsread('indiv2');
% 
% indiv3 = xlsread('indiv3');
% 
% %add x values - frame points at which CI avg and dist traveled were taken
% x1 = 1:size(indiv1,1);
% x2 = 1:size(indiv2,1);
% x3 = 1:size(indiv3,1);
% 
% %plot indiv line graphs
% figure
% yyaxis left
% ylabel('Average Number Points of CI threshold');
% plot(x1,indiv1(:,1));
% hold on
% yyaxis right
% ylabel('inches/sec');
% plot(x1,indiv1(:,2));
% title('Curvature-Speed Relationship-Larva1')
% 
% 
% figure
% yyaxis left
% ylabel('Average Number Points of CI threshold');
% plot(x2,indiv2(:,1));
% hold on
% yyaxis right
% ylabel('inches/sec');
% plot(x2,indiv2(:,2));
% title('Curvature-Speed Relationship-Larva2')
% xlabel('Frame Samples (every 10)')
% 
% 
% figure
% yyaxis left
% ylabel('Average Number Points of CI threshold');
% plot(x3,indiv3(:,1));
% hold on
% yyaxis right
% ylabel('inches/sec');
% plot(x3,indiv3(:,2));
% title('Curvature-Speed Relationship-Larva3')
% xlabel('Frame Samples (every 10)')
% 
% %combine all larvae together, and do regression
% all_larvae = nan(101,2);
% all_larvae(1:31,1:2) = indiv1;
% all_larvae(32:53,1:2) = indiv2;
% all_larvae(54:101,1:2) = indiv3;
% 
% mdl = fitlm(all_larvae(:,1),all_larvae(:,2));
% 
% plot(mdl);
% ylabel('Speed (inches/sec)');
% xlabel('Points above CI threshold');
% title('Relationship between Curvature and Speed');
% 


%%
%simple bend-speed analysis

%takes summary simple bend-speed data (avg CI, max CI, speed, roll dur) and
%plots, takes regression

%load in indiv excel file
simplebs = xlsread('bendspeedanalysis-og.xlsx');

%pull out variables
avgCI = simplebs(:,1);
maxCI = simplebs(:,2);
mode = simplebs(:,3);
median = simplebs(:,4);
rolldur = simplebs(:,6);
rotspeed = simplebs(:,7);

%plot avg x rotspeed
figure
scatter(avgCI,rotspeed);
hold on

%regression line and Rsquared
mdl1 = fitlm(avgCI,rotspeed);
plot(mdl1);
title('Average Curvature per Rotational Speed-OptoGoro')
xlabel('Average Number of Points over CI Threshold');
ylabel('Rotational Speed (1/Roll Duration in Seconds)');

% b_avgCIrolldur = polyfit(avgCI,rolldur,1);
% avgCIrolldur_fit = polyval(b_avgCIrolldur,avgCI);
% plot(avgCI,avgCIrolldur_fit);
% 
% yresid = rolldur - avgCIrolldur_fit;
% SSresid = sum(yresid.^2);
% SStotal = (length(rolldur)-1) * var(rolldur);
% rsq = 1 - SSresid/SStotal;

% %scatter avg x speed
% figure
% scatter(avgCI,speed);
% hold on
% 
% %regression line and Rsquared
% mdl2 = fitlm(avgCI,speed);
% plot(mdl2);
% title('Average Curvature per Speed')
% xlabel('Average Number of Points over CI Threshold');
% ylabel('Translation Speed (in/sec)');

% b_avgCIspeed = polyfit(avgCI,speed,1);
% avgCIspeed_fit = polyval(b_avgCIspeed,avgCI);
% plot(avgCI,avgCIspeed_fit);
% 
% yresid2 = rolldur - avgCIspeed_fit;
% SSresid2 = sum(yresid2.^2);
% SStotal2 = (length(speed)-1) * var(speed);
% rsq2 = 1 - SSresid2/SStotal2;


%scatter max x rolldur
figure
scatter(maxCI,rotspeed);

mdl2 = fitlm(maxCI,rotspeed);
plot(mdl2);
title('Maximum Curvature per Rotational Speed-OptoGoro')
xlabel('Maximum Number of Points over CI Threshold');
ylabel('Rotational Speed (1/Roll Duration in Seconds)');

% %scatter max x speed
% figure
% scatter(maxCI,speed);
% 
% mdl4 = fitlm(maxCI,speed);
% plot(mdl4);
% title('Maximum Curvature per Speed')
% xlabel('Maximum Number of Points over CI Threshold');
% ylabel('Translation Speed (in/sec)');


%scatter mode x rolldur
figure
scatter(mode,rotspeed);

mdl3 = fitlm(mode,rotspeed);
plot(mdl3);
title('Mode of Curvature per Rotational Speed-OptoGoro')
xlabel('Mode of Points over CI Threshold');
ylabel('Rotational Speed (1/Roll Duration in Seconds)');


%scatter max x rolldur
figure
scatter(median,rotspeed);

mdl4 = fitlm(median,rotspeed);
plot(mdl4);
title('Median Curvature per Rotational Speed-OptoGoro')
xlabel('Median Number of Points over CI Threshold');
ylabel('Rotational Speed (1/Roll Duration in Seconds)');


%% Rotational Speed by Pattern
bsbypatt = xlsread('bendspeedanalysis-og-bypatt.xlsx');

lccw_rotspeed = bsbypatt(95:114,7);
lcw_rotspeed = bsbypatt(22:71,7);
rccw_rotspeed = bsbypatt(72:94,7);
rcw_rotspeed = bsbypatt(1:21,7);

prs_lccwlcw = ranksum(lccw_rotspeed,lcw_rotspeed);
prs_lccwrccw = ranksum(lccw_rotspeed,rccw_rotspeed);
prs_lccwrcw = ranksum(lccw_rotspeed,rcw_rotspeed);
prs_lcwrccw = ranksum(lcw_rotspeed,rccw_rotspeed);
prs_lcwrcw = ranksum(lcw_rotspeed,rcw_rotspeed);
prs_rccwrcw = ranksum(rccw_rotspeed,rcw_rotspeed);

%% Max Bend by Pattern
lccw_maxbend = bsbypatt(95:114,2);
lcw_maxbend = bsbypatt(22:71,2);
rccw_maxbend = bsbypatt(72:94,2);
rcw_maxbend = bsbypatt(1:21,2);

pmb_lccwlcw = ranksum(lccw_maxbend,lcw_maxbend);
pmb_lccwrccw = ranksum(lccw_maxbend,rccw_maxbend);
pmb_lccwrcw = ranksum(lccw_maxbend,rcw_maxbend);
pmb_lcwrccw = ranksum(lcw_maxbend,rccw_maxbend);
pmb_lcwrcw = ranksum(lcw_maxbend,rcw_maxbend);
pmb_rccwrcw = ranksum(rccw_maxbend,rcw_maxbend);

