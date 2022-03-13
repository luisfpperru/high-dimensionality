% KNN experiments

clear all; clc ; close all;

k = 1:2:15;
filename = 'SmartphoneRecog';
embbed_dataset = load(['datasets/normalized/',filename,'.csv']);
intrinsic_dataset = load(['datasets/supervised/',filename,'_naive.csv']);
performance_embbed = datasetClassify(embbed_dataset,k);
performance_intrinsic = datasetClassify(intrinsic_dataset,k);
figure
plot(k,performance_embbed,'b',k,performance_intrinsic,'r')
legend('Performance embbed dimension','Performance intrisic dimension',3)
