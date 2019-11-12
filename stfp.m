function fpara=stfp(para,lambda)

fpara=zeros(size(para));
p=0.7;
w=0.5*(2-p)*((1-p)^((p-1)/(2-p)))*(lambda^(1/(2-p)));
pp=0.5*p*((1-p)^((p-1)/(2-p)))*(lambda^(1/(2-p)));
counts=0;
for j=3:size(para,2)-2
    for i=3:size(para,1)-2        
        if (para(i,j)>0)            
            if (para(i,j)-para(i+1,j)>=w)
                temp1=para(i,j)-0.25*lambda*p*((abs(para(i,j)-para(i+1,j))-0.5*lambda*p*((abs(para(i,j)-para(i+1,j))-pp)^(p-1)))^(p-1));                
            elseif (para(i,j)-para(i+1,j)<=-w)
                temp1=para(i,j)+0.25*lambda*p*((abs(para(i,j)-para(i+1,j))-0.5*lambda*p*((abs(para(i,j)-para(i+1,j))-pp)^(p-1)))^(p-1));  
            else
                temp1=(para(i,j)+para(i+1,j))/2;
                %counts=counts+1;
            end
            if (para(i,j)-para(i-1,j)>=w)
                temp2=para(i,j)-0.25*lambda*p*((abs(para(i,j)-para(i-1,j))-0.5*lambda*p*((abs(para(i,j)-para(i-1,j))-pp)^(p-1)))^(p-1));                
            elseif (para(i,j)-para(i-1,j)<=-w)
                temp2=para(i,j)+0.25*lambda*p*((abs(para(i,j)-para(i-1,j))-0.5*lambda*p*((abs(para(i,j)-para(i-1,j))-pp)^(p-1)))^(p-1));               
            else
                temp2=(para(i,j)+para(i-1,j))/2;
                %counts=counts+1;
            end
            if (para(i,j)-para(i,j+1)>=w)
                temp3=para(i,j)-0.25*lambda*p*((abs(para(i,j)-para(i,j+1))-0.5*lambda*p*((abs(para(i,j)-para(i,j+1))-pp)^(p-1)))^(p-1));             
            elseif (para(i,j)-para(i,j+1)<=-w)
                temp3=para(i,j)+0.25*lambda*p*((abs(para(i,j)-para(i,j+1))-0.5*lambda*p*((abs(para(i,j)-para(i,j+1))-pp)^(p-1)))^(p-1));                
            else
                temp3=(para(i,j)+para(i,j+1))/2;
                %counts=counts+1;
            end
            if (para(i,j)-para(i,j-1)>=w)
                temp4=para(i,j)-0.25*lambda*p*((abs(para(i,j)-para(i,j-1))-0.5*lambda*p*((abs(para(i,j)-para(i,j-1))-pp)^(p-1)))^(p-1));                
            elseif (para(i,j)-para(i,j-1)<=-w)
               temp4=para(i,j)+0.25*lambda*p*((abs(para(i,j)-para(i,j-1))-0.5*lambda*p*((abs(para(i,j)-para(i,j-1))-pp)^(p-1)))^(p-1));          
            else
                temp4=(para(i,j)+para(i,j-1))/2;
                %counts=counts+1;
            end         
            
        fpara(i,j)=0.25*(temp1+temp2+temp3+temp4);
        end
    end
end
%counts=counts/4/(size(para,1)-4)/(size(para,2)-4);