load("ensembleSinuMigChute1.mat")
load("ensembleSinuMigChute2.mat")
load("ensembleSinuMigNeck1.mat")
load("ensembleSinuMigNeck2.mat")

data1 = allDataNeckSinu;  % replace with your first dataset
data2 = allDataChuteSinu; % replace with your second dataset

nBins      = 200;      % number of value bins
alphaScale = 0.5;      % overall opacity (0=transparent, 1=opaque)

% --- Prepare bins from global range ---
allData  = [data1(:); data2(:)];
xEdges   = linspace(min(allData), max(allData), nBins);
xCenters = (xEdges(1:end-1) + xEdges(2:end)) / 2;

% --- Compute density maps ---
density1 = zeros(size(data1,1), length(xCenters));
density2 = zeros(size(data2,1), length(xCenters));

for t = 1:size(data1,1)
    c1 = histcounts(data1(t,:), xEdges, 'Normalization','pdf');
    c2 = histcounts(data2(t,:), xEdges, 'Normalization','pdf');
    density1(t,:) = smoothdata(c1,'gaussian',5);
    density2(t,:) = smoothdata(c2,'gaussian',5);
end

% Normalize per row
density1 = density1 ./ max(density1,[],2);
density2 = density2 ./ max(density2,[],2);

% --- Subplot ---
subplot(3,1,1);
ax = gca;

