load fisheriris
%gscatter(X, Y, GRUPO, COR,SIMBOLOS);
%gscatter(meas(:,1), meas(:,2), species,'rgb','osd');
%xlabel('Sepal length');
%ylabel('Sepal width');
%N = size(meas,1);

%LDA
%lda = fitcdiscr(meas(:,1:2),species);
%ldaClass = resubPredict(lda);

%Resubstitution error
%ldaResubErr = resubLoss(lda);

%Matrix de confusão
%[ldaResubCM,grpOrder] = confusionmat(species,ldaClass);


%%%%%%%%%%%%%%%%%%%%
load featureTraining

fileNumber = numel(featureFileNames);
%allocate memory for all the features of each file
features = cell(fileNumber, featureNumber);

%iterate over all files
for fileIndex = 1:fileNumber
    file = fopen(featureFileNames{fileIndex},'r');
    %iterave over all lines(features) of the file
    for featureIndex = 1:featureNumber
        %read all columns(attributes) of each line(feature)
        feature = textscan(file, '%f', attributeNumber);
        features{fileIndex, featureIndex} = feature;
    end
    
    fclose(file);
end

%LDA
%X and Y do not have the same number of observations.
lda = fitcdiscr(features{1,1}{1,1}, emotions);
ldaClass = resubPredict(lda);