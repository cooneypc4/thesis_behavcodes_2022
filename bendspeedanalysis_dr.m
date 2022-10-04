%% Bend Speed Analysis - dose response
%compare doses of oG activation in amount of curvature and rotational speed

%Patricia Cooney - 2/2021

%%
%load in indiv excel file
simplebs = xlsread('bendspeedanalysis-og.xlsx');
dosebs = xlsread('bendspeedanalysis-dr.xlsx');

%pull out variables
avgCI = simplebs(:,1);
maxCI = simplebs(:,2);
mode = simplebs(:,3);
median = simplebs(:,4);
rolldur = simplebs(:,6);
rotspeed = simplebs(:,7);

%pull out variables
avgCIdr = dosebs(:,1);
modedr = dosebs(:,2);
mediandr = dosebs(:,3);
rolldurdr = dosebs(:,4);
rotspeeddr = dosebs(:,5);


%
% avg bend by dose
avgCI_02 = [avgCIdr(1:32); nan(82,1)];
avgCI_15 = [avgCIdr(33:103); nan(43,1)];
avgCI_50 = [avgCIdr(104:170); nan(47,1)];
avgCI_100 = avgCI;

figure
boxplot([avgCI_02,avgCI_15,avgCI_50,avgCI_100]);
title('Average Curvature by Amount Goro Activation');
xlabel('Goro Activation');
ylabel('Average Curvature per Roll');

pavgCI_02_15 = ranksum(avgCI_02,avgCI_15);
pavgCI_02_50 = ranksum(avgCI_02,avgCI_50);
pavgCI_02_100 = ranksum(avgCI_02,avgCI_100);
pavgCI_15_50 = ranksum(avgCI_15,avgCI_50);
pavgCI_15_100 = ranksum(avgCI_15,avgCI_100);
pavgCI_50_100 = ranksum(avgCI_50,avgCI_100);


%mode bend by dose
mode_02 = [modedr(1:32); nan(82,1)];
mode_15 = [modedr(33:103); nan(43,1)];
mode_50 = [modedr(104:170); nan(47,1)];
mode_100 = mode;

figure
boxplot([mode_02,mode_15,mode_50,mode_100]);
title('Mode Curvature by Amount Goro Activation');
xlabel('Goro Activation');
ylabel('Mode Curvature per Roll');

pmode_02_15 = ranksum(mode_02,mode_15);
pmode_02_50 = ranksum(mode_02,mode_50);
pmode_02_100 = ranksum(mode_02,mode_100);
pmode_15_50 = ranksum(mode_15,mode_50);
pmode_15_100 = ranksum(mode_15,mode_100);
pmode_50_100 = ranksum(mode_50,mode_100);


%median bend by dose
med_02 = [mediandr(1:32); nan(82,1)];
med_15 = [mediandr(33:103); nan(43,1)];
med_50 = [mediandr(104:170); nan(47,1)];
med_100 = median;

figure
boxplot([med_02,med_15,med_50,med_100]);
title('Median Curvature by Amount Goro Activation');
xlabel('Goro Activation');
ylabel('Median Curvature per Roll');

pmed_02_15 = ranksum(med_02,med_15);
pmed_02_50 = ranksum(med_02,med_50);
pmed_02_100 = ranksum(med_02,med_100);
pmed_15_50 = ranksum(med_15,med_50);
pmed_15_100 = ranksum(med_15,med_100);
pmed_50_100 = ranksum(med_50,med_100);


%rolldur by dose
rd_02 = [rolldurdr(1:32); nan(82,1)];
rd_15 = [rolldurdr(33:103); nan(43,1)];
rd_50 = [rolldurdr(104:170); nan(47,1)];
rd_100 = rolldur;

figure
boxplot([rd_02,rd_15,rd_50,rd_100]);
title('Roll Duration by Amount Goro Activation');
xlabel('Goro Activation');
ylabel('Roll Duration (sec)');

prd_02_15 = ranksum(rd_02,rd_15);
prd_02_50 = ranksum(rd_02,rd_50);
prd_02_100 = ranksum(rd_02,rd_100);
prd_15_50 = ranksum(rd_15,rd_50);
prd_15_100 = ranksum(rd_15,rd_100);
prd_50_100 = ranksum(rd_50,rd_100);


%rotspeed by dose
rs_02 = [rotspeeddr(1:32); nan(82,1)];
rs_15 = [rotspeeddr(33:103); nan(43,1)];
rs_50 = [rotspeeddr(104:170); nan(47,1)];
rs_100 = rotspeed;

figure
boxplot([rs_02,rs_15,rs_50,rs_100]);
title('Rotation Speed by Amount Goro Activation');
xlabel('Goro Activation');
ylabel('Rotation Speed (1/Roll Duration)');

prs_02_15 = ranksum(rs_02,rs_15);
prs_02_50 = ranksum(rs_02,rs_50);
prs_02_100 = ranksum(rs_02,rs_100);
prs_15_50 = ranksum(rs_15,rs_50);
prs_15_100 = ranksum(rs_15,rs_100);
prs_50_100 = ranksum(rs_50,rs_100);
