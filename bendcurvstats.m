%Plots for Comparing Bend Max for Different Directions

%PC, April 2020; revised 11/2020 and 1/2021

%%
%Point to xlsx files of interest
dirname = uigetdir;
filenames = dir([dirname '/**/' '*stats.xlsx']); %gets filenames from all files within subfolders that contain .csv
cd = dirname;
data = [];

%Load in necessary data
for f = 1:length(filenames)
    data = [data; xlsread([filenames(f).folder '/' filenames(f).name])];
end
% 
% 
% allescapeparadigms_data = data(1:10,:);
% optogoro_data = data(11:21,:);

%%
% %ranksum tests for frequency of patterns
% rcwrccw = ranksum(data(1,:),data(2,:));
% rcwlccw = ranksum(data(1,:),data(3,:));
% rcwlcw = ranksum(data(1,:),data(4,:));
% rccwlccw = ranksum(data(2,:),data(3,:));
% rccwlcw = ranksum(data(2,:),data(4,:));
% lccwlcw = ranksum(data(3,:),data(4,:));
%
%ranksum tests for all directions and curve sides
%%
%highest total
% aephtotallr = ranksum(data(1:4,1),data(1:4,2));
% aephtotalld = ranksum(data(1:4,1),data(1:4,3));
% aephtotallv = ranksum(data(1:4,1),data(1:4,4));
% aephtotalrd = ranksum(data(1:4,2),data(1:4,3));
% aephtotalrv = ranksum(data(1:4,2),data(1:4,4));
% aephtotaldv = ranksum(data(1:4,3),data(1:4,4));
% 
% %%
% % %lowest total
% aepltotallr = ranksum(data(5:8,1),data(5:8,2));
% aepltotalld = ranksum(data(5:8,1),data(5:8,3));
% aepltotallv = ranksum(data(5:8,1),data(5:8,4));
% aepltotalrd = ranksum(data(5:8,2),data(5:8,3));
% aepltotalrv = ranksum(data(5:8,2),data(5:8,4));
% aepltotaldv = ranksum(data(5:8,3),data(5:8,4));

%%
% % %ranksum tests for goro directions and curve sides
% %%
% %highest total
% ghtotallr = ranksum(data(1:4,1),data(1:4,2));
% ghtotalld = ranksum(data(1:4,1),data(1:4,3));
% ghtotallv = ranksum(data(1:4,1),data(1:4,4));
% ghtotalrd = ranksum(data(1:4,2),data(1:4,3));
% ghtotalrv = ranksum(data(1:4,2),data(1:4,4));
% ghtotaldv = ranksum(data(1:4,3),data(1:4,4));
% 
% %%
% % %lowest total
% gltotallr = ranksum(data(5:8,1),data(5:8,2));
% gltotalld = ranksum(data(5:8,1),data(5:8,3));
% gltotallv = ranksum(data(5:8,1),data(5:8,4));
% gltotalrd = ranksum(data(5:8,2),data(5:8,3));
% gltotalrv = ranksum(data(5:8,2),data(5:8,4));
% gltotaldv = ranksum(data(5:8,3),data(5:8,4));

%%
%Binomial test on each side of larva (rows) for most contracted and least
%contracted (columns); 3rd col = total most; total least

%% total
cats = [1, 2, 3, 4];

data = round(data);

n_most_total = data(1,4) + data(5,4) + data(9,4) + data(13,4);
n_least_total = data(2,4) + data(6,4) + data(10,4) + data(14,4);

exp_most = 0.25;
exp_least = 0.25;

left_total = data(1,1:2) + data(5,1:2) + data(9,1:2) + data(13,1:2);
right_total = data(2,1:2) + data(6,1:2) + data(10,1:2) + data(14,1:2);
dorsal_total = data(3,1:2) + data(7,1:2) + data(11,1:2) + data(15,1:2);
ventral_total = data(4,1:2) + data(8,1:2) + data(12,1:2) + data(16,1:2);
lat_total = left_total + right_total;

all_total_most = [left_total(1); right_total(1); dorsal_total(1); ventral_total(1)];
all_total_least = [left_total(2); right_total(2); dorsal_total(2); ventral_total(2)];