% Convert density maps into RGB images directly
blueRGB  = cat(3, zeros(size(density1')), zeros(size(density1')), ones(size(density1')));
greenRGB = cat(3, zeros(size(density2')), ones(size(density2')), zeros(size(density2')));

% Plot blue heatmap
h1 = imagesc(ax, 1:size(data1,1), xCenters, blueRGB);
set(h1,'AlphaData', density1' * alphaScale);

hold on
% Overlay green heatmap
h2 = imagesc(ax, 1:size(data2,1), xCenters, greenRGB);
set(h2,'AlphaData', density2' * alphaScale);

% Overlay ensemble means
plot(1:size(data1,1), mean(data1,2,'omitnan'), '-','color',[0 0 0.7], 'LineWidth', 2.5);
plot(1:size(data2,1), mean(data2,2,'omitnan'), '-','color',[0 0.7 0], 'LineWidth', 2.5);
hold off

axis xy
xlabel('time')
ylabel('sinuosity')
ylim([1 5])

%% plot migration rate
data1 = allDataNeckMig;  % replace with your first dataset
data2 = allDataChuteMig; % replace with your second dataset

nBins      = 200;      % number of value bins
alphaScale = 0.5;      % overall opacity (0=transparent, 1=opaque)

% --- Prepare bins from global range ---
allData  = [data1(:); data2(:)];
xEdges   = linspace(min(allData), max(allData), nBins);
xCenters = (xEdges(1:end-1) + xEdges(2:end)) / 2;

% --- Compute density maps ---
density1 = zeros(size(data1,1), length(xCenters));
density2 = zeros(size(data2,1), length(xCenters));

for t = 1:size(data1,1)
    c1 = histcounts(data1(t,:), xEdges, 'Normalization','pdf');
    c2 = histcounts(data2(t,:), xEdges, 'Normalization','pdf');
    density1(t,:) = smoothdata(c1,'gaussian',5);
    density2(t,:) = smoothdata(c2,'gaussian',5);
end

% Normalize per row
density1 = density1 ./ max(density1,[],2);
density2 = density2 ./ max(density2,[],2);

% --- Subplot ---
subplot(3,1,2);
ax = gca;

% Convert density maps into RGB images directly
blueRGB  = cat(3, zeros(size(density1')), zeros(size(density1')), ones(size(density1')));
greenRGB = cat(3, zeros(size(density2')), ones(size(density2')), zeros(size(density2')));

% Plot blue heatmap
h1 = imagesc(ax, 1:size(data1,1), xCenters, blueRGB);
set(h1,'AlphaData', density1' * alphaScale);

hold on
% Overlay green heatmap
h2 = imagesc(ax, 1:size(data2,1), xCenters, greenRGB);
set(h2,'AlphaData', density2' * alphaScale);

% Overlay ensemble means
plot(1:size(data1,1), mean(data1,2,'omitnan'), '-','color',[0 0 0.7], 'LineWidth', 2.5);
plot(1:size(data2,1), mean(data2,2,'omitnan'), '-','color',[0 0.7 0], 'LineWidth', 2.5);
hold off

axis xy
xlabel('time')
ylabel('migration rate (m/day)')
ylim([0 1.2])

%% --- Load and preprocess NECK group ---
files = {'neck_width-0','neck_width-1','neck_width-2'...,
    'neck_width-3','neck_width-4'};
mergedData1 = [];
for i = 1:numel(files)
    S = load(files{i});
    fn = fieldnames(S);
    data = S.(fn{1});
    data = [data.MeanHeight];
    mergedData1 = [mergedData1,data];
end
Bcb = mergedData1';% load("widthNeck.mat");
% Bcb = results(:,3);
% Bcb = cell2mat(Bcb);
Bcb = reshape(Bcb,[199,500]);
Bcb(Bcb>500) = nan;

data1 = Bcb;  % rename for consistency

data1 = Bcb * (10/480);   % 🔹 scale values
%% --- Load and preprocess CHUTE group ---
files = {'chute_width-0','chute_width-1','chute_width-2'...,
    'chute_width-3','chute_width-4'};
mergedData2 = [];
for i = 1:numel(files)
    S = load(files{i});
    fn = fieldnames(S);
    data = S.(fn{1});
    data = [data.MeanHeight];
    mergedData2 = [mergedData2,data];
end
Bcb = mergedData2';
% load("widthChute.mat");
% Bcb = results(:,3);
% Bcb = cell2mat(Bcb);
Bcb = reshape(Bcb,[199,500]);
Bcb(Bcb>500) = nan;

data2 = Bcb;
data2 = Bcb* (10/480);   % 🔹 scale values;

%% --- Parameters ---
nBins      = 200;      % number of value bins
alphaScale = 0.6;      % transparency level

% --- Prepare global bins ---
allData  = [data1(:); data2(:)];
xEdges   = linspace(min(allData,[],'omitnan'), max(allData,[],'omitnan'), nBins);
xCenters = (xEdges(1:end-1) + xEdges(2:end)) / 2;

% --- Compute density maps per time step ---
density1 = zeros(size(data1,1), length(xCenters));
density2 = zeros(size(data2,1), length(xCenters));

for t = 1:size(data1,1)
    c1 = histcounts(data1(t,:), xEdges, 'Normalization','pdf');
    c2 = histcounts(data2(t,:), xEdges, 'Normalization','pdf');
    density1(t,:) = smoothdata(c1,'gaussian',5);
    density2(t,:) = smoothdata(c2,'gaussian',5);
end

% Normalize per row (so each time step has max = 1)
density1 = density1 ./ max(density1,[],2);
density2 = density2 ./ max(density2,[],2);

%% --- Plot ---
subplot(3,1,3); hold on
ax = gca;

% Build RGB layers
blueRGB  = cat(3, zeros(size(density1')), zeros(size(density1')), ones(size(density1')));  % blue
greenRGB = cat(3, zeros(size(density2')), ones(size(density2')), zeros(size(density2')));  % green

% Blue heatmap (Neck)
h1 = imagesc(ax, 1:size(data1,1), xCenters, blueRGB);
set(h1,'AlphaData', density1' * alphaScale);

% Green heatmap (Chute)
h2 = imagesc(ax, 1:size(data2,1), xCenters, greenRGB);
set(h2,'AlphaData', density2' * alphaScale);

% Overlay ensemble means
plot(1:size(data1,1), mean(data1,2,'omitnan'), '-', 'Color',[0 0 0.7], 'LineWidth',2.5);
plot(1:size(data2,1), mean(data2,2,'omitnan'), '-', 'Color',[0 0.7 0], 'LineWidth',2.5);

axis xy
xlabel('Time');
ylabel('Channel belt width (km)');
% title('Neck (Blue) vs Chute (Green)');
box on
legend({'Neck','Chute'}, 'Location','northwest');
