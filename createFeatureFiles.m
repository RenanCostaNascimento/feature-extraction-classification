wavFilePath = 'C:\Users\20121bsi0252\Downloads\emodb\wav\';
wavFileExtension = '.wav';
featureFilePath = 'C:\Users\20121bsi0252\Downloads\features\';
featureFileExtension = '.txt';

%Happines
fileName1 = dir([wavFilePath '03a01Fa']); %Male
fileName2 = dir([wavFilePath '16b02Fd']); %Female
%Sadness
fileName3 = dir([wavFilePath '03a05Tc']); %Male
fileName4 = dir([wavFilePath '16b10Td']); %Female

% 'fileNames' contains all the wav files names
files = ['03a01Fa'; '16b02Fd'; '03a05Tc'; '16b10Td'];
fileNames = cellstr(files);
fileNumber = numel(fileNames);

%Feature Extraction Parameters
%windowSize = 128;
%windowIncrement = 32;
levels = 10;

%allocate memory
featureFileNames = cell(fileNumber, 1);

for index = 1:fileNumber
    wavFile = strcat(wavFilePath, [fileNames{index}], wavFileExtension);
    [signal, sampleRate] = audioread(wavFile);
    windowSize = floor(size(signal,1)/2);
    windowIncrement = windowSize;
    
    %Wavelet Transform
    features = getmswtfeat(signal, windowSize, windowIncrement, levels);
    %PCA selection
    featureSelection = pca(features);
    coff = pca(ingredients);
    
    %Create file to write features
    featureFileName = strcat(featureFilePath, [fileNames{index}], featureFileExtension);
    featureFile = fopen(featureFileName, 'wt');
    
    %Write each column of 'featureSelection' in a line of the file.
    [lineSize, columnSize] = size(featureSelection);
    for fileLine = 1:columnSize;
        fprintf(featureFile, '%g\t', featureSelection(:,columnSize));
        fprintf(featureFile,'\n');
    end
    
    fclose(featureFile);
    
    featureFileNames{index} = featureFileName;
end

%Strings inside emotion array must be the same size.
emotionArray = ['happiness';'happiness';'sadness  ';'sadness  '];
emotions = cellstr(emotionArray);

[attributeNumber, featureNumber] = size(featureSelection);

save featureTraining.mat emotions featureFileNames attributeNumber featureNumber;

disp('done!');

%featTransformSample = getmswtfeat(rand(1024,1),winsize, wininc, levels);
%selectionTransformSample = pca (featTransformSample);