%Plots for Comparing Rolling Behavior from Optogenetic Goro vs Global Heat
%+ vib

%PC, December 2020

%%
%Point to xlsx files of interest
dirname = uigetdir;
filenames = dir([dirname '/**/' '*summary-combined-final.xlsx']); %gets filenames from all files within subfolders that contain .csv
cd = dirname;
data = [];

%Load in necessary data
for f = 1:length(filenames)
    data = [data; xlsread([filenames(f).folder '/' filenames(f).name])];
end

groups = {'global heat + vib','optogenetic-Goro 100%','oG 50%','oG 15%','oG 2%'}; 

global_heat_data = data(1:110,:);
optogoro_data = data(111:219,:);
og_2 = data(220:263,:);
og_15 = data(264:306,:);
og_50 = data(307:350,:);

roll_prob = nan([110,5]);
roll_prob(1:110,1) = global_heat_data(:,1);
roll_prob(1:109,2) = optogoro_data(:,1);
roll_prob(1:44,3) = og_50(:,1);
roll_prob(1:43,4) = og_15(:,1);
roll_prob(1:44,5) = og_2(:,1);

roll_num = nan([110,5]);
roll_num(1:110,1) = global_heat_data(:,2);
roll_num(1:109,2) = optogoro_data(:,2);
roll_num(1:44,3) = og_50(:,2);
roll_num(1:43,4) = og_15(:,2);
roll_num(1:44,5) = og_2(:,2);

bend_prob = nan([110,5]);
bend_prob(1:110,1) = global_heat_data(:,3);
bend_prob(1:109,2) = optogoro_data(:,3);
bend_prob(1:44,3) = og_50(:,3);
bend_prob(1:43,4) = og_15(:,3);
bend_prob(1:44,5) = og_2(:,3);

roll_lat = nan([110,5]);
roll_lat(1:110,1) = global_heat_data(:,4);
roll_lat(1:109,2) = optogoro_data(:,4);
roll_lat(1:44,3) = og_50(:,4);
roll_lat(1:43,4) = og_15(:,4);
roll_lat(1:44,5) = og_2(:,4);

bend_chg = nan([110,5]);
bend_chg(1:110,1) = global_heat_data(:,5);
bend_chg(1:109,2) = optogoro_data(:,5);
bend_chg(1:44,3) = og_50(:,5);
bend_chg(1:43,4) = og_15(:,5);
bend_chg(1:44,5) = og_2(:,5);

roll_chg = nan([110,5]);
roll_chg(1:110,1) = global_heat_data(:,6);
roll_chg(1:109,2) = optogoro_data(:,6);
roll_chg(1:44,3) = og_50(:,6);
roll_chg(1:43,4) = og_15(:,6);
roll_chg(1:44,5) = og_2(:,6);

% %ranksum tests for all combinations of stimuli
prgog = ranksum(roll_prob(:,1),roll_prob(:,2));
prg50 = ranksum(roll_prob(:,1),roll_prob(:,3));
prg15 = ranksum(roll_prob(:,1),roll_prob(:,4));
prg02 = ranksum(roll_prob(:,1),roll_prob(:,5));
prog50 = ranksum(roll_prob(:,2),roll_prob(:,3));
prog15 = ranksum(roll_prob(:,2),roll_prob(:,4));
prog02 = ranksum(roll_prob(:,2),roll_prob(:,5));
pr5015 = ranksum(roll_prob(:,3),roll_prob(:,4));
pr0250 = ranksum(roll_prob(:,3),roll_prob(:,5));
pr1502 = ranksum(roll_prob(:,4),roll_prob(:,5));

pbgog = ranksum(bend_prob(:,1),bend_prob(:,2));
pbg50 = ranksum(bend_prob(:,1),bend_prob(:,3));
pbg15 = ranksum(bend_prob(:,1),bend_prob(:,4));
pbg02 = ranksum(bend_prob(:,1),bend_prob(:,5));
pbog50 = ranksum(bend_prob(:,2),bend_prob(:,3));
pbog15 = ranksum(bend_prob(:,2),bend_prob(:,4));
pbog02 = ranksum(bend_prob(:,2),bend_prob(:,5));
pb5015 = ranksum(bend_prob(:,3),bend_prob(:,4));
pb0250 = ranksum(bend_prob(:,3),bend_prob(:,5));
pb1502 = ranksum(bend_prob(:,4),bend_prob(:,5));

