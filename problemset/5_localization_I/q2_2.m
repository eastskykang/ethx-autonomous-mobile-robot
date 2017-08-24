% Pr(heads) (= the first box was selected).
PHeads = 1/2;
        
% Pr(tails) (= the second box was selected).
PTails = 1/2;
        
% Pr(white | heads)
PWhiteGHeads = 7/10;
        
% Pr(white | tails)
PWhiteGTails = 1/2;
        
% Pr(white) (use Total Probability Theorem)
PWhite = PWhiteGHeads * PHeads + PWhiteGTails * PTails;
        
% Pr(tails | white)
 
% by Bayes rule ...
% Pr(tails | white) = P(white | tails) * P(tails) / P(white)
PTailsGWhite = PWhiteGTails * PTails / PWhite;
      