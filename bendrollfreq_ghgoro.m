%Plots for Bend-Roll Pattern Frequency

%PC, April 2020, modified 11/2020

%%
%Point to xlsx files of interest
dirname = uigetdir;
filenames = dir([dirname '/**/' '*pattern.xlsx']); %gets filenames from all files within subfolders that contain .csv
cd = dirname;
data = [];

%Load in necessary data
for f = 1:length(filenames)
    data = [data; xlsread([filenames(f).folder '/' filenames(f).name])];
end

% % groups = {'global heat'};
% %groups = {'global heat','optogenetic-Goro','total'}; 
% cats = [1, 1, 1; 2,2,2;3,3,3;4,4,4]; 
% 
% % %ranksum tests for all patterns
% rcwrccw = ranksum(data(1,:),data(2,:));
% rcwlccw = ranksum(data(1,:),data(3,:));
% rcwlcw = ranksum(data(1,:),data(4,:));
% rccwlccw = ranksum(data(2,:),data(3,:));
% rccwlcw = ranksum(data(2,:),data(4,:));
% lccwlcw = ranksum(data(3,:),data(4,:));
% 
% toaway = ranksum(data(5,:),data(6,:));
% 
% 
% %Plots
% 
% figure
% bar(cats,data);
% title('Frequency of Patterns');
% xlabel('Bend-Roll Pattern')
% ylabel('% Larvae')

%%
%use binomial distribution test to see if number of patterns is
%significantly different from number of expected patterns
cats = [1, 2, 3, 4];

n_gh = data(1,3);

exp_4 = 0.25;
exp_2 = 0.5;

gh_rcw = data(1,1);
gh_rccw = data(2,1);
gh_lcw = data(3,1);
gh_lccw = data(4,1);

gh_to = data(5,1);
gh_away = data(6,1);

% gh_tovib = data(7,1);
% gh_awayvib = data(8,1);

%run binom test on four patterns' frequencies
prcw = myBinomTest(gh_rcw,n_gh,exp_4,'two');
prccw = myBinomTest(gh_rccw,n_gh,exp_4,'two');
plcw = myBinomTest(gh_lcw,n_gh,exp_4,'two');
plccw = myBinomTest(gh_lccw,n_gh,exp_4,'two');

%run binom test on two away bend vs to bend
pto = myBinomTest(gh_to,n_gh,exp_2,'two');
paway = myBinomTest(gh_away,n_gh,exp_2,'two');

%run binom test on two away vib vs to vib
% ptovib = myBinomTest(gh_tovib,n_gh,exp_2,'two');
% pawayvib = myBinomTest(gh_awayvib,n_gh,exp_2,'two');

%make percentages
percs = (data(:,1)/n_gh)*100;

%figures of %s
figure %for all 4 patterns
bar(cats,percs(1:4));
title('Frequency of Patterns');
xlabel('Bend-Roll Pattern')
ylabel('% Rolls')

figure %for to bend vs away bend
bar([1,2],percs(5:6));
title('Frequency of Translation');
xlabel('Translational Direction')
ylabel('% Rolls')
ylim([0 100])

figure %for to bend vs away bend, but broken by 4 cats
bar(1,[percs(1) percs(4)],'stacked');
hold on
bar(2, [percs(2) percs(3)],'stacked');
title('Frequency of Translation');
xlabel('Translational Direction')
ylabel('% Rolls')
ylim([0 100])

% figure %for to vib vs away vib
% bar([1,2],percs(7:8));
% title('Frequency of Translation Relative to Vibration Source');
% xlabel('Translational Direction')
% ylabel('% Rolls')
% ylim([0 100])

%% power analysis for uni goro exper's
% freqsnulltova = 0.5; %null hypoth = to vs away doesn't differ
% alttova = 0.39;
% 
% freqsnullpatt = 0.25; %null hypoth = diff patterns don't differ
% altpatt = 0.34;
% 
% nouttova = sampsizepwr('p',freqsnulltova,alttova,0.8);
% 
% noutpatt = sampsizepwr('p',freqsnullpatt,altpatt,0.8);