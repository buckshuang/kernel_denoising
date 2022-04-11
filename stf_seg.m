function fpara=stf_seg(para,w,mask)

fpara=zeros(size(para));

for i=3:size(para,1)-2
    for j=3:size(para,2)-2
        if (para(i,j)>0)
            if (para(i,j)-para(i+1,j)>=w)
                temp1=para(i,j)-w/2;
            elseif (para(i,j)-para(i+1,j)<=-w)
                temp1=para(i,j)+w/2;
            else
                temp1=(para(i,j)+para(i+1,j))/2;
            end
            if (para(i,j)-para(i-1,j)>=w)
                temp2=para(i,j)-w/2;
            elseif (para(i,j)-para(i-1,j)<=-w)
                temp2=para(i,j)+w/2;
            else
                temp2=(para(i,j)+para(i-1,j))/2;
            end
            if (para(i,j)-para(i,j+1)>=w)
                temp3=para(i,j)-w/2;
            elseif (para(i,j)-para(i,j+1)<=-w)
                temp3=para(i,j)+w/2;
            else
                temp3=(para(i,j)+para(i,j+1))/2;
            end
            if (para(i,j)-para(i,j-1)>=w)
                temp4=para(i,j)-w/2;
            elseif (para(i,j)-para(i,j-1)<=-w)
                temp4=para(i,j)+w/2;
            else
                temp4=(para(i,j)+para(i,j-1))/2;
            end   
        w1=1;w2=1;w3=1;w4=1;n=0;
        if (mask(i,j)~=mask(i+1,j))
           w1=0;n=n+1;
        end
        if (mask(i,j)~=mask(i-1,j))
           w2=0;n=n+1;
        end
        if (mask(i,j)~=mask(i,j+1))
           w3=0;n=n+1;
        end
        if (mask(i,j)~=mask(i,j-1))
           w4=0;n=n+1; 
        end
        if (n==4)
            fpara(i,j)=(temp1+temp2+temp3+temp4)/4;
        else
            fpara(i,j)=(w1*temp1+w2*temp2+w3*temp3+w4*temp4)/(4-n);
        end
        
        end
    end
end