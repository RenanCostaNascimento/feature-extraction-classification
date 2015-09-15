load bior1.5-20levels.mat

%gscatter(features(:,1), features(:,end), emotions,'rgb','osd');
%xlabel('Energy');
%ylabel('Entropy');

lda = fitcdiscr(features(:,1:end), emotions);
ldaClassification = resubPredict(lda);

resubstituitionError = resubLoss(lda);

[confusionMatrix, classes] = confusionmat(emotions, ldaClassification);

disp('The classification is done!');
