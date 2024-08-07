%% Complete matrix just one example
% % Define the file name
% filename = 'Report1.txt';
% 
% % Read the file content
% fileContent = fileread(filename);
% 
% % Split the file content into lines
% lines = strsplit(fileContent, '\n');
% 
% % Initialize an empty matrix to store the data
% LLSat1 = [];
% 
% % Loop through each line starting from the second line
% for i = 2:length(lines)
%     % Extract the current data line
%     dataLine = lines{i};
%     
%     % Split the data line into individual values
%     dataValues = strsplit(dataLine, ' ');
%     
%     % Convert the cell array of strings to a numeric array
%     numericValues = cellfun(@str2num, dataValues, 'UniformOutput', false);
%     numericValues = cell2mat(numericValues);
%     
%     % Append the numeric values to the LLSat1 matrix
%     LLSat1 = [LLSat1; numericValues];
% end
% 
% % Display the matrix
% %disp(dataMatrix);

%% Complete code
clear all 
close all

%For Satellite 1
% Define the file name
filename = 'Report1.txt';

% Read the file content
fileContent = fileread(filename);

% Split the file content into lines
lines = strsplit(fileContent, '\n');

% Initialize an empty matrix to store the data
LLSat1 = [];

% Loop through each line starting from the second line
for i = 2:length(lines)
    % Extract the current data line
    dataLine = lines{i};
    
    % Split the data line into individual values
    dataValues = strsplit(dataLine, ' ');
    
    % Convert the cell array of strings to a numeric array
    numericValues = cellfun(@str2num, dataValues, 'UniformOutput', false);
    numericValues = cell2mat(numericValues);
    
    % Append the numeric values to the LLSat1 matrix
    LLSat1 = [LLSat1; numericValues];
end

% Initialize an empty matrix for the filtered data
filteredMatrix1 = [];

% Loop through each row in the LLSat1 matrix
for i = 1:size(LLSat1, 1)
    % Check if the seventh column in the current row is greater than 0
    if LLSat1(i, 7) > 0
        % Append the selected columns (1, 5, 6, 7) to the filteredMatrix
        filteredMatrix1 = [filteredMatrix1; LLSat1(i, [1, 5, 6, 7])];
    end
end

% Display the filtered matrix
%disp(filteredMatrix);


% Initialize an empty matrix for the spherical coordinates
sphericalCoordinates1 = [];

