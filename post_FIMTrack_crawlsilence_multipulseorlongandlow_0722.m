%Plots for Comparing Rolling Behavior from PMN silencing experiments

%PC 4/2022

%% Notes for running
% Be sure this script is in the folder that contains all your data
% folders before running

% Also put the "start frames" excel in there, where a column contains the
% frame number for each trial that the LEDs came on

% Be sure to only include 1 output folder per larva or there will be errors

%% Load and organize data
%Point to xlsx files of interest
loadnew = input('load? 1 = yes, 0 = keep already loaded');
if loadnew == 1
    clear all
    close all
    
    dirname = uigetdir;
    addpath(dirname);
    inputframes = input('What is filename for start frames? (put in single quotes)');
    stimframes = readmatrix(inputframes);

    filenames = dir([dirname '/**/' '*.csv']); %gets filenames from all files within experiment subfolders
    cd = dirname;
    data = [];

    framerate = input('What frame rate was used? (e.g. 10)');
    ctrlgrps = input('Names of ctrl groups? (e.g. in single quotes: Gal4-only or UAS-only');
    expergrps = input('Names of experimental Gal4s? (e.g. 221 or 410)');
    stimtype = input('Long and low = 1; Pulses = 2');
else
end

% find start and stop frames for each video based on stimulus onset
total = length(filenames);
startframe = size(1,total);
stopframe = size(1,total);

if stimtype == 1 %long and low output (10s off, 10s 15%, 10s off, 10s 15%, 10s off)
    for t = 1:total
        startframe(t) = stimframes(t) - 10*framerate; %minus 10 seconds worth of frames
        stopframe(t) = startframe(t) + 50*framerate; %plus 50 seconds worth of frames
        totalframes = 601;
    end
elseif stimtype == 2 %multi pulse (5s off, 5s 15%, 5s off, 5s 50%, 5s off, 5s 75%, 5s off)
    for t = 1:total
        startframe(t) = stimframes(t) - 5*framerate; %minus 5 seconds worth of frames
        stopframe(t) = startframe(t) + 35*framerate; %plus 35 seconds worth of frames
        totalframes = 601;
    end
end

ctrlnames = [];
nctrl = 0;
expernames = [];
nexper = 0;
frxvars = totalframes * 30;
maxstart = 200;

%Load in necessary data, isolate larva, change to rows x cols, and break into ctrl vs exper
discard = []; %keep track of faulty larvae
for f = 1:length(filenames)  
    data = readtable([filenames(f).folder '/' filenames(f).name]);
    larvaname = strcat('larva',num2str(f));
    firststring = data(1,1);
    first_num = firststring{1,1}{1};
    if length(first_num) < 10
        redoframe = str2num(first_num(7:8));
    elseif length(first_num) == 10
        redoframe = str2num(first_num(7:9));
    end
    data_redo = [nan(redoframe,1); table2array(data(:,2))];
    if contains(filenames(f).name,'ctrl')
       	ctrlnames{nctrl+1} = larvaname;
        if startframe(f) > maxstart*framerate
            disp(strcat('Removed ',larvaname))
            discard = [discard f];
        else
            nctrl = nctrl + 1;
            diff = frxvars - size(data_redo,1);
            if diff > 0
                data_redo(:,1) = [data_redo(:,1); nan(diff,1)];
                temp = reshape(data_redo(:,1),[totalframes,30]);
                ctrldata(:,:,nctrl) = temp(startframe(f):stopframe(f),:);
            elseif diff == 0            
                temp = reshape(data_redo(:,1),[totalframes,30]);
                ctrldata(:,:,nctrl) = temp(startframe(f):stopframe(f),:);
            end
        end
    elseif contains(filenames(f).name,'exper')
        expernames{nexper+1} = larvaname;
        if startframe(f) > maxstart*framerate
            disp(strcat('Removed ',larvaname))
            discard = [discard f];
        else
            nexper = nexper + 1;
            diff = frxvars - size(data_redo,1);
            if diff > 0
                data_redo_plus = [data_redo(:,1); nan(diff,1)];
                temp = reshape(data_redo_plus,[totalframes,30]);
                experdata(:,:,nexper) = temp(startframe(f):stopframe(f),:);
            elseif diff == 0            
                temp = reshape(data_redo(:,1),[totalframes,30]);
                experdata(:,:,nexper) = temp(startframe(f):stopframe(f),:);
            end
        end
    end
end
ctrls = 1:nctrl;
exper = 1:nexper;

%% now make array for each variable we care about for ctrl and exper
%arrays for distinct variables at stimulus times happen (rows = frames;
%cols = larvae)

