function fdata=kernel_denoise(data,sd)

% This file is the implementation of the kernel-based image denosing method [1].
% This method is used for denoising 2D multiple b-value DW-MRI data.
% In order to perform the kernel-based image denoising, you need to download
% the source codes (https://sites.google.com/site/gbwangonline/code) 
% for constructing the kernel matrix. 

%  data: undenoised DW-MRI data
% fdata: denoised DW-MRI data
%    sd: the estimated noise of each b-value DW-MRI

% Note that (1) data is arranged in a 3D array in which the x and y coordinates
%               are the image axes and the z directionn is that of the b-values.
%           (2) The size of sd is the same as that of b-value.
%           (3) To implement the smoothed kernel-based (SKernel) image
%               denoising method, you need to input DW-MRI denoised by other
%               methods (i.e. LMMSE and LPCA) and change codes (lines 38-46).

% References:
% [1] Huang HM and Lin C. A kernel-based image denoising method for improving parametric image generation. 
%     Med Image Anal. 2019;55:41-48.
% [2] Lin C, Liu CC, Huang HM . A general-threshold filtering method for improving intravoxel incoherent motion parameter estimates. 
%     Phys Med Biol. 2018;63(17): 175008.

% Copyright (C) 2019 Hsuan-Ming Huang (b9003205@gmail.com)
%%
sigma = 1;
nn=48;
iter1=5;
iter2=5;

fdata=zeros(size(data));
imgsiz=size(data,1);

% Construction of the kernel matrix for the kernel-based image denosing
% method
num=round(size(data,3)/3);
U =zeros(size(data,1)*size(data,2),3);
for i=1:2
   temp=sum(data(:,:,(i-1)*num+1:num*i),3);
   U(:,i)=temp(:);
end
i=3;
temp=sum(data(:,:,(i-1)*num+1:end),3);
U(:,i)=temp(:);

U = U * diag(1./std(U,1)); 
[N, W] = buildKernel([imgsiz imgsiz], 'knn', nn, U, 'radial', sigma);
K = buildSparseK(N, W);

for i=1:size(data,3)                     
    f=zeros(imgsiz*imgsiz,1);
    temp=data(:,:,i);temp=temp(:);
    for k1=1:iter1
        f=f+K'*(temp-K*f);
        fs=reshape(K*f,[imgsiz imgsiz]);
        for k2=1:iter2           
            fs=stfp(fs,sd(i));
        end
        f=K'*fs(:);
    end       
    fdata(:,:,i)=reshape(K*f,[imgsiz imgsiz]);    
end
