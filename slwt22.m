function coef = slwt22(frame, level)
%slwt2x2    Spatial lifting 2/2 (Haar) wavelet transform
%
%
%  Example:
%
%    coef=slwt22(frame,level);
%
%    frame(height, width)
%
%  -----------------------------------------------------------------
%  slwt2x2.m                               Minoru Hiki.     06/06/13

  [height, width] = size(frame);
  frame = double(frame);
  
  for i = 1 : level
    hb = ceil(height / 2 ^ (i - 1));
    wb = ceil(width / 2 ^ (i - 1));
    frame(1 : hb, 1 : wb) = trx(frame(1 : hb, 1 : wb));
  end
  coef = frame;		
  
    
function coef = trx(frame)
  [height, width] = size(frame);
  
  % horizontal
  if(rem(width, 2) == 0)
    % predict
    frame(:,2:2:width) = frame(:,2:2:width)-frame(:,1:2:width-1);
    % update
    frame(:,1:2:width-1)=frame(:,1:2:width-1)+floor(frame(:,2:2:width)/2);
  else
    % predict
    frame(:,2:2:width-1)=frame(:,2:2:width-1)-frame(:,1:2:width-2);
    % update
    frame(:,1:2:width-2)=frame(:,1:2:width-2)+floor(frame(:,2:2:width-1)/2);
    frame(:,width)=frame(:,width)+floor(frame(:,width-1)/2);
  end
  
  % vertical
  if(rem(height,2)==0)
    % predict
    frame(2:2:height,:)=frame(2:2:height,:)-frame(1:2:height-1,:);
    % update
    frame(1:2:height-1,:)=frame(1:2:height-1,:)+floor(frame(2:2:height,:)/2);
  else
    % predict
    frame(2:2:height-1,:)=frame(2:2:height-1,:)-frame(1:2:height-2,:);
    % update
    frame(1:2:height-2,:)=frame(1:2:height-2,:)+floor(frame(2:2:height-1,:)/2);
    frame(height,:)=frame(height,:)+floor(frame(height-1,:)/2);
  end
  
  hb=round(height/2);
  wb=round(width/2);
  
  coef(1:hb,1:wb)=frame(1:2:height,1:2:width);
  coef(1:hb,wb+1:width)=frame(1:2:height,2:2:width);
  coef(hb+1:height,1:wb)=frame(2:2:height,1:2:width);
  coef(hb+1:height,wb+1:width)=frame(2:2:height,2:2:width);