if stimtype == 1 %long and low output (10s off, 10s 15%, 10s off, 10s 15%, 10s off)
    %first stim
    beforefirststim = 1:10*framerate;
    firststim = beforefirststim(end)+1:beforefirststim(end)+10*framerate;
    %second stim
    beforesecstim = firststim(end)+1:firststim(end)+10*framerate;
    secstim = beforesecstim(end)+1:beforesecstim(end)+10*framerate;
    aftersecstim = secstim(end)+1:secstim(end)+10*framerate; 
    timechunks = [beforefirststim; firststim; beforesecstim; secstim; aftersecstim];
elseif stimtype == 2 %multi pulse (5s off, 5s 15%, 5s off, 5s 50%, 5s off, 5s 75%, 5s off)
    %first stim
    beforefirststim = 1:5*framerate;
    firststim = beforefirststim(end)+1:beforefirststim(end)+5*framerate;
    %second stim
    beforesecstim = firststim(end)+1:firststim(end)+5*framerate;
    secstim = beforesecstim(end)+1:beforesecstim(end)+5*framerate;
    %third stim
    beforethirdstim = secstim(end)+1:secstim(end)+5*framerate;
    thirdstim = beforethirdstim(end)+1:beforethirdstim(end)+5*framerate;
    afterthirdstim = thirdstim(end)+1:thirdstim(end)+5*framerate; 
    timechunks = [beforefirststim; firststim; beforesecstim; secstim; beforethirdstim; thirdstim; afterthirdstim];
end

%% compiling variable measures
%make list of variables to iterate through
varnames = {'Larval Area','Larval Perimeter','Spinelength','Accumulated Distance','Bend','Left Bend','Right Bend','Go Phase',...
    'Velocity','Acceleration','Coil'};
varcols = [6,7,8,4,11,26,27,25,29,30,23];

%chunk into multidim array:
%if stimtype 1, dims are ctrl = nan(measures(length timeframes above),
%indivlarva(numctrl), stimchunk(5), parameter(length(vars)))
%if stimtype 2, dims are ctrl = nan(measures(length timeframes above), 
%indivlarva(numctrl), stimchunk(7), parameter(length(vars)))
ctrlbystim = nan(length(beforefirststim),nctrl,size(timechunks,1),length(varcols));
experbystim = nan(length(beforefirststim),nexper,size(timechunks,1),length(varcols));
ctrlmeans = nan(1,nctrl,size(timechunks,1),length(varcols));
expermeans = nan(1,nexper,size(timechunks,1),length(varcols));

for c = 1:nctrl
    for chunk = 1:size(timechunks,1)
        for v = 1:length(varcols)
            ctrlbystim(:,c,chunk,v) = ctrldata(timechunks(chunk),v,c);
            ctrlmeans(1,c,chunk,v) = mean(ctrlbystim(:,c,chunk,v),1,'omitnan');
        end
    end
end

for e = 1:nexper
    for chunk = 1:size(timechunks,1)
        for v = 1:length(varcols)
            experbystim(:,e,chunk,v) = experdata(timechunks(chunk),v,e);
            expermeans(1,e,chunk,v) = mean(experbystim(:,e,chunk,v),1,'omitnan');
        end
    end
end

ctrlmeans = squeeze(ctrlmeans);
expermeans = squeeze(expermeans);
%% secondary calculations to make
%collapse into mean values per larva, combined into groups
%larval means into rows, single column; concatenate cols of stim & genotype
%to be put into boxplots

%dims = (chunk, variable, ctrl vs exper);
if stimtype == 1
    groups = {'ctrl-before15','exper-before15','ctrl-on15','exper-on15'...
    'ctrl-before15','exper-before15','ctrl-on15','exper-on15'...
    'ctrl-after15','exper-after15'};
else
    groups = {'ctrl-before15','exper-before15','ctrl-on15','exper-on15'...
    'ctrl-before50','exper-before50','ctrl-on50','exper-on50'...
    'ctrl-before75','exper-before75','ctrl-on75','exper-on75'...
    'ctrl-after75','exper-after75'};
end

%concatenate horizontally to make cols of mean for each variable, each grp
diffce = abs(nctrl-nexper);
if nctrl<nexper
    ctrlmeans = cat(1,ctrlmeans,nan(diffce,size(ctrlmeans,2),size(ctrlmeans,3)));
elseif nctrl>nexper
    expermeans = cat(1,expermeans,nan(diffce,size(expermeans,2),size(expermeans,3)));
end

for chunk = 1:size(timechunks,1)
    for v = 1:length(varcols)
        allmeansgrpd(:,chunk*2-1:chunk*2,v) = cat(2,ctrlmeans(:,chunk,v),expermeans(:,chunk,v));
    end
end

%% stats and plots

