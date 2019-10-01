function ChiperText= ENIGMA_II_Encrypt(PlainText,Key)

%   Making variables of the different wheels and set a identification
%   number on each 'wheel'.
    w7=['7','azyxwvutsrqponmlkjihgfedcb'];
    w6=['6','acedfhgikjlnmoqprtsuwvxzyb'];
    w5=['5','abcdefghijklmnopqrstuvwxyz'];
    global out;
    out = '';
    
%   Making a matrix of all the wheels. 
    WO=[w7;w6;w5];
    
    
%   This syncronice every 'wheel' inside a matrix and removes the
%   identifying numbers.
    for i=num2str(Key(1:3))  
        idx=strfind(Key,i);
        if idx==3
            row=find(WO==i);
             WO=RowChange(WO,idx,row);
             WO3=WO(idx,(2:end));
             WO3=circshift(WO3,26-strfind(WO3,Key(6))+1);
        elseif idx==2
            row=find(WO==i);
            WO=RowChange(WO,idx,row);
            WO2=WO(idx,(2:end));
            WO2=circshift(WO2,26-strfind(WO2,Key(5))+1);
        elseif idx==1
            row=find(WO==i);
            WO=RowChange(WO,idx,row);
            WO1=WO(idx,(2:end));
            WO1=circshift(WO1,26-strfind(WO1,Key(4))+1);
        end
    end
    
%   Setting some test paramerters and create a
%   counter.
    TF=isstrprop(PlainText,'alpha');
    count=0;
    
%   Starting the decryption.
    for i=1:length(PlainText)
            Up=isstrprop(PlainText(1,i),'upper');

%       Testing if the char is 'alpha'. Shifting arrays based on index in
%       plaintext.
        if TF(i)~= 0
            count=count+1; % Counter made to skip non-'alpha' 
            P=strfind(WO3,lower(PlainText(1,i)));
                RW=circshift(WO3,-P+1); % Working/test variable.
                MW=circshift(WO2,26+P-1);
                LW=circshift(WO1,-P+1);
  
%              Ask if counter is odd or even to alternate. And a check to
%              see if a char is upper or lower.
               if mod(count,2)==0
                   if Up==1
                       MW=MW(1,1);
                       out=[out upper(MW)];
                   else
                       MW=MW(1,1);
                       out=[out MW];
                   end
               
               else
                   if Up==1
                       LW=LW(1,1);
                       out=[out upper(LW)];
                   else
                       LW=LW(1,1);
                       out=[out LW];
                   end
               end
               
%       If the char is not an 'alpha' it is just passed trough.
        else
              out=[out PlainText(1,i)];
         end
    end
    ChiperText=out;
end