all_total_most_lat = [lat_total(1); dorsal_total(1); ventral_total(1)];
all_total_least_lat = [lat_total(2); dorsal_total(2); ventral_total(2)];

%run binom test on most bent frequencies
pmleft_total = myBinomTest(left_total(1),n_most_total,exp_most,'two');
pmright_total = myBinomTest(right_total(1),n_most_total,exp_most,'two');
pmdorsal_total = myBinomTest(dorsal_total(1),n_most_total,exp_most,'two');
pmventral_total = myBinomTest(ventral_total(1),n_most_total,exp_most,'one');

pmlat_total = myBinomTest(lat_total(1),n_most_total,0.5,'two');

%run binom test on least bent frequencies
plleft_total = myBinomTest(left_total(2),n_least_total,exp_least,'two');
plright_total = myBinomTest(right_total(2),n_least_total,exp_least,'two');
pldorsal_total = myBinomTest(dorsal_total(2),n_least_total,exp_least,'two');
plventral_total = myBinomTest(ventral_total(2),n_least_total,exp_least,'two');

pllat_total = myBinomTest(lat_total(2),n_most_total,0.5,'two');

%make percentages
percsmost_total = (all_total_most/n_most_total)*100;
percsleast_total = (all_total_least/n_least_total)*100;

percsmost_total_lat = (all_total_most_lat/n_most_total)*100;
percsleast_total_lat = (all_total_least_lat/n_least_total)*100;

%figures of %s
figure
bar(cats,percsmost_total);
title('Total Frequency of Being Most Bent');
xlabel('Side')
ylabel('% Rolls')

figure 
bar(cats,percsleast_total);
title('Total Frequency of Being Least Bent');
xlabel('Side')
ylabel('% Rolls')


figure
bar([1:3],percsmost_total_lat);
title('Total Frequency of Being Most Bent');
xlabel('Side')
ylabel('% Rolls')

figure 
bar([1:3],percsleast_total_lat);
title('Total Frequency of Being Least Bent');
xlabel('Side')
ylabel('% Rolls')
%% by side
catsall= [1:1:16];

%RCW to - 13:16
n_most_rcw = data(13,4);
n_least_rcw = data(14,4);

exp_most = 0.25;
exp_least = 0.25;

left_rcw = data(13,1:2);
right_rcw = data(14,1:2);
dorsal_rcw = data(15,1:2);
ventral_rcw = data(16,1:2);

lat_rcw = left_rcw + right_rcw;

%run binom test on most bent frequencies
pmleft_rcw = myBinomTest(left_rcw(1),n_most_rcw,exp_most,'two');
pmright_rcw = myBinomTest(right_rcw(1),n_most_rcw,exp_most,'two');
pmdorsal_rcw = myBinomTest(dorsal_rcw(1),n_most_rcw,exp_most,'two');
pmventral_rcw = myBinomTest(ventral_rcw(1),n_most_rcw,exp_most,'one');

pmlat_rcw = myBinomTest(lat_rcw(1),n_most_rcw,0.5,'one');

%run binom test on least bent frequencies
plleft_rcw = myBinomTest(left_rcw(2),n_least_rcw,exp_least,'two');
plright_rcw = myBinomTest(right_rcw(2),n_least_rcw,exp_least,'two');
pldorsal_rcw = myBinomTest(dorsal_rcw(2),n_least_rcw,exp_least,'two');
plventral_rcw = myBinomTest(ventral_rcw(2),n_least_rcw,exp_least,'two');

pllat_rcw = myBinomTest(lat_rcw(1),n_least_rcw,0.5,'one');

%make percentages
percsmost_rcw = (data(13:16,1)/n_most_rcw)*100;
percsleast_rcw = (data(13:16,2)/n_least_rcw)*100;

tpercsmost_rcw = (data(13:16,1)/n_most_total)*100;
tpercsleast_rcw = (data(13:16,2)/n_least_total)*100;

percsmost_rcw_lat = [percsmost_rcw(1) + percsmost_rcw(2); percsmost_rcw(3:4)];
percsleast_rcw_lat = [percsleast_rcw(1) + percsleast_rcw(2); percsleast_rcw(3:4)];