for v = 1:length(varcols)
    for chunk = 1:size(timechunks,1)
        pce(chunk,v) = ranksum(allmeansgrpd(:,chunk*2-1,v),allmeansgrpd(:,chunk*2,v));
        pcc(chunk,v) = ranksum(allmeansgrpd(:,chunk*2-1,v),allmeansgrpd(:,chunk*2+1));
        pee(chunk,v) = ranksum(allmeansgrpd(:,chunk*2,v),allmeansgrpd(:,chunk*2+2));
    end
    
    %boxplots
    figure
    boxplot(allmeansgrpd(:,:,v),groups)
    title(strcat('Proprioceptor Silencing - ',num2str(expergrps),' - ',string(varnames{v})))
    xlabel('Group x Stimulus Chunk')
    ylabel(string(varnames{v}))
    saveas(gcf,strcat('boxplot_',num2str(expergrps),'_',string(varnames{v})),'jpeg')
    saveas(gcf,strcat('boxplot_',num2str(expergrps),'_',string(varnames{v}),'.fig'))
    saveas(gcf,strcat('boxplot_',num2str(expergrps),'_',string(varnames{v}),'svg'))
end

%% for the trace plots: mean line, CI's to plot around the mean line
% if nctrl > 0 
%     alltracerectrl = reshape(adjctrlbystim,[nctrl,size(timechunks,2)*size(timechunks,1),length(varcols)]);
% end
% if nexper > 0
%     alltracereexper = reshape(adjexperbystim,[nexper,size(timechunks,2)*size(timechunks,1),length(varcols)]);
% end
% trace = nan(2,length(varcols),size(alltracereexper,2));
% 
% for v = 1:length(varcols)
%     for g = 1:2
%        if g == 1
%             trace(g,v,:) = mean(alltracerectrl(:,:,v),1,'omitnan');
%             SEM_trace = std(alltracerectrl(:,:,v),'omitnan')/sqrt(size(alltracerectrl,1)); %standard error
%             ts_ctrl = tinv([0.025  0.975],size(alltracerectrl,1)-1); %T-Score
%             CI_ctrl = ts_ctrl(2)*SEM_trace; %confidence intervals
%        else
%             trace(g,v,:) = mean(alltracereexper(:,:,v),1,'omitnan');
%             SEM_trace = std(alltracereexper(:,:,v),'omitnan')/sqrt(size(alltracereexper,1)); %standard error
%             ts_exper = tinv([0.025  0.975],size(alltracereexper,1)-1); %T-Score
%             CI_exper = ts_exper(2)*SEM_trace; %confidence intervals
%        end
%     end
%     
%     plottracectrl = squeeze(trace(1,v,:));
%     plottraceexper = squeeze(trace(2,v,:));
%     figure
%     shadedErrorBar(1:length(plottracectrl),plottracectrl,repmat(CI_ctrl,1,length(plottracectrl)),'lineprops','k')
%     hold on
%     shadedErrorBar(1:length(plottraceexper),plottraceexper,repmat(CI_exper,1,length(plottraceexper)),'lineprops','m')
%     grey  = [127 127 127]./255;
%     ymax = max([max(trace(1,v,:)) + max(CI_ctrl) + max(CI_ctrl)*0.1, max(trace(2,v,:)) + max(CI_exper) + max(CI_exper)*0.1]);
%     ymin = min([min(trace(1,v,:)) - min(CI_ctrl) - min(CI_ctrl)*0.1, min(trace(2,v,:)) - min(CI_exper) - min(CI_exper)*0.1]);
%     ylim([ymin ymax]);
%     if stimtype == 1
%         ymaxarray = [zeros(1,100), repelem(ymax,100), zeros(1,100), repelem(ymax,100), zeros(1,100)];
%         hold on;
%         area(1:50*framerate,ymaxarray,'basevalue',0,'FaceColor',grey,'FaceAlpha',0.2);
%         xlim([0 50*framerate]);
%     else
%         ymaxarray = [zeros(1,50), repelem(ymax,50), zeros(1,50), repelem(ymax,50), zeros(1,50), repelem(ymax,50), zeros(1,50)];
%         hold on;
%         area(1:35*framerate,ymaxarray,'basevalue',0,'FaceColor',grey,'FaceAlpha',0.2);
%         xlim([0 35*framerate]);
%     end
%     title(strcat('Proprioceptor Silencing - ',num2str(expergrps),' - ',string(varnames{v})))
%     xlabel('Frames');
%     ylabel(string(varnames{v}));
% 
%     saveas(gcf,strcat('timetrace_',num2str(expergrps),'_',string(varnames{v})),'jpeg')
%     saveas(gcf,strcat('timetrace_',num2str(expergrps),'_',string(varnames{v})),'svg')
%     saveas(gcf,strcat('timetrace_',num2str(expergrps),'_',string(varnames{v}),'.fig'))
% end

%% Save!
%be sure to save the workspace with p-vals(arrow at top --> Save)
save('propriosilence.mat','framerate','ctrlgrps','expergrps','stimtype','pec','pcc','pee','alltracerectrl','alltracereexper','allmeansgrpd','groups','experbystim','ctrlbystim');