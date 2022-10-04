% Multiview SCAPE movies simultaneous

%Loads in 3D-averaged SCAPE data
%Generates movie that has subplots: top and side view same channel

%PC, 2/2022

%% Load data
%ratio tiff for this ROI
tiffname_side = 'larva3_run1_yz_merged_scaletimer-finalsidevid.tif';
tiffname_top = 'larva3_run1_roll_composite_greenmag_finaltop.tif';
tiffname_xsect = 'larva3_run1_xsect_merged_roll_scale_timetick_finalxsect.tif';
info = imfinfo(tiffname_side);
numberOfPages = length(info);
raw_avi_side = [];
for k = 1 : numberOfPages
    raw_avi_side(:,:,:,k) = imread(tiffname_side, k);
    raw_avi_top(:,:,:,k) = imread(tiffname_top, k);
    raw_avi_xsect(:,:,:,k) = imread(tiffname_xsect, k);
end

%% Figure-movie with time bar on trace plot
%use for loop to move frame by frame SCAPE movie and plot with moving bar

for fr = 1:numberOfPages
    fig = figure;
    %make subplot for top tiff
    subplot(3,3,[1:2,4:5])
    imshow(raw_avi_top(:,:,:,fr));
    title('Top View');
    hold on
    
    %make subplot for side tiff
    subplot(3,3,[7:8])
    imshow(uint8(raw_avi_side(:,:,:,fr)));
    title('Side View');
    
    %make subplot for cross tiff
    subplot(3,3,[3,6])
    imshow(raw_avi_xsect(:,:,:,fr));
    title('Cross Section');
   
    %save it temporarily
    set(gcf,'color','k');
    fig.WindowState = 'maximized';
    f(fr) = getframe(fig);
end

close all
%[h, w, p] = size(f(1).cdata);  % use 1st frame to get dimensions
hf = figure; 
% resize figure based on frame's w x h, and place at (150, 150)
%set(hf, 'position', [150 150 w h]);
axis off
movie(hf,f);
mplay(f)

%% Save your efforts
v = VideoWriter(strcat('montage_SCAPE_3views_merged.avi'));
v.FrameRate = 10;
open(v);
writeVideo(v,f);
close(v);

%half speed
w = VideoWriter(strcat('slowx2_montage_SCAPE_3views_merged.avi'));
w.FrameRate = 5;
open(w);
writeVideo(w,f);
close(w);

%%
%%
%%

%% Side by side videos of different channels
% %ratio tiff for this ROI
% tiffname_ratio = 'MIP_ratio_16bitlarva10_run4_L2-1.tif';
% tiffname_gcamp = 'MIP_gcamp_larva10_run4_L2.tif';
% tiffname_mcherry = 'MIP_mcherry_larva10_run4_L2.tif';
% info = imfinfo(tiffname_ratio);
% numberOfPages = length(info);
% 
% for k = 1 : numberOfPages
%     raw_avi_ratio(:,:,k) = imread(tiffname_ratio, k);
%     raw_avi_gcamp(:,:,k) = imread(tiffname_gcamp, k);
%     raw_avi_mcherry(:,:,k) = imread(tiffname_mcherry, k);
% end
% 
% %% Figure-movie with time bar on trace plot
% %use for loop to move frame by frame SCAPE movie and plot with moving bar
% 
% for fr = 1:numberOfPages
%     fig = figure;
%     %make subplot for mcherry tiff
%     subplot(6,1,[1:2])
%     imshow(mat2gray(raw_avi_mcherry(:,:,fr)));
%     title('Top View - MIP mcherry');
%     hold on
%     
%     %make subplot for gcamp tiff
%     subplot(6,1,[3:4])
%     imshow(mat2gray(raw_avi_gcamp(:,:,fr)));
%     title('Top View - MIP GCaMP');
%     
%     %make subplot for ratio tiff
%     subplot(6,1,[5:6])
%     imshow(mat2gray(raw_avi_ratio(:,:,fr)));
%     title('Top View - MIP Ratio');
%    
%     %save it temporarily
%     f(fr) = getframe(fig);
% end
% 
% close all
% %[h, w, p] = size(f(1).cdata);  % use 1st frame to get dimensions
% hf = figure; 
% % resize figure based on frame's w x h, and place at (150, 150)
% %set(hf, 'position', [150 150 w h]);
% axis off
% movie(hf,f);
% mplay(f)
% 
% %% Save your efforts
% v = VideoWriter(strcat('montage_SCAPE_MIPs.avi'));
% v.FrameRate = 10;
% open(v);
% writeVideo(v,f);
% 
% %half speed
% w = VideoWriter(strcat('slowx2_montage_SCAPE_MIPs.avi'));
% w.FrameRate = 5;
% open(w);
% writeVideo(w,f);
% close(w);