tpercsmost_rcw_lat = [tpercsmost_rcw(1) + tpercsmost_rcw(2); tpercsmost_rcw(3:4)];
tpercsleast_rcw_lat = [tpercsleast_rcw(1) + tpercsleast_rcw(2); tpercsleast_rcw(3:4)];


%RCCW away - 9:12
n_most_rccw = data(9,4);
n_least_rccw = data(10,4);

exp_most = 0.25;
exp_least = 0.25;

left_rccw = data(9,1:2);
right_rccw = data(10,1:2);
dorsal_rccw = data(11,1:2);
ventral_rccw = data(12,1:2);

lat_rccw = left_rccw + right_rccw;

%run binom test on most bent frequencies
pmleft_rccw = myBinomTest(left_rccw(1),n_most_rccw,exp_most,'two');
pmright_rccw = myBinomTest(right_rccw(1),n_most_rccw,exp_most,'two');
pmdorsal_rccw = myBinomTest(dorsal_rccw(1),n_most_rccw,exp_most,'two');
pmventral_rccw = myBinomTest(ventral_rccw(1),n_most_rccw,exp_most,'one');

pmlat_rccw = myBinomTest(lat_rccw(1),n_most_rccw,0.5,'one');

%run binom test on least bent frequencies
plleft_rccw = myBinomTest(left_rccw(2),n_least_rccw,exp_least,'two');
plright_rccw = myBinomTest(right_rccw(2),n_least_rccw,exp_least,'two');
pldorsal_rccw = myBinomTest(dorsal_rccw(2),n_least_rccw,exp_least,'two');
plventral_rccw = myBinomTest(ventral_rccw(2),n_least_rccw,exp_least,'two');

pllat_rccw = myBinomTest(lat_rccw(2),n_least_rccw,0.5,'one');

%make percentages
percsmost_rccw = (data(9:12,1)/n_most_rccw)*100;
percsleast_rccw = (data(9:12,2)/n_least_rccw)*100;

tpercsmost_rccw = (data(9:12,1)/n_most_total)*100;
tpercsleast_rccw = (data(9:12,2)/n_least_total)*100;

percsmost_rccw_lat = [percsmost_rccw(1) + percsmost_rccw(2); percsmost_rccw(3:4)];
percsleast_rccw_lat = [percsleast_rccw(1) + percsleast_rccw(2); percsleast_rccw(3:4)];

tpercsmost_rccw_lat = [tpercsmost_rccw(1) + tpercsmost_rccw(2); tpercsmost_rccw(3:4)];
tpercsleast_rccw_lat = [tpercsleast_rccw(1) + tpercsleast_rccw(2); tpercsleast_rccw(3:4)];


%LCW away
n_most_lcw = data(5,4);
n_least_lcw = data(6,4);

exp_most = 0.25;
exp_least = 0.25;

left_lcw = data(5,1:2);
right_lcw = data(6,1:2);
dorsal_lcw = data(7,1:2);
ventral_lcw = data(8,1:2);

lat_lcw = left_lcw + right_lcw;

%run binom test on most bent frequencies
pmleft_lcw = myBinomTest(left_lcw(1),n_most_lcw,exp_most,'two');
pmright_lcw = myBinomTest(right_lcw(1),n_most_lcw,exp_most,'two');
pmdorsal_lcw = myBinomTest(dorsal_lcw(1),n_most_lcw,exp_most,'two');
pmventral_lcw = myBinomTest(ventral_lcw(1),n_most_lcw,exp_most,'one');

pmlat_lcw = myBinomTest(lat_lcw(1),n_most_lcw,0.5,'one');

%run binom test on least bent frequencies
plleft_lcw = myBinomTest(left_lcw(2),n_least_lcw,exp_least,'two');
plright_lcw = myBinomTest(right_lcw(2),n_least_lcw,exp_least,'two');
pldorsal_lcw = myBinomTest(dorsal_lcw(2),n_least_lcw,exp_least,'two');
plventral_lcw = myBinomTest(ventral_lcw(2),n_least_lcw,exp_least,'two');

pllat_lcw = myBinomTest(lat_lcw(2),n_least_lcw,0.5,'one');

%make percentages
percsmost_lcw = (data(5:8,1)/n_most_lcw)*100;
percsleast_lcw = (data(5:8,2)/n_least_lcw)*100;

