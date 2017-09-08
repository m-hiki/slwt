function frame=silwt22(coef,level)
%silwt22    Spatial inverse lifting 2/2 (Haar) wavelet transform 
%
%
%  Example: 
%
%    frame=silwt22(coef,level);
%
%    frame(height, width)
%    
%  -----------------------------------------------------------------
%  silwt22.m                              Minoru Hiki.     06/06/13

  [height width]=size(coef);
	
  for i=1:level
    hb=ceil(height/2^(level-i));
    wb=ceil(width/2^(level-i));
    coef(1:hb,1:wb)=trx(coef(1:hb,1:wb));
  end
  frame=coef;
  
  
function frame=trx(coef)
  [height width]=size(coef);
  
  hb=round(height/2);
  wb=round(width/2);
  
  frame(1:2:height,1:2:width)=coef(1:hb,1:wb);
  frame(1:2:height,2:2:width)=coef(1:hb,wb+1:width);
  frame(2:2:height,1:2:width)=coef(hb+1:height,1:wb);
  frame(2:2:height,2:2:width)=coef(hb+1:height,wb+1:width);
  
  % vertical
  if(rem(height,2)==0)
    % update
    frame(1:2:height-1,:)=frame(1:2:height-1,:)-...
        floor(frame(2:2:height,:)/2);
    % predict
    frame(2:2:height,:)=frame(2:2:height,:)+frame(1:2:height-1,:);
  else
    % update
    frame(1:2:height-2,:)=frame(1:2:height-2,:)+...
        floor(frame(2:2:height-1,:)/2);
    frame(height,:)=frame(height,:)+...
        floor(frame(height-1,:)/2);
    % predict
    frame(2:2:height-1,:)=frame(2:2:height-1,:)+frame(1:2:height-2,:);
  end
  
  % horizontal
  if(rem(width,2)==0)
    % update
    frame(:,1:2:width-1)=frame(:,1:2:width-1)-...
        floor(frame(:,2:2:width)/2);
    % predict
    frame(:,2:2:width)=frame(:,2:2:width)+frame(:,1:2:width-1);
  else
    % update
    frame(:,1:2:width-2)=frame(:,1:2:width-2)-...
        floor(frame(:,2:2:width-1)/2);
    frame(:,width)=frame(:,width)-...
        floor(frame(:,width-1)/2);
    % predict
    frame(:,2:2:width-1)=frame(:,2:2:width-1)+frame(:,1:2:width-2);
  end
  
  frame=uint8(frame);
