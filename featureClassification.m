%wavelet transform levels
levels = [5 10 15 20];
%wavelet families
%haar abd bior3.1 at beyond 10 levels throws and exception
wavelets = {'haar', 'db2', 'db4', 'db6', 'db8', 'db10', 'bior1.5', 'bior2.8', 'bior3.1', 'bior3.9', 'bior6.8', 'coif1', 'coif5'};

%quantity of levels and wavelets
levelQuantity = numel(levels);
waveletQuantity = numel(wavelets);

for waveletIndex = 1:waveletQuantity
    for levelIndex = 1:levelQuantity
        %create name of the training file that will be loaded
        trainingFile = strcat(wavelets{waveletIndex}, '-', int2str(levels(levelIndex)), 'levels.mat');
        
        load(trainingFile)
        
        lda = fitcdiscr(features(:,1:end), emotions);
        ldaClassification = resubPredict(lda);

        resubstituitionError = resubLoss(lda);

        [confusionMatrix, classes] = confusionmat(emotions, ldaClassification);
        
        %create name of the confusion matrix file that will be saved
        confusionMatrixFile = strcat('confusion-matrix-', wavelets{waveletIndex}, '-', int2str(levels(levelIndex)), '-levels.mat');

        save(confusionMatrixFile);
        disp(confusionMatrixFile);
    end
end


%gscatter(features(:,1), features(:,end), emotions,'rgb','osd');
%xlabel('Energy');
%ylabel('Entropy');