tpercsmost_lcw = (data(5:8,1)/n_most_total)*100;
tpercsleast_lcw = (data(5:8,2)/n_least_total)*100;

percsmost_lcw_lat = [percsmost_lcw(1) + percsmost_lcw(2); percsmost_lcw(3:4)];
percsleast_lcw_lat = [percsleast_lcw(1) + percsleast_lcw(2); percsleast_lcw(3:4)];

tpercsmost_lcw_lat = [tpercsmost_lcw(1) + tpercsmost_lcw(2); tpercsmost_lcw(3:4)];
tpercsleast_lcw_lat = [tpercsleast_lcw(1) + tpercsleast_lcw(2); tpercsleast_lcw(3:4)];


%LCCW to
n_most_lccw = data(1,4);
n_least_lccw = data(2,4);

exp_most = 0.25;
exp_least = 0.25;

left_lccw = data(1,1:2);
right_lccw = data(2,1:2);
dorsal_lccw = data(3,1:2);
ventral_lccw = data(4,1:2);

lat_lccw = left_lccw + right_lccw;

%run binom test on most bent frequencies
pmleft_lccw = myBinomTest(left_lccw(1),n_most_lccw,exp_most,'two');
pmright_lccw = myBinomTest(right_lccw(1),n_most_lccw,exp_most,'two');
pmdorsal_lccw = myBinomTest(dorsal_lccw(1),n_most_lccw,exp_most,'two');
pmventral_lccw = myBinomTest(ventral_lccw(1),n_most_lccw,exp_most,'one');

pmlat_lccw = myBinomTest(lat_lccw(1),n_most_lccw,0.5,'one');

%run binom test on least bent frequencies
plleft_lccw = myBinomTest(left_lccw(2),n_least_lccw,exp_least,'two');
plright_lccw = myBinomTest(right_lccw(2),n_least_lccw,exp_least,'two');
pldorsal_lccw = myBinomTest(dorsal_lccw(2),n_least_lccw,exp_least,'two');
plventral_lccw = myBinomTest(ventral_lccw(2),n_least_lccw,exp_least,'two');

pllat_lccw = myBinomTest(lat_lccw(2),n_least_lccw,0.5,'one');

%make percentages - out of total from that bend roll pattern
percsmost_lccw = (data(1:4,1)/n_most_lccw)*100;
percsleast_lccw = (data(1:4,2)/n_least_lccw)*100;

tpercsmost_lccw = (data(1:4,1)/n_most_total)*100;
tpercsleast_lccw = (data(1:4,2)/n_least_total)*100;

percsmost_lccw_lat = [percsmost_lccw(1) + percsmost_lccw(2); percsmost_lccw(3:4)];
percsleast_lccw_lat = [percsleast_lccw(1) + percsleast_lccw(2); percsleast_lccw(3:4)];

tpercsmost_lccw_lat = [tpercsmost_lccw(1) + tpercsmost_lccw(2); tpercsmost_lccw(3:4)];
tpercsleast_lccw_lat = [tpercsleast_lccw(1) + tpercsleast_lccw(2); tpercsleast_lccw(3:4)];


%% figures of %s
figure
bar(catsall(1:4),percsmost_rcw);
title('Frequency of Being Most Bent');
xlabel('Side')
ylabel('% Rolls')
hold on
bar(catsall(5:8),percsmost_rccw);
bar(catsall(9:12),percsmost_lcw);
bar(catsall(13:16),percsmost_lccw);

figure 
bar(catsall(1:4),percsleast_rcw);
title('Frequency of Being Least Bent');
xlabel('Side')
ylabel('% Rolls')
hold on
bar(catsall(5:8),percsleast_rccw);
bar(catsall(9:12),percsleast_lcw);
bar(catsall(13:16),percsleast_lccw);

%figures lat of %s
figure
bar(catsall(1:3),percsmost_rcw_lat);
title('Frequency of Being Most Bent');
xlabel('Side')
ylabel('% Rolls')
hold on
bar(catsall(4:6),percsmost_rccw_lat);
bar(catsall(7:9),percsmost_lcw_lat);
bar(catsall(10:12),percsmost_lccw_lat);

