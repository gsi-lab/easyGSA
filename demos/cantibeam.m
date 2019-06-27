function [D, S] = cantibeam(xx, w, t)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% CANTILEVER BEAM FUNCTIONS
%
% Authors: Sonja Surjanovic, Simon Fraser University
%          Derek Bingham, Simon Fraser University
% Questions/Comments: Please email Derek Bingham at dbingham@stat.sfu.ca.
%
% Copyright 2013. Derek Bingham, Simon Fraser University.
%
% THERE IS NO WARRANTY, EXPRESS OR IMPLIED. WE DO NOT ASSUME ANY LIABILITY
% FOR THE USE OF THIS SOFTWARE.  If software is modified to produce
% derivative works, such modified software should be clearly marked.
% Additionally, this program is free software; you can redistribute it 
% and/or modify it under the terms of the GNU General Public License as 
% published by the Free Software Foundation; version 2.0 of the License. 
% Accordingly, this program is distributed in the hope that it will be 
% useful, but WITHOUT ANY WARRANTY; without even the implied warranty 
% of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU 
% General Public License for more details.
%
% For function details and reference information, see:
% http://www.sfu.ca/~ssurjano/
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% OUTPUTS AND INPUTS:
%
% D  = displacement
% S  = stress
% xx = [R, E, X, Y]
% w  = width (optional)
% t  = thickness (optional)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

R = xx(1);
E = xx(2);
X = xx(3);
Y = xx(4);

L = 100;
D_0 = 2.2535;

if (nargin == 1)
    w = 4;
    t = 2;
elseif (nargin == 2)
    t = 2;
end

Sterm1 = 600*Y / (w*(t^2));
Sterm2 = 600*X / ((w^2)*t);

S = Sterm1 + Sterm2;

Dfact1 = 4*(L^3) / (E*w*t);
Dfact2 = sqrt((Y/(t^2))^2 + (X/(w^2))^2);

D = Dfact1 * Dfact2;

end
