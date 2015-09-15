%file's paths and extension
wavFilePath = 'D:\Arquivos\EmoDB\wav\';
wavFileExtension = '.wav';

%retrieve all .wav files from path
wavFiles = dir([wavFilePath '*.wav']);

%wavelet transform levels
levels = [5 10 15 20];
%wavelet families
wavelets = {'haar', 'db2', 'db4', 'db6', 'db8', 'db10', 'bior1.5', 'bior2.8', 'bior3.1', 'bior3.9', 'bior6.8', 'coif1', 'coif5'};

%quantity of files, levels and wavelets
fileQuantity = numel(wavFiles);
levelQuantity = numel(levels);
waveletQuantity = numel(wavelets);

%allocate memory for classification vector
emotions = cell(fileQuantity,1);
emotions(:) = {''};

for fileIndex = 1:fileQuantity
    %add wav emotion to 'emotions'
    wavFileName = getfield(wavFiles,{fileIndex}, 'name');
    emotions{fileIndex, 1} = extractEmotion(wavFileName); 
end

for waveletIndex = 1:waveletQuantity
    for levelIndex = 1:levelQuantity
        %allocate memory for features matrix
        features = zeros(fileQuantity, 4 * (levels(levelIndex) + 1));
        
        %create name of the training file that will be saved
        trainingFile = strcat(wavelets{waveletIndex}, '-', int2str(levels(levelIndex)), 'levels.mat');
        for fileIndex = 1:fileQuantity
            %retrive the fileIndex° name of wavFiles struct
            wavFileName = getfield(wavFiles,{fileIndex}, 'name');
            wavFile = strcat(wavFilePath, wavFileName);
            [signal, sampleRate] = audioread(wavFile);

            windowSize = floor(size(signal,1));
            windowIncrement = windowSize;
            
            %extract features using Wavelet Transform
            wavFeatures = getmswtfeat(signal, windowSize, windowIncrement, levels(levelIndex), wavelets{waveletIndex});
            %copy the features extracted for future use
            features(fileIndex,:) = wavFeatures;    
        end
        save(trainingFile, 'emotions', 'features');
        disp(strcat(trainingFile, ' created.'));
    end
end