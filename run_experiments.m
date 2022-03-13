
reduction_method = 'naive';
% reduction_method = 'FastMap';
% reduction_method = 'PCA';

% main('amazon','Euclidean',reduction_method,[],[6,2.^(3:11)],'unsupervised')
% main('CNAE','Euclidean',reduction_method,[],[5,8,16,32,64,128,256,512,856],'supervised')
% main('colors','Manhattan',reduction_method,[],[2.^(3:6),112],'unsupervised')
% main('faces','Chebyshev',reduction_method,[],[2.^(3:9),761],'unsupervised')
% main('gasdrift','Chebyshev',reduction_method,[],[12,2.^(4:7)],'supervised')
% main('GramFacial','Manhattan',reduction_method,[],[2,4,8,16,32,64,128,256,300],'supervised')
% main('libras','Manhattan',reduction_method,[],[3,2.^(2:6),90],'supervised')
% main('mfeat','Chebyshev',reduction_method,[],[3,4,8,16,32,64,128,256,512,649],'supervised')
% main('isolet','Euclidean',reduction_method,[],[2.^(1:9),617],'supervised')
% main('Ozone','Chebyshev',reduction_method,[],[8,16,32,64,72],'supervised')
% main('PlantSpecies','Euclidean',reduction_method,[],[2,4,8,16,32,64,128,192],'supervised')
% main('qsar','Euclidean',reduction_method,[],[8,16,32,41],'unsupervised')
% main('sensorless','Manhattan',reduction_method,[],[3,4,8,16,32,48],'unsupervised')
% main('SmartphoneRecog','Manhattan',reduction_method,[],[3,4,8,16,32,64,128,256,512,561],'supervised')
% main('Spam','Euclidean',reduction_method,[],[6,8,16,32,57],'supervised')


% main('2d','Manhattan',reduction_method,'uniform',2.^(1:11))
% main('3d','Euclidean',reduction_method,'uniform',[3,2.^(2:11)])
% main('aloi','Manhattan',reduction_method,'uniform',[5,13,2.^(4:9)])
% main('amazon','Euclidean',reduction_method,'uniform',[6,2.^(3:11)])
% main('bike2','Canberra',reduction_method,'uniform',[3,7,2.^(3:11)])
% main('canvas','Euclidean',reduction_method,'uniform',[10,2.^(4:11)])
% main('cities','Euclidean',reduction_method,'uniform',2.^(1:11))
% main('CNAE','Euclidean',reduction_method,'uniform',[5,8,16,32,64,128,256,512,856])
% main('colors','Manhattan',reduction_method,'uniform',[2.^(3:6),112])
% main('corel','Euclidean',reduction_method,'uniform',[11,2.^(5:11)])
% main('faces','Chebyshev',reduction_method,'uniform',[2.^(3:9),761])
% main('gasdrift','Chebyshev',reduction_method,'uniform',[12,2.^(4:7)])
% main('GramFacial','Manhattan',reduction_method,'uniform',[2,4,8,16,32,64,128,256,300])
% main('libras','Manhattan',reduction_method,'uniform',[3,2.^(2:6),90])
% main('mfeat','Chebyshev',reduction_method,'uniform',[3,4,8,16,32,64,128,256,512,649])
% main('isolet','Euclidean',reduction_method,'uniform',[2.^(1:9),617])
% main('nasa','Bray-Curtis',reduction_method,'uniform',[5,20,2.^(5:11)])
% main('Ozone','Chebyshev',reduction_method,'uniform',[8,16,32,64,72])
% main('PlantSpecies','Euclidean',reduction_method,'uniform',[2,4,8,16,32,64,128,192])
% main('popularity','Fractional-0.5',reduction_method,'uniform',[5,8,16,32,59])
% main('prove','Euclidean',reduction_method,'uniform',[6,8,16,32,51])
% main('qsar','Euclidean',reduction_method,'uniform',[8,16,32,41])
% main('sensorless','Manhattan',reduction_method,'uniform',[3,4,8,16,32,48])
% main('SmartphoneRecog','Manhattan',reduction_method,'uniform',[3,4,8,16,32,64,128,256,512,561])
% main('Spam','Euclidean',reduction_method,'uniform',[6,8,16,32,57])
% main('waveform','Fractional-0.5',reduction_method,'uniform',[9,21,2.^(5:11)])