figure 
bar(catsall(1:3),percsleast_rcw_lat);
title('Frequency of Being Least Bent');
xlabel('Side')
ylabel('% Rolls')
hold on
bar(catsall(4:6),percsleast_rccw_lat);
bar(catsall(7:9),percsleast_lcw_lat);
bar(catsall(10:12),percsleast_lccw_lat);

%% figures of %s by to vs away
figure
%left
bar(1,[tpercsmost_rcw(1), tpercsmost_lccw(1)],'stacked');
hold on
bar(2,[tpercsmost_rccw(1), tpercsmost_lcw(1)],'stacked');
hold on
%right
bar(3,[tpercsmost_rcw(2), tpercsmost_lccw(2)],'stacked');
hold on
bar(4,[tpercsmost_rccw(2), tpercsmost_lcw(2)],'stacked');
hold on
%dorsal
bar(5,[tpercsmost_rcw(3), tpercsmost_lccw(3)],'stacked');
hold on
bar(6,[tpercsmost_rccw(3), tpercsmost_lcw(3)],'stacked');
hold on
%ventral
bar(7,[tpercsmost_rcw(4), tpercsmost_lccw(4)],'stacked');
hold on
bar(8,[tpercsmost_rccw(4), tpercsmost_lcw(4)],'stacked');
hold on

title('Frequency of Being Most Bent');
xlabel('Side')
ylabel('% Rolls')

figure
%left
bar(1,[tpercsleast_rcw(1), tpercsleast_lccw(1)],'stacked');
hold on
bar(2,[tpercsleast_rccw(1), tpercsleast_lcw(1)],'stacked');
hold on
%right
bar(3,[tpercsleast_rcw(2), tpercsleast_lccw(2)],'stacked');
hold on
bar(4,[tpercsleast_rccw(2), tpercsleast_lcw(2)],'stacked');
hold on
%dorsal
bar(5,[tpercsleast_rcw(3), tpercsleast_lccw(3)],'stacked');
hold on
bar(6,[tpercsleast_rccw(3), tpercsleast_lcw(3)],'stacked');
hold on
%ventral
bar(7,[tpercsleast_rcw(4), tpercsleast_lccw(4)],'stacked');
hold on
bar(8,[tpercsleast_rccw(4), tpercsleast_lcw(4)],'stacked');
hold on

title('Frequency of Being Least Bent');
xlabel('Side')
ylabel('% Rolls')

%% plots by lat by to vs away
figure
%lat
bar(1,[tpercsmost_rcw_lat(1), tpercsmost_lccw_lat(1)],'stacked');
hold on
bar(2,[tpercsmost_rccw_lat(1), tpercsmost_lcw_lat(1)],'stacked');
hold on
%dorsal
bar(3,[tpercsmost_rcw_lat(2), tpercsmost_lccw_lat(2)],'stacked');
hold on
bar(4,[tpercsmost_rccw_lat(2), tpercsmost_lcw_lat(2)],'stacked');
hold on
%ventral
bar(5,[tpercsmost_rcw_lat(3), tpercsmost_lccw_lat(3)],'stacked');
hold on
bar(6,[tpercsmost_rccw_lat(3), tpercsmost_lcw_lat(3)],'stacked');
hold on

title('Frequency of Being Most Bent');
xlabel('Side')
ylabel('% Rolls')

figure
%lat
bar(1,[tpercsleast_rcw_lat(1), tpercsleast_lccw_lat(1)],'stacked');
hold on
bar(2,[tpercsleast_rccw_lat(1), tpercsleast_lcw_lat(1)],'stacked');
hold on
%dorsal
bar(3,[tpercsleast_rcw_lat(2), tpercsleast_lccw_lat(2)],'stacked');
hold on
bar(4,[tpercsleast_rccw_lat(2), tpercsleast_lcw_lat(2)],'stacked');
hold on
%ventral
bar(5,[tpercsleast_rcw_lat(3), tpercsleast_lccw_lat(3)],'stacked');
hold on
bar(6,[tpercsleast_rccw_lat(3), tpercsleast_lcw_lat(3)],'stacked');
hold on

title('Frequency of Being Least Bent');
xlabel('Side')
ylabel('% Rolls')