% Loop through each row in the filteredMatrix
for i = 1:size(filteredMatrix1, 1)
    % Extract the cartesian coordinates (rows 2, 3, 4)
    u = filteredMatrix1(i, 2:4);
    
    % Convert the cartesian coordinates to spherical coordinates
    [phi_theta_r] = cart2spherical2(u);
    
    % Append the spherical coordinates to the sphericalCoordinates matrix
    sphericalCoordinates1 = [sphericalCoordinates1; phi_theta_r'];
end

% Define the start date
startDate1 = datetime('01-Aug-2025 09:10:00.000');

% Initialize an empty array for the dates
dates1 = NaT(size(filteredMatrix1, 1), 1);

% Loop through each row in the filteredMatrix
for i = 1:size(filteredMatrix1, 1)
    % Calculate the date by adding the fraction of the day to the start date
    dates1(i) = startDate1 + days(filteredMatrix1(i, 1));
end

% Combine the dates with the spherical coordinates
%resultMatrix = [dates, sphericalCoordinates];




%For Satellite 2
% Define the file name
filename2 = 'Report2.txt';

% Read the file content
fileContent2 = fileread(filename2);

% Split the file content into lines
lines2 = strsplit(fileContent2, '\n');

% Initialize an empty matrix to store the data
LLSat2 = [];

% Loop through each line starting from the second line
for i = 2:length(lines2)
    % Extract the current data line
    dataLine2 = lines2{i};
    
    % Split the data line into individual values
    dataValues2 = strsplit(dataLine2, ' ');
    
    % Convert the cell array of strings to a numeric array
    numericValues2 = cellfun(@str2num, dataValues2, 'UniformOutput', false);
    numericValues2 = cell2mat(numericValues2);
    
    % Append the numeric values to the LLSat1 matrix
    LLSat2 = [LLSat2; numericValues2];
end

% Initialize an empty matrix for the filtered data
filteredMatrix2 = [];

% Loop through each row in the LLSat1 matrix
for i = 1:size(LLSat2, 1)
    % Check if the seventh column in the current row is greater than 0
    if LLSat2(i, 7) > 0
        % Append the selected columns (1, 5, 6, 7) to the filteredMatrix
        filteredMatrix2 = [filteredMatrix2; LLSat2(i, [1, 5, 6, 7])];
    end
end

% Display the filtered matrix
%disp(filteredMatrix);


% Initialize an empty matrix for the spherical coordinates
sphericalCoordinates2 = [];

% Loop through each row in the filteredMatrix
for i = 1:size(filteredMatrix2, 1)
    % Extract the cartesian coordinates (rows 2, 3, 4)
    u = filteredMatrix2(i, 2:4);
    
    % Convert the cartesian coordinates to spherical coordinates
    [phi_theta_r] = cart2spherical2(u);
    
    % Append the spherical coordinates to the sphericalCoordinates matrix
    sphericalCoordinates2 = [sphericalCoordinates2; phi_theta_r'];
end

% Define the start date
startDate2 = datetime('01-Aug-2025 09:10:00.000');

% Initialize an empty array for the dates
dates2 = NaT(size(filteredMatrix2, 1), 1);

% Loop through each row in the filteredMatrix
for i = 1:size(filteredMatrix2, 1)
    % Calculate the date by adding the fraction of the day to the start date
    dates2(i) = startDate2 + days(filteredMatrix2(i, 1));
end
%% For example, first pass:
%sat1
az1=sphericalCoordinates1(1:6,1);
el1=sphericalCoordinates1(1:6,2);
%sat2
az2=sphericalCoordinates2(1:6,1);
el2=sphericalCoordinates2(1:6,2);
az = [az1;az2];
el = [el1;el2];
groups = categorical([0 0 0 0 0 0 1 1 1 1 1 1], [0 1], ["Propagation 1", "Propagation 2"]);
%skyplot(az1,el1)
skyplot([az1;az2], [el1;el2], "GroupData", groups)
legend


%% For example, next day pass:
%sat1
az1=sphericalCoordinates1(34:39,1);
el1=sphericalCoordinates1(34:39,2);
%sat2
az2=sphericalCoordinates2(34:39,1);
el2=sphericalCoordinates2(34:39,2);
az = [az1;az2];
el = [el1;el2];
groups = categorical([0 0 0 0 0 0 1 1 1 1 1 1], [0 1], ["Propagation 1", "Propagation 2"]);
%skyplot(az1,el1)
skyplot([az1;az2], [el1;el2], "GroupData", groups)
legend

%% For example, 3rd day pass:
%sat1
az1=sphericalCoordinates1(81:86,1);
el1=sphericalCoordinates1(81:86,2);
%sat2
az2=sphericalCoordinates2(81:86,1);
el2=sphericalCoordinates2(81:86,2);
az = [az1;az2];
el = [el1;el2];
groups = categorical([0 0 0 0 0 0 1 1 1 1 1 1], [0 1], ["Propagation 1", "Propagation 2"]);
%skyplot(az1,el1)
skyplot([az1;az2], [el1;el2], "GroupData", groups)
legend


% skyplot([az1;az2],[el1;el2])
% 
%         az = [10 20 120 255];
%         el = [52 10 44 87];
%         labels = ["G1", "G22", "E17", "E11"];
%         groups = categorical([0 0 1 1], [0 1], ["GPS", "Galileo"]);
%         skyplot(az, el, labels, "GroupData", groups)
%         legend


%% New plots
clear all 
close all

%For Satellite 1
% Define the file name
filename = 'rep_vis01.txt';

% Read the file content
fileContent = fileread(filename);

% Split the file content into lines
lines = strsplit(fileContent, '\n');

% Initialize an empty matrix to store the data
LLSat = [];

% Loop through each line starting from the second line
for i = 2:length(lines)
    % Extract the current data line
    dataLine = lines{i};
    
    % Split the data line into individual values
    dataValues = strsplit(dataLine, ' ');
    
    % Convert the cell array of strings to a numeric array
    numericValues = cellfun(@str2num, dataValues, 'UniformOutput', false);
    numericValues = cell2mat(numericValues);
    
    % Append the numeric values to the LLSat1 matrix
    LLSat = [LLSat; numericValues];
end

%% PLOTS ALTITUDE
figure()
set(gcf,'color','w');
subplot(2,1,1)
plot(LLSat(:,1)*24,LLSat(:,2)-6378)
hold on
plot(LLSat(:,1)*24,LLSat(:,3)-6378)
%plot(LLSat(:,1)*24,LLSat(:,3)-6378,'-kx','MarkerEdgeColor','blue','MarkerSize',12)
%plot(LLSat1(240944,1),LLSat1(240944,2)-6378,'-kx','MarkerEdgeColor','green','MarkerSize',12)
grid on
legend('133 sfu, kp=3','147 sfu, kp=3')
title('Satellite mean Altitude, Brouwer-Lyddane mean elements')
ylabel('Mean altitude (km)')
xlabel('Propagation time (hours)')
subplot(2,1,2)
plot(LLSat(:,1)*24,LLSat(:,2)-6378)
hold on
plot(LLSat(:,1)*24,LLSat(:,4)-6378)
%plot(LLSat(:,1)*24,LLSat(:,3)-6378,'-kx','MarkerEdgeColor','blue','MarkerSize',12)
%plot(LLSat1(240944,1),LLSat1(240944,2)-6378,'-kx','MarkerEdgeColor','green','MarkerSize',12)
grid on
legend('5 degree attitude error','S/C tumbling')
legend('Location','northeast')
%title('Satellite mean Altitude')
ylabel('Mean altitude (km)')
xlabel('Propagation time (hours)')


%Plot of difference
figure()
set(gcf,'color','w');
subplot(2,1,1)
plot(LLSat(:,1)*24,LLSat(:,2)-LLSat(:,3))
hold on
grid on
legend('Different solar flux')
legend('Location','northwest')
title('Satellite mean Altitude Difference, Brouwer-Lyddane mean elements')
ylabel('Mean altitude difference (km)')
xlabel('Propagation time (hours)')
subplot(2,1,2)
plot(LLSat(:,1)*24,LLSat(:,2)-LLSat(:,4))
hold on
grid on
legend('Different attitude')
legend('Location','northwest')
ylabel('Mean altitude difference (km)')
xlabel('Propagation time (hours)')

%% %% To PLOT ACCESS POINTS
clear all 
close all

%For Satellite 1
% Define the file name
filename = 'report_vis_01.txt';

% Read the file content
fileContent = fileread(filename);

% Split the file content into lines
lines = strsplit(fileContent, '\n');

% Initialize an empty matrix to store the data
LLSat = [];

% Loop through each line starting from the second line
for i = 2:length(lines)
    % Extract the current data line
    dataLine = lines{i};
    
    % Split the data line into individual values
    dataValues = strsplit(dataLine, ' ');
    
    % Convert the cell array of strings to a numeric array
    numericValues = cellfun(@str2num, dataValues, 'UniformOutput', false);
    numericValues = cell2mat(numericValues);
    
    % Append the numeric values to the LLSat1 matrix
    LLSat = [LLSat; numericValues];
end
%% DATA for first sat, low flux, low drag surface
% Initialize an empty matrix for the filtered data
filteredMatrix1 = [];

% Loop through each row in the LLSat1 matrix
for i = 1:size(LLSat, 1)
    % Check if the seventh column in the current row is greater than 0
    if LLSat(i, 4) > 0
        % Append the selected columns (1, 5, 6, 7) to the filteredMatrix
        filteredMatrix1 = [filteredMatrix1; LLSat(i, [1, 2, 3, 4])];
    end
end

% Display the filtered matrix
%disp(filteredMatrix);


% Initialize an empty matrix for the spherical coordinates
sphericalCoordinates1 = [];

% Loop through each row in the filteredMatrix
for i = 1:size(filteredMatrix1, 1)
    % Extract the cartesian coordinates (rows 2, 3, 4)
    u = filteredMatrix1(i, 2:4);
    
    % Convert the cartesian coordinates to spherical coordinates
    [phi_theta_r] = cart2spherical2(u);
    
    % Append the spherical coordinates to the sphericalCoordinates matrix
    sphericalCoordinates1 = [sphericalCoordinates1; phi_theta_r'];
end

% Define the start date
startDate1 = datetime('15-Jan-2026 10:00:00.000');

% Initialize an empty array for the dates
dates1 = NaT(size(filteredMatrix1, 1), 1);

% Loop through each row in the filteredMatrix
for i = 1:size(filteredMatrix1, 1)
    % Calculate the date by adding the fraction of the day to the start date
    dates1(i) = startDate1 + days(filteredMatrix1(i, 1));
end

% Combine the dates with the spherical coordinates
%resultMatrix = [dates, sphericalCoordinates];

%% DATA for fifth sat, high flux, high drag surface
% Initialize an empty matrix for the filtered data
filteredMatrix5 = [];

% Loop through each row in the LLSat1 matrix
for i = 1:size(LLSat, 1)
    % Check if the seventh column in the current row is greater than 0
    if LLSat(i, 16) > 0
        % Append the selected columns (1, 5, 6, 7) to the filteredMatrix
        filteredMatrix5 = [filteredMatrix5; LLSat(i, [1, 14, 15, 16])];
    end
end

% Initialize an empty matrix for the spherical coordinates
sphericalCoordinates5 = [];

% Loop through each row in the filteredMatrix
for i = 1:size(filteredMatrix5, 1)
    % Extract the cartesian coordinates (rows 14, 15, 16 -> 2, 3, 4)
    u = filteredMatrix5(i, 2:4);
    
    % Convert the cartesian coordinates to spherical coordinates
    [phi_theta_r] = cart2spherical2(u);
    
    % Append the spherical coordinates to the sphericalCoordinates matrix
    sphericalCoordinates5 = [sphericalCoordinates5; phi_theta_r'];
end

% Define the start date
startDate1 = datetime('15-Jan-2026 10:00:00.000');
% Initialize an empty array for the dates
dates5 = NaT(size(filteredMatrix5, 1), 1);
% Loop through each row in the filteredMatrix
for i = 1:size(filteredMatrix5, 1)
    % Calculate the date by adding the fraction of the day to the start date
    dates5(i) = startDate1 + days(filteredMatrix5(i, 1));
end

%% PLOTS VISIBILITY
% plot(dates1,1,'.')
% hold on
% plot(dates5,2,'.')

startDate = datetime('15-Jan-2026 10:00:00.000');
dates = NaT(size(LLSat, 1), 1);
% Loop through each row in the filteredMatrix
for i = 1:size(dates, 1)
    % Calculate the date by adding the fraction of the day to the start date
    dates(i) = startDate + days(LLSat(i, 1));
end

%vis1 
vis1 = [];
% Loop through each row in the LLSat1 matrix
for i = 1:size(LLSat, 1)
    % Check if the seventh column in the current row is greater than 0
    if LLSat(i, 4) > 0
        % Append the selected columns (1, 5, 6, 7) to the filteredMatrix
        vis1(i,1) = 1;
    else
        vis1(i,1) = 0;
    end
end

%vis5
vis5 = [];
% Loop through each row in the LLSat1 matrix
for i = 1:size(LLSat, 1)
    % Check if the seventh column in the current row is greater than 0
    if LLSat(i, 16) > 0
        % Append the selected columns (1, 5, 6, 7) to the filteredMatrix
        vis5(i,1) = 1.1;
    else
        vis5(i,1) = 0.1;
    end
end

figure()
plot(dates,vis1)
hold on
plot(dates,vis5)
%% PLOTS AZIMUTH ELEVATION
%For example, first pass:
figure()
%sat1
az1=sphericalCoordinates1(1:9,1);
el1=sphericalCoordinates1(1:9,2);
%sat2
az2=sphericalCoordinates5(1:9,1);
el2=sphericalCoordinates5(1:9,2);
az = [az1;az2];
el = [el1;el2];
groups = categorical([0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1], [0 1], ["Propagation 1", "Propagation 5"]);
%skyplot(az1,el1)
skyplot([az1;az2], [el1;el2], "GroupData", groups)
legend

%% PLOTS AZIMUTH ELEVATION
%For example, last pass of the day:
figure()
%sat1
az1=sphericalCoordinates1(41:49,1);
el1=sphericalCoordinates1(41:49,2);
%sat2
az2=sphericalCoordinates5(41:49,1);
el2=sphericalCoordinates5(41:49,2);
az = [az1;az2];
el = [el1;el2];
%groups = categorical([0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1], [0 1], ["Propagation 1", "Propagation 5"]);
groups = categorical([zeros(1,length(az1)), ones(1,length(az1))], [0 1], ["Propagation 1", "Propagation 5"]);
%skyplot(az1,el1)
skyplot([az1;az2], [el1;el2], "GroupData", groups)
legend

figure()
plot(dates1(41:49),az1)
hold on
plot(dates5(41:49),az2)
plot(dates1(41:49),el1)
plot(dates5(41:49),el2)

%% New plots PART III
clear all 
close all

%For Satellite 1
% Define the file name
filename = 'report_vis_02.txt';

% Read the file content
fileContent = fileread(filename);

% Split the file content into lines
lines = strsplit(fileContent, '\n');

% Initialize an empty matrix to store the data
LLSat = [];

% Loop through each line starting from the second line
for i = 2:length(lines)
    % Extract the current data line
    dataLine = lines{i};
    
    % Split the data line into individual values
    dataValues = strsplit(dataLine, ' ');
    
    % Convert the cell array of strings to a numeric array
    numericValues = cellfun(@str2num, dataValues, 'UniformOutput', false);
    numericValues = cell2mat(numericValues);
    
    % Append the numeric values to the LLSat1 matrix
    LLSat = [LLSat; numericValues];
end
%% PLOTS VISIBILITY NOT IMPORTANT
% plot(dates1,1,'.')
% hold on
% plot(dates5,2,'.')

startDate = datetime('15-Jan-2026 10:00:00.000');
dates = NaT(size(LLSat, 1), 1);
% Loop through each row in the filteredMatrix
for i = 1:size(dates, 1)
    % Calculate the date by adding the fraction of the day to the start date
    dates(i) = startDate + days(LLSat(i, 1));
end

%vis1 
vis1 = [];
% Loop through each row in the LLSat1 matrix
for i = 1:size(LLSat, 1)
    % Check if the seventh column in the current row is greater than 0
    if LLSat(i, 4) > 0
        % Append the selected columns (1, 5, 6, 7) to the filteredMatrix
        vis1(i,1) = 1;
    else
        vis1(i,1) = 0;
    end
end

%vis5
vis5 = [];
% Loop through each row in the LLSat1 matrix
for i = 1:size(LLSat, 1)
    % Check if the seventh column in the current row is greater than 0
    if LLSat(i, 7) > 0
        % Append the selected columns (1, 5, 6, 7) to the filteredMatrix
        vis5(i,1) = 1.1;
    else
        vis5(i,1) = 0.1;
    end
end

figure()
plot(dates,vis1)
hold on
plot(dates,vis5)

%% DATA for first sat, low flux, low drag surface
% Initialize an empty matrix for the filtered data
filteredMatrix1 = LLSat(12860:12962, 1:4);
%filteredMatrix1 = LLSat(11754:11831, 1:4);

% Initialize an empty matrix for the spherical coordinates
sphericalCoordinates1 = [];

% Loop through each row in the filteredMatrix
for i = 1:size(filteredMatrix1, 1)
    % Extract the cartesian coordinates (rows 2, 3, 4)
    u = filteredMatrix1(i, 2:4);
    
    % Convert the cartesian coordinates to spherical coordinates
    [phi_theta_r] = cart2spherical2(u);
    
    % Append the spherical coordinates to the sphericalCoordinates matrix
    % output is azimuth, elevation, distance
    sphericalCoordinates1 = [sphericalCoordinates1; phi_theta_r'];
end

% Define the start date
startDate1 = datetime('15-Jan-2026 10:00:00.000');
% Initialize an empty array for the dates
dates1 = NaT(size(filteredMatrix1, 1), 1);
% Loop through each row in the filteredMatrix
for i = 1:size(filteredMatrix1, 1)
    % Calculate the date by adding the fraction of the day to the start date
    dates1(i) = startDate1 + days(filteredMatrix1(i, 1));
end
% Combine the dates with the spherical coordinates
%resultMatrix = [dates, sphericalCoordinates];

%% DATA for fifth sat, high flux, high drag surface
% Initialize an empty matrix for the filtered data
filteredMatrix2 = LLSat(12860:12962, [1, 5:7]);
%filteredMatrix2 = LLSat(11754:11831, [1, 5:7]);
% Initialize an empty matrix for the spherical coordinates
sphericalCoordinates2 = [];

% Loop through each row in the filteredMatrix
for i = 1:size(filteredMatrix2, 1)
    % Extract the cartesian coordinates (rows 14, 15, 16 -> 2, 3, 4)
    u = filteredMatrix2(i, 2:4);
    % Convert the cartesian coordinates to spherical coordinates
    [phi_theta_r] = cart2spherical2(u);
    % Append the spherical coordinates to the sphericalCoordinates matrix
    % output is a row (1x3): azimuth, elevation and distance.
    sphericalCoordinates2 = [sphericalCoordinates2; phi_theta_r'];
end

% Define the start date
startDate1 = datetime('15-Jan-2026 10:00:00.000');
% Initialize an empty array for the dates
dates2 = NaT(size(filteredMatrix2, 1), 1);
% Loop through each row in the filteredMatrix
for i = 1:size(filteredMatrix2, 1)
    % Calculate the date by adding the fraction of the day to the start date
    dates2(i) = startDate1 + days(filteredMatrix2(i, 1));
end
%% calculate distance between points on a sphere
%[arclen,az] = distance(lat1,lon1,lat2,lon2)
%calculates the arc length arclen and azimuth az of the great circle arc 
% from the starting point with coordinates lat1 and lon1 to the ending 
% point with coordinates lat2 and lon2. The function uses the shorter 
% (minor) great circle arc. This syntax references the coordinates to a 
% sphere and returns arclen and az as spherical distances in degrees.
[arclen,az] = distance(sphericalCoordinates1(:,2),sphericalCoordinates1(:,1),sphericalCoordinates2(:,2),sphericalCoordinates2(:,1));
 
figure()
set(gcf,'color','w');
plot(dates1,arclen)
hold on
grid on
legend('Arc length distance in degrees')
legend('Location','northeast')
title('Separation between two propagations w. 2 sec. difference in a pass')
ylabel('Arc-length distance (degrees)')
xlabel('Time (UTC)')
set(gcf,'position',[250,100,800,300])
%saved1=sphericalCoordinates1;
figure()
set(gcf,'color','w');
plot(saved1(:,2))
hold on
grid on
plot(sphericalCoordinates2(:,2))
legend('Elevation 1st pass','Elevation 2nd pass')
legend('Location','northeast')
title('Elevation for 2 passes after 16hs no contact')
ylabel('Elevation (degrees)')
xlabel('Time')
set(gcf,'position',[250,100,800,300])