least_squares('2d','Manhattan',reduction_method,2.^(1:11),1:11,0:4096)
pause
least_squares('3d','Euclidean',reduction_method,[3,2.^(2:11)],1:11,0:4096)
pause
least_squares('aloi','Manhattan',reduction_method,[5,13,2.^(4:9)],1:8,0:4096)
pause
least_squares('amazon','Euclidean',reduction_method,[6,2.^(3:11)],1:10,0:4096)
pause
least_squares('bike2','Canberra',reduction_method,[3,7,2.^(3:11)],1:11,0:4096)
pause
least_squares('canvas','Euclidean',reduction_method,[10,2.^(4:11)],1:9,0:4096)
pause
least_squares('cities','Euclidean',reduction_method,2.^(1:11),1:11,0:4096)
pause
least_squares('colors','Manhattan',reduction_method,[2.^(3:6),112],1:5,0:4096)
pause
least_squares('corel','Euclidean',reduction_method,[11,2.^(5:11)],1:8,0:4096)
pause
least_squares('faces','Chebyshev',reduction_method,[2.^(3:9),761],1:8,0:4096)
pause
least_squares('gasdrift','Chebyshev',reduction_method,[12,2.^(4:7)],1:5,0:4096)
pause
least_squares('libras','Manhattan',reduction_method,[3,2.^(2:6),90],1:6,0:4096)
pause
least_squares('isolet','Euclidean',reduction_method,[2.^(1:9),617],1:10,0:4096)
pause
least_squares('nasa','Bray-Curtis',reduction_method,[5,20,2.^(5:11)],1:9,0:4096)
pause
least_squares('popularity','Fractional-0.5',reduction_method,[5,8,16,32,59],1:5,0:64)
pause
least_squares('prove','Euclidean',reduction_method,[6,8,16,32,51],1:5,0:64)
pause
least_squares('qsar','Euclidean',reduction_method,[8,16,32,41],1:4,0:64)
pause
least_squares('sensorless','Manhattan',reduction_method,[3,4,8,16,32,48],1:6,0:64)
pause
least_squares('waveform','Fractional-0.5',reduction_method,[9,21,2.^(5:11)],1:9,0:4096)
pause
least_squares('CNAE','Euclidean',reduction_method,[5,8,16,32,64,128,256,512,856],1:9,0:4096)
pause
least_squares('gasdrift','Chebyshev',reduction_method,[12,2.^(4:7)],1:5,0:4096)
pause
% least_squares('GramFacial','Manhattan',reduction_method,[2,4,8,16,32,64,128,256,300],1:9,0:4096)
% pause
least_squares('libras','Manhattan',reduction_method,[3,2.^(2:6),90],1:6,0:4096)
pause
least_squares('mfeat','Chebyshev',reduction_method,[3,4,8,16,32,64,128,256,512,649],1:10,0:4096)
pause
least_squares('isolet','Euclidean',reduction_method,[2.^(1:9),617],1:10,0:4096)
pause
least_squares('Ozone','Chebyshev',reduction_method,[8,16,32,64,72],1:5,0:4096)
pause
least_squares('PlantSpecies','Euclidean',reduction_method,[2,4,8,16,32,64,128,192],1:8,0:4096)
pause
least_squares('SmartphoneRecog','Manhattan',reduction_method,[3,4,8,16,32,64,128,256,512,561],1:10,0:4096)
pause
least_squares('Spam','Euclidean',reduction_method,[6,8,16,32,57],1:5,0:4096)
pause
