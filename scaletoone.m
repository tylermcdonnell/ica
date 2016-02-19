function [ scaled ] = scaletoone( x )
%SCALETOONE Scales values in input array to range [0,1].

scaled = x - min(x);  
scaled = scaled / max(scaled); 

end

