all_train = [trainJazzCeps trainRockCeps trainClassicalCeps; trainJazzC trainRockC trainClassicalC; trainJazzR trainRockR trainClassicalR; trainJazzS trainRockS trainClassicalS; trainJazzE trainRockE trainClassicalE; trainJazzZ trainRockZ trainClassicalZ];
all_labels = [labelJazz labelRock labelClassical];
all_test = [testJazzCeps testRockCeps testClassicalCeps; testJazzC testRockC testClassicalC; testJazzR testRockR testClassicalR; testJazzS testRockS testClassicalS; testJazzE testRockE testClassicalE; testJazzZ testRockZ testClassicalZ];
correct_label = [testlabelJazz testlabelRock testlabelClassical];

k=[1 5 10 15 20];
rateAll = zeros(1,5);
for kk=1:length(k)
    disp(['set-up the kNN... number of neighbors: ',mat2str(k(kk))])
    Mdl = fitcknn(all_train',all_labels','NumNeighbors',k(kk));
    
    % test the kNN
    predicted_label = predict(Mdl,all_test');
    
    % measure the performance
    correct = 0;
    for i=1:length(predicted_label)
        if predicted_label(i)==correct_label(i)
            correct=correct+1;            
        end
    end
    %disp('recognition rate:')
    rateAll(kk) = (correct/length(predicted_label))*100;
end
[a,b]=max(rateAll);
disp('---------- results using All Features ----------------')
disp(['the maximum recognition rate is ',mat2str(a)])
disp(['and it is achieved with ',mat2str(k(b)),' nearest neighbors'])
disp('---------------------------------------------------------')