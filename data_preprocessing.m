clc; clear all; close all;
D = importdata('simple_multi_dataset.csv');
D = D(2:numel(D));

N = numel(D); % get number of data entries

%% Extracting vectors of IMU Measurements from the Data
% Each row of the vector features represents a measurement made by an IMU.
% Each entry in labels represents the label for the corresponding features.

split_data = strings(N,10);
labels = strings(N,1);
features = zeros(N,9);
data = strings(N,1);
for idx = 1:N
    data(idx) = cell2mat(D(idx)); % convert row into a string
    data(idx) = char(data(idx)); % convert that string into a char array
    % Now process the row using the comma as a delimiter
    d = data(idx);
    d = char(d);
    data(idx) = d(31:numel(d));
    split_data(idx,:) = strsplit(data(idx),',');
    
    % Separate labels from features
    labels(idx) = split_data(idx,10);
    features(idx,:) = split_data(idx,1:9);
end

seq = zeros(N,1);
for idx = 1:N
    seq(idx) = norm(features(idx,:));
end

[idx_paddling,val_paddling] = find(labels=='PADDLING');
[idx_floating,val_floating] = find(labels=='FLOATING');
[idx_surfing,val_surfing] = find(labels=='SURFING');

paddling_IMU = zeros(numel(idx_paddling),9);
floating_IMU = zeros(numel(idx_floating),9);
surfing_IMU = zeros(numel(idx_surfing),9);

for k = 1:numel(idx_paddling)
    paddling_IMU(k,:) = features(idx_paddling(k),:);
end

for k = 1:numel(idx_floating)
    floating_IMU(k,:) = features(idx_floating(k),:);
end

for k = 1:numel(idx_surfing)
    surfing_IMU(k,:) = features(idx_surfing(k),:);
end

% Visualize data
figure;
scatter3(paddling_IMU(:,1),paddling_IMU(:,2),paddling_IMU(:,3), 'r*')
hold on;
scatter3(floating_IMU(:,1),floating_IMU(:,2),floating_IMU(:,3),'go')
scatter3(surfing_IMU(:,1),surfing_IMU(:,2),surfing_IMU(:,3),'b*')
title('IMU: A1, A2, A3');
xlabel('A1'); ylabel('A2'); zlabel('A3');
hold off;

figure;
scatter3(paddling_IMU(:,4),paddling_IMU(:,5),paddling_IMU(:,6), 'r*')
hold on;
scatter3(floating_IMU(:,4),floating_IMU(:,5),floating_IMU(:,6),'go')
scatter3(surfing_IMU(:,4),surfing_IMU(:,5),surfing_IMU(:,6),'b*')
title('IMU: G1, G2, G3');
xlabel('G1'); ylabel('G2'); zlabel('G3');
hold off;

figure;
scatter3(paddling_IMU(:,7),paddling_IMU(:,8),paddling_IMU(:,9), 'r*')
hold on;
scatter3(floating_IMU(:,7),floating_IMU(:,8),floating_IMU(:,9),'go')
scatter3(surfing_IMU(:,7),surfing_IMU(:,8),surfing_IMU(:,9),'b*')
title('IMU: M1, M2, M3');
xlabel('M1'); ylabel('M2'); zlabel('M3');
hold off;