wavFilePath = 'D:\Arquivos\EmoDB\wav\';
wavFileExtension = '.wav';

%retrieve all .wav files from path
wavFiles = dir([wavFilePath '*.wav']);

%wavelet transform levels
levels = 10;

%allocate memory for classification vector
fileQuantity = numel(wavFiles);
emotions = cell(fileQuantity,1);
emotions(:) = {''};

%allocate memory for features matrix
features = zeros(fileQuantity, 4 * (levels + 1));


for fileIndex = 1:fileQuantity
    %retrive the fileIndex° name of wavFiles struct
    wavFileName = getfield(wavFiles,{fileIndex}, 'name');
    wavFile = strcat(wavFilePath, wavFileName);
    [signal, sampleRate] = audioread(wavFile);
    
    windowSize = floor(size(signal,1));
    windowIncrement = windowSize;
    
    %extract features using Wavelet Transform
    wavFeatures = getmswtfeat(signal, windowSize, windowIncrement, levels);
    %copy the features extracted for future use
    features(fileIndex,:) = wavFeatures;
    
    %add wav emotion to 'emotions'
    emotions{fileIndex, 1} = extractEmotion(wavFileName);
end

save emotionTraining.mat emotions features;

disp('The training is done!');