prngog = ranksum(roll_num(:,1),roll_num(:,2));
prng50 = ranksum(roll_num(:,1),roll_num(:,3));
prng15 = ranksum(roll_num(:,1),roll_num(:,4));
prng02 = ranksum(roll_num(:,1),roll_num(:,5));
prnog50 = ranksum(roll_num(:,2),roll_num(:,3));
prnog15 = ranksum(roll_num(:,2),roll_num(:,4));
prnog02 = ranksum(roll_num(:,2),roll_num(:,5));
prn5015 = ranksum(roll_num(:,3),roll_num(:,4));
prn0250 = ranksum(roll_num(:,3),roll_num(:,5));
prn1502 = ranksum(roll_num(:,4),roll_num(:,5));

prcgog = ranksum(roll_chg(:,1),roll_chg(:,2));
prcg50 = ranksum(roll_chg(:,1),roll_chg(:,3));
prcg15 = ranksum(roll_chg(:,1),roll_chg(:,4));
prcg02 = ranksum(roll_chg(:,1),roll_chg(:,5));
prcog50 = ranksum(roll_chg(:,2),roll_chg(:,3));
prcog15 = ranksum(roll_chg(:,2),roll_chg(:,4));
prcog02 = ranksum(roll_chg(:,2),roll_chg(:,5));
prc5015 = ranksum(roll_chg(:,3),roll_chg(:,4));
prc0250 = ranksum(roll_chg(:,3),roll_chg(:,5));
prc1502 = ranksum(roll_chg(:,4),roll_chg(:,5));

prlgog = ranksum(roll_lat(:,1),roll_lat(:,2));
prlg50 = ranksum(roll_lat(:,1),roll_lat(:,3));
prlg15 = ranksum(roll_lat(:,1),roll_lat(:,4));
prlg02 = ranksum(roll_lat(:,1),roll_lat(:,5));
prlog50 = ranksum(roll_lat(:,2),roll_lat(:,3));
prlog15 = ranksum(roll_lat(:,2),roll_lat(:,4));
prlog02 = ranksum(roll_lat(:,2),roll_lat(:,5));
prl5015 = ranksum(roll_lat(:,3),roll_lat(:,4));
prl0250 = ranksum(roll_lat(:,3),roll_lat(:,5));
prl1502 = ranksum(roll_lat(:,4),roll_lat(:,5));

pbcgog = ranksum(bend_chg(:,1),bend_chg(:,2));
pbcg50 = ranksum(bend_chg(:,1),bend_chg(:,3));
pbcg15 = ranksum(bend_chg(:,1),bend_chg(:,4));
pbcg02 = ranksum(bend_chg(:,1),bend_chg(:,5));
pbcog50 = ranksum(bend_chg(:,2),bend_chg(:,3));
pbcog15 = ranksum(bend_chg(:,2),bend_chg(:,4));
pbcog02 = ranksum(bend_chg(:,2),bend_chg(:,5));
pbc5015 = ranksum(bend_chg(:,3),bend_chg(:,4));
pbc0250 = ranksum(bend_chg(:,3),bend_chg(:,5));
pbc1502 = ranksum(bend_chg(:,4),bend_chg(:,5));

%Plots
% %probability of rolling
probrolling = nanmean(roll_prob,1);

figure
bar(probrolling);
title('Probability of Rolling');
xlabel('Stimulation Paradigm')
ylabel('% Larvae Rolled')

% number of rolls
figure
boxplot(roll_num); 
title('Amount of Rolling '); % 'p = ',num2str(prn)])
xlabel('Stimulation Paradigm')
ylabel('Number of Rolls')

% %probability of bending
probbending = nanmean(bend_prob,1);

figure
bar(probbending); 
title('Probability of Bending');
xlabel('Stimulation Paradigm')
ylabel('% Larvae bent')

% latency of rolling
figure
boxplot(roll_lat,groups); 
title('Latency to Roll');% 'p = ',num2str(prl)])
xlabel('Stimulation Paradigm')
ylabel('Roll Latency (s)')

% bend changes
figure
boxplot(bend_chg,groups); 
title('Bend Direction Changes');% 'p = ',num2str(pbc)])
xlabel('Stimulation Paradigm')
ylabel('Changes in Bend Direction')

% roll changes
figure
boxplot(roll_chg,groups); 
title('Roll Direction Changes');% 'p = ',num2str(prc)])
xlabel('Stimulation Paradigm')
ylabel('Changes in Roll Direction')

